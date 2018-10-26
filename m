Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2161F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeJ0EGE (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44263 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so2128120wre.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dhyh0a5Q4ZaOv+jNYAXOVcm28D6ttv4dilrANYN3DFU=;
        b=vTMmoG0D8SHnPNueuWFjJ3URVzlKLoryBE3Ot8ggUcMTOU6ecTJimc91FZs2q552R5
         QRzik3CGa/j0usWbU3KjtVbTfmTqUbBo/JhPhqwHrPx1/mHGfABMfN5B/OBYOJjI7tdk
         1U5uQNCjIjYZtPwXrYMYDvpScfqNOQNhslvK53qUUXGKj/Huh7vlWhxR4NINDSTWDJdX
         vBwCrJXepdxq6S2S5KfTh+ZNaSj9LCXx08uTLaKqOLW7HHr294PTQJzoLooGZ+bnlfp5
         7e1tdTwmX5oZkwis24nmszDi3kHQWhASzhcWhucwzkbmmIcuwVJAnRO/O+O2o6FnY3yo
         H41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dhyh0a5Q4ZaOv+jNYAXOVcm28D6ttv4dilrANYN3DFU=;
        b=SEEahIXifIQC9dI3f4bXaKRWPlNQGjaq5kYkxnFj6hbGH9B+vzBQuMdg6OFN3ZH61o
         lLpWGvOvERJN+41Nz58jmty+TF9JZXPv9VeuoQ6F2gqsizWT6MyUg2K2IBiAwCSQZaar
         22IX6yA5GN4SgEn9C+o323dUi5VpZQ2C7YnsXxrni9Wi6UVddViM5xBOHSEvJfuB9SQC
         9v//WorUFdLEFPXkoTYjiuvue0+ggW9/QbNoApaQ8S9Qu/45jIiwyvSFVSTtE6p1SMdM
         +TEpXKSdG6/4elavf4lKQyXyAFALWY4JdizvUvJkmqJ8CUpFkmI+7tzB+qo+9LVdadpU
         9kXw==
X-Gm-Message-State: AGRZ1gIgPTkHVhOS+vlBEuGqw07D8c2976fkjbkv5IZgxc2D9dhTJsVj
        HlIT25466ajWPGQmYVgvX3/PNOhv
X-Google-Smtp-Source: AJdET5fQo7wgaYQq9nPpRHEMZU76Mmw5ratUiRIXOEtcy24HaFznBxCm6W7Cjd+vwjmaH3nf4+cBtA==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr6664118wre.13.1540582065755;
        Fri, 26 Oct 2018 12:27:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] remote.c: add braces in anticipation of a follow-up change
Date:   Fri, 26 Oct 2018 19:27:28 +0000
Message-Id: <20181026192734.9609-2-avarab@gmail.com>
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
index 81f4f01b00..18cae48daa 100644
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
2.19.1.759.g500967bb5e

