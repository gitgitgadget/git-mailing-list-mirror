Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D1E20209
	for <e@80x24.org>; Sat,  1 Jul 2017 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbdGAWGA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 18:06:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35481 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdGAWF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 18:05:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id u23so13883756wma.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZKB3y5r9FRBQZ8Hcssv+Kcvps9sEDwjTJMlHhjejZQ=;
        b=OAGJIzOxua/L7qfFpRSUpKLg7MjiRW12iHXxKwu8Ap2zZ2Ch+81i2x3OWT1q7L197E
         x/kDD1DP3vwEl5eJLSPC1V3bLaLcUAjp0nQoLZFuznzGBDpYKcUkAZOf3V14alVQNfX1
         19/195H/q7CKcZZ59Xt0JMMTnyZgRfs+ZFLu65RehPt9vXMjnK8bvHbHIP5nunaImOGV
         2+r5ehX+aPLLIEacfUDkmA/jYYXccVLTCF3BjIS81DppPNQu8cmVGGPHGk2fGa/IbNuq
         sbk7k/ZBnghQzXsAys7Ltm0hENCy9wCbBd1dxGdIx4pVhpDgBzuEt3cwDyDdpIvcSagc
         HuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZKB3y5r9FRBQZ8Hcssv+Kcvps9sEDwjTJMlHhjejZQ=;
        b=GArTwBnAVMJb8lS39MaGiDY4Wmcm21JxwHyHB3/I/t39JgROOikJ/Yp9DmTajBZ9vd
         +TdT8ovwhy/atBdHb3jv6se/ca4s/ALqacA/7gqvL9/ZFU5OImGTH2SF0oMdyeP1vY1j
         K34MW6b3sVmvwJ6vqkKPSHduhni1pcYDoFKgPbSnpVv/ry7ZPhFndWjgrtN1EmR+PDEL
         8tsAXMxvZnk9sUiOGytVadUZJ9+A/s9BdfLy6RVsduq3W206/TnZcBSQv6ONN6bmzdo4
         R4Vh1CGM/rwwR052qLjzHjJoD5pMyQWsXN2ptLjHXs2Z1OAQ296iP7jQ9SmZFCKrKPjH
         08Qw==
X-Gm-Message-State: AKS2vOw/W9W1VUd1eAsqD0Y1EVbqqemHpDPN+H8AH3ked0OuQ7RdHn2i
        WV6PN5AQcB0RKkNISIM=
X-Received: by 10.80.173.132 with SMTP id a4mr7722942edd.180.1498946757357;
        Sat, 01 Jul 2017 15:05:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e54sm4208643eda.27.2017.07.01.15.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 15:05:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] Update sha1dc from upstream
Date:   Sat,  1 Jul 2017 22:05:44 +0000
Message-Id: <20170701220547.10464-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The upstream discussion about solving Big Endian detection concluded
with something that hopefully works on all our platforms, see
https://github.com/cr-marcstevens/sha1collisiondetection/pull/34

This updates us to the latest upstream commit.

Junio C Hamano (1):
  sha1collisiondetection: automatically enable when submodule is
    populated

Ævar Arnfjörð Bjarmason (2):
  sha1dc: update from upstream
  sha1dc: optionally use sha1collisiondetection as a submodule

 .gitmodules            |  4 +++
 Makefile               | 16 +++++++++
 hash.h                 |  4 +++
 sha1collisiondetection |  1 +
 sha1dc/sha1.c          | 90 +++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 92 insertions(+), 23 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

-- 
2.13.1.611.g7e3b11ae1

