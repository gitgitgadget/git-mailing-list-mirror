Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793443538;
	b=LyOTmzdeoUCeJATyDFc1Bx9FeSJsH2IkOwe+7ZagYJ1LaKqaTtfrBRlRNoyDLGmA3+mP
	 KYFWsVJss3VtSmbdaorqN0hCtAWs03SgoTRvTn50CEYrEMe7/lje3p+oxuNY6c/IKX/V1
	 sbaf/cwS/JRk5AZ3cCF75FpL0q3xl4GD3BipL0uLd29JhJ5h1kahNwdM/YE2EZ8QGRwt2
	 ecACQcJo4s0OhNBfJg0MrYvb9ilXJkoFq+PpXx3OtyKMDzrL2Xy3F095wGCJ39hlZ5dyX
	 g4uV6nkv3E35ybB/rpt4ol3i2UvaCBC777kCRKxAUi/xubfisVi3auOtAOW036yHIYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793443538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mRep0eAkSTDV6HB340hQFRMCJrZXm9K1DmqT1eT9lTo=;
	b=v2jdVzzfJuq/Dxt5JcByNn9UNRl88xeujylBrNsZcIY4bSk4DS+zKZGocdhhmxqmRp3I
	 ONqvuyB5haUzANKaD3jcKXLy9JuGDF1bac+VJN4GMOqzJwuPFjKIZWlJHXuLJ8znfQQ05
	 w+0R8E4PTPfF/WsmQExO2QLSpwiGJHC4W3yPvJgCpn9+xdTHk+rx8nHi+HVD6zWikqrD3
	 aClWOyEuw9TuGFDlYkw4Za2jLZSWqKIbDWUG+E4sRHCPyD11Qt6Hmu+wEuvKcIIInn7PA
	 xK7Rk5z2jWwtNg3qp6pAfeGsv7nlDEw587bOez1yR55+lQ/EZQcpCq870FME4sjedDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IOL/kY9M";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A49606A31C
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOL/kY9M
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so16795375e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793443536; x=1794048336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRep0eAkSTDV6HB340hQFRMCJrZXm9K1DmqT1eT9lTo=;
        b=IOL/kY9MlVYOqfIeDptbaV7JTm2APIZatxUhf06laEF62Gn2+icClrU1myEf2X8KUj
         mcpvFxcVVNXGoJWzEWmtAk5MtbsEGxgGlRRNWB/+dzGJQeIcmOwThd6ZJGTdt9WBvFc5
         GxHgFqh+yyXaIukBEHG2r8SG17EViZm/Gy5HSVO18GR/6NclqAVgS9V407JWungoc6te
         VxGa7Wj3YKKHSMsX9Agh7IPm/HirmejTiBwWqRRS1gH2QUnPOs9k+koKTqMKn47eUzP4
         EDUBozRLYWU+5kGz98l5NBOBdzeaOcWL5pPQxiJ4f06K1p2ov68U7owfoxmvzALbqMyX
         HGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793443536; x=1794048336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRep0eAkSTDV6HB340hQFRMCJrZXm9K1DmqT1eT9lTo=;
        b=Lcu0XxULGFArLTwwWhYy1tn8tzsTVNM+mhRJmDKhYxR3cRFlZTlytK+SaEW3HF24aJ
         ZSwZEybDIWiz3OIcdVkTOYoXSI8x1xp2Q92x4h4Oy5c7/a4AhmJZNpaycwjqPCEjcbwj
         jzBLQZTvabbQk3YPldoe27Zyfc6Z315WfmyotfXjFVaVoHOe/9v/4Rb9AdcMv2yYvUoQ
         5cCU0IFFuKUIGEQgBes8OecWBqbmBcopAvqdACvHTtv1kN4V2Khzi+YJ7gagEA8GmZhg
         O7ZywxAXIZPUCfkdnzcExzYuxFDqsjITqIVWhamgBWlhmC1Z0FsZIktmRH02VavLl/3V
         T9iA==
X-Gm-Message-State: AFq9FYJIVMGQ0ah6yjCK1O5f3gs5YlMPgVlFJwasqrPLMGbMHp660gPC
	26/RDs/tEA+peqna4EroL/Yyq9byim/zptp5YeusW/XCwAjydyyLPAUL8Fua/+QnYg4=
X-Gm-Gg: AYBFou39tpBTJiIE7VCHwmLpkQv4WaUCOwtpItge3xkqf7LbPt2BxIIMYG5rWIznB76
	VSd4WVwpXOAH96shTEH3N+hH1gk2xC0OKITG/pauKtqf4uxy6lh7yvPzEk8ahA+GUOtZTiR2VLO
	iTX90fiDaROjF3ubHQUXQT/MYTES9t9SGoJPdLZbTE4ZKQq4ipBEBt4Lq5dHt4ZSxUGP15r+E3c
	2ImAikjoVmpwHcQHhZZhEkUHGXYS9l4CUEQZKrlr+vy+qWjuImhFlBKbp5JHApA2pvZny4cSDtC
	IwuS9SxPNiwci6iESeeR3NEJLKg+Tcur4nJfYLd+Efkze2kLwYxWJaC3A8IRKaXWneeVVwQFZge
	YnD7OEAQZYgx5fQZ5sO0fXWQHgLAZeoMwedgVaFo2tjtiMon/vY01r9PMv6YewMviuUfLWhJTR4
	XfIWtY56SJ1JZGwv0pe/CFVYc345e18JunflZQsSt4fG48WbMdH8bNQmE7ORyHvH9pGdg/eLq8Q
	LgbjoZKW1rECIBGREimq9DwIsCwUlYdg0OpSoJJRQVZlA1I72bDohNv/sUK2bNpgMaxoTNSg0At
	EV/opgeRMUCohE6OmrECkzcre130CoBRQVX4YZh4c7I5/4yfzNWSnN7UpRiwR9yZvnYGjKuMJCd
	Dgp0pFPqzr0Wm+jw63SPm20H/HyHA4icIa1Lk2aAyOvqX0IjJX8CnCtFzNDxoGZEwCL8QICedSV
	qTghqim1m2sABEkmp5OD2RNIN5jb1+
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr104010535e9.9.1793443535713;
        Sat, 31 Oct 2026 03:45:35 -0700 (PDT)
Received: from localhost.localdomain ([105.113.81.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm110388405e9.0.2026.10.31.03.45.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 03:45:35 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] notes-utils: use the passed repository for notes refs
Date: Sat, 31 Oct 2026 11:45:26 +0100
Message-ID: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_notes_commit() and commit_notes() receive a repository,
but read and update the notes ref in the_repository.

Use the repository they are given.

Keep USE_THE_REPOSITORY_VARIABLE because
init_copy_notes_for_rewrite() still uses the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..d4606bc576 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -26,7 +26,7 @@ void create_notes_commit(struct repository *r,
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
-		if (!refs_read_ref(get_main_ref_store(the_repository), t->ref, &parent_oid)) {
+		if (!refs_read_ref(get_main_ref_store(r), t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(r, &parent_oid);
 			if (repo_parse_commit(r, parent))
 				die("Failed to find/parse commit %s", t->ref);
@@ -61,7 +61,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 
 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
-	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
+	refs_update_ref(get_main_ref_store(r), buf.buf,
 			t->update_ref, &commit_oid, NULL, 0,
 			UPDATE_REFS_DIE_ON_ERR);
 

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.56.0

