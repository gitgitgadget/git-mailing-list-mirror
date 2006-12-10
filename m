X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Sun, 10 Dec 2006 23:24:32 +0000
Message-ID: <b0943d9e0612101524w3a2cccecqdd12023233e8ec0c@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
	 <200612101801.58247.jnareb@gmail.com>
	 <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com>
	 <200612110002.05847.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 23:25:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HDZ0xc7RTwMP39gw3SvuyKmGH5WM0pJlEiCBe+8w8MjYtUn3Ex0MbSzoSQD0M1rOUDlnswI4xdWqSmFrH5m5EcoRnxuiKF1/Ng6iG6z+rX/LgfBkrBo3qFN6WJHAsiDXs6Ci8kQvJvzIvqcq8Bly6wNjYttCNCaxIFSc987Whuk=
In-Reply-To: <200612110002.05847.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33958>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtY2T-0007km-Ek for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762424AbWLJXYe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762526AbWLJXYe
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:24:34 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:60259 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762424AbWLJXYd (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 18:24:33 -0500
Received: by py-out-1112.google.com with SMTP id a29so804133pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 15:24:33 -0800 (PST)
Received: by 10.65.38.13 with SMTP id q13mr9790395qbj.1165793072861; Sun, 10
 Dec 2006 15:24:32 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Sun, 10 Dec 2006 15:24:32 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Catalin Marinas wrote:
> > Yes, only for updating HEAD. The refs in refs/patches/<branch>/ are
> > written directly. I initialy wanted to add patch history support using
> > reflogs and added "git-update-ref -m ..." for the patch commits but I
> > found slow the pushing operation a bit. Do you only want to track the
> > reflogs for HEAD?
>
> Yes, I want for StGit to provide reasons when updating HEAD. I know that
> StGit manages it's own versioning of patches not using reflog -- fine.
> What matters for me is reflog for HEAD after "stg commit; stg clean".

Just curious, do you run the "stg commit; stg clean" commands together
and in this order? Neither of them would update the HEAD. The "commit"
command simply removes the StGIT metadata for the applied patches
since it no longer needs to track them (permanently stored to the
repository). It doesn't change HEAD. The "clean" command only affects
the HEAD if there are empty applied patches but after a "commit" there
won't be any patches (only the unapplied ones which do not affect
HEAD).

Maybe we could have reflog info for "push", "refresh", some undo
operations. Are they of any use (I haven't used them so I can't tell)?

-- 
