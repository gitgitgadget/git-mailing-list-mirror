From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Jul 2015, #03; Fri, 10)
Date: Fri, 10 Jul 2015 18:58:54 -0400
Message-ID: <CAPig+cRqaHszW_zA6FQ4CCurYK-Gcd83+W-jHKWwtJTVbB0RAg@mail.gmail.com>
References: <xmqqh9pbk4y5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 00:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDhG0-0005TD-To
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 00:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbGJW65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 18:58:57 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36795 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbbGJW6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 18:58:55 -0400
Received: by ykey15 with SMTP id y15so78475595yke.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vM5/ndebKJgRLpL8Qu2o0Zts3jvTQXDDPV13fh4qcO0=;
        b=zkk314iNgSZwTj4/o2tma0ol6phfQF9S3PXTbFXmIyCO9+jgLKG8/6pdjmsU3oQVAI
         07eNyj4GfC3SAgloKrv+bju6sDJH/zIArfjK6c8Myg6nBDz6KElOtJ2QsiFk2Ij0Mi+l
         dW0PDtOh/hZMaftnYRO/CDBw3IdSg7bwzc28g8p3j2IxjCrDAyksrb1oGiU9pB7BFDmV
         m4b1HqlyfBT2HprsAMJRY+M4kHyrfk+Yp2Q/kGaE8oQ1Jg49Z6E7sNAtwWEYhQa/NRiR
         LID1xT7YRfPeTzlHIXfS4CsxS5TtTljwTg1E6R2Yz/LlObSPYPrpSbZnF9Ef7A3HI2O8
         a5KA==
X-Received: by 10.13.207.1 with SMTP id r1mr26175753ywd.166.1436569134954;
 Fri, 10 Jul 2015 15:58:54 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 10 Jul 2015 15:58:54 -0700 (PDT)
In-Reply-To: <xmqqh9pbk4y5.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 6HoArIT1iCbCFKe8Yij1c0uGXNU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273839>

On Fri, Jul 10, 2015 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-add (2015-07-07) 23 commits
>   (merged to 'next' on 2015-07-10 at 304e329)
>  + checkout: retire --ignore-other-worktrees in favor of --force
>  + worktree: add: auto-vivify new branch when <branch> is omitted
>  + worktree: add: make -b/-B default to HEAD when <branch> is omitted
>  + worktree: extract basename computation to new function
>  + checkout: require worktree unconditionally
>  + checkout: retire --to option
>  + tests: worktree: retrofit "checkout --to" tests for "worktree add"
>  + worktree: add -b/-B options
>  + worktree: add --detach option
>  + worktree: add --force option
>  + worktree: introduce "add" command
>  + checkout: drop 'checkout_opts' dependency from prepare_linked_checkout
>  + checkout: make --to unconditionally verbose
>  + checkout: prepare_linked_checkout: drop now-unused 'new' argument
>  + checkout: relocate --to's "no branch specified" check
>  + checkout: fix bug with --to and relative HEAD
>  + Documentation/git-worktree: add EXAMPLES section
>  + Documentation/git-worktree: add high-level 'lock' overview
>  + Documentation/git-worktree: split technical info from general description
>  + Documentation/git-worktree: add BUGS section
>  + Documentation: move linked worktree description from checkout to worktree
>  + Documentation/git-worktree: associate options with commands
>  + Documentation/git-checkout: fix incorrect worktree prune command
>  (this branch uses nd/multiple-work-trees.)
>
>  Update to the "linked checkout" in 2.5.0-rc1.
>
>  Instead of "checkout --to" that does not do what "checkout"
>  normally does, move the functionality to "git worktree add".
>
>  Will merge to 'master'.

Did you want to drop the final patch[*1*] which retires
--ignore-other-worktrees in favor of --force before letting this
graduate to 'master'?

By the way, v1 of the follow-on series which replaces "git checkout"
with "git reset --hard" to populate the new worktree is ready. I
expect to send it out shortly.

[*1*]: http://thread.gmane.org/gmane.comp.version-control.git/273415/focus=273585
