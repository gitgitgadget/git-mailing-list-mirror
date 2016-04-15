From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/25] worktree lock, move, remove and unlock
Date: Fri, 15 Apr 2016 07:40:30 +0700
Message-ID: <CACsJy8DK863+rgseeYrQJ1db+xSeFfm8WsNvGBmJwD_pr1yMJQ@mail.gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com> <xmqqfuuoi35o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:41:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqror-0003Mj-8q
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbcDOAlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 20:41:04 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35087 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcDOAlC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 20:41:02 -0400
Received: by mail-lf0-f42.google.com with SMTP id c126so128210553lfb.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hio46suFkspWJkNC6XpFsu3eCfDp4WZa23ysxpOchyQ=;
        b=Tf2TZ41tpLLZnTkVFIyKvrUnE3jyQXR/pwJ75V8uQky4fZEE7sK8GAz3GZoU2v4G4y
         1/po7f7RYRgT2Txqjh3PhxVK9zhNpuKZBHficbLvN+KfiVVQuZuyRlg/qCZpisEnxoY7
         QJGz96/pKL24oyXe2cEYlWFIMdrceMtyaf/2HXDtztMGVplqAIMFCCKRvcqFxHopb4qi
         9Ex9v7M72TeYT1+Wf6b+HmF4fSmOnqB97iDlcf7Kf2XkRAZh2pZ5QzJiYZZa4S4Ey943
         7k4kTUBwiackUsuw6mxryMumwxobla0YuGMUANRGs/Px2dGZHcbl3/eNgJLP5Fvz9UTH
         P/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hio46suFkspWJkNC6XpFsu3eCfDp4WZa23ysxpOchyQ=;
        b=aicaPbV7h9sJ5aJA0o/V1FJ+YblN7G2wcL3MVubkVEZkbHlGJAtFUScFibv7c9KtQw
         Fq20e7qJnmYzLJY0WkEl5WoBJHnEnnHItheukupcSGaMIJLytKtSQjqzLQo3j/Lmpzg0
         svbaXFMxaHelmRjx+Fj36VssR8o2gqOEmgYHZXQ3+bDMa/KYsFBw08woLjuLyFL3mFxN
         DQmadUZcfr91rB2G1b9/4OtfSsiAMY3fPxA6K+rSqQf3XAQ8Z4UjxKvIwNnVi31w3z8j
         SQBumMrA6fqH+uKL/1VBtZsl/vugZv7q+kFcLIHabtx7ixkpMhqAYw02R7cwZNKIpxzB
         i2QQ==
X-Gm-Message-State: AOPr4FW4rBwBl/iMp9RU4y2iatit76kEEWYk4ukV7zSkKwlqBJIOu6wywK65YFZHPpOSGCwsPV6jg6DrTzXhOA==
X-Received: by 10.25.23.88 with SMTP id n85mr6340339lfi.3.1460680860367; Thu,
 14 Apr 2016 17:41:00 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 14 Apr 2016 17:40:30 -0700 (PDT)
In-Reply-To: <xmqqfuuoi35o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291585>

On Thu, Apr 14, 2016 at 11:08 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This is basically a resend from last time, which happened during rc
>> time.
>
> It would have made them a much more pleasant read if you re-read
> them during that time and added the missing "why" to many of the
> commit log message.

Hmm... I thought I didn't receive any comments last time.

>> It adds 4 more commands, basically cleaning up the "TODO" list
>> in git-worktree.txt.
>>
>> So far I've only actually used move and remove (and maybe unlock onc=
e
>> because worktree-add failed on me and I had to unlock it manually).
>> And I don't get to move worktrees a lot either so not really extensi=
ve
>> testing.
>>
>>   [01/25] usage.c: move format processing out of die_errno()
>>   [02/25] usage.c: add sys_error() that prints strerror() automatica=
lly
>
> This looks parallel to die_errno(); isn't error_errno() a better name=
?

To me, no. Duplicating the "err" looks weird. error_no() does not look
good either. Though there's a couple of warning(..., strerror()),
which could become warning_errno(). Then maybe error_errno() makes
more sense because all three follow the same naming convention.

>>   [03/25] copy.c: import copy_file() from busybox
>>   [04/25] copy.c: delete unused code in copy_file()
>>   [05/25] copy.c: convert bb_(p)error_msg to (sys_)error
>>   [06/25] copy.c: style fix
>>   [07/25] copy.c: convert copy_file() to copy_dir_recursively()
>
> Somewhere among these, there needs to be a single overview of why we
> want "cp" implementation of busybox, e.g. what part of "cp" we want?
> the whole thing?  or "because this is to be used from this and that
> codepaths to make copy of these things, we only need these parts and
> can remove other features like this and that?"

We need directory move functionality. In the worst case when
rename(<dir>, <dir>) wouldn't do the job, we have to fall back to
copying the whole directory over, preserving metadata as much as
possible, then delete the old directory. I don't want to write new
code for this because I think it shows in busybox code that there are
pitfalls in dealing with filesystems. And I don't want to fall back to
/bin/cp either. Windows won't have one (long term I hope we won't need
msys) and *nix is not famous for consistent command line behavior.
Plus, if we want to clean up a failed cp operation, it's easier to do
it in core by keeping track of what files have been copied.

>>   [08/25] completion: support git-worktree
>>   [09/25] git-worktree.txt: keep subcommand listing in alphabetical =
order
>
> I'd defer doing this immediately before 21 if I were doing this
> series.

Will do.

> Offhand, I think it makes it easier to look things up in an
> alphabetical list in the description section, but it probably is
> easier to get an overview if the synopsis part groups things along
> concepts and/or lists things along the order in typical workflows
> (e.g. "create, list, rename, remove" would be a list along
> lifecycle), not alphabetical.
>
> But such judgement is better done when we know what are the final
> elements that are to be listed, i.e. closer to where new things are
> introduced.  This is especially true, as the log messages of patches
> leading to 21 are all sketchy and do not give the readers a good
> birds-view picture.

Well. I think all the commands are there now at the end of this
series. So we have add, list, prune, move, remove, lock and unlock. I
guess we can group list/add/move/remove together and the rest as
support commands. I might add "git worktree migrate" for converting
between worktree v0 and v1. But it's not clear yet.

>>   [10/25] path.c: add git_common_path() and strbuf_git_common_path()
>
> Write "what for" when adding a new API function.  "Wanting to learn
> X is very common and there are many existing code or new code that
> repeats sequence A, B and C to compute it.  Give a helper function
> to do so to refactor the existing codepaths" or something like that?

Pretty much for convenience. Will add some more in commit message.

> Move some part of [12/25] that is not about "store 'id'" but is
> about this refactoring to this commit.
>
>>   [11/25] worktree.c: use is_dot_or_dotdot()
>>   [12/25] worktree.c: store "id" instead of "git_dir"
>
> It is better to have these (and other conceptually "small and
> obvious" ones) as preliminary clean-up to make the main body of the
> series that may need to go through iterations smaller.

Sure.
--=20
Duy
