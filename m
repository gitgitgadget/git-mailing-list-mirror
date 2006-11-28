X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Tue, 28 Nov 2006 08:57:15 +0100
Message-ID: <e5bfff550611272357w33756febud0bbbe59e2e1e140@mail.gmail.com>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
	 <7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
	 <e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
	 <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 07:57:32 +0000 (UTC)
Cc: catalin.marinas@gmail.com, "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPjq13rPgDe2qOfREJpQGNpY6GhoaMWO9gMyYB0KhR5Yqtdv5RJjwcF+w0J6jMVCAil41r67T5uIcBoo1cv75pSWkfY6JVOkH6kf1IBNKmBQmR2MRbKxLDlGupJWdRVn4CkToZmLrI3+0Bb5+24X9WfXveKHVixHKQzSgTycDJY=
In-Reply-To: <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32493>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoxqC-0001zd-Lq for gcvg-git@gmane.org; Tue, 28 Nov
 2006 08:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935756AbWK1H5R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 02:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935767AbWK1H5R
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 02:57:17 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:37926 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S935756AbWK1H5Q
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 02:57:16 -0500
Received: by py-out-1112.google.com with SMTP id a29so1253057pyi for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 23:57:16 -0800 (PST)
Received: by 10.35.78.9 with SMTP id f9mr1033579pyl.1164700635865; Mon, 27
 Nov 2006 23:57:15 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Mon, 27 Nov 2006 23:57:15 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/27/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Could a possible '--all-branches' new option come to rescue?
>
> I doubt it.  Next thing people would start talking about is what
> to do with the remote tracking branches, and what we are talking
> about is rev-list, one of the lower level of plumbing that would
> be better left without knowing much about the Porcelain's use of
> refs/ namespaces.
>
> If you (as a Porcelain) want to get all refs under refs/heads/,
> there are (unfortunately) two ways to get that list.  I would
> suggest obtain the refs you want that way, pass them as command
> line arguments to rev-list.
>

Unfortunatly that does not work in case a branch and a tag have the same name.

I was bitten by this trying to do what you now suggest, there were a
tag and a branch called 'test', and calling

git-rev-list master origin test

raised a warning.

Only among the _same_ 'family' (branches, tags, etc..) unique names
are enforced.

