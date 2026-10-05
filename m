Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C54CE68B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218155; cv=none; b=DFgxChjh/vwv9Kc3ZcHnFj0uS84IIheJ1PwF0vD74z+Q//JLlrIOiG2aUXlYNFwuzEKEchRz2pMEmITCWTtfAeXcAE8UYKmULf1BPLy6ia6SmwVetz8bh6hnBQJW7r+SdTZdLMX8D6k5dAoDyn9liUeYL14J8d7pPBaWMZdyxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218155; c=relaxed/simple;
	bh=Z+hlTAmNTwqLh5B1Bxc/GcnlGticXHvXPKx4HMiE7Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caMctkWkZXlaZTmm1fzN5VrcS0z+a2w+hh4opl11zbxy8FgpKC+TqdKiFs6p702dqSAq0fF39jV+Q8lSRhYsZ7hTZoUTop2QKG2cBfFzoEy/WjEFWQ48IXTjgVFkC59voBjdBV3OwebQe0Pmdxc2Y45IGDxI58hB5gQgfgyDHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCaT3qqU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCaT3qqU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso10580695e9.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218149; x=1791822949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FbJu7eIM6ZYxXaIx+0HufFFBDTJMVwJdzsmn6+5IcoQ=;
        b=nCaT3qqUcNU0VNUXDqRFXjUjljqEVWVzgCLRerwdPDXYAkUFpEWonshElmv8iwZeBe
         df0m7ADFdlYLhgyDP2Dobg/Ca9MvQeCNw3l07ejR4t5KiI1k360vVJQwzY1yImJD8kxT
         vO6mKuRvJTKmWzJuByi41cNEkniIn0yvaW335L6ShGVOq+F82cA6dRodvnaWGT0N8vN/
         CGbQTMfUTMpzdvYhZ0XYLoClrZ6rv4SFBIazoIA/Wy5x2+vSMDTM9yvRfoOV5j9QaEIR
         F4440gW1bSMgvAKqwAiYIE7SNtuuF3EXLpKXsuaRDrZ+x3fde5luuu+GiBd/tgH8KxxQ
         x8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218149; x=1791822949;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FbJu7eIM6ZYxXaIx+0HufFFBDTJMVwJdzsmn6+5IcoQ=;
        b=uMFiglqBu0k3s8VYiySNYpO6mh9zwgaDYJqvlhvBTYbeA6GpCwitIy7mX5KJmHNPLJ
         I8mg9WS9IxPrnTu1RWtwsj+CrhbqAbrE8/PFE7cdzoz87VPPYWRtRl2HPpWg2rvVq3zq
         WNrm8kQKqMEQWs6ZYpxm3uvVKxLgeBf34Zg25eBO9ig6R0vuiphKkinxonVZEp80p+3Q
         lTWwJPPbT3d/N+MYkj7gQogYowz99K+UIhECNpt+QdFwlxomarHMtDjYHd6nzJpnTRaq
         FbIHVrdf4wCzcKM2SnC+nLTyfmwUoNQrlPBfms4noIuaShy072dhbPYEbG30syIpDUqB
         We5g==
X-Gm-Message-State: AFuF++nqs5DdRE3u5FUBhDayCkJ4sj8QFIOjwgqrvGM6n0Pv7Js9w7Tf
	D1IxLIyf9E2ekSuLDeW6HMpwsK+GmWrKpd78whiOF85VQ9vv7FE4hDJwQ2dzbuAQ
X-Gm-Gg: AYBFou0o8GHWR8YpBRqVBkeeC3bZR7nNmz7Ghfvf7O6it+NO/Vqm7gBC5spH3u86uy4
	Z6eD96gbAvVTBCI+IYQ1i+j7HwR5r1uSFeGpsKw9mvHxBwCGl0LWkLRaJVhu/hoeAQG2KlrpL/l
	wj8bUUJLgjyE7h8uit1T57JsTQIZiTU77l6GloNtNS0/cNiSPuIJxvBlULsahwIXT25ay83bAx0
	KKD5ZCki0oRgblJRGwyBJLmfNuLdEvVsJSq8cjf2K0agTC1PsOR+wYg1seWzvEANPSTUp2coHub
	LZUt3abSW1lcs7QCdWMMzqzsGrofeiiIXUYow5w1BmhWeICYjzA25SK1tiG8BLImvf2wouwgiwB
	rK8pMCrecD7yYttURY9U2ahILZguZ+tfQvg0s0cvRyRUS1CCMq15QubLqu9izv6nFoTqp5l1I/+
	Z0MoYNowKi6c+dDi9Fy66n/700AoFQptos9hOmqBoSk+L0BBa1T0R2/GXLfRBVK+hymEupjYMyR
	fb/0ENcFX2P
X-Received: by 2002:a05:600c:8b78:b0:4a1:74a1:7ecc with SMTP id 5b1f17b1804b1-4a174a181f9mr36343685e9.1.1791218148772;
        Mon, 05 Oct 2026 09:35:48 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6229e025sm4540545f8f.31.2026.10.05.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:35:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] stash push: remove duplicate changes detection
Date: Mon,  5 Oct 2026 17:35:31 +0100
Message-ID: <95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. "git stash push" checks for changes twice, once in do_push_stash()
and then again in do_create_stash(). Avoid that by removing the call
to check_changes() from do_push_stash() and checking the return value
of do_create_stash() to see if there were any changes to stash. If
check_changes() finds there are no changes do_create_stash() now
returns 2 rather than 1. This enables us to distinguish between there
being no changes and there being nothing stashed so that "git stash
push --patch" when nothing is select, and "git stash push --staged"
when the index matches HEAD still exit 1 rather than 0.

There is still one small change in behavior as, if there is nothing
to stash, we'll try now to create the reflog for stashes before we
realize that there is nothing to stash. I don't think that should
matter in practice.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9a5006e3d92..79fdfff09a2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1538,7 +1538,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	}
 
 	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		ret = 1;
+		ret = 2;
 		goto done;
 	}
 
@@ -1664,8 +1664,8 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	/*
-	 * ret is 1 if there were no changes. In this case, we should
-	 * not error out.
+	 * ret is greater than zero if there were no changes. In this case,
+	 * we should not error out.
 	 */
 	return ret < 0;
 }
@@ -1728,12 +1728,6 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		if (!quiet)
-			printf_ln(_("No local changes to save"));
-		goto done;
-	}
-
 	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) && do_clear_stash()) {
 		ret = -1;
 		if (!quiet)
@@ -1743,8 +1737,15 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    interactive_opts, only_staged, &info, &patch, quiet)) {
+	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
+			       patch_mode, interactive_opts, only_staged, &info,
+			       &patch, quiet);
+	if (ret == 2) {
+		if (!quiet)
+			printf_ln(_("No local changes to save"));
+		ret = 0;
+		goto done;
+	} else if (ret) {
 		ret = -1;
 		goto done;
 	}
-- 
2.56.0.134.g299a3c16181

