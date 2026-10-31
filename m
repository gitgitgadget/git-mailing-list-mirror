Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793476946;
	b=Gw0pW9o5M0g+pbCv1Q2FdDtY7BNmcjvc4XuNCdVuEzZk5xDLg4qYg8y5NITB5CaCgQ19
	 KsfFBirGcRaED84ExYRKppoLmXpDq+gSLyAd9LB4NwQLKGOllTT4nW5+lMplhmESg6N7Z
	 336a/ELgbKiOYe5zsFV7wieXQuYnIxGJr5YAguga7GurARZGnEP9N96rnebnYaxD23+J5
	 ywiBhNDAhMi79S8z7AP+OvJ0C1XZBMAACV9UAufODPClpUoFK/hV3J5LaY8xbZxG9AFpF
	 Y1ZLV1yMUvQJaqS+NlrTqGqSCcJgtUlNUtHSrapBxZkxGIxkgU4CMfKMwlwkgobUUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793476946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tnMZfpCsZsBk7Kome3B8VgOBYBol4CEfBMMwiNMpzB0=;
	b=RaIh8Y+VyGMKPxSLQc+RMfvPbbGLBKwKPtg5ROyTHiyPJ9SnhCsAEpXtO8JA3Mqoy5Rr
	 23OS6GZ36iwH+TT2sH/4ytCJylZU5ur7UGb3ymjhPSaODuxtfoS1vSdi7q9BFfZg8jXN2
	 GzOldPgWvq0RyC0rAn6a/eviNrACdj5E6Ibw0II7xm2r7jVXJpMbU0wkV1gQ1BF7+fHBZ
	 W5iaL589xyytfUsFRa/uU9gR2A7cTXBaYgTNLeM1epKCopND8qaVrELzDSFHutVYP87eU
	 HE7r9xNJLg01Ecz8WkzkBsBbDVeGtt7xpLbJnfap0bCpCUEfDq/hNxs6wrEv4U176sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaReFleZ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3167606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 20:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3167606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaReFleZ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so2183748c88.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793476945; x=1794081745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnMZfpCsZsBk7Kome3B8VgOBYBol4CEfBMMwiNMpzB0=;
        b=SaReFleZrMO2B6Xd0670G/Onx8YEo74FuTRaXNVQYslTXrunsQd11EZcL6witOmy4m
         hcT/qQuqWk01GdGngBZFuVSPhuJ1bjWjuQciwQA80pRIQ6NF4XmQatBtqT2eVbNv72Ki
         t5StY3itB2rWoxcW3Obe5ti2Po+4WSFAxRVE/NbWOyZpKyR/3pOCcYG0dvWftsDN3uLn
         gMPU6vAqUHSxji7vWnSR2y7hFFkS1W8T5Ds7QBH4Lg0OBvcrwWimOi3nx6vEl4WDt+ct
         m5laD1X3UMxjr9KuCC1WZLIjElHGXaNWlqO7QbYCv0+Kg9W02epwkElXntRnGEueAv+e
         6ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793476945; x=1794081745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnMZfpCsZsBk7Kome3B8VgOBYBol4CEfBMMwiNMpzB0=;
        b=SCgGixFKvIt+8V1jLRfWFAUwQ+S1V1mBOiAHFqm+03vJQcSlE+bIpZpLwz+aaLRIoM
         9jkjdnEk79rC+y1boxSqwxsgXfUjqPvUs0GhpiyRsByj8AZGmtbEz9GtX5i8rRR7vuEB
         dGCyMdFSflBbxwvPE1XpNtfJjtFTOcmjqELFtPsxdo6zr8EJW+JtaZQEIKVdrQ5Hhf9B
         g1akrJFpXIjTPxFx4FKKaFjDHwvRPwWHcSDXCVxOPWNBvghUAGH9bTBfewINeN/F7ybt
         5EqcdtgcSGwtywxaCongTWz+GQVV3pShbjarhR8pHZkzhESb7bdxHcQjlNgaEizOyuz9
         +hLw==
X-Gm-Message-State: AFq9FYLWS/MXXTl4y/gPAoYIAF+J6VkBOim4wD9ZrYHCgx3IYl3zhXMT
	xSIatZE0Q1GVEwgmrYxU8q/bSF71sPKPEXU3T2OYA7RcnT0UvuPV0QINTnwwlZT/WCA=
X-Gm-Gg: AYBFou2DpDu7r6A5sCECFukYgarX6ESR4EQES5cojLNJ43HxWr2l/MPXh+hVqEzqSkL
	p1JEFYpbFabe7UlgsZRR3vUlv0S79u44kijllfAEuDYaLvF6UUY28eM3GtHU91ZYh3LGe6bpNQh
	CIangMDg+iVG/ZotI5Pwa2CU/rayp3sToiw9oYOn60+OXuiYaIfLAC4aDxhQWqeBYjKCxTWLNxk
	X991cIlqjon3BBNXpVk7fVZ07R7aDxCa0tzP0XsVYdBt82zpDJ+BqPFElrAYX7eqHeKlaS/ISng
	6WY+BAzX7Ic2txhUHqUEQUc6xxW5wyHx8ldaZ8H4YQuljdb2dOSEYwklMBk9Uh5IXp6reoMdgdX
	cqX98jd6Qh94wL3k9Ok60DeG7wGW2TTe7VPW/s4cvjUc8yvu+gH4WcQEszriO7zx9P7knmlFlDa
	OVIs+oFNywvZVzRVZoiuc0GDFHkuk9lHlgy5QwcQRtJ3F81LD+QxfZiGoka79SsDmaJ/qP0habd
	Vu6o7FRefpjBAAkSEr/BO2mJP9GG37y2+/3/5LwMTLOMZub940QG0Xt59b9iG7sO6NGutGK7ZIs
	UHb407kkRmm9ylJUFIGitcUbcFf04QSJHt6WlKCQTfy7wbuQQRMFzFAvp6WR3oItoiSD0UphNkQ
	=
X-Received: by 2002:a05:701b:4589:b0:190:f24b:9491 with SMTP id a92af1059eb24-1ac59fbfa7cmr8370136c88.12.1793476944542;
        Sat, 31 Oct 2026 13:02:24 -0700 (PDT)
Received: from overlord.home.arpa (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm12956831c88.12.2026.10.31.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:02:23 -0700 (PDT)
From: jasmeet.bhatia.us@gmail.com
To: git@vger.kernel.org
Cc: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Sergey Organov <sorganov@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Leon Michalak <leonmichalak6@gmail.com>
Subject: [PATCH] stash: reuse prepared state when creating stash
Date: Sat, 31 Oct 2026 13:01:07 -0700
Message-ID: <20261031200107.285168-1-jasmeet.bhatia.us@gmail.com>
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

From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>

do_push_stash() already preloads and refreshes the index and calls
check_changes() before invoking do_create_stash(). However, Git then
repeats this same index preparation and change detection, including
rebuilding the list of untracked files when requested, which is
duplicate work.

Instead, avoid this duplicate work by passing the already prepared
untracked file list to do_create_stash(). When the list is provided,
reuse it and skip the redundant index preload, refresh, and
check_changes() call.

This maintains the existing behavior of "git stash create", which
invokes do_create_stash() without prepared state and thus continues
to perform its own index preparation and change detection.

Testing this using the p3904 stash performance tests shows a decent
performance boost.

    stash -p, no fsmonitor
    0.12(0.11+0.17) -> 0.10(0.10+0.18)  -16.7%

    stash -p, builtin fsmonitor
    0.11(0.10+0.02) -> 0.09(0.08+0.01)  -18.2%

Testing this on the Linux kernel on my system, "git stash push"
improved from 254 ms to about 239 ms, which is about 6%.

Signed-off-by: Jasmeet (Jazz) Bhatia <jasmeet.bhatia.us@gmail.com>
---
 builtin/stash.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index e1a3a76bd0..58eb782597 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1459,7 +1459,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			   int include_untracked, int patch_mode,
 			   struct interactive_options *interactive_opts,
 			   int only_staged, struct stash_info *info, struct strbuf *patch,
-			   int quiet)
+			   int quiet, struct strbuf *prepared_untracked_files)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1473,14 +1473,17 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
+	struct strbuf *untracked_files_p = prepared_untracked_files ? prepared_untracked_files : &untracked_files;
 
 	prepare_fallback_ident("git stash", "git@stash");
 
-	repo_read_index_preload(the_repository, NULL, 0);
-	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
-					 NULL, NULL, NULL) < 0) {
-		ret = error(_("could not write index"));
-		goto done;
+	if (!prepared_untracked_files) {
+		repo_read_index_preload(the_repository, NULL, 0);
+		if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
+						 NULL, NULL, NULL) < 0) {
+			ret = error(_("could not write index"));
+			goto done;
+		}
 	}
 
 	if (repo_get_oid(the_repository, "HEAD", &info->b_commit)) {
@@ -1493,7 +1496,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked, &untracked_files)) {
+	if (!prepared_untracked_files &&
+	    !check_changes(ps, include_untracked, untracked_files_p)) {
 		ret = 1;
 		goto done;
 	}
@@ -1529,7 +1533,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	parents = NULL;
 
 	if (include_untracked) {
-		if (save_untracked_files(info, &msg, &untracked_files)) {
+		if (save_untracked_files(info, &msg, untracked_files_p)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
 						     "the untracked files"));
@@ -1615,7 +1619,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 		return 0;
 
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
-			      NULL, 0);
+			      NULL, 0, NULL);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
@@ -1698,7 +1702,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
 	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    interactive_opts, only_staged, &info, &patch, quiet)) {
+			    interactive_opts, only_staged, &info, &patch, quiet,
+			    &untracked_files)) {
 		ret = -1;
 		goto done;
 	}
-- 
2.56.0

