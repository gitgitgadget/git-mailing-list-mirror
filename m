Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252081F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeHCC2J (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 22:28:09 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:58358 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCC2J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 22:28:09 -0400
Received: by mail-it0-f74.google.com with SMTP id h7-v6so3749471itj.7
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lY87fMeV8UANogmvWv0LoV3NxolpW29+c6aCPhQSO+s=;
        b=WwWXGxB5BXSxOcZWUbjog21dASI79E66YqD0DSj/zJzislpjEkVff3OOD/uSFKLZKe
         iaPdK4HB/YBOy/XnK+IFtvWlfeQkZPucdW0yfc/7RsbQB/7tFMYH7Qi+CKekjGEkgKVN
         eYo8fef2DvEPOCTrufLhlr+cN/Kj2OYe58TO3m7qSlLTgi3P0waj/IUvxPHKd+8E9bk2
         G7zhibLIrFHRK3rmRj7WbMfipTnBYPyOOaF5oYmIbX+FyViqQQl+t5rCm5J6O3O6xCyc
         zgh/VizMNZD+INeWNGmERpYf11RJ+F33+riU/M8gsFatcYVxsR8FzTPKnOOEXTL1yqi0
         L8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lY87fMeV8UANogmvWv0LoV3NxolpW29+c6aCPhQSO+s=;
        b=UVg1HG8/r6NXID+rYrqIEx6y49Aszgt8aLw/JcIFxpGdQgAybcM1yvwX5Sg8143LJv
         oOsb5JGLiiHbeExhUjEMc2Bro/uMv8S2RjYgQcpk75bbP3Ehgauz6Dd5xHSe+zKV4gEP
         kcVw72uTMue0q3+Q8axhK90fbrmIQuUpiexDk3LURtB308pzBPy1z9jpEyHikok2uyUP
         C6VR6qPajCdkt/aCcSq5s8EXffNNwkOHZAKbyhWZ4mF6k3rkLZ2lCl2eE+rNtF8XdUun
         Le9J1rnO6ihaR2CURcNRnjvk8nwKhSMynPkJC6W0qRLQzSbtvGT84WdH+AQOApKa2oGK
         Ezbg==
X-Gm-Message-State: AOUpUlEmUP68GKEqk5nxEIObNNmSBPz+RJMNE2qQW8oBI7eou6lMjZfE
        dlmZrsoxRLunQ8Ytgr0e23ag847xucHz
X-Google-Smtp-Source: AAOMgpc8T0zI/uKvMF5Doe+I1h7dQlCla7yZxUBdR1H4K3q2KWAUee/5z2n8aBGF7ZrNFsWlYADnKAHa1dEm
MIME-Version: 1.0
X-Received: by 2002:a24:76c9:: with SMTP id z192-v6mr2313066itb.29.1533256470592;
 Thu, 02 Aug 2018 17:34:30 -0700 (PDT)
Date:   Thu,  2 Aug 2018 17:34:15 -0700
In-Reply-To: <20180803003417.76153-1-sbeller@google.com>
Message-Id: <20180803003417.76153-2-sbeller@google.com>
References: <20180801193413.146994-1-sbeller@google.com> <20180803003417.76153-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/3] t1300: document current behavior of setting options
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net
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
index 24706ba4125..e87cfc1804f 100755
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

