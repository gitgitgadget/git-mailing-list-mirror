Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26863155744
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407292; cv=none; b=nMem4/wJH5Wln2nceU5tktALTKl91TCy0NznldDTbfmACeRv1YTgPrQZE4XbfuBN9YA/KjDFoPwg4spK3OBRDLc/oLKRHIQjf3P6jf2hihSMImkP0ZNzfTHBZoY1De9Pc7Ok6eKdvWBpVyHCpRwfDVEinrcyjzN+9DSqE6JF8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407292; c=relaxed/simple;
	bh=ZwYf9WRMbuhixf6mmu2X4cIH9wFgzlEcIwR9UpzxuDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKL15GBUFEICRCfJP8SEA+1WGJLxMfxKsJE30Ls8Gt2oxPSX5ByLb3xnDFx6CPrshOJz+5heZWAL4pnY3nWdeLkqOCddi1oEYSb+ZrOXnYOUXGezWBKq3CI3yycFyKkPrTazojz++NjV87gaLFCy+9h41kr6ICTrsVvq6yuJ8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVu027EP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVu027EP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f406e9f80so4184615f8f.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407287; x=1741012087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3invKOWKedbzAlOHRv9VeZd4UNgPGa0WBPllbGXrrHw=;
        b=YVu027EPz+Nt0fyoBhcZLwV+QNT7PFz1J+Bi1cCyjyf15M31KXUnEhyRDBIHRr9lmX
         V2FoZ5ga9hepzrll4yKE1MwDig41a1xlI/4uCgIsPJ+sCdTHUSE/D6FOym7dmq2vWPb+
         uav3cEwATgY53Fegs5E3/IcORLLKzYxQTt/3mOlX3g8bQ2kwmJig4KVUhHyT5LHtmCJb
         q6tw/7NBIh26cB2nHsko32IBj1qvFx4bIePjffQ1dgOSM/My+9m4lHyLgIiIhajPkg9I
         WiDQ6zETAfMsSWVLOBvo27r3Nul71UxdYv9iK7rTYHCsu+PELtQTTWxEQBgQXepX0RUH
         zZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407287; x=1741012087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3invKOWKedbzAlOHRv9VeZd4UNgPGa0WBPllbGXrrHw=;
        b=EfMkN3mbAOCXPaVL30aNwTMiCUBXGAPGVG5mZqPLmaD6tINA+fxu8IZXc/XiKTAAd5
         U3aoBMzN1akpg0WrJd356rt+wbaK9z6GP6xlkGMhBAC1mFOYIl5FrK+JNlbVq20aORdP
         YGaLMBA0PDhEpQfvgqjkC5EtBIEVb5u/XADZYyIbls+kElnuWdSyCW5FvBbFMKuHi0J5
         L6VdKLiR5l4h37CluGEgu7WzdBTZfnVM7FiUqUOMq+kScARQBNJRRL8yeGV4rcji+BB4
         uWVod+otkF3KFziq3DTmE2x7VLVHZzi8TMxWcJt9HRpa4dP+Nzw9JrYa6dIqKnfWwGdS
         0New==
X-Gm-Message-State: AOJu0Yz6Y62MQ5WPLufbE9hma0GbgUmtG0cRrPsUOTh25Qq2bC3MR7XO
	CKWhmfpV214VfHLgsuYc1yi+EU+9H10n2s50K7+F+zypy1pE8s/4eUkuZg==
X-Gm-Gg: ASbGncu4zeK80Y0XID+ay/KK/2YArawdkOncM63amxHRphvCVh08JjlluhXW9Df30MO
	vdrfgcero0KosRTmeEly7Oq7g30VPmY6c5Igme7ShOKZ44tfB1AHB9oUH+twtwDqQRlMDxynwLX
	b00I970W3hYOOLxCIcFEJZp3l/NFcFFw/ADsvBRJjzXcJrG/qbOYQPvrTCyg0mhlux0iyinIPto
	gU8V0r9ppozAxc9Bmnuuojma+gfbdplI7G4oRy8Cs9BUhm1S66qE1xavyH/VE1HDcHLqsUaqSd6
	BvZQJ5CJoWmUHW2WJO9aHOFq+6dx2ayVkpMKReXV/hDOpwKmVlX0Ms76a9Sh
X-Google-Smtp-Source: AGHT+IGSrZVDm2WZez5cMsxwgUkjRqmO3bHYcI4d2TMscK+wVdUPkBUzLT073KOlccGg98huqVYeEA==
X-Received: by 2002:a5d:64eb:0:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-38f6e97a27dmr12593830f8f.27.1740407287299;
        Mon, 24 Feb 2025 06:28:07 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:05 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/6] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
Date: Mon, 24 Feb 2025 15:27:41 +0100
Message-ID: <20250224142744.279643-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

The --signed-tags= option takes one of five arguments specifying how to
handle signed tags during export.  Among these arguments, 'strip' is to
'warn-strip' as 'verbatim' is to 'warn' (the unmentioned argument is
'abort', which stops the fast-export process entirely).  That is,
signatures are either stripped or copied verbatim while exporting, with
or without a warning.

Match the pattern and rename 'warn' to 'warn-verbatim' to make it clear
that it instructs fast-export to copy signatures verbatim.

To maintain backwards compatibility, 'warn' is still recognized as
deprecated synonym of 'warn-verbatim'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-export.adoc |  6 +++---
 builtin/fast-export.c              |  8 ++++----
 t/t9350-fast-export.sh             | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 752e4b9b01..ab9a315fa9 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -27,7 +27,7 @@ OPTIONS
 	Insert 'progress' statements every <n> objects, to be shown by
 	'git fast-import' during import.
 
---signed-tags=(verbatim|warn|warn-strip|strip|abort)::
+--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
 	after the export can change the tag names (which can also happen
 	when excluding revisions) the signatures will not match.
@@ -36,8 +36,8 @@ When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
-exported and with 'warn', they will be exported, but you will see a
-warning.
+exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
+they will be exported, but you will see a warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2bf787191a..2de2adc30e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -36,7 +36,7 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
 static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
@@ -62,8 +62,8 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 		*val = SIGNED_TAG_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
 		*val = VERBATIM;
-	else if (!strcmp(arg, "warn"))
-		*val = WARN;
+	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+		*val = WARN_VERBATIM;
 	else if (!strcmp(arg, "warn-strip"))
 		*val = WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
@@ -833,7 +833,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
-			case WARN:
+			case WARN_VERBATIM:
 				warning("exporting signed tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 40427883ec..cc110727fb 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -253,6 +253,24 @@ test_expect_success 'signed-tags=verbatim' '
 
 '
 
+test_expect_success 'signed-tags=warn-verbatim' '
+
+	git fast-export --signed-tags=warn-verbatim sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
+# 'warn' is a backward-compatibility alias for 'warn-verbatim'; test
+# that it keeps working.
+test_expect_success 'signed-tags=warn' '
+
+	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
 test_expect_success 'signed-tags=strip' '
 
 	git fast-export --signed-tags=strip sign-your-name > output &&
-- 
2.48.1.401.g48e0d4203c

