Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4651F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJaDiX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:38:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:38:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so12812399wmc.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10Xt/B4D04kbrh4i82/siHV2wxJN/B+eCMI8sJcfrPc=;
        b=LxuiuHVPUeh9wsW797MoVZsDcDH/B6NMbsHNlmpyCP6fcvsRkSmPEAqKTQhwMlWrmq
         ulJuk+NTIuDtRZr2DSbKQfEOd2gGuLdOE0Iapn5kUi8R4L045WoKrGMmrAuYK3mpE3Vk
         /ZgFl+e+a9yWpjIRUjyxchX69Ex2Gyn+dxr0H9Ycl7JpWU67RK+XRPEypmuUdGNoGujT
         G8HQRqhenmtxvcDb3SzoeEMHfmAnFfbsyHk/6e36/OyFUVNN1GnS0q2FwUT6mxjwp3N2
         XbV6uVLaKSgX7umaIzSmMoPUwdJ/Ap+zLTLQ6fl0ZMh9gMxph/JdDZlZM/6xd+qpV1Wi
         I/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10Xt/B4D04kbrh4i82/siHV2wxJN/B+eCMI8sJcfrPc=;
        b=tdOfqXPB34mEkzMrQjk8zCwJAtW3HNSUl/wc/poLB53aqkKQKAnzLPtxZ14M7hXxQa
         si7x7rWt3RghwxgtDKZJXoWBlxpdLpxfWREYwQKhypzAAl88WhWMuAvvDGBdcimmf0km
         zbfJ7QyPJ9M0C36Aj6wkJ4Shhg/0vSBsqjEr0PpYfG/iBg3+X5oT5MD2+HFGsxsburR8
         UA/mrLr+efz0JIpRuNDWYudI0je8Qdc6p7gN7L/npjJNErpOUjh97e9z+s9t+FXniBD4
         Gm/K+eMN50M9/+Zkj8g5LCr9g35XNhnmJkAnjRjKmVOnCMSu4F4aLMUUyFo8XkZrUS2Z
         Z7AQ==
X-Gm-Message-State: AGRZ1gJM4igSmwb7eC5lPCYbKlFQpiAGIXFKRhB7Dk+39uMzXZzsLClh
        MIxSPUg6pddDph4SIAa7XVUEC4Me
X-Google-Smtp-Source: AJdET5cRQXAmx/l+IS3Vn8nQV/rbsvGqpQ0PUskgbT+o7h9L6fxs05hOGNQG7YkVU+OnD8+JBceKQA==
X-Received: by 2002:a1c:a782:: with SMTP id q124-v6mr28916wme.21.1540925022778;
        Tue, 30 Oct 2018 11:43:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k66-v6sm9999825wmd.47.2018.10.30.11.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:43:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] index-pack: test updates
Date:   Tue, 30 Oct 2018 18:43:28 +0000
Message-Id: <20181030184331.27264-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181028225023.26427-1-avarab@gmail.com>
References: <20181028225023.26427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd still probalby like to have core.checkCollisions as a config knob
to be able to turn it off, but let's see what Jeff comes up with once
he finishes his WIP cache patch.

In the meantime 1-3/4 of my series is obviously correct test fixes
which I'd like queued up first.

Ævar Arnfjörð Bjarmason (3):
  pack-objects test: modernize style
  pack-objects tests: don't leave test .git corrupt at end
  index-pack tests: don't leave test repo dirty at end

 t/t1060-object-corruption.sh |  4 ++-
 t/t5300-pack-object.sh       | 47 +++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.19.1.899.g0250525e69

