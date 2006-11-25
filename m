X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Store peeled refs in packed-refs (take 2).
Date: Sat, 25 Nov 2006 09:09:25 +0100
Message-ID: <e5bfff550611250009x70a16c66h8077a2dccc1273e7@mail.gmail.com>
References: <7vac2kvsos.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611220425x5cf9e33ds7b7b98229c6b408a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 08:09:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K9SAoO0ehjRrapSNsYtIJXXLlApVcExcOouTZ91UzQvE3YAS30MYIqreMSipd7k56KZxGNFXGR2hkQhHUGPDI4gnAzmUD5UIQU8IOatgzSI1woCVKjbUW3I5+jXeun3Z5OTO6+54tiOLBXA2ai1Fg9CS0+aHQEFMI+bwrpbDUR8=
In-Reply-To: <e5bfff550611220425x5cf9e33ds7b7b98229c6b408a@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32264>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnsbR-0006pH-FQ for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757883AbWKYIJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757887AbWKYIJ0
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:09:26 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:62509 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1757883AbWKYIJ0
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:09:26 -0500
Received: by py-out-1112.google.com with SMTP id a29so656298pyi for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 00:09:25 -0800 (PST)
Received: by 10.35.115.18 with SMTP id s18mr7768437pym.1164442165498; Sat, 25
 Nov 2006 00:09:25 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 25 Nov 2006 00:09:25 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/22/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 11/22/06, Junio C Hamano <junkio@cox.net> wrote:
> > there is only one such extension defined, "peeled".  This stores
> > the "peeled tag" on a line that immediately follows a line for a
> > tag object itself in the format "^<sha-1>".
> >
>
> Thanks, I will try to do some performance tests this week end.
>

Cold cache tests with "git show-ref -d" on packed refs (after
"git-pack-refs --prune")

Before patch:

- git tree 2374ms
- linux tree 2225ms



After patch:

- git tree 1108ms
