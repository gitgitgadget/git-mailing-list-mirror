Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8FA47
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916080; cv=none; b=mPkqXTZjU3yyLMHIcBVN9RAVG0W0s5GY/FUQR4t2OAisWUx5sLdjqgRbXFvjqsZzQCAQixYjW+ye7cB+9NWaJleo+VzYlhyGM88qvb9wLKenCkY1VepkqqrVMdUpcKmpZf3NDM31x7x3Pb4cAZ4Bn/huCTTGecQU8/WJ5EJy12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916080; c=relaxed/simple;
	bh=q6tfA2XARsnB7cwFhN7Tiqfq+jt6Z+lzYmhbJ6vkDeA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EQ1F+bvKP0hMZWp4ozWyplIRTnHtZYQg39tRInVnVigCPrL+RtRPRHUAfvx+vQvXk8deozTqFlnkgJBVdZky0ACbTFJIrL/aJlkklJ9R8n4+9FE0e26J19YHctn8KAEatqzDtcwkIWpG/1oN2RTR9fBIJjprnnqRGDsTpnu3OsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeyDgCi7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeyDgCi7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a363d15c64so3525119f8f.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748916076; x=1749520876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx0pD4GeVqbt6efLY/va/G5R5VdTBE/lC9jFwsi5tCo=;
        b=OeyDgCi7m7Dur8nf7PxG8GAYdtRph/cu20mWP44EEd8f4YpXotR/jtwIczW8WSH3/Y
         SqWedsdM7Xkm88nB9VRCcNVfpmewQk6e/Q5s/nwgkD7z53gVCIyLZU6DRFdmwO8Qu0fa
         oB3MagyAVtPciqRPwvxq2hFy8F+XrOIgfyjwpmPp+ENllHf60Lf0GfK/VInNQNZ/p+r1
         4BuIMnndyCxmWC7SwGZmTGS5Fqb06GCu4pjaVBgKihj07T75kOxEe8C9CTkzJhYMmCRl
         7jMT1+Q1Up0PefakZQCz1qvyJZOcw4TTlfkUL+Ia8bZpxEGIpy8axZm/v1VeokSPkjTO
         Tb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916076; x=1749520876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx0pD4GeVqbt6efLY/va/G5R5VdTBE/lC9jFwsi5tCo=;
        b=lXC5NGsPtPhnO0NCjRT2F3+FS/8377fjHGl8eZyDprhTtLD0V/oDnEPOrE1MtpnHJy
         QoZL8irpV6JYw/T8ump7wDkEdXGo02sK2lbBCHkjL4wGnOYHEYgYng7bt6p5pmwXxUhS
         +mWD2eumwcg/IaP7LBVXjQWw/bgTVr6iFNf7RbqfvJmqKU5tu34I29q6fCmB41nZOVGi
         s4cJ6SOLE6ZDOjrXhRgWD9Yt/jmGqu8qbxqYUPbFO8QSu7lhTstsDZEGeyHKtru6Kz6F
         vv+JcR6Cwv8iRGaZi25xXwNydM6gBO+IeJfgMoTIyphmOF8xhJkqCvtO2jx0GygAc4oo
         GFhQ==
X-Gm-Message-State: AOJu0Yw5aVCqE+y6fQtziFRRLS8zsh/OpmU443KOGVBZ/rosgQybr+w0
	d5/IJcN/JBP/401c10AEr0kol1WmJSG+KyQAMrmYiT2RoqtcZlnGvyqZF6l/4Q==
X-Gm-Gg: ASbGncvHR0da/wTWu2jS/mxh7F7Jw92oiBrxeAB+dXb3Y1n+HO13iIEiIWF7O8CNMG6
	M3rDSh+pMNUawS2RzQqGpQMc5S4GNfE8nZjHrUzcwGmgnS5eJ95/ddwwuJkNB1han+f6zK44V8x
	c4reYy6Slz81UiF18LSMHquCNK0/vOFclmb9V2oq3SEu5y2L9GfD1MtMyhvdn7ybsSa1lCXFM2i
	I1FXdKd2thXujsIEbQ1YWJNkk3bobX8kFK/TstbcIkTjrhp8u0aMoPLy201j61cIUngntJoTHwh
	hRL/z1R8x5gszmqIJVB+h5hvOg4dpzkoRtDRxV0b5Bfz/z1A6BZMuEgaZQlIxTI=
X-Google-Smtp-Source: AGHT+IHMyTkUWQZ+YYI0IKsT9GW/3VTsvXPxB6UAyZ2s90ewpuSq/dXK4Ha7ZNKC0BlALuoYebRZbA==
X-Received: by 2002:a05:6000:2485:b0:3a4:c614:4c1f with SMTP id ffacd0b85a97d-3a4f7a0254emr11326621f8f.3.1748916076230;
        Mon, 02 Jun 2025 19:01:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e505d454sm6090535e9.0.2025.06.02.19.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 19:01:15 -0700 (PDT)
Message-Id: <f2d2cfd6a876daa6019cd82aa6bf1309f29fea83.1748916074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
	<pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 02:01:13 +0000
Subject: [PATCH v4 1/2] sequencer: replace error() with BUG() in
 update_squash_messages()
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
update_squash_messages(), any other command passed in should be
considered as BUG. Replace `return error('unknown command')`
with `BUG('not a FIXUP or SQUASH')`.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ee0abbd4514..9456ca6ee97d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2067,6 +2067,9 @@ static int update_squash_messages(struct repository *r,
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
+	if (!is_fixup(command))
+		BUG("not a FIXUP or SQUASH %d", command);
+
 	if (ctx->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
 		char *eol;
@@ -2134,8 +2137,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
-	} else
-		return error(_("unknown command: %d"), command);
+	}
 	repo_unuse_commit_buffer(r, commit, message);
 
 	if (!res)
-- 
gitgitgadget

