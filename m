Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F05C20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756777AbdDPWVR (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36295 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbdDPWVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so6477177wmd.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LO8xeutJE3pGzRO1l25uQFZ0CIpt7xVve+2LDfBht0A=;
        b=eVI1fKQ2orfwzVsB5l2PwmpAJZKBKUxYKcuAmo3oZlu8OcqJyzjjnvDXm62g5mc+N2
         wZ9NPYKR+KQJaKKbJUIHGuWmNU5ARfQOFVbqdN34M/sQC5R/A1olJzOamtefc573Puqc
         wTe1TIAlDP9pLE/dAmiqlYkPx3bSp4dyY5nAWf08pv5RTT0krZmfLhllw0dKWcukLGIt
         oDXZexawuNPP0vWJgwMbduP9m3dAv3zHvc8EjHAjT4t1vc7JMEFGW8qZBMgpbRVdb3/V
         3L/1/ZZ1NgDabXkgpCJR9B7/BDRUqUlFGMzPv7sip4yWCpUq7MP+hwa+4/62g7YPHF7K
         2zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LO8xeutJE3pGzRO1l25uQFZ0CIpt7xVve+2LDfBht0A=;
        b=izHpFKTZln+OITjwERzmLki9flN5bq2w8e3OaBTSiEsb6vfwVGGno4+aLOqFoEFk3U
         6C1dy7cLuESYZ6/dK3H+sLsYFhpSRQIypgrioboozPugmPBXVpSWvZJAFo020F+XsoB6
         f/pyZ378mqT8D0jFopOknDEf1RuhL0hg9MvEzsNmenHEbh5IBxX+eH7rn9TmxUe03xTm
         kDS3qD0KuO9DpFjvkKSsnp2Krd4L9EBK0A5LrKFxGxrefe+3rAYgPSvVlBW5ycAHsb3M
         6R/Ke5cQtVPd8KF5uORTlP5/smAPmuGAPvA6oVbOtKwm9JdhFbV2mlkjd/GRzhZXUijR
         nVBA==
X-Gm-Message-State: AN3rC/5FBzs+y1SDHFjnfj0H88zzrcosM2ngXjeq0P5drAg7k8PFss5m
        2N7FoWTQ8+uCTg==
X-Received: by 10.28.143.135 with SMTP id r129mr6316615wmd.54.1492381274160;
        Sun, 16 Apr 2017 15:21:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] grep threading cleanup & tests
Date:   Sun, 16 Apr 2017 22:20:54 +0000
Message-Id: <20170416222102.2320-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the spiritual successor to the "grep: add ability to disable
threading with --threads=0 or grep.threads=0" patch I submitted as
part of my PCRE series (<20170408132506.5415-2-avarab@gmail.com>).

There's a long back & forth thread between me and Jeff King as a
follow-up to that which I'll summarize: I'd misunderstood what
--threads=1 does, because I was tracing how often a pattern was
compiled, and observing that even with --threads=1 we'd compile the
pattern twice.

This series fixes that redundant needless compilation in 3/8, skips
pthread overhead as Jeff suggested kin 3/8. The rest of the patches
are a bunch of small related fixes I noticed along the way.

Ævar Arnfjörð Bjarmason (8):
  grep: assert that threading is enabled when calling grep_{lock,unlock}
  grep: add tests for --threads=N and grep.threads
  grep: don't redundantly compile throwaway patterns under threading
  grep: skip pthreads overhead when using one thread
  tests: add a PTHREADS prerequisite
  pack-object & index-pack: add test for --threads warning under
    NO_PTHREADS
  pack-objects: fix buggy warning about threads under
    NO_PTHREADS=YesPlease
  grep: given --threads with NO_PTHREADS=YesPlease, warn

 Makefile               |  1 +
 builtin/grep.c         | 32 +++++++++++++++++++++++++-------
 builtin/pack-objects.c |  4 +++-
 t/README               |  4 ++++
 t/t5300-pack-object.sh | 33 +++++++++++++++++++++++++++++++++
 t/t7810-grep.sh        | 34 ++++++++++++++++++++++++++++++++++
 t/test-lib.sh          |  1 +
 7 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.11.0

