Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F101F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGSW4N (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:56:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40456 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbeGSW4N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:56:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so8212044edq.7
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0fmEOyeNfBPqR9I5bLVEmjcpeIwyezkoY5cGSLtg28=;
        b=vHGSaBN5kYHLHJulHW3Vn+UiGJ/P38dSbPkUmHk93Zu2Oht4Z4rvXiqkhScGvUh7Xv
         /PpyGFormfr7wgjGFviRN3ogzS2HRDqPgkV9Ajn3Tao3+LvUxfBycLTJ3WSaKLug9fLD
         jdRaWREkmrQa60ZrbPCWjxDqC1JZNKEW9nK9A93TW9UDWhWzPqhlPNzRZq4Sn6P22VnV
         R4XwQcR7M+bH3hBqRlQa0Spgu2uz0soNUFJLmG38VDgNz1jBjdvo97Zbvfqa3w7kNhL7
         pLliK1olHNqV9Bsv+2yDUgrZWvKtSZHfUH5B1Nc80npIUM8zmTFzlxiJi5xo+QXy4ByB
         TRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0fmEOyeNfBPqR9I5bLVEmjcpeIwyezkoY5cGSLtg28=;
        b=oKt3JvaYHiI4B9r0jS0SbX1Zj+By520BeawYxq7oV7UTxFErKFd1MGMADHxu+rBBvu
         CZn7HwXVzhzFCHjnPvAKRGZFIsFjiiwowLRLCjtASduWkdpUZ4RpSgPd8LJJ4ZTPhmIM
         ACAi1krfymFpG/QxcMArUn1mWB+1dU757YA1chprirm1z9IATf7HRDCC8hXv97kTlaE2
         42gjrL1Ql0puBSPgzlTQM1JTnJPIK9SFp0nVLsjcjn1J8f7tWANiDwzm3Oc+ZX2JDncC
         Ne2QFRNpmd2uEQV9fgqHJkGVk2YT3HOTcpYBhkj/TkJnBWAgoSRoZzsh2Y0FwagO6fuY
         M37g==
X-Gm-Message-State: AOUpUlE9TGlhGrctVyCbENKtKRGX2mbJCnv/Mmv0QIFyA2Ul2I6tKFID
        uZfGAB+qvK1nrrNXrt2gkpY=
X-Google-Smtp-Source: AAOMgpfVYFyDKrTGNmkcLeU6nTs1f4CHEheU5T1RSMhItu/6WBhEycwRm+Dx9tP/2OFnqzxFWDw0kg==
X-Received: by 2002:a50:b2a6:: with SMTP id p35-v6mr12964877edd.215.1532038267348;
        Thu, 19 Jul 2018 15:11:07 -0700 (PDT)
Received: from localhost.localdomain (x4db1dbec.dyn.telefonica.de. [77.177.219.236])
        by smtp.gmail.com with ESMTPSA id t44-v6sm328378edd.17.2018.07.19.15.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 15:11:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
Date:   Fri, 20 Jul 2018 00:09:29 +0200
Message-Id: <20180719220929.6550-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <nycvar.QRO.7.76.6.1807192225260.71@tvgsbejvaqbjf.bet>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com> <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com> <20180713184732.GC968742@genre.crustytoothpaste.net> <20180713201949.GA17670@sigill.intra.peff.net> <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807192225260.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, 16 Jul 2018, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > None of which is too surprising. The root of the bug is in the
> > > conversion to rebase--helper, I think, when presumably we started
> > > setting GIT_DIR at all (but I didn't dig further). Then 09d7b6c6fa fixed
> > > _one_ fallout of that, which was relative paths, but didn't help the
> > > subdirectory case.
> > >
> > > Just reading over this thread, I suspect the simplest fix is to pass
> > > GIT_DIR and GIT_WORK_TREE together, which is almost always the right
> > > thing to do.
> > 
> > Perhaps.  Not exporting GIT_DIR (unless the end-user already did to
> > the environment before starting "git rebase"---it would be a bad
> > change to unexport it unconditionally) may probably be a way to make
> > rebase--helper conversion more faithful to the original scripted
> > Porcelain, but I suspect in practice always giving GIT_DIR and
> > GIT_WORK_TREE would work well for many existing hooks.
> 
> Forgetting the code in git-sh-setup, are we?
> 
> git_dir_init() rather specifically set GIT_DIR to the absolute path, and
> since that variable is already exported, the `exec` commands launched via
> `git-rebase--interactive` all saw it.
> 
> That is the reason why the sequencer.c was taught to set GIT_DIR to an
> absolute path rathern than not setting it: for backwards compatibility.

GIT_DIR was not exported to 'exec' commands during an interactive
rebase prior to 18633e1a22 (rebase -i: use the rebase--helper builtin,
2017-02-09) (nor was GIT_PREFIX):

  $ git log -Sgit_dir_init master git-rebase*.sh
  # Nothing.
  $ git checkout 18633e1a22a6^ && make -j4 prefix=/tmp/BEFORE install
  <....>
  $ git checkout 18633e1a22a6 && make -j4 prefix=/tmp/AFTER install
  <....>
  $ GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"' /tmp/BEFORE/bin/git rebase -i HEAD^
  Executing: set |grep ^GIT
  GIT_CHERRY_PICK_HELP=$'\nWhen you have resolved this problem, run "git rebase --continue".\nIf you prefer to skip this patch, run "git rebase --skip" instead.\nTo check out the original branch and stop rebasing, run "git rebase --abort".\n'
  GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"'
  GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
  GIT_REFLOG_ACTION='rebase -i (start): checkout HEAD^'
  warning: notes ref refs/notes/commits is invalid
  Successfully rebased and updated refs/heads/master.
  $ GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"' /tmp/AFTER/bin/git rebase -i HEAD^
  Executing: set |grep ^GIT
  GIT_CHERRY_PICK_HELP='
  GIT_DIR='.git'
  GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"'
  GIT_INTERNAL_GETTEXT_SH_SCHEME='gnu'
  GIT_PREFIX=''
  GIT_REFLOG_ACTION='rebase -i (start): checkout HEAD^'
  warning: notes ref refs/notes/commits is invalid
  Successfully rebased and updated refs/heads/master.

And then recently came 226c0ddd0d (exec_cmd: RUNTIME_PREFIX on some
POSIX systems, 2018-04-10), which then started to export GIT_EXEC_PATH
to 'exec' commands as well...  


