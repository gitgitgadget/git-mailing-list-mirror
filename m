Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7BC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbeHAVVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:21:40 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:46900 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbeHAVVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:21:40 -0400
Received: by mail-yw0-f201.google.com with SMTP id 2-v6so12410719ywn.13
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ul60BfXlQmeg60kKf5coJORjwhcLoyUEl6I7YyrPKxY=;
        b=AFlwhgXA8QBAqd8VSXMJ7lRoTvQC87uF2USIUOLyMeJ7Jtgm2jLfocL9GypH7TZ/Gd
         Iih6fxzuOB2qJIKdcEpBzu3VNITwer+RikDBI3HZ2/yS2lcyFpPVDqnsncC/dy4tqu+g
         IBNWC7L8lh+m5qTrGR2FIflbEGmsh9QQCrw6oD6QS37dAJq0/AVz7arfkoZ1B3nvv61b
         4fMYUiNSa9vR/uto1SvgWXJTDGFP9Mw5b3WQt1BYV1S4kS6lpKYh0VeZoahF69W47QkH
         48m7NyTDTUdQhiMf7Acm7wOVORm39gTQsxUxrgpkcA+iTGrsgNln23Xukc5H1vORblIC
         rEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ul60BfXlQmeg60kKf5coJORjwhcLoyUEl6I7YyrPKxY=;
        b=tyW5m8NFH9N92NyPKrP0ExK8WA4udGNyDEHk+GeKF8n/TGMxNFHcWJeqdDCLZ7RtFE
         GqsmMWIhiKXqPYrGxZKuc0I9bde+o6S+02cIyDVN5drWgug1Tuo2hOf0FOyxU75DEynU
         l6L3rIoR8LTwCx9wWOJgKS7heXP/8nah5wBSWt7ZbYeXKxsOiFAJ9qy6loj1aXrmb0L7
         QnaK7JJYwWhgKfKywNNF/Krrimi0fKMIw/oy91jlNtO3w21Da9AekEolVuA68jvIm6kn
         qno0J20HsB6drtWRF34f8cWwMIaOmOYopCk8UyghIA/4/UQvv4CljM9FF69Mk6b2K3TX
         P4IA==
X-Gm-Message-State: AOUpUlEacWgy3QrGzezitreW1wcBP7P7jD9WvL+y0RI0a6YgtGXKYLkG
        WUJ6sCmIz5WlSsVzLtZujMZ2CJHAR3/V
X-Google-Smtp-Source: AAOMgpcX1QLBwHQSihSQ/UlAAb24OEp3+cuOxs0CcYi2ZgVqQNo2UPGsMUZ/x4si4d9gwSXe0C2GNzfA2DPz
MIME-Version: 1.0
X-Received: by 2002:a5b:444:: with SMTP id s4-v6mr7795891ybp.58.1533152060969;
 Wed, 01 Aug 2018 12:34:20 -0700 (PDT)
Date:   Wed,  1 Aug 2018 12:34:11 -0700
In-Reply-To: <20180801193413.146994-1-sbeller@google.com>
Message-Id: <20180801193413.146994-2-sbeller@google.com>
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com> <20180801193413.146994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/3] t1300: document current behavior of setting options
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
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

