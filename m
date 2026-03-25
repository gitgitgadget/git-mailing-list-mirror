Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EA3F9F46
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457346; cv=none; b=aZzFohyVKNTpGYtf2p43MSjXC3wSQ1HyT0vQfAUUNRHoxziz+gZnDSzygafyXMZBIoy06Mmy2fro2AeB1SGgh4TS/it/KriHKVL/2RB7ft4bcfLWVJh8iwB51ISjIwHlq41OZMRp7wCu2ps8ojK3LMGsSxeX2j/TLMnWtym1cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457346; c=relaxed/simple;
	bh=I+8Kd3URrtigFcHycvmzgpzdAWoxJBf59Qrb7TvbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvR2Sz+kK0HHKhskySLG7aS8xGi9/XIje4jlP0Qjy4WUUoLyWn302M0IwxIneKNhD02YGVY+if39tdZgq4t22fRijuShA45++bWRgVg/vpTdFrqoVa5deVsWzVGyq9DbcC8nFe0+lBOEfmI6B122H9Cm7zOrjvDs5g5GRbupGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE9eT82c; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE9eT82c"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b06c43e6a7so95905ad.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457341; x=1775062141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=CE9eT82cfn47C4jZciQh1AYrus0rueQpAlOt0SIloBaKlvep0rDMe8/pHsSg+SoHyD
         gsqYR484/eIBsPJ+JeHHtbZ1KXEtRZB4+76eOyf2aWl1ltyczd66RttIgYwThQjtG/I9
         pzLDZfeK0tTFs9C6is/7krKrnQwHy39kdkDwoggo2eKWBHf8tsI2LOiR6GGRXN6Xc5or
         4IwmPIoAHfHfBMzxciL7Jnj6wmWkxhEW2PuDSvVFhOE7TofTj8k7gnZ+7qPzcfSyzQEW
         9pc32M1czE2EB9BcBOHmTqf6MiMSoTbOu6il2ZIWEqucPHyQGMiVJH6vet/j51rlodtx
         fPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457341; x=1775062141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=A6N7gY6/kavasdN4OmllFvBSSnIprn2gsbJsW7zFThzj6PcrPf5WM03fT06Tejxiso
         Po9n3tb/OBvlWiDx79YGWb/SnSoha8H1LsatSbdLp876HUtaNVWxPG5w0aM3SnBdkCZf
         sbY8ULErSN/T5CMP/1NdrLJgncIR+SeZ823mr44+6E/FlZtEkEd8IBt+Vaf5csqluj83
         wYIxYdWtgDyVp+IcqeeCa8QwAXQO4HaILQ0B5f3Lp56lwfRzJy9SsIvywA2n+XFSHRZi
         YgJyA/50pNyU26RvO2kSr9PNCPTg2A2Ls6KG0gjlpMmnwsDD4gTEbuEKrfK50RFihvgk
         cbEQ==
X-Gm-Message-State: AOJu0YwY5Fi+EVrT97GFeQqWLrdr7u1NfzsJ3TCp3IWpnQ7DJfMVLxqK
	D2FZOnckfH1cTeGJtd69WfXuYSzLqP8nz50Ru2MHt71wcKanxcSgvOuggXIlmQ==
X-Gm-Gg: ATEYQzxgK32rrAw0uhhZHeylRzDXAS0PlDJckgBwqO6kuRTRnWn7hc77xoiAA03ZRiF
	cVjO0PjsdMlqdCX3mJmCC4x2tk5RtTkHBElJUXVEOJ2DeP1JcBAKNfNyfRImuZEjIaUl3JOuJ/N
	1LaAvWXNVgC2FRbRJ+ytlyiSv4c/BQl0b27L7kyE2EICOsvFWlWSBG7yzMq/3XPBKkevn2jPW75
	ByFRHv4npy5LyFKB8zaEaoZRUTJkblf/qd1Pastc6ThTxmfuKe+ZGgH4ny0TynqoFj9PT8mvCHM
	S7hJ/81WaerG3gS0vSB7tu4ZiOxhvbGzHW2PpGzgmq5HcRs50xzPhjz7ZfrvvuaWNLLU9xqcAw/
	SuLSoWFTiN6XiyUWssaxEXdRa/R3uVVcYTvwB5D13fLoVfWU4c3B2kteHSlQLiUL5yEMa94PVBV
	Js8U5OjjvqwjMK1LcVRt0H8iYYEOqKVOCvAvTjmD0MZkM=
X-Received: by 2002:a17:903:2b03:b0:2b0:b561:b07e with SMTP id d9443c01a7336-2b0b561bea7mr32017495ad.18.1774457341337;
        Wed, 25 Mar 2026 09:49:01 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:49:00 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 4/5] refs/reftable-backend: drop uses of the_repository
Date: Wed, 25 Mar 2026 22:14:21 +0530
Message-ID: <20260325164833.1216577-5-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_be_init() and reftable_be_create_on_disk() use the_repository even
though a repository instance is already available, either directly or via
struct ref_store.

Replace these uses with the appropriate local repository instance (repo or
ref_store->repo) to avoid relying on global state.

Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
is_bare_repository() is still there in the file.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b124404663..7c8a992fcb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -404,13 +404,13 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(the_repository, 0666 & ~mask);
+	refs->write_options.default_permissions = calc_shared_perm(repo, 0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
 	refs->write_options.fsync = reftable_be_fsync;
 
-	repo_config(the_repository, reftable_be_config, &refs->write_options);
+	repo_config(repo, reftable_be_config, &refs->write_options);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
@@ -492,7 +492,7 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
+	safe_create_dir(ref_store->repo, sb.buf, 1);
 	strbuf_reset(&sb);
 
 	strbuf_release(&sb);
-- 
2.53.0
