Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6834F48F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420474; cv=none; b=sS63rnCp9kxj/7NFIAfl5KrvMgveEw4UcTvuV+NlvXKgzycNxl6SEFa/j7KrZ8PgBzkZkrAoGDshWXkGRURPLXJVI9HJrKXw1OkFh9wCG9ZWZzmxVaG5ji9N4zo/3y9wvYci8LU/h454YyjHHydAwKb8SRmYo2PPH7qiSzo0NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420474; c=relaxed/simple;
	bh=disqvcilfl35B3nWh/9al6ONKzWG272cpbgs5ovuWCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxjbmVGMOeSIhfVGhuBoPr30vYp3HP2TItNRUPNMM6wKra0upCaPOM/Sv6WJ81MZnnycQdbI7P/RMEoaN9o4Vacp4r3T3QhIq8HEQdkpKF2phnelCsrW8EZfCDyOPuhIbm4FZga0fAVS1EyWf12IQhq2Dx6dVcrCvmNBets2xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bB+JAfrp; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bB+JAfrp"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6420c0cf4abso96271d50.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420469; x=1769025269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Sdxbr7qqb0VJBA2GuzKBIcPXDQORn3Evb5+WaGxfE=;
        b=bB+JAfrpw2SGaeiwhrLGtYl5GOM9IHfgEagHWeVZtdMuSHv8oN7SOujcvBnVCSTA+R
         wWT3R0zpka+fWelaojByjNZWAE4dXB9Us0RZ1qnmwgr7PB4VjclEzuW2ky31jRL6ELTx
         UPCftzyEMrgZQIYEbOPqTmSq1lotREbE+Rbvp6mqauhORTfWTVIsxaFhqRpFet+6vinS
         1yMRdxeF8yIk12HkD2OVHlZUT4omehldzh9Yjzyrrtmq8jzbP8gKtY8C/wzaOPbmFrkq
         3r5sdwfbOG4vg62dbD2IoatZP6oeaFNRXg0YbT0qkvTsTzae0ViFryH6PEGZZarM+VMA
         WS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420469; x=1769025269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/Sdxbr7qqb0VJBA2GuzKBIcPXDQORn3Evb5+WaGxfE=;
        b=CbGIbqPCViDeHZuLBtBMpe3bFR6f1HdpYjj/3Q41siCov4IIgYx+W5WnaV+U0bq/jC
         g8YBErzo8TZ25Q1ZPO34ItYu9RfrO4toZtCgmoxU8SiVm93qTxqU45kn/9kLvbWocprO
         snancfRos7Io3sagPDyJYL7NtJYcoyeDysmERKDtlC5JhOeF/ojxgVZKQBOp1evNFlcu
         Hq0NfQzmzRsY5udqs3KgEvpynuYbIJDMNTikAxQB3WWWZ2iRzdpYv03lL7unVZvV1rIr
         hdqG9LY9XL3AmExj8M9rf1euPv3IwSMYYUUoQX4/lLF1m5QoJD5WEfk9IIVcfWt54ujA
         2O5Q==
X-Gm-Message-State: AOJu0YyZkAygyFmn9X4/HoZtws8hFN/CcFn09R8Yxs1C53zIHRqMEE5w
	VTiCSPtkBF1ksZJinwKgOSqZwnXg5Vk60LGLok9Ot225MEIr65TtmFplYCjYrZEwUHBcKXk8xUy
	Y2iusUG49QA==
X-Gm-Gg: AY/fxX7J30wARZ4hw/kfrv0ssnstinuciARfsq977ckXGygjGlx5UfUONkasj4dNH8C
	vXpUY3noE9e3ltdkJiWoTMyc1k8K5qaHKj5THdQGxJRUmIBSKXHlzDLGaXvBLe18r/YsWXGWyxl
	2152ZhETy5IcZSodf1ppl1M0yDUUOvbXgeQnmQRaeLazZ2Ul/wzqBz4MY5jE8tFz/mYf0qB2Rz6
	ejdHOnzLUDt6lTrOXg85uZwQXW87pKGtBljTctVoWOCzvAYXc+Q46QBzdRw5l/ZHZzv4RhiCpQv
	XPJ10kEMEOK9dCbE+8lcbxkn613OO2mXGloSd9IRzVvLtHYPi+1ji8qlm6WpygFpVwY3H/SyegM
	DuMQtvavPNEcXTG8wb7cIZ0Iyjx20+MgL5INBVoLILGnHRtOoMlO6yu98VKzgo1fzW5F/knVUvQ
	Rn5vHiJYYe9N4+fMXtT8aC40azndqVuZTL656HCj8+yNkIvgtT9FGtcDvlNdzJSlkt05O+HcmtU
	yhzzN2C2T3G/WZi2A==
X-Received: by 2002:a05:690e:1a45:b0:646:e643:d14d with SMTP id 956f58d0204a3-64903b11ba4mr1804721d50.42.1768420468876;
        Wed, 14 Jan 2026 11:54:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f72easm10925298d50.5.2026.01.14.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:28 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/18] builtin/multi-pack-index.c: make '--progress' a
 common option
Message-ID: <2aedd72db8c6a6bc776e003e306a5d9ef446bc32.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

All multi-pack-index sub-commands (write, verify, repack, and expire)
support a '--progress' command-line option, despite not listing it as
one of the common options in `common_opts`.

As a result each sub-command declares its own `OPT_BIT()` for a
"--progress" command-line option. Centralize this within the
`common_opts` to avoid re-declaring it in each sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  2 ++
 builtin/multi-pack-index.c              | 10 ++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 2f642697e9e..a4550e28bed 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -18,6 +18,8 @@ Write or verify a multi-pack-index (MIDX) file.
 OPTIONS
 -------
 
+The following command-line options are applicable to all sub-commands:
+
 --object-dir=<dir>::
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5f364aa816b..ca98d4c3ba3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -84,6 +84,8 @@ static struct option common_opts[] = {
 	  N_("directory"),
 	  N_("object directory containing set of packfile and pack-index pairs"),
 	  parse_object_dir),
+	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"),
+		MIDX_PROGRESS),
 	OPT_END(),
 };
 
@@ -138,8 +140,6 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -200,8 +200,6 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -231,8 +229,6 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -264,8 +260,6 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_repack_options[] = {
 		OPT_UNSIGNED(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
-		OPT_BIT(0, "progress", &opts.flags,
-		  N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
-- 
2.52.0.457.gb599f1ad4b0

