Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B521F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJ0EGS (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44271 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeJ0EGK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so2128317wre.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8uKsA8NO0fr26TkXK5TqU2QYhmOKbVQmuurpcJ16X0=;
        b=GULAY+Y2Ddm4MH8e99tJJ13kgfcpB6pC2B/P8Hl3qM5w4CcsdEsFOjYZpBUjQlmK15
         Ok4rQ5XLmq3QoL+nAUbx70doDpTT7lkajh9xR3+C7pkg1IhYewOFid2TQbc/0uqqo8Al
         gx/AXI/+RHveILdP5svsd1Mu4YWdtX6mKVz6Do/dZtgQRyU6k1wpDarX89lE8TkrTcZo
         GU0YGNlY1kizZ/jIXmMdbwNEVRNGqIVe4gKEb4UyHvJ2N2iBQIrS4MG0OKxNPRRSCPHb
         lzs8YONEYEzgXrbNHHTEIsU5RAmvjzfg7EgDF7AUpgrBLJbmgwzUFhyULTy13iUnhJTq
         ZD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8uKsA8NO0fr26TkXK5TqU2QYhmOKbVQmuurpcJ16X0=;
        b=c/JfOacgZJf/WkH7Dx/YDBSXUtD6wK1vlOUkm3RM2r8xXho2BAN4qjOsdZUUY8Gri1
         JvzwSADPQbezRut66cJ/wCEb/Jt0RInA+zhLGWVdQXFSfhMwYXOVjscTEiD/2E1GwXkd
         n41kloBz5oOW73qntsR37O1JRrGsRy1r3h/CQldeD2sd6132OeeV5kEY/In8oQSCnvTa
         yYTuA4fz2fMb7hPxOxr25djSQMwk5q6NOOSiki0zMwYAT5Xs2k6Zo+g0n73sGCYsTbx6
         iTOE0LhLTXolvQBtVvQKBGHURsWDy6OQCrwrs/Q2+1UchOE2FWUyzXHImBrAF/kJLNQN
         aXiA==
X-Gm-Message-State: AGRZ1gJ04XzUa8QKZejqcj/I1tys1HaRixsV6Hx0GuiEr+WM8+2v7C0z
        qsJm5ymfIvfcb+v4YVeS+Ix6V5HOJ3c=
X-Google-Smtp-Source: AJdET5e20smZyDv8vJ0AcBMEvJaRD6nHOwqVgjzZiz5GrovSb1wazx6TUJVEu4Xud1nadEXbWKFY3Q==
X-Received: by 2002:a5d:4911:: with SMTP id x17-v6mr6759320wrq.272.1540582071357;
        Fri, 26 Oct 2018 12:27:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] push: move unqualified refname error into a function
Date:   Fri, 26 Oct 2018 19:27:31 +0000
Message-Id: <20181026192734.9609-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up change will extend this error message with the advice
facility. Doing so would make the indentation too deeply nested for
comfort. So let's split this into a helper function.

There's no changes to the wording here. Just code moving &
re-indentation, and re-flowing the "TRANSLATORS" comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index f4b438ff74..c7a0b9c46f 100644
--- a/remote.c
+++ b/remote.c
@@ -1005,6 +1005,26 @@ static int match_explicit_lhs(struct ref *src,
 	}
 }
 
+static void show_push_unqualified_ref_name_error(const char *dst_value,
+						 const char *matched_src_name)
+{
+	/*
+	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
+	 * <remote> <src>:<dst>" push, and "being pushed ('%s')" is
+	 * the <src>.
+	 */
+	error(_("The destination you provided is not a full refname (i.e.,\n"
+		"starting with \"refs/\"). We tried to guess what you meant by:\n"
+		"\n"
+		"- Looking for a ref that matches '%s' on the remote side.\n"
+		"- Checking if the <src> being pushed ('%s')\n"
+		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
+		"  refs/{heads,tags}/ prefix on the remote side.\n"
+		"\n"
+		"Neither worked, so we gave up. You must fully-qualify the ref."),
+	      dst_value, matched_src_name);
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
@@ -1049,22 +1069,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
-			/*
-			 * TRANSLATORS: "matches '%s'%" is the <dst>
-			 * part of "git push <remote> <src>:<dst>"
-			 * push, and "being pushed ('%s')" is the
-			 * <src>.
-			 */
-			error(_("The destination you provided is not a full refname (i.e.,\n"
-				"starting with \"refs/\"). We tried to guess what you meant by:\n"
-				"\n"
-				"- Looking for a ref that matches '%s' on the remote side.\n"
-				"- Checking if the <src> being pushed ('%s')\n"
-				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
-				"  refs/{heads,tags}/ prefix on the remote side.\n"
-				"\n"
-				"Neither worked, so we gave up. You must fully-qualify the ref."),
-			      dst_value, matched_src->name);
+			show_push_unqualified_ref_name_error(dst_value,
+							     matched_src->name);
 		}
 		break;
 	default:
-- 
2.19.1.759.g500967bb5e

