Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D205F2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdCRCFn (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32793 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdCRCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so3350306pgf.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rISzjUe8dh4VNoe8mNrHjT8UVszwFVssdM4JshAQg6U=;
        b=bdklpE7AT74ciHEVOO/rx2GO+m6fLRkNeMubP9/Cds1XYy+ih4BzBcwbdn5876ssIp
         xvnLFbeUPTHlth78trZMd0oxT5TMPfShfkkymgva/BHIh1Jg1TypaAPIaSmADesWM/wV
         Xxn4zMBBwkgiT8c3z3sqLJlfKdT5imeLSW2mcQ9rF+28aJ+W436KDmPuSSJ2qKupAkbP
         xYf/zQ8gI7jQBgsVnPS4KGCSCHHupTiFBOZRRmVIIG9UcaN6gPpNJRp8TuJNTs51uu7e
         QK4aJK2VOMLRa3Log+Nfx0dSmgGaGSVJpQ8QG1Jbn1xoD3LauxicK6kA/K8EofXED5Ax
         uGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rISzjUe8dh4VNoe8mNrHjT8UVszwFVssdM4JshAQg6U=;
        b=DXE/CuY4htO51Oh/4MXhiVXg90T7onab6HUk01LH9Ry+ylC4I1koaS7I9cjdA73FSJ
         Lf9kMd6KqgWodgC3x8PWTrrtN3rQD58mgSunsxdACyu0Jty1LO9atm+GETLnaU01Bp3H
         t7Wrc0rzjDksiC7Sxvk5aV5pJ0CXvbXhM9NUNVzoxRJ1Emkb1syTaVzW8x9RnU6BKQ6k
         QN/4aUdXGdUVHQv2/x3U2kLBGGPdEC2/WgzXceV8GG2bR9TxS5+rrBtGrouPCZwe0y6X
         sN2Jbp7FaaY4vSqpJ3/KNgO/YYiVomGKpTVkKDFKYsWm5KIws/mLMLPZhZUu+nJpVtHR
         HyaA==
X-Gm-Message-State: AFeK/H3cGW0dW6kgdDuFel4UuE+Vg1IroPsRqwKXG2fCD0rqQ2AcWirPopVrB9TNjJBB2w==
X-Received: by 10.84.211.97 with SMTP id b88mr24210749pli.113.1489802710563;
        Fri, 17 Mar 2017 19:05:10 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id t187sm2327940pfb.116.2017.03.17.19.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 11/27] refs.c: introduce get_main_ref_store()
Date:   Sat, 18 Mar 2017 09:03:21 +0700
Message-Id: <20170318020337.22767-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index e7606716dd..2637353b72 100644
--- a/refs.c
+++ b/refs.c
@@ -1456,15 +1456,23 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	struct ref_store *refs;
+
+	if (main_ref_store)
+		return main_ref_store;
+
+	refs = ref_store_init(NULL);
+	return refs;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
-
-		if (!refs)
-			refs = ref_store_init(NULL);
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
-- 
2.11.0.157.gd943d85

