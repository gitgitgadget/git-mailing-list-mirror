Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FE3321AA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997452; cv=none; b=s29KzLx4dtCW9TwcNsWAgVkej3TyAc49Jgvrn6OPFY1145GvuWQk7jKyAHx1djFFPRcUc7JbAfczapxKTdiaWwXHbq78V7harQlfk0rihUsbYoncVcXO1KWXG17KqLQiIySpJ/xh1ZpFnZjNBPoUNcZNxEPjVx5iImKNcWxM834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997452; c=relaxed/simple;
	bh=yKtEMCwkElnrYOUQ4qzVf6w4z+11WcTn3d+FDA+dnsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2+BuW4rrk6iIfPEGOFysDa9mkDO32DdbBpq8Th9kFLioFuBbCqfS56/kBoiD1QDgfaTMfsgyqH074ZhNixKf7aaCE5FFZ9D4GMbrhximzN8HQMlcO0zAEOF2pdjdtEFHg3G4hZlbb8VbDt3OSVSIsEUViGnIzG1UkqkndZnZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SdbMp3LU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SdbMp3LU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-794719afcd4so31506537b3.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774997450; x=1775602250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+JYupsio+mMrlj98/MYIcuJ+TpkzVESuwLJGaGTykQ=;
        b=SdbMp3LUxbmoTLzmFeREwJpJq0+Vwwo6VltsjqgHX3SEQwoerYbGz56XatpJIGmz0c
         /dAaVbrTmEz+z+LkyvE5HoFOEuTpIyvIcme9HSj0t06WohdWIQ1WWJq7FmPoNwPOy0a4
         g6v08iaQtPOgDJyvIxciSXRAPpwAQiMthV1KZbcuS5ADGR1VS+CgdFS8zG3uBThp7Dfr
         U+uqjSOtRCxKczSlAd0/xaptEbz8F2PT47QJcPtwgAs3eFE6HirXvwlX72iwzEvBOw6e
         pX608aYR2fgWwtzSYSRLxAlVFzeM6Bhn4/oIWFs7pOFPpen6qKGx9AUbfG8FiJVsnYAQ
         U9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997450; x=1775602250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+JYupsio+mMrlj98/MYIcuJ+TpkzVESuwLJGaGTykQ=;
        b=LzrSUx8HAVeloMfo98ricCZ2Ao5rJofSbPHZDPhmPQZ0Ow6iV3HdgqrOvLwa2svnnE
         Kp3w0uxScixW26cbFuX3lCrX7t8eaoIJVzk2iIHlhXQ5wEmOQiIHaRyKWblmSkFqGjD/
         uWxi6k3qaZ1IFsZf8nch9e9QkCYfberBK1UCEtdokC3Qi0dSf+v9SHb5U+uQwH2DAxkZ
         ffuw15frwtklyx2fCVPum09JHfN40SCi3P2qHoOrZH1sKA6ripc4FiHNbtnuZ6lqH7aK
         Hez/Ub/nJzeuakq3dtPmFTZUL5wDz+y2dKNniflYJTMufNKX/mohXKlMPERwZIbWrFy4
         edOA==
X-Gm-Message-State: AOJu0YzBs4OgQ9hN8R9KVx/s+Cc79Y0zC5akQngMLT1Ao6SQ7pPX8zyO
	UcDHkU4ACadQMeC7nn7rpMiJf92cx+RPZarm/Q228AvTzK95F4zIvRmP7KUH5RSDvv8=
X-Gm-Gg: ATEYQzz0OnK0gX2FX2pSbPIQZvjyMmNXE1xRbIz6V37yNjDZ78nySQLIqpCLKfmikLv
	SWiTZLPJZAiyAwHX7BCieQW7VsVCm7CK0yf2nlq8F6k9Q/NVPY7kXRiBzY0Z944px2ChJW/KGJM
	duGhcNE8XfM4knZfN9LdPhNXqf4qvhx/NNkAbuQ7PkUsSuX/d2QlD5xYP9KmOM+kO7RND/syoUq
	k/6VNMs8lwsX8xGPhlO+n9NjicYwJIDKBoIqs7UMEbSh2Q3364Z4xXHHFXyQBmbQq4Gp5NNm8tc
	rRJgKb8/JxjLKyuR1msXm5K49e7VCvgZOoVZrSVp4nPD+z3bWqlsEjhyim9LtlGaeTecnVhJZEJ
	XTZRFklMrjyLjgEOfKBd6BvktnDsnEArUAiwy2KDHQVpidb6B6SjQYVu80AfJmV8WkBJUcD5VqP
	AT/XdYWK9Vgqr1TJZWOtPUfkiJc6RyL3hyEMmT8vbquQndtIQKakaP5Gcz7EfEca8SrXYLOYGQ+
	sMfSKf6m5GkdC4PPP6RbhmRmpnbjQ==
X-Received: by 2002:a05:690c:c0c4:b0:79a:d43a:1177 with SMTP id 00721157ae682-7a2102b84edmr13872797b3.17.1774997450166;
        Tue, 31 Mar 2026 15:50:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cbaa605fasm55428627b3.47.2026.03.31.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:50:49 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:50:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <acxPyXnV8HtxtEHl@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
 <20260330230130.GD41843@coredump.intra.peff.net>
 <acxJ/NfLNloCv3o+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acxJ/NfLNloCv3o+@nand.local>

On Tue, Mar 31, 2026 at 06:26:04PM -0400, Taylor Blau wrote:
> > Also also, the original was leaking the strings, right? The string_list
> > was initialized as NODUP, but we assigned allocate xstrfmt() results to
> > it. But because of the nodup, string_list_clear() won't free them.
> > It should have been:
> >
> >   .keep = STRING_LIST_INIT_DUP,
> >   [...]
> >   string_list_append_nodup(&data.keep, xstfmrt(...));
> >   [...]
> >   string_list_clear(&data.keep);
> >
> > in patch 2.
>
> Good catch, that's right, but partially obviated by the fact that we're moving to
> strset here.

...actually, I think this is a little more subtle than I was hoping for.

If we move to strset, we obviously still need to ensure that
constructing .keep doesn't leak strings. The strset API has a
strdup_strings option (via the strmap underneath), but does not
explicitly free keys on clear.

As far as I can tell, the strset API is not designed to take ownership
of the strings themselves, so to avoid leaks we would have to do
something like:

--- 8< ---
diff --git a/midx.c b/midx.c
index 4976ed4fac3..1c17a8657ff 100644
--- a/midx.c
+++ b/midx.c
@@ -802,12 +802,14 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 				      char **keep_hashes,
 				      uint32_t hashes_nr)
 {
-	struct clear_midx_data data = {
-		.keep = STRSET_INIT,
-		.ext = ext,
-	};
+	struct clear_midx_data data = { .ext = ext };
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
 	uint32_t i;

+	strset_init_with_options(&data.keep, NULL, 0);
+
 	for (i = 0; i < hashes_nr; i++)
 		strset_add(&data.keep, xstrfmt("multi-pack-index-%s.%s",
 					       keep_hashes[i], ext));
@@ -815,6 +817,9 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);

+	hashmap_for_each_entry((struct hashmap*)&data.keep.map, &iter, e, ent) {
+		free((void *)e->key);
+	}
 	strset_clear(&data.keep);
 }
--- >8 ---

which is... pretty gross. I think we may be better off sticking with a
string_list for 'keep' here internally.

Thanks,
Taylor
