X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Sun, 10 Dec 2006 22:26:44 +0000
Message-ID: <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
	 <elgpjk$ggm$1@sea.gmane.org>
	 <b0943d9e0612100831t7b79d4b1p436de5dbb813e51a@mail.gmail.com>
	 <200612101801.58247.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:27:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g10eZNktxjvmPEFgAxA+pxJzW6HGx5AlfdfDHrYQ/1N/sUwoidNefJiD/paxowZZXkweHE2DUpeUA1q57RV6yqmTxQtEqlwvaGx5rRRwbJ2P9vJqE4DpIy1zBdCObNCKJfWWIvX2itKBjAl35/0OA5qekCy8JFCR1JDnsYVFnhE=
In-Reply-To: <200612101801.58247.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33942>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtX8G-0001oR-4o for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758281AbWLJW0q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLJW0q
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:26:46 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:34519 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758281AbWLJW0p (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:26:45 -0500
Received: by py-out-1112.google.com with SMTP id a29so797503pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:26:44 -0800 (PST)
Received: by 10.65.159.2 with SMTP id l2mr9757269qbo.1165789604463; Sun, 10
 Dec 2006 14:26:44 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Sun, 10 Dec 2006 14:26:44 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Catalin Marinas wrote:
> > On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >>>> Here are some issues which are a bit annoying for me:
> >>>> - make "stg help" (without command name) equivalent to "stg --help"
> >
> > There was a patch in this area. Doesn't it work correctly now?
>
> I use stgit 0.11

I was in general referring to the latest HEAD in the StGIT repository.

>
> 1056:[gitweb/web!git]$ stg help
> usage: stg help <command>
>
> while "stg --help" lists all commands.

Works correctly in the latest snapshot.

> >> And as far as I can see it doe not use git credentials (user.name and
> >> user.email).
> >
> > StGIT now uses the GIT credentials (and config files).
>
> Hmmm... in stgit 0.11 "stg refresh --sign" once gave me Signed-off-by:
> Nobody line instead of using git user.name and user.email.

Again, it is different in the latest snapshot (feature added post 0.11).

> The git commands StGit uses to perform operations automatically record
> changes in branches in reflog. What StGit does not provide is the "reason".
> You do use git-update-ref?

Yes, only for updating HEAD. The refs in refs/patches/<branch>/ are
written directly. I initialy wanted to add patch history support using
reflogs and added "git-update-ref -m ..." for the patch commits but I
found slow the pushing operation a bit. Do you only want to track the
reflogs for HEAD?

-- 
