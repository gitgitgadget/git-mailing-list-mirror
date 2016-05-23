From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] worktree: add "lock" command
Date: Mon, 23 May 2016 00:21:45 -0400
Message-ID: <CAPig+cRx+HjDMhqSN+aff7Qrvb9pgninuw4ZMxC-pzE=2UJmLA@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-4-pclouds@gmail.com>
	<CAPig+cRMxYGx_gR9vei=6bcoXkhm2ntQSdqA3Vq9rtTzDd1RSQ@mail.gmail.com>
	<CACsJy8CpsW+Jp=A8swDzR0+udGq8H-ampztyZwyXiK2mbcjqPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hNJ-0007yq-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbcEWEVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 00:21:47 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35697 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbcEWEVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 00:21:46 -0400
Received: by mail-ig0-f179.google.com with SMTP id bi2so26916018igb.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=v4ave9PdVb/yV94+LApFCPw0OB+RcOlB7Tmr2Y5bvds=;
        b=qMwHZMfUZ1/XG8t2OG3qvBnltMjJWwBCopVUDSIvpFkC4vNJ7k40PVfsg55jGSEdtY
         LAAWfyU1OHWom7BbJ53XyNjQtBPnwRVPM2jHGZLtnF3bhS9tkUD9lSLIIa9BAHm2ptl5
         cBkgnss/NBjDobN7//Bd9X4C+1Cd/ht1/YRxYY/3JpC2L179IwV6QG0V1Bo1E3hbSp4F
         RwN0ZhYeCJZ+JRZkqFpfeth0hHDiSkKon3lytJKBRO3tkazxLMuk1wfUN6CUbe0LCucJ
         GwdO7kCRPJUeCNf5vyaTEd16XXfOkeH8FAU6iimM9pmo/scESQ1rcSvYAHAYBGPDRR/Z
         dqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=v4ave9PdVb/yV94+LApFCPw0OB+RcOlB7Tmr2Y5bvds=;
        b=IIL/SFUoKRaYVuYqjs8HJNQ29derBL+4yxIefX0NTuD9GLv6ZHJaHERUHTvZRmWDZj
         J10Ta//UiXcfJYovGw94njP7E3Av4rmOJrfJJXcFDWI1EmBUaLttWn2a34GThcUvu2ky
         CI0JiZ5wC+zruEJNeF1yEXTR2LMBHEyThvcY0a8u+FoQbptU+POPJv1okru1DCRY7S8C
         1YWCWsrYZ+L/cJQeRgoFdOA9OooE23PxwlhSiG4eY3sHXYfzRTvn0rU9cbu/5Fmkpw3u
         DPBFtWDmC6DoBaNroXAS2eANY6GZT5TF/uJYl7jyEAEmdtrFCqIgAZkCjho6f1vry2X2
         o1mg==
X-Gm-Message-State: AOPr4FVnsl2ToEM3RI+9Z0LxF0IP/GRZ1ydTsJIsxla48iYuLyQa2DbGa/+B5zPLA7hrte1yeYgGKvMO4bxlFQ==
X-Received: by 10.50.158.198 with SMTP id ww6mr10379570igb.91.1463977305764;
 Sun, 22 May 2016 21:21:45 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:21:45 -0700 (PDT)
In-Reply-To: <CACsJy8CpsW+Jp=A8swDzR0+udGq8H-ampztyZwyXiK2mbcjqPA@mail.gmail.com>
X-Google-Sender-Auth: Xnq1ov4ZqU1socjUbEQzC1zEKpI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295304>

On Sun, May 22, 2016 at 6:31 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, May 16, 2016 at 7:09 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +       old_reason = is_worktree_locked(wt);
>>> +       if (old_reason) {
>>> +               if (*old_reason)
>>> +                       die(_("already locked, reason: %s"), old_reason);
>>> +               die(_("already locked, no reason"));
>>> +       }
>>
>> As a convenience, would it make sense to allow a worktree to be
>> re-locked with a different reason rather than erroring out?
>
> For now I think the user can just unlock then relock, after examining
> the previous reason and maybe incorporating it to the new reason. Yes
> there is a race but for these operations I don't think it really
> matters. If it's done often enough, we can lift this restriction.

Agreed. It's easy to imagine someone wanting to change the lock
message to correct a typo, but that's likely a rare occurrence, and
other conceivable reasons for wanting to change the message are
probably even more unusual, thus not worth worrying about now.

>>> +       write_file(git_common_path("worktrees/%s/locked", wt->id),
>>> +                  "%s", reason);
>>> +       return 0;
>>> +}
>>
>> This is a tangent, but it would be nice for the "git worktree list"
>> command to show whether a worktree is locked, and the reason (if
>> available), both in pretty and porcelain formats. (That was another
>> reason why I suggested to Mike, back when he was adding the "list"
>> command, that 'struct worktree' should have a 'locked' field and
>> get_worktrees() should populate it automatically.)
>
> Yes. And a good reason for get_worktrees() to read lock status
> automatically too. I will not do it right away though or at least
> until after I'm done with move/remove and the shared config file
> problem.

For the record (for future readers of this thread), [1] itemized
various useful bits of information that would be handy as fields in
'struct worktree' and populated automatically by get_worktrees(), all
of which (I think) could be nice to have in the output of "git
worktree list". Excerpt:

    For git-worktree commands such as "lock", "mv", "remove", it
    likely will be nice to allow people to specify the linked
    worktree not only by path, but also by tag, and possibly even by
    $(basename $path) if not ambiguous. Therefore, to support such
    usage, at minimum, I think you also want to show the worktree's
    tag (d->d_name) in addition to the path.

    Other information which would be nice to display for each
    worktree (possibly controlled by a --verbose flag):

       * the checked out branch or detached head
       * whether it is locked
            - the lock reason (if available)
            - and whether the worktree is currently accessible
        * whether it can be pruned
            - and the prune reason if so

    The prune reason could be obtained by factoring out the
    reason-determination code from worktree.c:prune_worktree() to
    make it re-usable.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275528
