Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF99205514
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149844; cv=none; b=sOVrYth2F31BYTkpkrvLCeZpJPGyAkxferFGUf/Mtky32f9zWsrdX73ZsEdBhsJERHRqc4aBgondyr1WYnrBvT2H44lM4BCt2Ia72HDJ335+p1EjGYNJ8mvzcgYBZt/rnEoRkvdajc57ZcEz/5ic16ZhYyES+WwHpV2vZCd92FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149844; c=relaxed/simple;
	bh=AZUPztYyQ4clpNBRu9KqyPcTramRjqVFiF2Wd//bXmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DDGtOeK9AhlKamH57lgrUkGlq6EZr1ST3LZITNWaCzCBccU4UUnxC8BQ18pIxecP7/IDRb24quMoUZivBg0ENGQMFwBTWtcBid1zt5LbkiUDBuPHCA8R08s5LSnsckVrqGYnNf815F/RhS8gvfTaPisOYvtaclBTdsbMEbJorDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGXERUhC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGXERUhC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso3157375a12.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149840; x=1740754640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfgBAo0vfxEZARFaZc98GyLRH69WKdvTWalJX1aK/78=;
        b=cGXERUhCyHn/9TXAQt89AZL/MpsyFqCcfAr8nSqjnrEgcgd9qaOBukOw+CLfmEO2zR
         PYQjov7P2gkktUDUaUO2V7hfxxNV2mCyeGY32Z0m2ysbxC2UbTG9SmaUDtqJqf36Udwe
         DzSABzoyR0uX4sN0dT5D0gc91hWNTtMDHRUgcg24nnOlBypP0h5/d4lg1rs5gVEbKmD9
         NpB872yNW6+9mb9p2MLTXXjnWnnfxOoO94wtB4Tuk7Elhw8wfLC4uF/tuzJfqfnUVJs7
         hY6604rZj24aSeitiVx3w4aK8H2q6bc0b/B6s3y3iPFU/tglGBB5P5vsT8QMYELtaqRM
         hhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149840; x=1740754640;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfgBAo0vfxEZARFaZc98GyLRH69WKdvTWalJX1aK/78=;
        b=bv/f9cRPU4TpfZYMmvuM5lOISncQFE008ThKuiFYOJT5eIpY9lu1Ur4uv7LEPiIA46
         kFcomJzJ+pINdlAI9Kng1MNK2i086QFP/quWQ9FFQcYtzdYHfDjreKrx426dZXpi9r1V
         5h3QFDtI6NJxA0xbqc2EFUXgqrwvqbFfJeEF+xIWJnS9L6r0ERWVgjFN2RxJUlb3D/So
         DOWXKjtJE+XbjGeVyD3Kf17soK7mQe0Tb0eZpJdQmpk+Pr4TjFnlU72bSQ8YpYqzCIEy
         vSukPvui2PVWoSxFbiFTLx70zW0m3p9c6Yw1hSyW7O3T61TsPE8gv046DNMG4u/2G4Td
         oXEA==
X-Gm-Message-State: AOJu0Yyvunwr7SLOBfecVq+6B2fbQqPPT+bcDRjEYFeQhXboGwxIb0nX
	d2ckXiyjWjdQXlgZu4ztiYUqww/HkFknSExya6YWAvylAOgvM9ywYNGIpg==
X-Gm-Gg: ASbGncvDy/hYhmMDMggj0vCU0RZVrO0cUDgzeKXqwtNFH0FxsrthG8ra0basSohkyZH
	SIXuP/f+2EYpCFcnuI6l66FBfKVW2AEwzx5q+c5opSdMOLu305apTe3c6cq45W9ftgaNmzDXggx
	bOUMYUtewyXEZG5gJj8Gnwy9T1hXoQ0i3eKEyvKL+JqtQuZ6HEVoV3/X8axTye4xtAdgddaN2rp
	/c5JzEeBRWznt7g9rQLCm1Rx/yccei0Kk03DwuPkfhlnMJm/fYm1mARUrvz19z1WYGBbJKAOeca
	c5ap0p6nM1rvLpPvVEgsk64HSA8=
X-Google-Smtp-Source: AGHT+IEE9MNTDhsdXWQMG9Js3cce1dvydBNg4TDt5gD/QrPDwcoVll7gE6a+54/Ka34ySPlOWqd/FQ==
X-Received: by 2002:a05:6402:1d4b:b0:5e0:36c0:7b00 with SMTP id 4fb4d7f45d1cf-5e0b7257b92mr3339024a12.31.1740149840197;
        Fri, 21 Feb 2025 06:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm13775842a12.12.2025.02.21.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:19 -0800 (PST)
Message-Id: <35ef0ee2b9925748ae3b6b6ac68e79c71782e5cf.1740149837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 14:57:17 +0000
Subject: [PATCH 2/2] add-patch: update hunk splitability after editing
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the users edits a hunk if they change deletion lines to context
lines or vice versa then the number of hunks that the edited hunk can be
split into may differ from the unedited hunk and so we need to update
hunk->splittable_into. In practice users are unlikely to hit this bug as
it is doubtful that a user who has edited a hunk will split it
afterwards.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                | 12 +++++++++++-
 t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f44f98275cc..982745373df 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1182,19 +1182,29 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
 {
 	struct hunk_header *header = &hunk->header;
 	size_t i;
+	char ch, marker = ' ';
 
+	hunk->splittable_into = 0;
 	header->old_count = header->new_count = 0;
 	for (i = hunk->start; i < hunk->end; ) {
-		switch(normalize_marker(&s->plain.buf[i])) {
+		ch = normalize_marker(&s->plain.buf[i]);
+		switch (ch) {
 		case '-':
 			header->old_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case '+':
 			header->new_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case ' ':
 			header->old_count++;
 			header->new_count++;
+			marker = ch;
 			break;
 		}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 760f3d0d30f..cb81bfe64c8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1240,4 +1240,25 @@ test_expect_success 'splitting previous hunk marks split hunks as undecided' '
 	test_cmp expect actual
 '
 
+test_expect_success 'splitting edited hunk' '
+	# Before the first hunk is edited it can be split into two
+	# hunks, after editing it can be split into three hunks.
+
+	write_script fake-editor.sh <<-\EOF &&
+	sed "s/^ c/-c/" "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+
+	test_write_lines a b c d e f g h i j k l m n>file &&
+	git add file &&
+	test_write_lines A b c d E f g h i j k l M n >file &&
+	(
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+		test_write_lines e K s j y n y q | git add -p file
+	) &&
+	git cat-file blob :file >actual &&
+	test_write_lines a b d e f g h i j k l M n >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
