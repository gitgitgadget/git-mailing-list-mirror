X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 20:49:45 +0100
Message-ID: <8c5c35580612081149y2042c62j55b1b7b3f23da6ad@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <45785697.1060001@zytor.com>
	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457995F8.1080405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 19:49:56 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cRD9mBVl3SYP8zSel+frUsGaN50CF2CG2jScJ1RzvdYkg/4imIMimWhXNTDVS+0raMV+D7ab97LbXrXRhHiy2YU5yFWEb94HVT6cJ+q9Hz6Ft52mzTCyaCIoPu1BdTcDglv6ZjH+XpGDYnvaKGA7bakRBbrjJrn2/b2APd5um70=
In-Reply-To: <457995F8.1080405@zytor.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7f506924f6fa9ce5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33730>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsljC-00037u-Ui for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426172AbWLHTts (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426176AbWLHTts
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:49:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:21585 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1426172AbWLHTtr (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 14:49:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1221250nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 11:49:46 -0800 (PST)
Received: by 10.82.113.6 with SMTP id l6mr610877buc.1165607385253; Fri, 08
 Dec 2006 11:49:45 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Fri, 8 Dec 2006 11:49:45 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>, "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/8/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Linus Torvalds wrote:
> > I could write a simple C caching thing that just hashes the CGI arguments
> > and uses a hash to create a cache (and proper lock-files etc to serialize
> > access to a particular cache object while it's being created) fairly
> > easily, but I'm pretty sure people would much prefer a mod_perl thing just
> > to avoid the fork/exec overhead with Apache (I think mod_perl allows
> > Apache to run perl scripts without it), and that means I'm not the right
> > person any more.
>
> True about mod_perl.  Haven't messed with that myself, either.
> fork/exec really is very cheap on Linux, so it's not a huge deal.

I've been playing around with a "native git" cgi thingy the last week
(I call it cgit),  and I've been thinking about adding exactly this
kind of caching to it. And since it's basically a standard git command
written in C, it should have less overhead than any perl
implementation.

It's far from ready yet, but I'll try to publish some code this
weekend just in case someone finds it interesting.

-- 
