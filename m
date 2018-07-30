Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D9E1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeGaAmE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:42:04 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:39770 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAmE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 20:42:04 -0400
Received: by mail-io0-f201.google.com with SMTP id x5-v6so9850033ioa.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ul60BfXlQmeg60kKf5coJORjwhcLoyUEl6I7YyrPKxY=;
        b=KTSdi+yudUKWJ4HkhlmsIJshYfRVczXqDoPMKuYB4j6YSLnGvUTFTx/o3Jv2M7sVDb
         k4iYzw/R4Rllsw0m1/m9BuazDWbN0cLh+VBO37HSh6eOXrVLZ0/hCtghdx4Igc1tURxd
         tZCEwWITuFwTas6GD7hK34Gct0YySvxEA5rxxmIThEOyEV2FcozQ+xT2CEIUv+HP3w9h
         q++E7q2rDNvc9fYF+8NRawOfqKR9yC20JfZO5ZaCnDcaYfxYjhiEMFBnGGDl/a5d3c5Z
         R91Psuhv8gwku4DU9FJPcXNUEGoQG7cnFmIhP6hEitTzOt/p60yTjzj4i/XNgBGWetQX
         QHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ul60BfXlQmeg60kKf5coJORjwhcLoyUEl6I7YyrPKxY=;
        b=SfEcMzX+kQvZGJzCM1FGJMo7CS/tzWQv9kFAjY/VGdtfflx4yAu5MMo6uAUaN9xJde
         b+Hk2Gf2jYrTF49TbhccQG6V7pJRHmRTmc3h0T+O1Bzs5rDvUzwx3fhiz/x9iEXGSXlg
         o33e+cMmx3/EGLTYnV9XjtTYPw2wtx9LXYcUJj7oKpFmsbRvAoQpLMrEDzh8zHIfaCgQ
         Q5ncJoWE+MWSDvgzpyvN80VKp/7I3GV/eRBUYHFrjNF6H7KG7ySGlSB7luHvQX02dAjK
         KO/8eQN7ZCO1gyoBcJKcweupPMm+2GcLh1lzHszZgu5zWM9D9l1R8KmGvQUH4MTTH9Mj
         JH2g==
X-Gm-Message-State: AOUpUlGRS3Z8+OIxgtfTohtWOjoqbWQoCrAnUm9iEx2LRVNKfiCP9tcn
        Ycwt4JOfvK8DecpvzTZEc8yUlVwfEgFu
X-Google-Smtp-Source: AAOMgpeYkA4I1kxbuCq8P0uA0SpIw/xso2wWHNlx3isUzm0VvOmJvR1M2Lk3p2egWK3WE20pDfObEvwX8+nk
MIME-Version: 1.0
X-Received: by 2002:a6b:3f57:: with SMTP id m84-v6mr7491763ioa.57.1532991889441;
 Mon, 30 Jul 2018 16:04:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:04:41 -0700
In-Reply-To: <20180730230443.74416-1-sbeller@google.com>
Message-Id: <20180730230443.74416-2-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet> <20180730230443.74416-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/3] t1300: document current behavior of setting options
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documents current behavior of the config machinery, when changing
the value of some settings. This patch just serves to provide a baseline
for the follow up that will fix some issues with the current behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1300-config.sh | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708eb..ced13012409 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1218,6 +1218,92 @@ test_expect_success 'last one wins: three level vars' '
 	test_cmp expect actual
 '
 
+test_expect_success 'old-fashioned settings are case insensitive' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "v.a.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		QR = value2
+	EOF
+	git config -f testConfig_actual "V.a.R" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		r = value1
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "V.A.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V.A]
+		r = value1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V.A]
+		r = value1
+		Qr = value2
+	EOF
+	git config -f testConfig_actual "v.A.r" value2 &&
+	test_cmp testConfig_expect testConfig_actual
+'
+
+test_expect_success 'setting different case sensitive subsections ' '
+	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
+
+	cat >testConfig_actual <<-EOF &&
+		[V "A"]
+		R = v1
+		[K "E"]
+		Y = v1
+		[a "b"]
+		c = v1
+		[d "e"]
+		f = v1
+	EOF
+	q_to_tab >testConfig_expect <<-EOF &&
+		[V "A"]
+		Qr = v2
+		[K "E"]
+		Qy = v2
+		[a "b"]
+		Qc = v2
+		[d "e"]
+		f = v1
+		Qf = v2
+	EOF
+	# exact match
+	git config -f testConfig_actual a.b.c v2 &&
+	# match section and subsection, key is cased differently.
+	git config -f testConfig_actual K.E.y v2 &&
+	# section and key are matched case insensitive, but subsection needs
+	# to match; When writing out new values only the key is adjusted
+	git config -f testConfig_actual v.A.r v2 &&
+	# subsection is not matched:
+	git config -f testConfig_actual d.E.f v2 &&
+	test_cmp testConfig_expect testConfig_actual
+'
+
 for VAR in a .a a. a.0b a."b c". a."b c".0d
 do
 	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
-- 
2.18.0.132.g195c49a2227

