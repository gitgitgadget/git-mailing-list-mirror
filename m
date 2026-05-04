Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC313E5562
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916660; cv=none; b=uCXbq4RQFjxHczzjBrVgwhdKF7q4+ZnjLNG7URbrFBVtrAAE4/repg/m8NxAW5oeuoqCIeN7ZvK6iVXDWT/thSAN9Nq3dZftA32hI+9z8URaWnWMVIpqtZW3k00T5k5f3lgeMlsuoHXhn6k6B9pVAsm0QSweHrnRLI26w8Glzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916660; c=relaxed/simple;
	bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuxuGZ6lkdqUe8op6th/+daFuf8ZCDyk1cqYCLt8bhhqGcp3CNXDGpGhxKGM+wyLmlhzFJ7QK+X9Ks7XbrzVqkNPItpOmMRUTp5BmHtCKJdbdhYYjl30dSBZe8CWasea94W7LPHwopLky/GLULEXLyU8MLVBH3XP99UZKDwuIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAMavSjz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAMavSjz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so64309345e9.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916658; x=1778521458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=IAMavSjzqCW1n/H6SyJy+PJDt0x8GWMo36WrmYtF1P0C0dE8FO9sNtQMeYf+zHkzSR
         2T4JiqNMQLItlp431lH1venzk2k0q0u6aNs+7u13kJxvItOu/i5VwKB8VzOzxxSIe1bh
         Y/C58+JfoWQvxuFHF6HyhAGlZ4rEPd4fi3MPyN0wo9MLWqeOn9kqi4/wH0RXJrAJA1PX
         u1KjFx4nXuTM4QRgVpkCuTQN9w9m78UBJrpwHi1M2LrUGkUdjGnbJpU5v0i51c4alMO1
         kf08rLddeqC+mEETE+mFTZoNi5DBnT57ZF35IEhGxytjieAMdKsXEXtJ8l1oUb5Nbpc7
         +new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916658; x=1778521458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=mdaUJI7m1Mto3ibMD9z7o+QWEE3TLEISJELWEiM3RN5fdTG9FcSp85jbh35/1cUaPY
         Qu8O4NW5UHIrkyjrnI5XPSnOMObGqwADOFaaH8VxwQFZ3m4YwqIOHDNPQfllgCQxNXrF
         hQyPFWjMJ96fFWntS+4JwuU9h1s7hf724/N+cLF9Zl95QTxIhhfVHT/qz1KKYMOandMh
         N1HH2AICy5IwJAL3UouiX8MXqUGe6BcipSC8niMK2uRAMCfc5pQvQZOl7m9dOktGTKnH
         0SBwe4DPyfTbiJm4Cv/Q0ZpYZqhmbzaKvKnwguAnIY+om18NKZ0xYc7LzUULIZz2/wp5
         soHw==
X-Gm-Message-State: AOJu0Yz4evlpye/pvJM8ABfY+r/RK94G0aT5v3GhXnFITkT5/i00yoO/
	EJNrKwsuw9m7WHVILA5QzolyLghZUOdcTspHmJr4VNf396VvT/UvaTq28M0GIw==
X-Gm-Gg: AeBDieueuNRHAIcfS9DAP4c3VlKEjRHpIl3/OB02WXbGbE30AOpK+7ewi4k7hss96pZ
	SaTDEopSTmqR98Da1UwJH/gja0o3SLJy/vCoe2u0oLFps05hJ0Es1gjHzG+Xp8sv7LMPsUIgt70
	hyUUVgRE3srYHjCpSx4eo/zkQn1VItYRWe8QrIzqtMOqWg7cISD3XD+TpR34HajdPY1GshjVPlA
	OO/1vczu+ZUuNfq1Snb5mKKkV9FuLJ6jZemISA2xlbPE1HKo0q8FFADBp989uvUiaH3ToryXdti
	ShV6fDoYIdbdTRfmvsumHeUwfRs72Hq8cqSclnaU+Pnxq80B86iaGO58Evrqya9HIAmqLygIeP3
	tDkxnNxIXlk4Ue3BuRYMdEJ0sarhEAKny9jPot1HWXYOlkNiAj+Qceu25n8nE9lhzkNocVe6hXH
	KDCKJDJFYgBvD6X9AY3o9Nm/ua/Z9IOKELIn8+WPF4
X-Received: by 2002:a05:600c:4e0d:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48a98658b64mr191735325e9.15.1777916657530;
        Mon, 04 May 2026 10:44:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:09 +0200
Subject: [PATCH v4 5/9] update-ref: move `print_rejected_refs()` up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-5-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42ukJDBVritEt0G9CF+xdfqhnaUuXtCnfv
 UWjeYd61f+QfYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrpAAoJED7VnySO
 Rox/f8cL+wVrRsCsIzVlGifK0ZpArQLNGajqhCH7YN9MBPpvKefhdc7z0OCBG7FTyv3TNXoHO/c
 Yql8VZRcrzg3esKAITdDaGauNV2PZ80k4qXr6uNeJvh9TaLpzOXMulUF+wbcQjvLSVXQTj4DK9F
 EeHbO8dkt0UUNniU+YGBYSWzseMEAShjeMuat1zvhcLok0OOBwmFZrm6dlUpPRmAkYWu2OZTRMy
 Z9JggK0o3Qy5ghpbV0M/8zI4tRG6Z/+hDUI8pbSV75OtpoRi/mE5RiVG1I5culEZQhlTxnXn3SA
 l1PLQIakaL2S3ugWiIkb5eL/R7iFOb0+iMZUPTRt2kg94O5Dx5UtNyi7FbnYo9DTE7tr6MPWvgC
 rNHsdx9WK9rOmt5l/yh8ybUySNrMNWT10o+ramgXvlkqUUFiux+iD2HX5kRBwaj2eRo7wN7Ml6a
 YL2iez+vlw2MmoJQp2po3L51eutPC+Hlrqa26UlnXA9egZ9eQCz0A6dOze2GkE6SvVlfcN8lEa8
 L0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `print_rejected_refs()` function is used to print any rejected refs
when using git-updated-ref(1) with the '--batch-updates' option. In the
following commit, we'll need to use this function in another place, so
move the function up to avoid a separate forward declaration.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..5259cc7226 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -234,6 +234,28 @@ static int parse_next_oid(const char **next, const char *end,
 	    command, refname);
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				const char *details,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (details && *details)
+		error("%s", details);
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    ref_transaction_error_msg(err));
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
 
 /*
  * The following five parse_cmd_*() functions parse the corresponding
@@ -567,29 +589,6 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
-static void print_rejected_refs(const char *refname,
-				const struct object_id *old_oid,
-				const struct object_id *new_oid,
-				const char *old_target,
-				const char *new_target,
-				enum ref_transaction_error err,
-				const char *details,
-				void *cb_data UNUSED)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (details && *details)
-		error("%s", details);
-
-	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
-		    new_oid ? oid_to_hex(new_oid) : new_target,
-		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    ref_transaction_error_msg(err));
-
-	fwrite(sb.buf, sb.len, 1, stdout);
-	strbuf_release(&sb);
-}
-
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {

-- 
2.53.GIT

