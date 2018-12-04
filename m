Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C15D211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbeLDN1Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:27:24 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45541 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDN1X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:27:23 -0500
Received: by mail-wr1-f41.google.com with SMTP id b14so2367408wru.12
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iyc3WIDGXn6/6x7AJclri/mnpEcdhCgJf1P3mNP/miY=;
        b=l3gKJuaSbX+Z28/951u65uJ4KPfK4f8a9z9QY2Y7f40yl3plCZAenpDk5vmvSTY0Lf
         /fSD+rbnd0RkvUOdwVqjBmhkqmHzEi5h9vqAjPh1+rMbcXvg8FmRYDuDGle4H9g1QNWS
         fLpLos+6dq+jHmCDOw/qFiCBaxQtGjvFoF3LkpkwYIru2E/LcEkNstR/OeA783O3ZtEi
         /pee6sZHxKks2oZBZC4rEvLnEr1am0NB+KqE3I/3IsrYkwmvOqq0JcCgmZqpBpHuP2MO
         LFrLXTprdIejbODEPRQUExtSiYBzvsNwIt7QzDcqXWuk3FYYXozs6UNbOaktYYEJM1vH
         22wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iyc3WIDGXn6/6x7AJclri/mnpEcdhCgJf1P3mNP/miY=;
        b=DpwBjhkEE0x+iqH9AFsYKLEY6ErhcYCXn8zeOY6NDxKLbqZ1yUaSSjwUwDxnyJZf/2
         +/HEdb4Y0/2uPkQo+AdMCjuvu8MSbewN0BL8FOT7IhmtK2ORZENLZWDM50XSSDIy/9vR
         HReCwzyJawPYd//SI+r+BUw/Fh0ZTCsqdhaVtmQ4k2/IwhsXCrgJH2u0kHyo+RzZjrOc
         3kMh6OV4BIwctTNNcs5jj8Wmu8JQgeiLni+GBQuR2YmyoessRbR6pE1dRL3wUX8tLZaC
         g6FWM4e/L+FuAl5nE0Yuqy7TbidCqEs/ydKJ97U8EjWlMv98hIFmILaA962xhve0Iu2c
         HYIA==
X-Gm-Message-State: AA+aEWYJDe/79n9iMBi9ft4YNEF6tZjOOCRDcw/lX0/ncv26SAHcMRXQ
        dAM6TbVpRXsPDuyKHkOo6nMvne/V
X-Google-Smtp-Source: AFSGD/UG2C7WpSSZO8JSbn6/Ezkjw02+qr0Y9FtRmQQ874+y5TEoK+faoZqFr1mIizUc64D2goRa3w==
X-Received: by 2002:adf:8506:: with SMTP id 6mr19013342wrh.128.1543930040338;
        Tue, 04 Dec 2018 05:27:20 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h16sm24588523wrb.62.2018.12.04.05.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 05:27:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] sha1-file: warn if alternate is a git repo (not object dir)
Date:   Tue,  4 Dec 2018 14:27:13 +0100
Message-Id: <20181204132716.19208-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805
In-Reply-To: <87tvjtvah0.fsf@evledraar.gmail.com>
References: <87tvjtvah0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a warning for the issue discussed upthread. As noted in
these patches we've been emitting an "error" while not impacting the
exit code, should we die() instead? Maybe, but until there's consensus
on that let's change this to warning() while we're at it.

Ævar Arnfjörð Bjarmason (3):
  sha1-file: test the error behavior of alt_odb_usable()
  sha1-file: emit error if an alternate looks like a repository
  sha1-file: change alternate "error:" message to "warning:"

 sha1-file.c               | 16 ++++++++++++----
 t/t5613-info-alternate.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805

