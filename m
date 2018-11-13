Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF611F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKNFwh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNFwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id e3-v6so14723466wrs.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gb/FDpQi2kCW3QSHhfAwUnjCxvhV5TG9StfUeAcXTs=;
        b=OYgB2klHRCH7gorxbhZMNneOY4ga6CiNDkck2SwP3Y/6F8gwBqz8yp6TP/Eku9gnuZ
         Zr8klF6adPehwBL2CWs1siwqLk7rgdpT+raGgj7X7g8I5gCGwIhBiQr29uCuTKQ4KGkB
         Is6yR+G2OUKnfTmpzz5xMQrEsVo7WMRbCNZ1fJjFgMsSAZ8iqKQPxZk5KV0dJWmvfn9z
         V93ij4VEZ78NnaUB4O+TXhPeUekOMu+HprYb7UncQKbj7CIrsGsWVZp9r4lFR4fQJ6uF
         apjLnyI9aKyi+eWztMoN4I4Goj8L4tuensoVvIjbVeShbJutqWXe6mY/3lJHzaLS/mNK
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gb/FDpQi2kCW3QSHhfAwUnjCxvhV5TG9StfUeAcXTs=;
        b=WrHCN5WZUKRS1Tc+hE+N80MbOybKl37+afsC7HL1fLfuObHNQWkMjuCqQj0TR7aMe3
         D+rviAieD4v5dqbXawNQ0YO6NSaKuJ3l61alwVIGqMMkkyjA/orsu82ss5qziNNuXbtE
         EmMCEmRh3ZwOhD11iioWwfQJMJrCrINFSl5z+K78/b9nUJ8dx06lbCHyJgQp+vRN2vzq
         2O1bd6UB3c2+9L9UH2fKcRk51fq79gSuYmJ8aCG2Nz0UgKvmNuWae2ikQgUYuIhnQPNS
         Wzm+GQ5lddAe2Ae7+P5wzhgYio6WV/rLTM9D0p+8uZSZbHBgVyvR4WbApkgH2vSTHRTa
         HkXw==
X-Gm-Message-State: AGRZ1gLzY4fs9HjsGWoaKTDWpmQ5VY6A9J4xWrfODBcDdg6IkQIcKF4y
        Qv4zwF4FbNGGx1SNt9z12osjQu/8SHM=
X-Google-Smtp-Source: AJdET5ewaw4KCYj3lSPGByOhvv1LVKW4Nt04Pw3dGRNTx2mosBGllCedXY4SrZi4r+xjKVtqvWdZEQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr887000wrq.69.1542138776708;
        Tue, 13 Nov 2018 11:52:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:52:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/7] remote.c: add braces in anticipation of a follow-up change
Date:   Tue, 13 Nov 2018 19:52:39 +0000
Message-Id: <20181113195245.14296-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CodingGuidelines say "When there are multiple arms to a
conditional and some of them require braces, enclose even a single
line block in braces for consistency.". Fix the code in
match_explicit() to conform.

While I'm at it change the if/else if/else in guess_ref() to use
braces. This is not currently needed, but a follow-up change will add
a new multi-line condition to that logic.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index b850f2feb3..695b379a44 100644
--- a/remote.c
+++ b/remote.c
@@ -968,12 +968,13 @@ static char *guess_ref(const char *name, struct ref *peer)
 	if (!r)
 		return NULL;
 
-	if (starts_with(r, "refs/heads/"))
+	if (starts_with(r, "refs/heads/")) {
 		strbuf_addstr(&buf, "refs/heads/");
-	else if (starts_with(r, "refs/tags/"))
+	} else if (starts_with(r, "refs/tags/")) {
 		strbuf_addstr(&buf, "refs/tags/");
-	else
+	} else {
 		return NULL;
+	}
 
 	strbuf_addstr(&buf, name);
 	return strbuf_detach(&buf, NULL);
@@ -1038,21 +1039,22 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (starts_with(dst_value, "refs/"))
+		if (starts_with(dst_value, "refs/")) {
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if (is_null_oid(&matched_src->new_oid))
+		} else if (is_null_oid(&matched_src->new_oid)) {
 			error("unable to delete '%s': remote ref does not exist",
 			      dst_value);
-		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
+		} else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
-		} else
+		} else {
 			error("unable to push to unqualified destination: %s\n"
 			      "The destination refspec neither matches an "
 			      "existing ref on the remote nor\n"
 			      "begins with refs/, and we are unable to "
 			      "guess a prefix based on the source ref.",
 			      dst_value);
+		}
 		break;
 	default:
 		matched_dst = NULL;
-- 
2.19.1.1182.g4ecb1133ce

