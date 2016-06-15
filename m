From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Date: Wed, 15 Jun 2016 17:12:41 +0700
Message-ID: <CACsJy8BqDYrjzvaYJC1sBcqLw+5NAONE0Txo24BVS1Gz+ZmFjw@mail.gmail.com>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 12:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD7oy-0003qu-AN
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 12:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbcFOKNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 06:13:12 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36683 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbcFOKNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 06:13:11 -0400
Received: by mail-io0-f178.google.com with SMTP id n127so18390529iof.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SQ5aK4pw0QW/kNXklHvdZZ5tB4CLop6LYuTbxd9RZ7A=;
        b=B7MAQQBR+5kAprFSZ4dHbtFd37CPn/qrurJBRfBFQJdyGR0P5M3gbbL8GP4CR0GZ70
         tg3yZqPBVRAA355XQWOfOAk0aiF4Oujm37//t4L2P/UTcQ4crk/VLTnro+QFtT20ct6M
         Vm5EJ3SEQOqha/vHInNwKQGRyT1dZCcRaX8KQ5yMpCENTr8ipXzl4rvZy7S0ixRmjT81
         og8U5xp91S0Tns1L1/VOXDsGUNVyq/LRTKI54XXf1/sXHz0kZMYRQYOwA3A7vo179l+5
         y2hYl4SGUnUvr3z+HKKSHclPkpcQ6Zg9Spb/IJtyOb4eldL2lFtqa/QQtQxACHjvj5fI
         m5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SQ5aK4pw0QW/kNXklHvdZZ5tB4CLop6LYuTbxd9RZ7A=;
        b=BfHWQ5ChuNJZdMoIsvw5pfpb7hLHNnSf7lUR4lT6nMoca4SYEMTSQCO4LM18A1wFOZ
         sgN8kLlfj3J3pRGk8SsRRWQmP4hizR5s6nSSBsaiVQmCyqh3Bd0Pv5TysXyF89kwxmfl
         bUMpRcSvF31+cfTbf0/xQoN78J3vqyKw7l+takdXsyXttF7s6H/dY1qsoFqiwIg7ppcw
         Y5xKTE6l+MFO/SM3t2LRA65lrsAabyaC9yqRua23b/VDikeFs8q3Se39IOaN8Kral2sH
         0aKq0zniTNPQCDTDQXXgG+HCmTQ95JQQCXX6XO4G6HuWSQ/08cJ3cRdUr+2jLx3Fq7UP
         YzCA==
X-Gm-Message-State: ALyK8tLr3yJ4ZlljXg4DzjXc3qyfxGwcz8z4cZsI940Y+zW4WADddB/xBNShfDOM7B9Ac0GIdvgicr5j4QpU9Q==
X-Received: by 10.107.22.131 with SMTP id 125mr38303492iow.128.1465985590562;
 Wed, 15 Jun 2016 03:13:10 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 15 Jun 2016 03:12:41 -0700 (PDT)
In-Reply-To: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297362>

On Wed, Jun 15, 2016 at 5:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/i-t-a-commitable (2016-06-06) 3 commits
>  - commit: don't count i-t-a entries when checking if the new commit is empty
>  - Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
>  - diff.h: extend "flags" field to 64 bits because we're out of bits
>
>  "rm .git/index && git add -N * && git commit" allows you to create
>  an empty commit without --allow-empty; attempt to forbid it.
>
>  Breaks many tests by completely butchering "git commit", it seems.

Not surprising. I did run some basic tests, but not the test suite. It
was more an excuse to bring up the topic again. Please drop it. I will
probably resend (with more or less the same idea, since you haven't
given a loud and clear "NO").

> * nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
>  - worktree: simplify prefixing paths
>  - worktree: avoid 0{40}, too many zeroes, hard to read
>  - worktree.c: use is_dot_or_dotdot()
>  - git-worktree.txt: keep subcommand listing in alphabetical order
>  - worktree.c: rewrite mark_current_worktree() to avoid strbuf
>  - completion: support git-worktree
>  (this branch is used by nd/worktree-lock.)
>
>  Further preparatory clean-up for "worktree" feature.
>
>  Expecting a reroll.
>  ($gmane/294136, etc.)

Hmm.. I think what's in 'pu' (which is v2, $gmane/295260) is ok now.
-- 
Duy
