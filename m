Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3A31F405
	for <e@80x24.org>; Tue, 18 Dec 2018 13:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeLRNrJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 08:47:09 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40758 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLRNrI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 08:47:08 -0500
Received: by mail-oi1-f169.google.com with SMTP id t204so1956590oie.7
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=playrix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sOqCZxD+iz514F9y+3FgJNc9OoiS3JG54UFQ7IwvfSo=;
        b=PPZU5E04rsp4DLa9ej1ovIoanv1CUUrDW5hyZf9ZfJmoyi8l8VV/qnEArjfbIuUjfW
         Z7L6F3ux1nlHxka82/pg8PCA0bdW/TIZUeHgr012kM5zlMPK4aEeG/wNYSk5Y2i+rN4X
         rUpwZ0x6jfpbYRP2ehwva+x1W/tz6q0+URZ4JN4lXJ1yGDz5JA063lBXfP9F+NKmOuF/
         zxIFcnTiRK9N+m9dxKTUTpKKNtWOSEQ9LJjuH02BYOYa6vvh+b3uar9DEU+PHjJ6q3ai
         X0YhpVAqQKZEEf/Idmc6u2CiBMoLwaWHh5Xixf5rTUHBjgDqYTZpFlGXwI47hKxgCxQ+
         HbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sOqCZxD+iz514F9y+3FgJNc9OoiS3JG54UFQ7IwvfSo=;
        b=eHEV2zaO4Hwh7hgFLUQMZJg4HZf04CvTLfADzm/i/ovbRckHqMXgzdPQuLLN0GPXb/
         SlcL7NhaN06doPekO56WPj5pibPvwFJyQROjUscdM+1nX0jyt17Nx8L1bEwO7aqrhhJU
         PiSKRRIPBsULvZDAy5Sh+3meT4a1DjMPse5RrvjQz8l27/HPY2E++GSEgWpxlbeu/SpK
         9cE01wJcK2DBlyd6F9Jyo7T7FpVyJoiOAWR4COb7gTsez6zh0PGAUmzniJ7IAOpRoXwq
         eN0IWx59ryvpuk1vTgI0tFmWNV7haqlSqHak3OPYr5bUi6SO+sbSfiVGpDM/4VzfMv8s
         PpVg==
X-Gm-Message-State: AA+aEWYmt/3p3SrZgHPNs9bqk+5fj3sYPmUwGDFPXvuo89hRgnG35a0V
        LFfE9WjpBVFB3y8wJok2SSS81kGaXlxKK8hrQMkUdIvQwJ4oMBhE
X-Google-Smtp-Source: AFSGD/Vk/d4bwq4jp0QpEaQ/rgrEF6OejIk9c622e6x8UMneyDiaugS+b0MK9hIFOJ6KUEdolTE8Q8Yb6d6EUkazT4Y=
X-Received: by 2002:aca:b954:: with SMTP id j81mr7429637oif.68.1545140827757;
 Tue, 18 Dec 2018 05:47:07 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?0JjQstCw0L0g0JzQvtCz0LjRiA==?= <ivan.mogish@playrix.com>
Date:   Tue, 18 Dec 2018 16:46:56 +0300
Message-ID: <CACu3VMWJ_otp2D6Tu_2adq=J2wcj0nsYhsW5oWxmbidb3afuyg@mail.gmail.com>
Subject: Git hooks don't run while commiting in worktree via git-gui
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0K/QutC+0LLQu9C10LI=?= 
        <yakovlev@playrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.
There is a little difference in behavior when you are committing to
the worktree from CLI or some git client (tortoisegit/sourcetree) and
embedded git gui.

If you configure git hooks in your repository and then add a worktree
(via git worktree add), hooks from main repository works well both in
main directory and in worktree, if you are using CLI/third-party GUI.
Committing in the main directory via embedded git-gui works fine too,
hooks are running. But when you try to commit in the worktree
directory from git-gui, hooks don't work.

I think I've found the cause of this:
https://github.com/git/git/blob/master/git-gui/lib/commit.tcl#L238
variable fd equals {} because proc githook_read calls proc gitdir to
determine path to hooks.
https://github.com/git/git/blob/master/git-gui/git-gui.sh#L626
This proc use variable _gitdir for calculating result. This var equals
the result of executing git rev-parse --git-dir
https://github.com/git/git/blob/master/git-gui/git-gui.sh#L1245
So, the path to hooks for worktree is
path_to_main_repo/.git/worktrees/my_worktree/hooks, but there are no
hooks. Hooks are in path_to_main_repo/.git/hooks, from where they are
correctly (or not?) executed by git cli, while running from worktree
directory.

If we put hooks to path_to_main_repo/.git/worktrees/my_worktree/hooks
too, they will work both in git citool and CLI/third-party GUI. But
they will execute different files, and it may cause some problems.
-- 
Ivan Mogish
Support Engineer
Phone: +9115212057
