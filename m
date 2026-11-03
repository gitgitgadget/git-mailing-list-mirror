Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741057;
	b=BkKMYXeG9YqXuvNNgChbJyapSoQkEyzWUqwHcQaDvVacU3c4zPEN3pBu7JkWBGAi8OoX
	 CEKhZVhSD3iE8d96rLWV9vXxU2UYjOhveGuwT4rLcH7YU4UDq8gYGU9BIr8IjBvT7ZNYF
	 hEdxjwLcuuRgUeX1c4BZ8LJOUkVq/0jyOZefLxV+50FpSLRL2rK5Khs08HCd9hDXInyBs
	 7MXWUfszpyX0OpKrnUNnVowaxAaAIhXMsiIGII7Sxhi1ciZEuxVX/jjOki37NyPZPdfMO
	 8cUcJ0uvUsF0+FUtSG8GhazuDdnpaU1Afl3qD+IIdEHeUuSjzTdElV4aMLpMbIlH7eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nk8OQF+9E6Q+dHuLRIfmN2aCerDRhChgOGmIx/N4w3U=;
	b=GRhP6DseOjdT3bs69dxvziv/q4svP+yOlkQiBpgxln31tAmvTutlypdJHFBZG6nvupUC
	 xGYJuTa5yfIP6BxlgVKqrHaWnFWHkYJWAzidkGjJTXYGB3+T5CdPBBp/mCcpLJPUzPvGn
	 n0Z1zl9GcOF95LfTNARPdjU/Z6qxzZSXilNeJcu78zMvXkZsV/heP5qMtmf6Jxzlfxzeh
	 vryFIY138W/W5EXTWTyXCtZmzuqehyAgdm69yGJb22W3W5ih2UI+RBnDKrDuJIlAYiKOW
	 PX/iXZyZ8x4VHa1ZNIxbJXSuUEVycOewxeYQBcf1EOfMS30dpbnvxALx4BxTRobyC+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZYXRm+n;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389B606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A389B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZYXRm+n
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-55651e7de9bso40523b6e.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741055; x=1794345855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nk8OQF+9E6Q+dHuLRIfmN2aCerDRhChgOGmIx/N4w3U=;
        b=uZYXRm+n7FGpIsS/+DGlgbDlVItwE8S3S0jHYb8rir9uuK1zkZN3WPI2QAuZIa2KPw
         b3xy39TWeUV5DUShvnLKbr2V5EgOeebv3bSLpilheLscdznrjYWbVwuZ7lUZvbm9024D
         jot7yxMjqb9hwS1o6UyAlOJyd+Uxdus4P1P+EB5xUTDW6NiOTUP2kP/vkclEDSHUMv8d
         Th7NPkNcc3k7Ed4CuypSkTiRSze4Ed7zv8hfCKzp3cNj2sXKneOKh7/Huz7FA+Dtv5ZO
         gwdi78CwdsNADhE2jadUDRwYgV8C9tNF9GNpbo7NS+iif4yDwdf+R9NvE4BNJoZ3Ot2j
         OuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741055; x=1794345855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nk8OQF+9E6Q+dHuLRIfmN2aCerDRhChgOGmIx/N4w3U=;
        b=o/voy07yGEp8XLjOAEvItYhb1ha8e4GhdugwgcrgB8plFsoShDc6PWFjA/JzZxwOb9
         DFEvCchk41xyoQQA8iMxWJ4FLRuh9LvWqo1olmR19yOpQpTRT30rZ3zba8S9E6X0o4hK
         v6dUbu7MvCI3WoWsBBUV2XecK3DVzFRJnt6mp48JHVrV0V0q+uMc6sm1LcF8TSjLPp91
         kmlH8do5+SaujnoaFPdkml8mA2HWSSyr/u17EbZA8aZzLIfxUjN8O9G2nGC0j0k3oZo7
         4bYQVMdWCVROm6OdPLdZYEyzVlFn1mqTWCRjPbL2Tv06ndm3on9K89fpNd8VPwNCdGnY
         DaSg==
X-Gm-Message-State: APuU4Z8NGzRfiwMHi1iJC4AkKtLG5gr13+sMZyyERemsK9uGW3vXEGQT
	yHNMz41H6lupfI7aXrZX4l8hpGda5iV7TzdlF+BUsKc/blB5GgCGT6tETdMiDQ==
X-Gm-Gg: AYBFou1Glo2PgjuDAwrRt+4wFF8eyH8IAOJO2ZidW3j9YA2siov1IgoXhf2YISs9P+V
	1yuHbZ1HXL3gPT1+sUcDlcFD1TXwN4Wkj7PvUn+4tmvC1CybmBbwgPhHiwSMaRNh2yleZeY5fgt
	JT5ZH+Hdq6P0pGeaEqzr2XOxr7u0Uvo8Xui8EJlCT9tMsLLQpJDcHwuhNLFrl+HMOWJM/SvvL7N
	Zo0ZcyQnmj+UdetVNBNjY8dZHW6sVnmCKIEcnGQsl9seyipUlgtQjRgJWD4LGwE2Q276cc5TGXy
	unvDxipoN+q3pSR4ECut5gvl1tx0Amq1UFqjukUjJNmTdSbLpIkpfh2hZ9isMT/4HsXodqjrgOh
	RVW8LTc48bI84HuOwgaNCzNR2mv25sCljYPL8zEdfjvuvUzsJfZaB9UQ1QbByVewpOp/DaqNpMT
	hyxNRyAxc5eUoGcsUzBnw+h7UXYEraqiZ34e47OHT62icbgwn8Mny9wtITyzPRyoezWTE4h6Jmb
	qNbBh5jmFK18bXDqMdRnJ5RisT7lis/PlUoavTIaQ3HeqM+Ofb209rtmz2ctpIhe5pPYK5yC2NL
	iFyeCX5Hl33jaJUcGtso5vQd9ToZLBXPlzN8q+1WQZECpSu8H31ueiUghyOBehYYXeGsqw==
X-Received: by 2002:a05:6808:1383:b0:4d5:27da:a496 with SMTP id 5614622812f47-5640dea5a02mr10319831b6e.48.1793741055654;
        Tue, 03 Nov 2026 13:24:15 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm15628b6e.1.2026.11.03.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:24:15 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] object-file: warn on failed unlink
Date: Tue,  3 Nov 2026 15:24:09 -0600
Message-ID: <20261103212410.1389988-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261103212410.1389988-1-jltobler@gmail.com>
References: <20261103212410.1389988-1-jltobler@gmail.com>
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

When the "files" ODB transaction cleans up a temporary packfile or
".keep" lockfile on an error path, any failure to unlink the file is
silently ignored. A ".keep" file left behind this way prevents its
packfile from ever being removed by housekeeping.

Use `unlink_or_warn()` instead so that such failures are reported.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 132aaab6f8..a9800143bd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -823,7 +823,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
 	if (state->nr_written == 0) {
 		close(state->f->fd);
 		free_hashfile(state->f);
-		unlink(state->pack_tmp_name);
+		unlink_or_warn(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
 		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
@@ -1276,13 +1276,13 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 	if (write_in_full(fd, contents.buf, contents.len) < 0) {
 		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
 		close(fd);
-		unlink(lock_path.buf);
+		unlink_or_warn(lock_path.buf);
 		goto out;
 	}
 
 	if (close(fd) < 0) {
 		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
-		unlink(lock_path.buf);
+		unlink_or_warn(lock_path.buf);
 		goto out;
 	}
 
-- 
2.56.0.173.gf57c9a7388

