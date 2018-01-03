Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929DD1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeACStF (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 13:49:05 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37112 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeACStE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 13:49:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id f8so2547665wre.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRQ61FP7JYIKe1RkkT4KwZFXgiNVTXbiSppxznh2//w=;
        b=QzF6EDfKE2avJd0jKhoNbdc8RteiEErm8Vtw10kSpmgr5XpJccAkj41/V/aKqSWTc/
         o4vRAvRXRAJu7wajP34xx8d7/GbWLYXFDtA7PG1SKz0pIKZSzmKb5JUuPWtb9w+KAD4l
         DsL4FhHo+EesTJ1z/CjLFyknv9HtXaIICia2KryD7L1qasMmdBPx8jWchpBBKqdy8Sbv
         zbp9nt2d5blGsVZTI2/BpciT8uNUCa83ebjqv/6YBx2Bpq+KIa8yLVlOLlh0/ZRwCffp
         dshmJeCq84BPP0sj7jt7JwJs4K41z7sO3lcxH/iAAea1pe/p0Pm8B0h9b7foe5l7BL3J
         jeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRQ61FP7JYIKe1RkkT4KwZFXgiNVTXbiSppxznh2//w=;
        b=NoOCWlYZmKZ5RYE6sHrES2Y84LKanhgqWZs4rASy/ZFuyMgdyCT0/piQylZZ1GwXKd
         eySYJjwrsRL3Nci8zdWrzNTPFEHHy8WLxeUSrzREcjknGGIt/sOqvQsuNInhLxEEBiO0
         wmzwIqWHm35sg+nM0seS5xBQgvsH5bYbq3Y1Mclx5pfz2QIofHpDMxx+h2lMNdW2VWtb
         w3Rnw26TlkdkvNKDjdF6XKVxbR95K7hJT+nsm/hu1d9y0jtqO6tl4kbaSZNHBTG8ck36
         Zuvf+1Pbp8l0cNtKMUWRbcQ+vpjUj6UbyGwFoJIrkxp9KzLeeeL4UFkRa1TWBX+iLuZ/
         zARA==
X-Gm-Message-State: AKGB3mKFGreyY0TktfKRNru4uc6blV69/i6aXGd8+gewozY6pNoRP7gR
        Kpz53hGMC+4/kg438KB0IbK38Ktk
X-Google-Smtp-Source: ACJfBouWr//Ubmk5vrbqGGM7xVad13SrjjsPHzLibS/zCiKTL8Ztqmt0tBFTW9QwVPZxYINhMLYShw==
X-Received: by 10.223.160.40 with SMTP id k37mr2314644wrk.66.1515005342919;
        Wed, 03 Jan 2018 10:49:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k61sm1744469wrc.84.2018.01.03.10.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 10:49:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yasushi SHOJI <yasushi.shoji@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bisect: fix a regression causing a segfault
Date:   Wed,  3 Jan 2018 18:48:52 +0000
Message-Id: <20180103184852.27271-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
References: <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7c117184d7 ("bisect: fix off-by-one error in
`best_bisection_sorted()`", 2017-11-05) the more careful logic dealing
with freeing p->next in 50e62a8e70 ("rev-list: implement
--bisect-all", 2007-10-22) was removed.

Restore the more careful check to avoid segfaulting. Ideally this
would come with a test case, but we don't have steps to reproduce
this, only a backtrace from gdb pointing to this being the issue.

Reported-by: Yasushi SHOJI <yasushi.shoji@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..2f3008b078 100644
--- a/bisect.c
+++ b/bisect.c
@@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		if (i < cnt - 1)
 			p = p->next;
 	}
-	free_commit_list(p->next);
-	p->next = NULL;
+	if (p) {
+		free_commit_list(p->next);
+		p->next = NULL;
+	}
 	strbuf_release(&buf);
 	free(array);
 	return list;
-- 
2.15.1.424.g9478a66081

