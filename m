Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767831;
	b=MZXcT2Q2l1MOX1NAQFWcn4F+SQ6qJ6CvbMynVa1HBRe/lhMvpkGcVjoHUYnvYIcJ5wyM
	 1OJqBY6KJF5yC6yzM955w+6GoI3Xc++IT1hXbw7jW+bRJdKQJhOOt9hi07t8ybB4GA1KD
	 ZKuJUWFFSKq04rLXKGiFoPOv9i/W+Gs/NP3MhJElixpOskuaAU5ybIbKLBSrJFAwdAtr4
	 NeXj8rg6mKVF8+ciXCGICsA14u+acTaeFj/qA2oCGCKumdm8aqeZfCxl/3urADXAp5HjH
	 JY5/bSWUVfXoobO3zZH2+C78FTTsxJeeNrm4sU9IVBkatuGrFrsme5BKsEmesu5FsHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=riDu2y6NBTOchVGIjQOB2w093Spfyixid7bdQmTPwv0=;
	b=YjHRfbAWZErn4EMkd16WlNkDjR+OLEcrz2xGlZJw1qgmIEoLkzT3NRsUz4TKnw5I7sox
	 D0V3g/Equz1GpymIQqWLcoebHpMYhUC+8azA3F6kRsvIA4FwgqPUznOmPkoYY0TQO4PLn
	 GIQMVFc9CjWt+W909wMg6FJhgXmVbHmEJE7m/fTRJilNd00anI/+dIzBrT6jQ6VH3/1Fu
	 d5S3Wq7bOaiMyExkPTGG6UW1GnqSja3FfcLytkqcZodvDsbtDwe0uiiYCfQvnGVnQ8Xnn
	 RFjKzDNnaIIoxI/Wgo28+XyRfGjIxRfV5geSLLlIO61pnCCr32gXfzPiuPHkj1zJWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DmAiMxbr;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43B606A32C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F43B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DmAiMxbr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d885929so629245f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767829; x=1793372629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=riDu2y6NBTOchVGIjQOB2w093Spfyixid7bdQmTPwv0=;
        b=DmAiMxbrHguX/S+GZkEusioH7KMTpr8hOGSo/jYYM/4dL9w+wqCfebfOnnpU9aRySD
         NfyOL3KQxLLrRt3XMxT2/UqK1FA0FmYpvzl/06FCfSo7aqtP/bL5CftoSzCx/KSOoxCE
         fKKTEax0bBXmptlzGu05wL6J98NCTyT1NQY+iZOag8NUpHOsSrqx/Kyi8Ue/f7ti6Mci
         C1cKPpQXiEFrcxqDSsmIgsu2MHsF9WE85JDqvdwLmRwiLxBzhBUcnOjctG9KtL0b+uOu
         iFtaZq0HZ4Na5emLdSYDxotBtjEnf3QSg4JEeOcRQdBNvm435MqwOvLTr1oAJNsk5wxG
         sPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767829; x=1793372629;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riDu2y6NBTOchVGIjQOB2w093Spfyixid7bdQmTPwv0=;
        b=ioziyBCayBmUYWfsQfkhI+8b+pIZjJAiOO4kxkmicpf9Fhtn2q2CN+/B450H+16jD8
         JmRhEgmBuVUd2XN+mp//xDV312K57MwYKG7JWf4y6E3T+HldHHKejWCwXQ8F44qrqWRO
         IYKQmYOh4I+w3zdQG84jECjHzlDMwL/XmE2IHXOt4Iwmx2axodrOASWPtNswbdanFTGR
         xjl3tOtRu1JVIPJPU/BVDTwqFY50ARox6Yz8yRb8ZB7f06FFABVORNoNbVsHGVTDNVlp
         atECsSwNv8Gekfh+Tx/GkyuTaOFd70GnVMmuduJ05E9XQp+yXcvD7SCr8BP8evQ7P5/K
         5MrA==
X-Gm-Message-State: AFq9FYI7+JUpfQWhuf2+v+0/0f2q2l8+sPkuakxVuAbErenEmq+Nn9XZ
	ZJLz0dojFDjtpkvLTQtEZ2nWX22pUJg0bgbk32VLG54S6UHKvt+vMLKpqdoUQw==
X-Gm-Gg: AYBFou1IrLfSjb0D458ngEs3gG88PUj0pEMfokqnx+czGV9lB2r1Q/iz1MyYIK699Hk
	fxJQaVEY0LYuU8jmbboqJ6N0CV1FP3wwimfX5Ihgsi6Z9g60n1BaeGWSl3dOhnh6eAovgk+BbD3
	5qOQ9fnaRYfmxRvKII694nQ4G+miT/q8C7Sq4MPOix/nvRmAip/kyuDGh+pp34EEuHzOB0f7MLf
	BAIPvG2xIFCcgp+wcQcc487U+d+JByj8ykQX6+f5cHDeD+W12dnNiG07d5+b9NIp2q9F8UBQfIl
	cJBQhR8fpsZ8HegOmm57LZmQyGI1Pk7bXsCSSM8Q6IIeQ6NAdKg0xpSv1x9/lPLluJZBv/wfF4V
	2rVRzv7hFuujTaI65fQpiFpwWdO51cbxmQ4C7b58gEJqoFYcJd+2TsbOUFIP31Ye2KlR0tWrUsT
	HhXc886UgDBHPpfKIIw8fQSnMuQ9p2pXVNfLZdcXs12v7uzJQriwiCchyxc7I2tLjDDE+/VBsnK
	2cJwyK1/5Hj//zeAkSFIb0vPJ6XYxKXexgzihCHINJOphAUC0lRWa63mOk=
X-Received: by 2002:a05:6000:46d4:b0:487:88b:4681 with SMTP id ffacd0b85a97d-48e38594ae6mr2828682f8f.10.1792767829164;
        Fri, 23 Oct 2026 08:03:49 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/7] stash create: remove duplicate changes detection
Date: Fri, 23 Oct 2026 16:03:30 +0100
Message-ID: <d2773fc82ebbb7bc7db0656d9025db74e0b3ec01.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
and `check_changes()`, 2019-02-25) "git stash create" has checked
for changes twice, once in create_stash() before we refresh the
index and then again in do_create_stash() after the index has been
refreshed. That commit claims it is an optimization but it is not
clear what it is trying to optimize by checking for changes twice,
especially as checking for changes before refreshing the index is
unreliable (the scripted version of "git stash create", called "git
update-index -q --refresh" before looking for any changes).

Avoid checking for changes twice by removing the call to
check_changes_tracked_files() from create_stash(). In principle we
could remove the call to check_changes() from do_create_stash()
instead, but it is more convenient to keep it there, rather than
require each caller to call it instead.

The remaining callers of check_changes_tracked_files() sensibly read
and refresh the index before calling it, so it no-longer needs to
call to repo_read_index().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 53744d96e84..5137456da7d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1248,9 +1248,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (repo_get_oid(the_repository, "HEAD", &dummy))
 		return -1;
 
-	if (repo_read_index(the_repository) < 0)
-		return -1;
-
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
@@ -1670,8 +1667,6 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
 
 	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 				     NULL, 0);
-- 
2.56.0.134.g299a3c16181

