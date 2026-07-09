Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7073F23D0
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590170; cv=none; b=YqeNgzTw9JadaHQ4FRWB6jaGMaQ6qQ3hnej+hlT3KjtVPlmbQN/qjNGc8NPxLMzxz9RieCxfkXcJZhN/by00R/BlR7elsd1SIWZ0uITTOJlI8/i8VFYdpeiQAF9OH314Cm8Ty95EFRrDo7cmlB17jizJ3kdASK2U9zkz49IQzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590170; c=relaxed/simple;
	bh=F9FKv4Sug4MR8YFk8q2j3Sc+RifXOvgg/r96fLHomRI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WUzqEdQbnYMOmxkxM1SSzQ5OhEBZVFVumxQbmT8IdWiXPmTN4RF4LjXLyJg5vPv6UIvSwC7dvPL2UfniSNCeZUHFQgoDsPVeAY+g79bjDI87AGoKGWeJCOCMLPlmPwr1LA17bZQPc6hzOlKIi9ljE3VVJdnwtLaSS9kLYQT8ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzAAiBCA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzAAiBCA"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2149571dso14135931cf.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590167; x=1784194967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7bpdeu3Lcqh0T9DjCdXFsMirShsTwvNQvJpBnRRWklA=;
        b=jzAAiBCApeQBt0YfzfF+E5iP4r+HERJJ/7Bg7/Kpe5OmPasmLVFPGj+GIhqayzhq2u
         ERMwu+kmoKjKOIWuoIF8rHRlVYMVUDdOXdOd3ZvJmpYQx8qOfRnPFCXqu+QRJT5EpQe8
         Wr/6VuhZganQooBMMm0hQff5y6kg1jtgX9eM09fD0Ti1I4+5N2nbTpLlK32hhhqW0x5H
         Ox9Fjop+aU2QzT9tkXOSzJz6tqVE0i85KvNyDmMbMlPCwu0knkT09j3Ebxvn5EDqShRN
         fh4SItkTkY2L4KkU0EvoyxuWZGN9kp0f4ZswxdmHSNCWx8i1rnqrOP4/UdFNmdm/9dUa
         ojcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590167; x=1784194967;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bpdeu3Lcqh0T9DjCdXFsMirShsTwvNQvJpBnRRWklA=;
        b=MFnPhlf0qPx8PJgowdJ5v7vHL9l4sC1j0E4G9neVtXlHzFrjQ9Ym2kTiZ0WFUSzhgX
         bsCIJ9xNlQ5PIRRjHYkkxTCB9rWaMry02M5MZzYSKXrMEHZMv++IZrJvDtOMU2Q1tT/5
         WstyLQ4UgaOVOjmOgiOPftMMUDGd1UyjJKDz7sYxfyMuc/jXn3nzhtCS3D0QiM6Jxaxu
         KuebaItTfteRv2bwsJ+72wYoqP/C/eJ181NiCunS8LO1xLtFr/YLhj1Ixpg7no7CjTcf
         zwdE9dh6CmRcMfR/aAiupLtysuny/ilK5uT1wgjYa7ealZxRJwflgsGxLqlqaPjhg1s1
         vfEw==
X-Gm-Message-State: AOJu0Yw21r4F5QEh6InO8OWobccLJxc9NQpn493We/hvh5W7yj63vrwQ
	VU5BMh6Gf238TV4eUSgCN2EbMO9A5KiowHHFXNmrbUiXldNGr3MCh5XZhf2M8kCl
X-Gm-Gg: AfdE7cmYW3G6juBMQGiT3y5Bwn89sbbgGNKkyUoYKuMefwll273+IK5tpHI2adN3jpi
	RMpQDr9tLmX+xmK8JHvSRpxparrY5TnW+XGS0A8tENPxxFBR9dE4TUUzleVC9D2mXwSAEbfSnhb
	7945scoMJKTFxolbf69oNs0oNY1OccPV+D9c8tcODvjYuMvgsOGytdyHPR32upiESXXw26OLGpV
	GHXQMBTm+ti8E33FElo2qtZMcHuUw9W8zZN5cGDqyvQAibNOAXC2L0GM6ltu+IXifKcCM5TY26y
	y9NzUZNO+jiypC2K4uwtNWInSWBCMjfMbMA52ntwqllmA/JOhuhNWL3nHgg3kK/kPesh7TKD6xN
	tqnRizffNfAZNIsWIOqFdsZ5q4Y2EwTOXiju2+r294H38TOIa8aWG13v2dJMXLVhaZkZ8lD+Ogm
	26/v5bRcDS+yH5
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr81497821cf.74.1783590167537;
        Thu, 09 Jul 2026 02:42:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b281c9sm158126801cf.9.2026.07.09.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:46 -0700 (PDT)
Message-Id: <41eef047ae6e3c332e1c8f96a9f9abf55d5004fc.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:32 +0000
Subject: [PATCH 05/11] mailsplit: move NULL check before first use of file
 handle
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `split_mbox()` function calls fileno(f) to check whether the input
is a terminal, but the NULL check for f (from `fopen()`) does not happen
until later. When the file cannot be opened, f is NULL, and
`fileno(NULL)` is undefined behavior, typically crashing with a
segmentation fault.

Move the NULL check above the `isatty()`/`fileno()` call so the error
path is taken before any use of the potentially-NULL handle.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mailsplit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 264df6259a..0993418e63 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -225,14 +225,14 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
 
-	if (isatty(fileno(f)))
-		warning(_("reading patches from stdin/tty..."));
-
 	if (!f) {
 		error_errno("cannot open mbox %s", file);
 		goto out;
 	}
 
+	if (isatty(fileno(f)))
+		warning(_("reading patches from stdin/tty..."));
+
 	do {
 		peek = fgetc(f);
 		if (peek == EOF) {
-- 
gitgitgadget

