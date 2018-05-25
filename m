Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508BE1F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968103AbeEYT2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45558 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968062AbeEYT22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id w3-v6so10927071wrl.12
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WSg//m17NQLIPg00rA8ocU0bTxGTIgsFBBTvkwwt05k=;
        b=fluC1hGLrdPB6aNVrpFvOxHl9uxXB0ZjaB9/KeQ5TrOygrkqA5n/U5nfJw6mPwB7rG
         Z7jhzGOoFPyIWpndkx1w+tuv1/VexJhE3AXHaR287pq/FnwDjwhvAkuX3czcHRnRNzwb
         KHqnxyREasVTOdgOaQWHE1+oW0yiBbZjjsMfz7/iJ6AxpgDHFv3ov5ZkZXl+Z/ePvOD8
         BpKPCVxErGLepWbEL0/plLbxabNxPMlCKgJBZZfbMWco+Hu48zx663MT36gUcTePUI9n
         tZOraWsqo3/eDH7VsDbU2zwqP0dunYjB0y0KgITyPWs5UuG72L3xKKFYh/1QNwvSeez6
         1NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WSg//m17NQLIPg00rA8ocU0bTxGTIgsFBBTvkwwt05k=;
        b=PXvNox39dlIpM9S5MS9HTsMUeExjk73A6arjfsg2uI+xAPIwI3PB/nGuXjX/SqI9h9
         Gq4SseTg1Jtj23Q8CM74rCRjuNWb+Afuc9iJ5te2rnJmCC/GZLchwMPJiQXlmzr2QNuS
         th2ZE3QL+Xgk6NJVeYyDoxTib0pE1ibCEMP/wMM0iDf8wLsXSGilOtkFeRLJEnlO4zs8
         1n0Nqd88pPHAE+AyoqdcDLm2iNxU64MU7vtJx4EN987XvjcAOTCrbISbY66fVBPrJObd
         q7oZmo0iKcEgfnJvFNcDqLdavl+lhhqD7oJ0JDwGKb8h8fINQEBb0xOtoVgPHaW2NRG6
         mv5A==
X-Gm-Message-State: ALKqPweAwJxmL0TCaJRDXAzO/A5ifD9mm2rQo4njBTk2i36u0nvTwCRY
        EtXVHtTcTaqx2b7cQQkQrOgZHkOC
X-Google-Smtp-Source: AB8JxZo+JS40caH/wg9crpGJi0DzNvh9Oxek8zjZ5E1gMk6P/6JMZUSteua5UiTBXKFshuzUTVF+JA==
X-Received: by 2002:adf:a949:: with SMTP id u67-v6mr3029224wrc.71.1527276507146;
        Fri, 25 May 2018 12:28:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] config doc: mention future aspirations for transfer.fsckObjects
Date:   Fri, 25 May 2018 19:28:10 +0000
Message-Id: <20180525192811.25680-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King has said on at least a couple of occasions (at least one of
which may have been in person over beer) that leaving corrupt objects
in the local object store after a "fetch" that fails
transfer.fsckObjects should be fixed, and we should have something
like the server-side quarantine environment on the client-side.

Let's note that in the documentation so we don't seem to be claiming
that this is by design. A previous version of this change called the
current behavior a "bug", that's probably too strong a claim, but I
don't think anyone would dislike a hypothetical local quarantine
patch, so let's we might change this in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71b3805b4e..f97f21c022 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3350,7 +3350,9 @@ security checks may be added in future releases.
 On the receiving side, failing fsckObjects will make those objects
 unreachable, see "QUARANTINE ENVIRONMENT" in
 linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
-instead be left unreferenced in the repository.
+instead be left unreferenced in the repository. That difference in
+behavior should not be relied upon. In the future, such objects may be
+quarantined for "fetch" as well.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.17.0.290.gded63e768a

