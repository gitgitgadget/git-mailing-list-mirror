Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2F241686
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567901; cv=none; b=Itum4yZWCvP1+gZgvf0/nPvb2BcX/WROzUYqTHxcDhUQfSJYf0ksc7DsgV1dAnnAsmagq4xd5B47oFemCajW83rh0ty+UDmZcjGmVzhedSZ6bWccvlbCBeoPCUdoOKzrlXcYzfEo0OC6ozPgqRHi0DkixYC5jJBdt4vKMVCoSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567901; c=relaxed/simple;
	bh=5DWbVhqstlhz+qH7ZJgKeTdVWwrYDCNh3Igu5Rr8aSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INF+js8WN6a7D9s03sGrBBcq62bW9pbCUOXLZmyRq1iktdQszvsB7yG0kWzJvf3JSVnE2IcdJG2CKeaCSV0FnDhXYnlD1jwdjiopE5ZFvWFO4JSd55P5cGLwPbmOXytbO7h9x8gaFD/0/QxokYhpR4jx9iruCXOmBfaMDfboUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQpssJhO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQpssJhO"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b95e21ccaso70050a91.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773567899; x=1774172699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP4RMNlqMnNL+kSdod4jRZFnTYtKufMdw3CRDgt7mP4=;
        b=lQpssJhOHmPBgKj3K+OpasqwoecRdHbg+zgLkvYwd/Xx9OjsMAEIN7SEL9nuwA2NA1
         qS41FtM5MDibgPUbr351/d1ysC6aZveO1iTG/lvkRSe9d6woZCnj35+LypxrfWGfDvvY
         C6d9mFBsgMO70MNUS/hyLB67Arku6YP+tL1FmiN0IaZpiAMFDa5MHwXk79CMl4gCy8mO
         BFtHAeiaeH7PbJR7PI7lZSiP5Mu8eVdAuHt1/1xD32VnljOJP9FafkCUEtnU0USDNC6f
         5MBPiH6cYzYEJbCwQj60RaBgzFfax+7i9/E+tagOfqLkNvoZFosRBId+Bgu/lACYWn73
         iDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773567899; x=1774172699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SP4RMNlqMnNL+kSdod4jRZFnTYtKufMdw3CRDgt7mP4=;
        b=J2QejJ++gODXTv+Y7fi5EG54PorgGFk3DLRr5XYRAPevW5Fx/l+o3qOirM7qdFNIj6
         NSLEuz5LvJtrFf46A6NDQ2c46vSd8pIFg48RdvQ0zejR9du6+uWZgGXjUuHUDrgNqs8G
         XWqEoYx31GEgki9Nc9D1OJo6UZzKjV4fOpxZtH5OtZhg3ONQWYyOuSGAD66lRsaEJ24P
         VCaNzmTvZQITG7B8sMzw/GMChE5Ab4rpr6YyNxf9674VkIsdb8VE1GUPJlEKco4uz8U3
         +NshKqPJfpGqdcxwi3OL0lXsp8qS8CCjqoLGyQpr9Lx/f5B5R3NQqmj3S5FOssgSy/H/
         ly6w==
X-Gm-Message-State: AOJu0YziA/s4zn87Iwy2ZQ4soravuhmAEZtOqM1knYXfby0ztGbAhRd7
	xvdMBEHeqBfQROJLRFJtyKiTAt7MuUT/X2m2aRu15sW31PCxarG2S6pYlwKM2Q==
X-Gm-Gg: ATEYQzyaeox8e1XjMQSzJUgln4CvzdfwHCtT4cJ0f90Xg/hl87syIC4OoTbyC7PgPD1
	mP5bdWUXvxMsgbpz3Zl7Ik9+gHb3zYmQCY+7QZx8CCpd51av7435pcn91aJ7Gy0mBc4exJuqlMI
	2mIO8Gt6bCntslLqxCPh7U8LW0LBEMVdIPWrkqV2JW+3Uh1CybrsN5T4rkcLmizhDCOccxWSJ2C
	gphIuP2VoGJ19SQpn4z6Q4Zw4otubLyt87qzHS6ynV3mbsYEM/VlA5EMz+R2knNJVDiyAhZkjNx
	kXdDwaYMH6hJn6NoAqju6WHr5PeYKIn9wQpgRDs/koFmoW7OB/YPA79tw2E5fG2encbQ92vPakZ
	3UW6Ts5yN1hzm+0ggeCbNHjU2Z8+NyTxIYZJphEZSUkb+Lr2+dfPEr6epBVjNeSL5MhAcXWF+7z
	FwS4ke/Iaf+AkAmvvJWICS0y3JfGv+bwtuPnzoXS5iinfctk4=
X-Received: by 2002:a17:90b:4b47:b0:359:ff9f:9164 with SMTP id 98e67ed59e1d1-35a21e39c75mr8218362a91.2.1773567898978;
        Sun, 15 Mar 2026 02:44:58 -0700 (PDT)
Received: from d ([106.207.231.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a229e7f9asm3413596a91.0.2026.03.15.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 02:44:58 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 2/2] stash: do not pass strbuf by value
Date: Sun, 15 Mar 2026 09:44:44 +0000
Message-ID: <20260315094445.19849-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260315094445.19849-1-deveshigurgaon@gmail.com>
References: <20260315094445.19849-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

save_untracked_files() takes its 'files' parameter as struct strbuf
by value.  Passing a strbuf by value copies the struct but shares
the underlying buffer between caller and callee, risking a dangling
pointer and double-free if the callee reallocates.

The function needs both the buffer and its length for
pipe_command(), so a plain const char * is not sufficient here.
Switch the parameter to struct strbuf * and update the caller to
pass a pointer.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 builtin/stash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index e79d612e57..472eebd6ed 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1232,7 +1232,7 @@ static int check_changes(const struct pathspec *ps, int include_untracked,
 }
 
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
-				struct strbuf files)
+				struct strbuf *files)
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
@@ -1246,7 +1246,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 			 stash_index_path.buf);
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
-	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
+	if (pipe_command(&cp_upd_index, files->buf, files->len, NULL, 0,
 			 NULL, 0)) {
 		ret = -1;
 		goto done;
@@ -1499,7 +1499,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	parents = NULL;
 
 	if (include_untracked) {
-		if (save_untracked_files(info, &msg, untracked_files)) {
+		if (save_untracked_files(info, &msg, &untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
 						     "the untracked files"));
-- 
2.52.0.230.gd8af7cadaa

