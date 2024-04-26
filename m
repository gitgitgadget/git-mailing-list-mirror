Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CAA94B
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091186; cv=none; b=AJKroBpzD7hKz62kzVLJwVBEFA9INwx/MXFVZZY3qerX7+rc0O2x4PeB7XvjVjS7qQhwJ5XpqIhOkodxkePn2fyNy0Z2C8CcH/0i6RhTW0iAt3xUugi8/sqtxCUFWPyNw8JeBvK+nTnJoI61UzGyi94V7iPr1lKmZ/dtGxxWnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091186; c=relaxed/simple;
	bh=M2IGualKqbmz1Ic5SwZXBIEQDju0L9R0gDiDDtzgrBk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sksj5V8iAEUY2hIG3P2LqN97GTWykhIeknYniC5zf5cRBn6iS7E2uBFTWkWpPORe9CdqzRBe6eV3i18YUK9eSe+7M5Wvrj0lDZzJi0oaYUNAtbhCESjOeuXEx3o61cQOb3om11huG2UGtvOU7+vX8hPH2GyZe6PSulzrP8IiwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUMMzqa6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUMMzqa6"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso22717051fa.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091182; x=1714695982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Syadgd5b0jP+Rx/VwdK+bsvYAR8drTA/fM/+OqxR0bU=;
        b=AUMMzqa6ktuemciVIvfzhEj2EQskTQMMnvfQzsX/4M8hN9LdbrjcDXp9Wa6pDUb0BX
         XCAEACDAKmbGsyv+cDWjmU1kTMhTxRxtK5qBThrJDjw2TtNphjNBhsVaS+ZqI5GZg21l
         z9Fwmd1pznQlj88Ri5iTC4LGcUpSBrn4hG/RlLpi3wg3CwuV6PaP2NSdQ0bGvGN2RIAx
         WA6e5E+Z/EyQgrS0bxF0B0lQ5nRifbSSkAlaV4y1SOJXKNquVPCyvBJQZ/lSypH5pVWN
         lk2TkOa5z3uazPUdPlEOf+4ZBWBdX7PekFXnC0FIArQqQGE5rzDXxmxYwb1v1yv0qz0o
         9mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091182; x=1714695982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Syadgd5b0jP+Rx/VwdK+bsvYAR8drTA/fM/+OqxR0bU=;
        b=g7iZWsnkO+QC4UvFLJdHNLWcrRvNDfu2pN2R+G6ZUbKLQk1/jNoNj4kM4iVsqwbrkk
         gvpec1xh8miBuNypgmcHVTc3uTGczdlkDkT8pF4IKOdvpnsLHUvoQkA6VpXpNZxG6ENS
         Sgt/7VMYMalDJllMCXyLac7cGBQnJodK8Yfyxt98nGhQtwZqiA3fcrtwQXZwF5uyf4XC
         Yze6XA06Z1kxKZYdYsX59GuiJtSY+ClBz7s4j/xDqLDKodGJWHMuMoqDfB5mN/AyJ8Ep
         zRz6+paGL6BasnXTuN/kewvYP0xp/Vp9MBFoKb15cb8eSds00MVr97t3uHCGxhl9Ezuk
         YWvg==
X-Gm-Message-State: AOJu0YzaP1CMzsWve3jrIxkF4zoIwa39GvW9K67BF3YP0SgZDrOIYTVq
	HTiuabDkvVfg3TSqNUCe8Eib+oOn1IoBKrC/zlaow5MyXGkRz6q1corafQ==
X-Google-Smtp-Source: AGHT+IFE6lftTONE+0DfqUnGbQU6kie4Gp7WTw20sg7EEtd0ZCubz4H0Mfe2iHNP2aXX438AR81sww==
X-Received: by 2002:a2e:2407:0:b0:2de:4b8d:ee31 with SMTP id k7-20020a2e2407000000b002de4b8dee31mr467008ljk.37.1714091181932;
        Thu, 25 Apr 2024 17:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay28-20020a05600c1e1c00b0041b4f563a17sm3581586wmb.39.2024.04.25.17.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:20 -0700 (PDT)
Message-Id: <35304837e08aa1ecf6bebb47aa31813a80f2a2f4.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:09 +0000
Subject: [PATCH v3 09/10] trailer: document parse_trailers() usage
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Explain how to use parse_trailers(), because earlier we made the
trailer_info struct opaque. That is, because clients can no longer peek
inside it, we should give them guidance about how the (pointer to the)
opaque struct can still be useful to them.

Rename "head" struct to "trailer_objects" to make the wording of the new
comments a bit easier to read (because "head" itself doesn't really have
any domain-specific meaning here).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c |  8 ++++----
 trailer.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/trailer.c b/trailer.c
index 33b6aa7e8bd..406745264aa 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1026,12 +1026,12 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
 }
 
 /*
- * Parse trailers in "str", populating the trailer info and "head"
+ * Parse trailers in "str", populating the trailer info and "trailer_objects"
  * linked list structure.
  */
 struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 				    const char *str,
-				    struct list_head *head)
+				    struct list_head *trailer_objects)
 {
 	struct trailer_info *info;
 	struct strbuf tok = STRBUF_INIT;
@@ -1051,13 +1051,13 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 				      separator_pos);
 			if (opts->unfold)
 				unfold_value(&val);
-			add_trailer_item(head,
+			add_trailer_item(trailer_objects,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
 		} else if (!opts->only_trailers) {
 			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
-			add_trailer_item(head,
+			add_trailer_item(trailer_objects,
 					 NULL,
 					 strbuf_detach(&val, NULL));
 		}
diff --git a/trailer.h b/trailer.h
index 1b7422fa2b0..647d48aa2de 100644
--- a/trailer.h
+++ b/trailer.h
@@ -70,14 +70,63 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
+/*
+ * Given some input string "str", return a pointer to an opaque trailer_info
+ * structure. Also populate the trailer_objects list with parsed trailer
+ * objects. Internally this calls trailer_info_get() to get the opaque pointer,
+ * but does some extra work to populate the trailer_objects linked list.
+ *
+ * The opaque trailer_info pointer can be used to check the position of the
+ * trailer block as offsets relative to the beginning of "str" in
+ * trailer_block_start() and trailer_block_end().
+ * blank_line_before_trailer_block() returns 1 if there is a blank line just
+ * before the trailer block. All of these functions are useful for preserving
+ * the input before and after the trailer block, if we were to write out the
+ * original input (but with the trailer block itself modified); see
+ * builtin/interpret-trailers.c for an example.
+ *
+ * For iterating through the parsed trailer block (if you don't care about the
+ * position of the trailer block itself in the context of the larger string text
+ * from which it was parsed), please see trailer_iterator_init() which uses the
+ * trailer_info struct internally.
+ *
+ * Lastly, callers should call trailer_info_release() when they are done using
+ * the opaque pointer.
+ *
+ * NOTE: Callers should treat both trailer_info and trailer_objects as
+ * read-only items, because there is some overlap between the two (trailer_info
+ * has "char **trailers" string array, and trailer_objects will have the same
+ * data but as a linked list of trailer_item objects). This API does not perform
+ * any synchronization between the two. In the future we should be able to
+ * reduce the duplication and use just the linked list.
+ */
 struct trailer_info *parse_trailers(const struct process_trailer_options *,
 				    const char *str,
-				    struct list_head *head);
+				    struct list_head *trailer_objects);
 
+/*
+ * Return the offset of the start of the trailer block. That is, 0 is the start
+ * of the input ("str" in parse_trailers()) and some other positive number
+ * indicates how many bytes we have to skip over before we get to the beginning
+ * of the trailer block.
+ */
 size_t trailer_block_start(struct trailer_info *);
+
+/*
+ * Return the end of the trailer block, again relative to the start of the
+ * input.
+ */
 size_t trailer_block_end(struct trailer_info *);
+
+/*
+ * Return 1 if the trailer block had an extra newline (blank line) just before
+ * it.
+ */
 int blank_line_before_trailer_block(struct trailer_info *);
 
+/*
+ * Free trailer_info struct.
+ */
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-- 
gitgitgadget

