Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D325306D52
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567349; cv=none; b=Cct1szTUSByUFQPAMJMPcIKXMXt6uDbwk4/LVTuqKewFou3FtV7yplOWIz6wWt6RFNYLT0XrSmRwgY1x/068R06J78DiVrvb+6Sf1KsU3S/iwDura4FlmmwNMNS6eLBTRBc1sOPaZ0Jmkr5Ky2nhY989o8FxGa7poypYJ+ikyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567349; c=relaxed/simple;
	bh=S2WavbHr5rVRCxZreY31sYpCwGWAlSSM14d79193xh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppG8Lu+Kg8zWXrDDCBdNxssPnNvMw7Rlbam/2dBzbVu8A0fXHvF+4bjVmtKT6uoa3Td2zxb9T+1YOFmP9gucF4rOEJAG5cnQYRexGeypy9YUnVldroAF4wW9sxf7hiM8hgCl7fifQhJ5Fuv9pWNpW9HeGH+mSyWR6M2egnDKmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ARWzQlpM; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ARWzQlpM"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-781da6c1a37so930547b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567346; x=1761172146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtuDD6VEiW8iUtp5I3zzSXgzmMFp0MiNLlIF9k4LzEs=;
        b=ARWzQlpMvPxjliIjHvbS/V+YfSeW0ISeUYv6lxRWvRHbrhiUYLRJev9ELEJCcsNGIx
         emNokSbMBb9sYXb+2+QYKGtgdd8TwgYB2HUqRKwMNxA4ht85BwuqopxPhtlJ0mpFjDjU
         m2pzr5I+ma6cgKcrz3E3gl/PZpkEpNgZRr13Cp0UTgLAZKScPfl6m/+vgGfsqR7igpJe
         y4aBtUQWSpbKLChUnEQgyd3T7YRj4+m091R6sAZWjYulXyVS3I8G4L2xMXAPqQUNrGDl
         5vsBv7k5HDhYLY2pGOTrQRf7hLvBtITu1V4q5oIyzaxLzycl/fu1QBp7oDfN/kneZzxj
         gBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567346; x=1761172146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtuDD6VEiW8iUtp5I3zzSXgzmMFp0MiNLlIF9k4LzEs=;
        b=YuZZ8pJZqFCi1542F+cPrnU+oB08vpX3IsAKFXHS1LBmHw+LtVCMHH9PcvEgGGfwx7
         lKy+9CxifntRrhqQT5+4meJkSVR6CVJHERb0CtbaD9rIgWlSsSHFQAu7GSvmCgjBpTEN
         i+mtNuJvC2+RJlA7iPk4B0XdFoU5oTtfg1tJe+2HIyC+34NnB1Y1WV3P/8oeg+d3CU70
         O8Cn2FBgTjClO49g4Phy7YuyzTg2T0ff9VQmvN0bZhLtO3+3OZ4pL6ZNHes1rR5OyFJM
         xPsjIWqTrjWCIX+4rtuEULSo/91dcHeNQppw/F5Gt7/WfUeqOPXfJx+MSJR5x2yGvZqW
         iZ1Q==
X-Gm-Message-State: AOJu0YxzkDpEST32b0y+QJP4UKv6K96H+GO1SO6zWb/Wu7t5w2v29Hhz
	B5uRz92qaRijuJzDTUHPLnScNewzpigxvpVyhvP0AX2cD0JdXffjudWseNVfu7IUHEgD5n13n5t
	I5KqoPBa+/vby
X-Gm-Gg: ASbGncvghVUHqmGqpoaxhohaJfJzG1kHXshERPxsAe+PwlM2Tu6LFk3vd5n1FyXofUz
	ezvbCUN4slqeXcflLO2IpsOH6MMXgROlmqKnSlk6nzIB34eQ9ryLYMdKHBHSBRUrWGiVXRJ6nfC
	O/hDJ4nqek+Kbge9EHKwfIc+tmYcM5+mEKhZ0If3UGcqdiBCaaQiigOISLbv9plEPnZBKAbDo/o
	lFKAnV70v2nob4ac/KlJt6N+8LUogAHxl7DPnnO9MBryY4/HKI4QGoy0Hxi3zsXSSstMwR35mjQ
	UuJpbe3FocauOGg7ApYZsfECVA9sUEGyZy0j3pkqW5kJ0ypQVMFjIH/4z6jV5gvNZ9xOT+g6tGe
	69ggThS314dHlngfoHE+ThogyniJH1eadptxSudjxT8L40kUIOa+3CXKqfNnRwLetxKl5JroI/i
	Mpul0jhXrm1blUq43ewXpopOGiWKDFMVE9Ko+tlwz0gPeTRKRm1HSO4KDJvV+Odk0cj+G5obQow
	eP89yADkd8IuPHNQQ==
X-Google-Smtp-Source: AGHT+IFRYV/xchjI7ZuYWZ0aeF53GvZ0teKpMLqlij166smpyHQfvVNz/u2Ly+w4hIE9eaNeZDujUA==
X-Received: by 2002:a05:690c:260a:b0:77f:a47d:23bd with SMTP id 00721157ae682-780e16d6806mr306273487b3.33.1760567346424;
        Wed, 15 Oct 2025 15:29:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c149a5sm2586207b3.41.2025.10.15.15.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 36/49] builtin/repack.c: inline
 `remove_redundant_bitmaps()`
Message-ID: <af06f60e639827038fb9f75e3d884303e9b20416.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

After writing a new MIDX, the repack command removes any bitmaps
belonging to packs which were written into the MIDX.

This is currently done in a separate function outside of
`write_midx_included_packs()`, which forces the caller to keep track of
the set of packs written into the MIDX.

Prepare to no longer require the caller to keep track of such
information by inlining the clean-up into `write_midx_included_packs()`.
Future commits will make the caller oblivious to the set of packs
included in the MIDX altogether.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 865e0af039..271c869268 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -331,10 +331,10 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
 	FILE *in;
-	int ret;
+	int ret = 0;
 
 	if (!opts->include->nr)
-		return 0;
+		goto done;
 
 	cmd.in = -1;
 	cmd.git_cmd = 1;
@@ -392,14 +392,18 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto done;
 
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, opts->include)
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
-	return finish_command(&cmd);
+	ret = finish_command(&cmd);
+done:
+	if (!ret && opts->write_bitmaps)
+		remove_redundant_bitmaps(opts->include, opts->packdir);
+	return ret;
 }
 
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
@@ -1003,9 +1007,6 @@ int cmd_repack(int argc,
 
 		ret = write_midx_included_packs(&opts);
 
-		if (!ret && write_bitmaps)
-			remove_redundant_bitmaps(&include, opts.packdir);
-
 		string_list_clear(&include, 0);
 
 		if (ret)
-- 
2.51.0.540.ga7423965ad8

