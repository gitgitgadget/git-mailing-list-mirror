Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637F19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097403; cv=none; b=jmPLc2fkNulzCvYMzNXiGYzsNQ/gYrnvyQfzYkZQHkw3kpWVWQ5jgXQalEScdmgxhdH4pyXWcHm0Sea2a34coStqWZru96IvC4tdlcGiypizQcUxwUYB/5sa9wH/7tXiEa9TnKrdgbwyZ6jc123ftcllQx9+ko71ImPIu73S41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097403; c=relaxed/simple;
	bh=ywBJEI0AMT4kAjslMpJQHjIcuhUxdJuyTQQu+CtIClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6ByVCeb5IfbxlZv2Odl3YsGbPkgegGDvz+Yqx7Og/KWSYIDfEnPNtXs3jy21SgN+CzqPhiRwA8CKR3CjqpvneoH8ii6U+gaMkjv4jgVMe0cBSkyOT+1h5wMkDIvNLCdpYcQup7KcILji8jCfQ8ZmwJlDQCn7I0pk2NOoOJ+jwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hLKP6m1u; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hLKP6m1u"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d5fe46572so52939287b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097400; x=1759702200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSyCap5rTofeNgeps3fxzAOmj3s0mOvn1DeqCXrOlU0=;
        b=hLKP6m1uZHmyrTQBK2nIfnru/5MuUs3JCNckqhMQmgYw5gcOHabjGMD7WtVPGxnlWp
         HAdgbTexLiBtSOCGbZN04FKdcCdetkfChM4vkeqLJo6pqfOKNTyaOp3y2ORB9xX61lcY
         I49LV+HU2MmYsJkWIZkDMaNgUZ/lF2vwfOGTP1+V1KNsqyngqdk6/QELGtxeX8r/Asc8
         5ICeJak0SHFjCcx7m70Sy1DVcatuJaRgQexwkqvBdV6FV3uiZXiLhSl7isnv/IfTgUe9
         ahbbG/Nu8kQF06ncLbIzo14vmVdIRNCAhQmV9LKvpXU6acqxNxsMNR16qIdUxuCIWpIg
         X0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097400; x=1759702200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSyCap5rTofeNgeps3fxzAOmj3s0mOvn1DeqCXrOlU0=;
        b=PmUWRYdxisLAhyEPzEJX9px/LsujxwUUvYUlCuhHh4SzEeykZzTAwdhohTXT+hiyrq
         bT9EQ+lki7zy0onF2YCRSgvVodmHtFt3XineCRvgxZTN/TXOPId8b3awsaBx9rhCOGsn
         kX0Q1st9tFbIPpWEYw9dISQLqNcUCvizyFRDgXCOQhKa8AVOKfKCQLirEZ7n6cfPEIwU
         hWZLKJuLRX9/TXyEQ16/r6PGUlxT9N03tgbsxy01udB+Ft/sOQ2ZRlWrtl3ZvnDI/7Ze
         /2DB4FhrmGKGdgjLGsiRgE/HLxAHHBJDR7QLvZpYT3G2tCet1tja1xzuqMd2gM4xk2XL
         fHhw==
X-Gm-Message-State: AOJu0YzuGR2q1IKpM+RDRTcI+R2AoJzWZrz/dPWSHUPGvw0xKEdhwBRA
	fz/aiySC26LM8T5Qflq5HFjgnwlY4M3MmLmlG8Hz+TgTifFCcptNKyGLWNGJ6fZil0BJcjTsY32
	UozmvJKI=
X-Gm-Gg: ASbGncsmvgrlbIHcM4t0wx1rqh6ldBDeOir8XKk1HK0qcZxJYhhKZz2iCCUcqR+01i+
	N8Lop2ccS3zlPnc4b0UKDthf4OcPX0BkR4khPkR1j3FGJLNqFiQqxCHzG2nUi2xGjjjJxqtEjF0
	RLnTfBPwCJHNpQJLHfRJktv9cEkVvrMik3RVQ1dgEFQwrs6zW6Jgc5DPVCYda+LNij3eHjJJ0cG
	23f4SVecK5kTTVfGoZcSVH/VunIblqx7zzv6MwAnj6sZkVwXuWP3T0AOjtdF/Qr9VYgHvGumOoX
	s0c+yenM1Ag5tBKBB66buPZDbhJYZ8W8IQj2XkdtLCVghtLN1sZ5S5NVoWmso/nGyEEbTxv7MWD
	GiAcSd0tamRPfvSz1E1gCTL81uMFDw5mIkibbVlNxyahJ65pcRY8z4ETcsceMC3y24s0ggfTr8l
	Rn+5bfBmWD23W5GfdMWXDHBPgeQyIg4chQ3Q+o
X-Google-Smtp-Source: AGHT+IFKKa7yAvZg/ofEJomFmG1qcnxno4iGv6EUc9bQCH4Vg/n50iDzzwphT7g/i9dt//LhfuHncg==
X-Received: by 2002:a05:690c:6605:b0:734:be90:3b11 with SMTP id 00721157ae682-77229ce5df6mr43235997b3.17.1759097400569;
        Sun, 28 Sep 2025 15:10:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765bb916b3bsm23143047b3.2.2025.09.28.15.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:00 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 41/49] builtin/repack.c: use `write_pack_opts` within
 `write_cruft_pack()`
Message-ID: <7826afc17376f0d4a7f3169d9aafce21b3273ff5.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Similar to the changes made in the previous commit to
`write_filtered_pack()`, teach `write_cruft_pack()` to take a
`write_pack_opts` struct and use that where possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6df7c88085..501359c580 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -221,9 +221,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 	strbuf_release(&buf);
 }
 
-static int write_cruft_pack(const struct pack_objects_args *args,
-			    const char *destination,
-			    const char *pack_prefix,
+static int write_cruft_pack(struct write_pack_opts *opts,
 			    const char *cruft_expiration,
 			    unsigned long combine_cruft_below_size,
 			    struct string_list *names,
@@ -234,9 +232,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	FILE *in;
 	int ret;
 	const char *scratch;
-	int local = skip_prefix(destination, packdir, &scratch);
+	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, destination);
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -267,7 +265,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
+		fprintf(in, "%s-%s.pack\n", opts->pack_prefix, item->string);
 	if (combine_cruft_below_size && !cruft_expiration) {
 		combine_small_cruft_packs(in, combine_cruft_below_size,
 					  existing);
@@ -599,6 +597,13 @@ int cmd_repack(int argc,
 
 	if (pack_everything & PACK_CRUFT) {
 		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
+		struct write_pack_opts opts = {
+			.po_args = &cruft_po_args,
+			.destination = packtmp,
+			.pack_prefix = pack_prefix,
+			.packtmp = packtmp,
+			.packdir = packdir,
+		};
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = xstrdup_or_null(po_args.window);
@@ -615,8 +620,7 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 
-		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
-				       cruft_expiration,
+		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
 				       &existing);
 		if (ret)
@@ -651,11 +655,8 @@ int cmd_repack(int argc,
 			 * pack, but rather removing all cruft packs from the
 			 * main repository regardless of size.
 			 */
-			ret = write_cruft_pack(&cruft_po_args, expire_to,
-					       pack_prefix,
-					       NULL,
-					       0ul,
-					       &names,
+			opts.destination = expire_to;
+			ret = write_cruft_pack(&opts, NULL, 0ul, &names,
 					       &existing);
 			if (ret)
 				goto cleanup;
-- 
2.51.0.243.g16eca91f2c0

