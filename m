Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9041F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfJUSkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so14738547wrb.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJp2xqy63/C8ct2GGPsWDLBKXQPX2IIv7PxniheFSEM=;
        b=D4LCeqqIFJ5fzRS3D69JR97YMaSO+EUX8FAO4J9GvHvpVjJS7vqmIVeLk3Hla1XDH7
         c1fB1bzRd1wRBI8uGgqAlgWAkY/P74eGd2ALO1PYX7RlGwMTTyPRQj6q0aqfPG3ap/m/
         JL/B/S5tVep5T9S7NbCvv6ql7KRFq6ptHDwTcIt3G/xjqwKt3hR1fzKHqQdLY2Z5xFIe
         /tCCv1JwaQdWx5J+b2of9s1w3eCKRHLED3ZQlDix7R0NfzLPHGtZldL+1KaY0+KIc+o9
         euitl86mpEYAOhC56fnZDWPPqM+jGHq8s2MQGMVzHtNpF+l1w5tU96Nqd36Q0bLctFZW
         iEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJp2xqy63/C8ct2GGPsWDLBKXQPX2IIv7PxniheFSEM=;
        b=eebZKYFvx6g9TvZGMkZ5wLtAdlJgABIS6Go7lTfM4QLXZo9wyxJG4xVPpFkhe0ynBl
         9VD2x41k8JofPnPLiosoxFdhhMKUzMUo4AaF1ijmqW84ZtV5uyQp7kxgaJuvvXqZNjuH
         prnx26Pw+cx3+HfGJYQX2KanmRx7mHWLynpROYkwOXiO5w97fAm6zpeaAOuF4FzhRBqO
         UccBGcTSwx6lQgYev4MaIZwPELD2c7aiW1v7Kdu+jl0SzYgFs8DONIukhAZdxzDNTLO/
         4aKws4DeqS6CBN/mhjAg4aUQ3Ie+oRpWPbw400sCRSJ3rtfWKXBqX0Fa2mRuWF5PGdI9
         iBzQ==
X-Gm-Message-State: APjAAAVYuf9wSC3Bv0XWt1uIFc+VoJ3+dDSUAT0rJYrY8Gucq8SFHfNJ
        vJcOcxoP+S6SxX+ocleQKPn8rQ3L
X-Google-Smtp-Source: APXvYqxvaLMeAqk2NlgslFP3yBsvhYeGzEjSgD/Zzdf6uQYEBmnCgHXanomM6fdhquWtw/ajGo33/A==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr21517388wrw.176.1571683206656;
        Mon, 21 Oct 2019 11:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm21561602wmf.14.2019.10.21.11.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:06 -0700 (PDT)
Message-Id: <4ac9527d984bffea22a399506500a18823b4bd53.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:40:00 +0000
Subject: [PATCH v4 3/6] midx: add progress to expire_midx_packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Add progress to expire_midx_packs.  Progress is
displayed when the MIDX_PROGRESS flag is set.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/midx.c b/midx.c
index 006f36b570..7157259ca2 100644
--- a/midx.c
+++ b/midx.c
@@ -1205,18 +1205,29 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct progress *progress = NULL;
 
 	if (!m)
 		return 0;
 
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
+
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Counting referenced objects"), 
+					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
 		count[pack_int_id]++;
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
+		display_progress(progress, i + 1);
 
 		if (count[i])
 			continue;
@@ -1234,6 +1245,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 		unlink_pack_path(pack_name, 0);
 		free(pack_name);
 	}
+	stop_progress(&progress);
 
 	free(count);
 
-- 
gitgitgadget

