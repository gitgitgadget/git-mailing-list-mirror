Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB711F453
	for <e@80x24.org>; Mon, 18 Feb 2019 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfBRPSs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 10:18:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40880 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfBRPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 10:18:48 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so41763941ite.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KUglxclcqmXx51xTc/BkYD472rO1n48OE7jxmOHzhpU=;
        b=LKX9Kpjy6JQvhowOJG0qaedwxkLBsIs7iBU+4vppvXjYRCCcdNsVLkGl6/9kG5GgPp
         Nus7mrtBAKD7upCQS1YeHW+EseVlgq4JdTsgeF7dnFkw9uc2ukY7OBpdHHeCkQJuUONR
         u3Sj1wu8KhiXKFDnTqzRzlhKDTyxkV3bfkxRSaCVgNVziUfw5tTKl8YI5XrwW2LFOIUY
         Vi192HhP6dR9LYv4oa5YnuXQCrhCRtRCBlnnRgfY2d+bV1Oawrmo/+bLvx69g/hBRp8K
         XagHeT32pCIMM+YBswCOeBZ5hWR9Trs2UtlWylxcaEtO1xV6JhmChxfapFcxwzCJJ/b2
         LF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KUglxclcqmXx51xTc/BkYD472rO1n48OE7jxmOHzhpU=;
        b=W3D3B0hyZdbqB2RgfO72xSn/JOr3OLNm7PuWL1hMNSv2cHNV1B2SkDZ8l93oESi2Zb
         uZCgwV5LJp95T0sWGE4qLqPMFJkcczE9KwXN2IhNVRv6KlrDdw/dc2fDWn/ibJo+mxAh
         WzzR6dIGPSIoownXbNV2U3KjLjV2noZseJ4BTLCd9VUDsIC5Iep91UcR3Vy8pxez9ka/
         UG9ES/BKbp9I/QsjtSNa64F353ppowAUEAcbuwK4QPYZya9rvbqAi7hFQvsrG85fW3e0
         uyh2RmapthKyLSSMxrvKRVBVXu1XrzRxTp9mQvZP6DsE2pdq9DD43B9oHPj6yWs4+i/f
         JD2A==
X-Gm-Message-State: AHQUAubGbPC3xVpP7og6Wno2WD+N+5DnK5aGNLYPO1jaIhB5SHtJgkBc
        0EOP9azMC8ADIgHXjlWU4j+VySxmH7mlEhz7MBQ=
X-Google-Smtp-Source: AHgI3IZCjHQLeC70zlZRpl3vfnrmgRCzioikkAGngU6O2RgEo4ABWB0XeRDs166NE4Icvr+T4pFtTCXGNHePkRdOIs4=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr2874626ioo.236.1550503127042;
 Mon, 18 Feb 2019 07:18:47 -0800 (PST)
MIME-Version: 1.0
References: <1550500586.2865.0@yandex.ru> <CACsJy8Bjryv5Of0kN-wwiQs5S3Km=z=WRDTPcBD_Sgsm6Mvjag@mail.gmail.com>
 <1550502546.2865.1@yandex.ru>
In-Reply-To: <1550502546.2865.1@yandex.ru>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Feb 2019 22:18:20 +0700
Message-ID: <CACsJy8BLERwq_oSnox7f0f_VPZy9NMjpM=nym_sJ-i8k-0DTKg@mail.gmail.com>
Subject: Re: git gc fails with "unable to resolve reference" for worktree
To:     hi-angel@yandex.ru
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 10:09 PM <hi-angel@yandex.ru> wrote:
>
>
>
> On =D0=9F=D0=BD, Feb 18, 2019 at 6:02 PM, Duy Nguyen <pclouds@gmail.com> =
wrote:
> > On Mon, Feb 18, 2019 at 9:44 PM <hi-angel@yandex.ru> wrote:
> >>
> >>  # Steps to reproduce (in terms of terminal commands)
> >>
> >>      $ mkdir foo
> >>      $ cd foo
> >>      $ git init
> >>      Initialized empty Git repository in /tmp/foo/.git/
> >>      $ echo hello > testfile
> >>      $ git add testfile && git commit -m "my commit1"
> >>      [master (root-commit) d5f0b47] my commit1
> >>      1 file changed, 1 insertion(+)
> >>      create mode 100644 testfile
> >>      $ git checkout -b bar
> >>      Switched to a new branch 'bar'
> >>      $ git worktree add ../bar\ \(worktree\) master
> >>      Preparing worktree (checking out 'master')
> >>      HEAD is now at d5f0b47 my commit1
> >>      $ git gc
> >>      error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable
> >> to
> >>  resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument
> >
> > Thanks for reporting. This is not a valid reference and causes the
> > problem. The worktree's name has to sanitized. I'll fix it tomorrow.
> >>
>
> You mean, you want to prohibit such directory names as a worktree? But
> it's a proper directory naming, can perhaps git do the sanitizing
> transparently for end-user?

No, not inhibiting. When you do "git add ../(abc)" then the internal
name could be simply "abc" or something like that instead of "(abc)"
which is invalid to reflog and other commands. The worktree's location
is still '(abc)'. There's also a work-in-progress option to let the
user control this worktree name directly.
--=20
Duy
