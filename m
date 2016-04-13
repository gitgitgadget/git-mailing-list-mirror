From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/25] worktree lock, move, remove and unlock
Date: Wed, 13 Apr 2016 20:15:21 +0700
Message-ID: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeE-0003lX-C5
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760369AbcDMNPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 09:15:53 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35783 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760191AbcDMNPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:15:52 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so3958288pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/4kQv+tG+CojscRS0HIXjZnEsX4g4nsGmAiOLiki+M=;
        b=mzwIaBEXNPyKSG8PmnABZXSGeTtmZHojcLDgWunzHoNWIPgpRa7QLR3Kl0lctbngmQ
         NH5AOAV7k3jmaazv1lAEkxu/TVBJ+/pbYjpRmmXF8zGf+YyKUkxG55Z842N6IZp2Ak9P
         I6joYkM1nDaUxQJDldKYdmb/nK7zpU/Nf81QvtWUq/4SAx1mO+AaVONzv51N/3xp9Na1
         8lPeAz9xJ6BA2QTVMuBMR5XRPYUHzPqvNmrkOAN5n0lH3kbfSaI/kZ5k8QNnU6KwvSJJ
         5nv+L5XXLG0Kh3AffJn7XlfH4AjfreAZD8YIAaI0//5b5ub9/cuZBZ/w+C+qw6/2K0XP
         n39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/4kQv+tG+CojscRS0HIXjZnEsX4g4nsGmAiOLiki+M=;
        b=euYf25ACrE4yge5fGDVDuMn/66JM2RxNEYwx9yB7fkgRV/2Qus7OadQCaiNDXwMXUT
         5/HNQLh0U0tm1wAbGCRZaXDQSPT5mbgyXmyG8K7MuISEi7faGDbdYNdKV4JBMTyKTgue
         U7fV51AiVRhqI5cCn7t/XxptU1Cn24qQvnWOJ3+fKKguEANJb+B/Q6WE6vmjU3DyGX+k
         0CuywK6Fk6Mms1xuiTUghNZ1L4nXz8as2/0i4crW0yJGOwkIAmvvZDYZ/FRw85eZR83p
         CzxW1VLZ2tFcsHbC4LPF1ognL/+iRX8BSP5hGtGdbPxfmcuikAXGESC027EnbaByCbGT
         l2RA==
X-Gm-Message-State: AOPr4FUJ7sK8AG91wcmaTfPe+QuUrvNluMkACOvaI9k+0uA7IPZFLmwbksciy9ZD1W0T1Q==
X-Received: by 10.66.65.201 with SMTP id z9mr12809293pas.143.1460553347139;
        Wed, 13 Apr 2016 06:15:47 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id z2sm51125694pfa.90.2016.04.13.06.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:15:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:15:53 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291421>

This is basically a resend from last time, which happened during rc
time. It adds 4 more commands, basically cleaning up the "TODO" list
in git-worktree.txt.

So far I've only actually used move and remove (and maybe unlock once
because worktree-add failed on me and I had to unlock it manually).
And I don't get to move worktrees a lot either so not really extensive
testing.

  [01/25] usage.c: move format processing out of die_errno()
  [02/25] usage.c: add sys_error() that prints strerror() automatically
  [03/25] copy.c: import copy_file() from busybox
  [04/25] copy.c: delete unused code in copy_file()
  [05/25] copy.c: convert bb_(p)error_msg to (sys_)error
  [06/25] copy.c: style fix
  [07/25] copy.c: convert copy_file() to copy_dir_recursively()
  [08/25] completion: support git-worktree
  [09/25] git-worktree.txt: keep subcommand listing in alphabetical order
  [10/25] path.c: add git_common_path() and strbuf_git_common_path()
  [11/25] worktree.c: use is_dot_or_dotdot()
  [12/25] worktree.c: store "id" instead of "git_dir"
  [13/25] worktree.c: add clear_worktree()
  [14/25] worktree.c: add find_worktree_by_path()
  [15/25] worktree.c: add is_main_worktree()
  [16/25] worktree.c: add validate_worktree()
  [17/25] worktree.c: add update_worktree_location()
  [18/25] worktree.c: add is_worktree_locked()
  [19/25] worktree: avoid 0{40}, too many zeroes, hard to read
  [20/25] worktree: simplify prefixing paths
  [21/25] worktree: add "lock" command
  [22/25] worktree: add "unlock" command
  [23/25] worktree: add "move" commmand
  [24/25] worktree move: accept destination as directory
  [25/25] worktree: add "remove" command

Total 11 files changed, 1028 insertions(+), 48 deletions(-)
