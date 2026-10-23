Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767833;
	b=vAhmRWLmTNg9TPj59iGzPtYmwhKM9L/I2Vg+oEK3vPsv+HEYrvYAcYjuvAPTYfE2QYUW
	 ajbU4cVT7FjhLmoskxy+WybQb8S1Ve5sqSUqpcfMDo5VRP87q0c1FzwtYAqFDupqrBMNY
	 uOZj8YV8mxTtzjIflyReCmV4VHOT6O2b5Uve0lJKap2GZtecHOg8Vr5cT7TnZis5jQOtn
	 8Z27/vUvPZpiVj+DqsVSowBBmHgbKYH7Kj8M0tFtFePRfHytuCrc4E1MkOY5/xbQEeTvm
	 l0JD14j7a3ulQ74nRrbGdbNW2VD591Qw83G4BTOJKSaZR1dtlbkc0pVj31+u2HSQovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bDRYeBaKtl8mi59Maaa2jsMY0p+F9HxO4yQnurRekBg=;
	b=FHmB6VRumdp29YxFDzVHxwJtcaFJaTbgTqHaOEE97Hcv+kfUHUKwGDi6TuJPHC6UvVGN
	 U6eRVyedHXsXv1CUB0D9Hhtvg+pytXsvLPeyffJBEHolQWvtPLTLdvUu6t2987h1itO0n
	 BzZ8I9x4zweUT1UI4DHSzLaooLeiJ1Plh6XH/A8YU4QEjuTF9BLSmnz5mlf6JkE9IPWgn
	 DZcK02WdatRCvyo1Mdi5FOqKMUsDSfEErZcoPJ/X4m4QVLSp4whKsSv+o/ZnE3pjR5WbA
	 QqRibyvAR8zzSJEI284FjlvaTITQHH+SBxA4EG6UpShxs5l5qxWIBjZKryfQ4yK1EKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="mLFOnSX/";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE774606A327
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE774606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mLFOnSX/
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so699881f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767831; x=1793372631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bDRYeBaKtl8mi59Maaa2jsMY0p+F9HxO4yQnurRekBg=;
        b=mLFOnSX/nSKkXlGdW1hEQHsvp43voPh+9uQX3OFNKLuj/kmMNk7sve/i3bi9j/IGz4
         o21Wtay81AGYnpO+BWS3tMGWkPVpBXZcz2ca/vkylmbZK71XRpPls7p+uArG0Yrt7BPk
         TEGV0BeslykrS0gFCbuzlh0IDds45j73Q+7O4zmfionJXGl61/q3AbGszSHDijE0jzfr
         OHI/kobupsEJrHC1vd/qtIFtScvRl0CCTNN86rv5QokbbAFpxvkzmG/9ZxSF5+1sk2vY
         ppsL0Y8YhdS6C57y7ekDb+FVXUbXmDifh5Ricw2cm9rOmuq6tRqpsoj0awmissxu1THn
         4YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767831; x=1793372631;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDRYeBaKtl8mi59Maaa2jsMY0p+F9HxO4yQnurRekBg=;
        b=AuVWruNsMJu4dMQVHFfjT9j5+E+o+hIdEH1nFRvE52/YaEhMcMBvGka8BKYqP+UYwn
         bJko0Bncn0IyY6IM163rYWQWezlwOfaLnoHB9B+oQHSxGnbyiT7q57Qzl/exIvq97h52
         q6zy+0+Tdq1FeV5piEyjCJkkH/UWozSploAkZkfqrDM8s0d2f9sL7gnofJkxBWb60m4B
         kloPBhQXP5IjoQL5fcp8F6640iJH/nrP7lDZdtn/3TmM+X7hAd1AH3rInP+zH8e2huaT
         3pnK9feZKj/cZV07btRUS3hT38OknWIrr4En8oShVHt8dBPjwi2lovivmms234HrmSen
         q4Rw==
X-Gm-Message-State: AFq9FYJ4StGOgUX7EF03SSTHwwtegn5Na8oGBfPbVJq9G4tuzelsfwxp
	aSukyUq9vrOnQP5LHRQsRVQwNLXC724Qc8H6f1uE/7qHskYPDvB1wZeobfp83w==
X-Gm-Gg: AYBFou0M4zebQc2npPDfBFc0bmO/h2mCnyekWJospjz3DaduK+Z3l7LCbyfKkKEvspJ
	eINmVRHrAnSD1jj+6u5gKjI09sBAuhtyJbcyoqtg6eyowoIp/TnpT+xomIjvXs2IJgbA3Ruh2rX
	ZDJ4KW4cU9Y38wPW5QS93aAOEoQCMIHtWD2sR7LvT9dkYPIWANoX23NPBv/Kjk6g0laFqTjyGUL
	U9PDh8T5UjFjvXsStnbwedQzzntJfqd21q8r3liMH8Cb5CNnoMKPGjdP4F12G8OloMguNikcLuK
	p52HScStNmO2l2cqNxqwHgVG7uDvDi+KPGydKX0oZ+/qHKdg/Dw9RWW8yi39Zy2wnJcO9e7+rlK
	hzigFv+aW8bB2QDEXrVyGOFLfo5tGlqLlVtUKwUSHdhLWZAVc87SjlHTCxwd9EttyiX6z0eoDLZ
	1yBuH08EZvleHgKTJxOdZz6RVGCAinew2vjNZHbCGuBuJYZD/AE38liF7+5rUe8GYNxddZpFi/t
	gdA4dkfa5b30Owv2Z+8+LW71ltg5wSTQu0cyM/hZRryhgrb2inJbjR5gGE=
X-Received: by 2002:adf:e18e:0:b0:48d:f3a4:610b with SMTP id ffacd0b85a97d-48e385945efmr4870645f8f.25.1792767831230;
        Fri, 23 Oct 2026 08:03:51 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:50 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 4/7] stash push: avoid duplicate calls to preload_index()
Date: Fri, 23 Oct 2026 16:03:32 +0100
Message-ID: <32f7c97b7c06402aa6f2c16b3d0d3407a0421ba7.1792767795.git.phillip.wood@dunelm.org.uk>
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

do_push_stash() needs to load the index so it can check that any
pathspec argument refers to tracked files. To do that it calls
repo_read_index_preload() which does not just load the index, it also
calls preload_index() which lstat()s all the files to see which ones
are up-to-date. do_create_stash() then calls repo_read_index_preload()
for a second time which lstat()s all the changed paths again and then
calls repo_refresh_and_write_index() which invokes preload_index() for a
third time. So we're preloading the index three times when we only need
to do it once. Avoid this by making the callers of do_create_stash()
responsible for reading the index and use repo_read_index() rather
than repo_read_index_preload(). This saves two lstat() calls per
changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7259f6374ce..8db75d9e135 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1526,7 +1526,6 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 
 	prepare_fallback_ident("git stash", "git@stash");
 
-	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0) {
 		ret = error(_("could not write index"));
@@ -1672,6 +1671,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 
 	memset(&ps, 0, sizeof(ps));
 
+	repo_read_index(the_repository);
 	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 				     NULL, 0);
 	if (create_res == CREATE_SUCCESS)
@@ -1717,7 +1717,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	repo_read_index_preload(the_repository, NULL, 0);
+	repo_read_index(the_repository);
 	if (!include_untracked && ps->nr) {
 		char *ps_matched = xcalloc(ps->nr, 1);
 
-- 
2.56.0.134.g299a3c16181

