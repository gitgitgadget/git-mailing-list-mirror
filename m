Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E291F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbeALJ44 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:56:56 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42122 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754350AbeALJ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:56:54 -0500
Received: by mail-pf0-f193.google.com with SMTP id d23so4052901pfe.9
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkP/o0gYgVb9FTz3LbGM5qiURDA3a4SYEXZKChdvwsc=;
        b=vbHK/NWphZrteJS/h74NDCdU4EriRsvcEubCEOWWF0ofqXAoisJJrAW4rCMmfdgkzq
         tjjw9znbavaCxWlUDWhqUQ2PeCoxn3kWofF1L1YpxWKQoimA7VSRXWllfA/8afzShdcp
         zr2bmVtvbVyhYyqXBv58yxGmjGaOpjXeN1rZDXfTd+/A4vj5+OS7V2Qtkq1VC2lmj/dd
         nEvYfSraIGcz0xbNziShyF9coEWWAXuxsdeDfP8yXblF4W1GtGV+SyhrfvBfFxBTWVx0
         CwI7Wh7KUqUG8dMn+NLliSkxdnh749eC+Ntxv2OQAhRzGuaPtO0ampfkKySF5HNqd1SS
         iiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkP/o0gYgVb9FTz3LbGM5qiURDA3a4SYEXZKChdvwsc=;
        b=GaxrE8G7VPA7NtWFERCAe29dslZwpHBuWQaKzUYi+z23NfWqV/MertWFd+Mc23VDHP
         pO6LHWyPhDNMfynhxwpwOr+It6DcDPSSb1/ioRX2lxOfTbAoafZjIiWlGiSZO9ul3RDd
         WQzlnWru/GAitBpPGi2bSWkEG85Zm1/0aGaziV1M2ZS6lzMDla4DAk3Svop3JOWbNlK1
         c/xggHxurI8OiLNb1K20f2ncqTdDRe/iFAJIVIWWRBZ6Bmm7xP/EK7GPrumcD2KvlXE5
         4gA/2dHjNpLBQPp5MnRaul+3/vODRgn04CVmtmbMiuHZM0ozOUHcIQZ1mg86P/SJ3m8K
         WqYA==
X-Gm-Message-State: AKGB3mJ7ULd8EyoEVo2qx9DQloWYX1a0CR2idWBrj8xXpdeaWDvlXpqw
        LTdeiFKudjmeWd3jI4mUFCQvTA==
X-Google-Smtp-Source: ACJfBoufiVTE2RZezS8W9woQe0GR59EfaBviL8KfxqbuQwnXYgidt1MMLQsozeBNT70dXSwN2aFW1Q==
X-Received: by 10.98.86.217 with SMTP id h86mr22982618pfj.105.1515751013333;
        Fri, 12 Jan 2018 01:56:53 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id k13sm8948872pfj.38.2018.01.12.01.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 01:56:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 16:56:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/4] run-command.c: print env vars when GIT_TRACE is set
Date:   Fri, 12 Jan 2018 16:56:03 +0700
Message-Id: <20180112095607.18293-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180111094712.2551-1-pclouds@gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 turns a single patch into a series. Changes from v2

- env var quoting is now done correctly (from shell syntax perspective)
- the program name is prepended in git_cmd mode
- cwd is now printed too (because I have too, see 4/4)
- we don't blindly print the env delta anymore but print the actual
  differences compared to parent env
- which means we also print "unset XXX" statements in $GIT_TRACE

The new output on git.git looks like this

    trace: run_command: cd 'sha1collisiondetection'; unset GIT_PREFIX; GIT_DIR='.git' git 'status' '--porcelain=2'

a bit longer than I would like, but that's because of
sha1collisiondetection and it's not long enough for me to invent
$GIT_TRACE_EXEC.

I'm not adding "sh -c" back though because that looks like it should
be done in run_command.c itself, not just output tracing output.

Oh.. before anybody asks, I'm not adding git prefix to the "cd" part.
You're supposed to know that git moves back to worktree top dir when
you read $GIT_TRACE (or are welcome to improve the print out).

Nguyễn Thái Ngọc Duy (4):
  trace.c: introduce trace_run_command()
  trace.c: print program 'git' when child_process.git_cmd is set
  trace.c: print env vars in trace_run_command()
  trace.c: be smart about what env to print in trace_run_command()

 run-command.c |   3 +-
 trace.c       | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 trace.h       |   3 ++
 3 files changed, 111 insertions(+), 1 deletion(-)

-- 
2.15.1.600.g899a5f85c6

