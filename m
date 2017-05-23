Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6113020281
	for <e@80x24.org>; Tue, 23 May 2017 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764378AbdEWTZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:18 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37968 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758009AbdEWTZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:17 -0400
Received: by mail-wm0-f41.google.com with SMTP id e127so43504718wmg.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vGGl4kiUZto0a9Y0KiA/Zu1UPWLkn2dyBXoaCBm94A=;
        b=EUKRg91SFullwgsLW0H7C3V8HpTLY40fbsvklBYuBDV5N8IP5+zJY6Bb0EWFjqrokC
         VxXAXaR6uFwTQrVM76npzdDnphC31OzY0MriMWaTr+p3B8OhGhhwYM8M2wcG7t6WUeBt
         8th2ncDr7zHma0Sc/oVZc3aQQcK3eM7rUncCPQZz/OUzQSI9/gDvveqsgeU2Q/kfLpS0
         04URzn53bGrO4kbYbVo9TCYTGwP0f783fdOmBT+9B1v+GB0Yu+VQcy+3I75ewY3MwhRA
         XKArTKX5UhNTk2Y7b/Y3+kMnwwk96mLlqFUjIqdVHejiINzlLUZC5CI1/YVkfNWsgA9x
         7hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vGGl4kiUZto0a9Y0KiA/Zu1UPWLkn2dyBXoaCBm94A=;
        b=PXvkEaFQ0UfGAoj0a8T6hVZJCSw+lGTC7ipDlVOhyEyL0PcKrpgJjzAkRvYBScEVc5
         NNPaL4746/2U/EcQa0TFELKDKL4ENFNfIsCHCBri33uTBAnC0+vZjk6x6+bitcn+oFC8
         CCIe4jLh6kYbWZUlXsZ6FCGMLEjhw5qyyEZbyECgiNgyF623T4dmXO3SblAXadQ3e/qY
         uNWYKLFVfi9VTYW3WPacvq0iCByJfbbRzr8vcFb7Xw51RBHEUSU8oSNb5reh1veHRijh
         Z7oAjh8hcF5vjjYz25h72fGrzWYAe3WdWbEmaQ2PXlvDTPAdwbRHthabTmKUHlPBP8LV
         CiuA==
X-Gm-Message-State: AODbwcDwDeNwskC2eJm+rAocV1qvWi9CAXq2vxYgGDjdWl04dUrkjCCj
        4IIQrxSMbO2y3w==
X-Received: by 10.223.171.238 with SMTP id s101mr16287079wrc.83.1495567515897;
        Tue, 23 May 2017 12:25:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:14 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] PCRE v2, PCRE v1 JIT, log -P & fixes
Date:   Tue, 23 May 2017 19:24:46 +0000
Message-Id: <20170523192453.14172-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
References: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Easy to review? 29 (I mean 30) patches? Are you kidding me?!
>>
>> As noted in v1 (<20170511091829.5634-1-avarab@gmail.com>;
>> https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/)
>> these are all doc, test, refactoring etc. changes needed by the
>> subsequent "PCRE v2, PCRE v1 JIT, log -P & fixes" series.
>>
>> Since Junio hasn't been picking it I'm no longer sending updates to
>> that patch series & waiting for this one to cook first.
>
> I actually do not mind a reroll that goes together with this.  The
> only reason why I skipped the earlier one was because I looked at
> the original one, and the discussion on the reroll of this 'easy to
> review' part indicated that it will be rerolled, before I got to
> look at these upper layer patches.

Great, now that the base of this is migrating to next, here's the
second part of this.

For v1 see <20170513234535.12749-1-avarab@gmail.com>
(https://public-inbox.org/git/20170513234535.12749-1-avarab@gmail.com/).

The only changes to the content are better if/else branching around
conditional macros (but no functional changes) in the PCRE v1 JIT API
patch in response to a comment by Simon Ruderich.

The only other changes are trivial updates to the commit messages to
account for t/perf changes made in the series this builds on.

Ævar Arnfjörð Bjarmason (7):
  grep: don't redundantly compile throwaway patterns under threading
  grep: skip pthreads overhead when using one thread
  log: add -P as a synonym for --perl-regexp
  grep: add support for the PCRE v1 JIT API
  grep: un-break building with PCRE < 8.32
  grep: un-break building with PCRE < 8.20
  grep: add support for PCRE v2

 Documentation/rev-list-options.txt |   1 +
 Makefile                           |  30 +++++--
 builtin/grep.c                     |  16 +++-
 configure.ac                       |  77 +++++++++++++---
 grep.c                             | 177 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |  31 +++++++
 revision.c                         |   2 +-
 t/t4202-log.sh                     |  12 +++
 t/test-lib.sh                      |   2 +-
 9 files changed, 324 insertions(+), 24 deletions(-)

-- 
2.13.0.303.g4ebf302169

