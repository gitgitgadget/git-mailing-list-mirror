Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926225570
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400290; cv=none; b=GEwdpa1mQbnh3Y+9FhEfmEqj1Chrc/r5WWAqaSfZb09cWO/nwQCL7LkVktz7SWuUvAJIjjvOxx0p4m+DQcLpavxtsurAAykNP6o4rn/k6H6vNAalUBev0Sblye/bHaeKx0RfigWLe6AjY822vlSYQAr+TzOXGi5YGIkODBb/JgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400290; c=relaxed/simple;
	bh=8Orh8tHAN4r5fJx0M+klvaKDwkGYQgCLU2IVjDNHwjo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ezV0W6q/YX8h5Qvdj4b2X5jxo70oF2zhzm3aOwc6VOPZdt9/8obKrWoQf8ig+jpjvRbA4Z7tR4taN2vhCfBEUmpCNbENAAxNX2aqUKwWSG3c/tLYBvsvkJGBXJLeRLBpchPLyBt4H2tG/pLn+d59YmjM+nDBwlDtZTif+WVypHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5hf8i0E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5hf8i0E"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae102702so19118395e9.0
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400287; x=1727005087; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea828ll0qGcYWVMWvM0HRdMucXIi3SWfdfCGLXJ7V9s=;
        b=O5hf8i0EaXC7pfNFTmTDcfNYV9sSG0pO3rlPguChNhMKXb16j4K9POJaSXHfd1ZBxM
         QvKQc9ab0KxE8UqPBzZKvj5RDP7LMfTWpkHAjTF490aJMrLcM9842bQzuxJYHzgVvtCM
         tjKRttBtbhdi+YV350Lfi9SnEZ2zinl75a0DsjAmNMaigX2eTD/7yQBNlyx8i9Kcn3IT
         QYpFrLsIeYIkl2lZFTOfr2rW6CVqn2PeMv6f5e0Nd94fgCAVc5sy/u4sXoSqeHl+yIfd
         ci9GdwkRYpf6oylG+tmGNCphXbHBIFvumtfNWXiOiDneau2xh5aULjCnJYwoKs31KbxJ
         FOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400287; x=1727005087;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ea828ll0qGcYWVMWvM0HRdMucXIi3SWfdfCGLXJ7V9s=;
        b=PDNJfA6aZ/Xe+mT/j6gOZLJoPaqpaQEa05TnMdoErUqwwP0+00jKsCiDiSwAKsp5H6
         Q1N2/CsH3XVJrOztwoi76+5A5JlUxwJCe2ll0oyZcOfnIocZSMViSc/Vl2E7SUrJib+S
         DbGNr7SkohLqkeak4MQaYZEXdDR6drmmAbkmcw1F9Y54z7zs1OEDhxT0EeYzsMcjvOGy
         HaaNAtcAxCUAaDLcFIMVKtzeQZ+2dfDj+5ifgykYsqwv8kmv3kr89ANLWonwiD7qOBG2
         ZavNOnJ+iLx35aTx2KGSzhQvJsPyGKprIGs6yHrqQMoyFW0ifS1yx11cyzM1bGDqyRoF
         WtcQ==
X-Gm-Message-State: AOJu0Yx3SUgQeyUg6pdwlPZFI99St5bPAfzsi/r4jS7pOmB+8DmRkEl7
	VMzdmH4JY2sPtK5boYFemk0tJxy/YHIrhWHjSVAJs/TcB4uVf2kf+ApKeg==
X-Google-Smtp-Source: AGHT+IE05N5RGkjDIHTPpFDXkBLI6fLPUGgQqOz5vuMsuLXSU/5GmsmSeRe9Ssegz+8IevlDFZA4lA==
X-Received: by 2002:a05:600c:354b:b0:428:36e:be59 with SMTP id 5b1f17b1804b1-42d9081bb39mr48167795e9.11.1726400286838;
        Sun, 15 Sep 2024 04:38:06 -0700 (PDT)
Received: from gmail.com (139.red-88-14-201.dynamicip.rima-tde.net. [88.14.201.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22d8f8asm46634325e9.19.2024.09.15.04.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 04:38:06 -0700 (PDT)
Message-ID: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
Date: Sun, 15 Sep 2024 13:38:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] add-patch: edit the hunk again
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "edit" option allows the user to directly modify the hunk to be
applied.

If the modified hunk returned is not an applicable patch, we give the
opportunity to try again.

For this new attempt we provide, again, the original hunk;  the user
has to repeat the modification from scratch.

Instead, let's give them the faulty modified patch back, so they can
identify and fix the problem.

If they really want to start over with a fresh patch they still can
say 'no' to cancel the "edit" and start anew [*].

    * In the old script-based version of "add -p", this "no" meant
      discarding the current hunk and moving on to the next one.

      This changed, presumably unintentionally, during the conversion
      to C in bcdd297b78 (built-in add -p: implement hunk editing,
      2019-12-13).

      Now makes perfect sense not to move to the next hunk when the
      user requests to discard their edits.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

The message "saying 'no' discards!" comes from ac083c47ea
(git-add--interactive: manual hunk editing mode, 2008-07-03).

I think it was referring to discarding user modifications, not the
current hunk; which is what we were doing then (and now regaining).

However, we stopped behaving that way in 2b8ea7f3c7 (add -p:
calculate offset delta for edited patches, 2018-03-05), perhaps for
some reason I'm missing.

Therefore, this patch also modifies what we did, possibly
unintentionally, in 2b8ea7f3c7.

Thanks.


 add-patch.c                | 26 ++++++++++++++++----------
 t/t3701-add-interactive.sh | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 557903310d..125e79a5ae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1111,7 +1111,8 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 	hunk->colored_end = s->colored.len;
 }
 
-static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
+static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk,
+			      size_t plain_len, size_t colored_len)
 {
 	size_t i;
 
@@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				      "addp-hunk-edit.diff", NULL) < 0)
 		return -1;
 
+	/* Drop possible previous edits */
+	strbuf_setlen(&s->plain, plain_len);
+	strbuf_setlen(&s->colored, colored_len);
+
 	/* strip out commented lines */
 	hunk->start = s->plain.len;
 	for (i = 0; i < s->buf.len; ) {
@@ -1257,15 +1262,14 @@ static int edit_hunk_loop(struct add_p_state *s,
 	backup = *hunk;
 
 	for (;;) {
-		int res = edit_hunk_manually(s, hunk);
+		int res = edit_hunk_manually(s, hunk, plain_len, colored_len);
 		if (res == 0) {
 			/* abandoned */
-			*hunk = backup;
-			return -1;
+			break;
 		}
 
 		if (res > 0) {
-			hunk->delta +=
+			hunk->delta = backup.delta +
 				recount_edited_hunk(s, hunk,
 						    backup.header.old_count,
 						    backup.header.new_count);
@@ -1273,10 +1277,6 @@ static int edit_hunk_loop(struct add_p_state *s,
 				return 0;
 		}
 
-		/* Drop edits (they were appended to s->plain) */
-		strbuf_setlen(&s->plain, plain_len);
-		strbuf_setlen(&s->colored, colored_len);
-		*hunk = backup;
 
 		/*
 		 * TRANSLATORS: do not translate [y/n]
@@ -1289,8 +1289,14 @@ static int edit_hunk_loop(struct add_p_state *s,
 					"Edit again (saying \"no\" discards!) "
 					"[y/n]? "));
 		if (res < 1)
-			return -1;
+			break;
 	}
+
+	/* Drop a possible edit */
+	strbuf_setlen(&s->plain, plain_len);
+	strbuf_setlen(&s->colored, colored_len);
+	*hunk = backup;
+	return -1;
 }
 
 static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 718438ffc7..6af5636221 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -165,6 +165,20 @@ test_expect_success 'dummy edit works' '
 	diff_cmp expected diff
 '
 
+test_expect_success 'setup re-edit editor' '
+	write_script "fake_editor.sh" <<-\EOF &&
+	grep been-here "$1" && echo found >output
+	echo been-here > "$1"
+	EOF
+	test_set_editor "$(pwd)/fake_editor.sh"
+'
+
+test_expect_success 'editing again works' '
+	git reset &&
+	test_write_lines e y | GIT_TRACE=1 git add -p &&
+	grep found output
+'
+
 test_expect_success 'setup patch' '
 	cat >patch <<-\EOF
 	@@ -1,1 +1,4 @@
-- 
2.46.1.507.gbcf32d0979
