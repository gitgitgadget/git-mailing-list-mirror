Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13357EDAA
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171866; cv=none; b=O89MRRggBaLxVDNsyMs1SeIvrEgfYv5tTUxy7GKeF6xfYj04NkOBvQrHR+Vay05ne7+rp2gFqvBYWhtB/y5CF/YcGfpFq5rzehtsWcVEd8BhGwYMFut2qzWeOpRgjhXERG8jOrNrcegGnJtnDr17LrmRfidocHHpddBM5ptL/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171866; c=relaxed/simple;
	bh=KE96gVQrwaizZ5c8AE4RfV2u1Jcl1YSt5OIiB00qVWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQKSBiqBBGCdDBbPBz5Qg/K2XXqwqPneVONgI3gK/GhZ8pl2coJA4Obu0vBOrFKklOG9100Yn3k6CvKiHPG/IO1toDRt3PT7siVHwRcH+oB5Q9WS/ykTtfuAKDl9z3BhzfAlCs+QH9uTAut4GPjKiMXzdRHCJKREDv/fk+XnXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URCDrseB; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URCDrseB"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-823e4047037so39923a34.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171863; x=1792776663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/jb0KoiV68HFRnQgUbOr4fgdhL82ywo2x4F0IUxUClg=;
        b=URCDrseBRD4z3HdblXy9ly13vt3YiiTRshPjUFqNAOrVOeXf3//vvS6ZP8g4f64LQr
         GuCdwgS301qwOf5jKXprG1aGXyxFzORrl0Ueu4urPJwI2vD0G5YCGPbEm6IGSPZyY0jq
         PH/AUd2taK4g/V+lKYGK/Jn1Iy5+aZ/CXx5ykB2VheeKDwOFEtA32QYsAwpW41iLR3Gd
         tvBp45N2I9Lkxjj4nmRZb361tIc5stcqcqWYTAmEW03aQX+fO5XT0zEmvm44Gom880We
         UB61jFxRV1aC0FAwd0fv60rYg61nXyt3bOD9AeXABjqbaQzSyhTK+mVDFO7bh4+oTx5B
         n8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171863; x=1792776663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jb0KoiV68HFRnQgUbOr4fgdhL82ywo2x4F0IUxUClg=;
        b=e1aAM4VWq6Agxi/t6Bob082GVMex4Li5vXKVmQcVCTaGQh2nXawrR5aW44GrdcbtFL
         5h+Wp+iUUC/ZBoH5TIm3BXLMhOsjXvNTWg/QXAKbKLdcHFvMld5UeIs10JRrl9ZlQRYm
         LDVwC/NeGsBmR4rK1vAUpdj7bLWAqY8TtPx/VKYjteiD34l16kOw9Ot5sK92G0b4jyKt
         rJvSmzkjxLN8g2UQ6quCq9i79nGkqyYijfgSEg17SssQUfy3+FWZf/RBWZHfqX//yZ3a
         6UsqQ5ZHbM4qFppVs/etETF2okHUKD1sTh81B0WpWzKVTM/DLg8W4M2aVzON68eKZVht
         CP9Q==
X-Gm-Message-State: AFq9FYKDZhSnBtxiOGu2mX7M+gVJQkBTDCcYK2o7uOVQjeRveW5SVe+v
	LprKJv1p5wAgWHk04Xk6RWx8o0DXLpYpYhazXiz0fsLVXhC/5GrVAlzcPWFzVQ==
X-Gm-Gg: AYBFou0c+kGjms4lgSjURJGbyVT5b8bnEh9Wuw1IZXJMtlE1ecoZdqFlDaKd13YXL+C
	PnM/3Ig4Ab5icag8EI++pX1/D3jT1Q3dyZRu/oHdK6rA/4bopJTH1xwW6lQNqPjsuvnrTsArXFb
	5eFI6zjpSlvtKNDFtS+yxCXe2CAsm8tG+HfjSKB9eQ1jR/aF5TGUk6MMk1Mu1FKo+FXbzletmHk
	+JTsl30BR+b7tOdePY1xfJAGZEsgc8Y+XdvYDN37fOl2lxcRSfZMxLZW9NSZa/lanrrOJwkC5E7
	b6icaABRBWhqN5UvPXqBkDoMQKNJlygrGTermpVav+8lXPteD4FO+yEY+7Rxn0jbfwARt4Ma/kk
	ASuTL9hlj5ZPheP73Z5Gwt7GYakVUCZ+caJ2lh38njp0PqbDQPuKKGDL1JJxXSnLuMNmNYJZXDO
	Z6qtDUBv5YRFCU7CQyE3Iu3S9n6204lCtDOnGmLVkk05Ry67WIg8kzesXjehtg0CmTHp01OBdC3
	t1QO9KJSuxrSDx1ZRJ04Spz
X-Received: by 2002:a05:6830:6d2a:b0:834:b015:ae9e with SMTP id 46e09a7af769-844fe973548mr212465a34.12.1792171863387;
        Fri, 16 Oct 2026 10:31:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a01f56sm2236185a34.7.2026.10.16.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:31:02 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:30:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] pack-write: lift and expose index-pack report parsing
Message-ID: <atJX3IyBTUCx0NWN@denethor>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-2-jltobler@gmail.com>
 <atHLBS0GGxf_cPmT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atHLBS0GGxf_cPmT@pks.im>

On 26/10/16 08:58AM, Patrick Steinhardt wrote:
> On Thu, Oct 15, 2026 at 09:28:59PM -0500, Justin Tobler wrote:
> > Once git-index-pack(1) finishes writing a packfile, it reports the
> > hexadecimal name of that packfile on stdout prefixed with either "pack"
> > or "keep" depending on whether a ".keep" file was also created alongside
> > it. Callers that are required to manage the lifecycle of ".keep" files
> > parse this report via `index_pack_lockfile()`, which provides the path
> > to the temporary ".keep" file.
> > 
> > In a subsequent commit, the "files" ODB transaction begins staging
> > packfiles in a transaction without eagerly creating a ".keep" file and
> > must instead read git-index-pack(1) "pack" output to get the packfile
> > name. Extract the generic parsing logic for the git-index-pack(1) output
> > into `read_index_pack_report()` in preparation accordingly.
> 
> So if I understand correctly, the intent is to eventually stop creating
> the ".keep" file in the quarantine directory? I assume that instead,
> you'll then manually create that file in the final location before
> moving around the pack itself.

That is correct. Instead of migrating the ".keep" file in the quarantine
with all the other object files, the intent is for the ".keep" file to
be manually created during transaction commit first. I'll update the
commit message here a bit to allude to this a bit more directly.

> If so that makes sense -- it's kind of pointless to create ".keep" files
> in quarantines anyway, nobody but the current process should be touching
> it anyway.

Yup, creating the lockfile in the quarantine doesn't really tell us
anything. It also makes it a bit more complicated during transaction
commit to detect whether there is already a lockfile for the same pack
that exists.

> > diff --git a/pack-write.c b/pack-write.c
> > index 85674e4b72..5f5bb894a5 100644
> > --- a/pack-write.c
> > +++ b/pack-write.c
> > @@ -469,33 +469,68 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
> >  	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
> >  }
> >  
> > -char *index_pack_lockfile(struct odb_source *source, int ip_out,
> > -			  int *is_well_formed)
> > +int read_index_pack_report(struct repository *repo, int ip_out,
> > +			   struct strbuf *pack_name, int *is_keep)
> >  {
> > +	const int len = repo->hash_algo->hexsz + 6;
> >  	char packname[GIT_MAX_HEXSZ + 6];
> > -	const int len = source->odb->repo->hash_algo->hexsz + 6;
> > +	const char *name;
> > +	int keep;
> 
> Suggestion, please feel free to ignore:
> 
>     int is_keep_ignored;
> 
>     if (!is_keep)
>         is_keep = &is_keep_ignored;
> 
> Then you can unconditionally use `is_keep` further down, which I think
> is a bit less awkward.

Good suggestion. Will use in the next version.

> >  	/*
> > -	 * The first thing we expect from index-pack's output
> > -	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
> > -	 * %40s is the newly created pack SHA1 name.  In the "keep"
> > -	 * case, we need it to remove the corresponding .keep file
> > -	 * later on.  If we don't get that then tough luck with it.
> > +	 * The first thing we expect from index-pack's output is
> > +	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
> > +	 * name of the packfile it has just written. The line is therefore five
> > +	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
> > +	 * "keep" prefix tells us that index-pack has also created the
> > +	 * corresponding ".keep" file.
> >  	 */
> 
> Okay. I originally thought you only reflow this comment, but you fix it
> to no longer assume that packfile hashes use SHA1. I would have either
> pointed this out in the commit message or done this as a preparatory
> commit.

Will split out the code comment change into a preparatory commit.

> > -	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
> > -		const char *name;
> > +	if (read_in_full(ip_out, packname, len) != len || packname[len-1] != '\n')
> > +		return -1;
> > +
> > +	packname[len-1] = 0;
> 
> Missing spaces around `-`.

Will fix.

> > +	if (skip_prefix(packname, "pack\t", &name))
> > +		keep = 0;
> > +	else if (skip_prefix(packname, "keep\t", &name))
> > +		keep = 1;
> > +	else
> > +		return -1;
> > +
> > +	strbuf_addstr(pack_name, name);
> > +	if (is_keep)
> > +		*is_keep = keep;
> > +
> > +	return 0;
> > +}
> > +
> > +char *index_pack_lockfile(struct odb_source *source, int ip_out,
> > +			  int *is_well_formed)
> > +{
> > +	struct strbuf pack_name = STRBUF_INIT;
> > +	char *lockfile = NULL;
> > +	int is_keep = 0;
> >  
> > +	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
> >  		if (is_well_formed)
> > -			*is_well_formed = 1;
> > -		packname[len-1] = 0;
> > -		if (skip_prefix(packname, "keep\t", &name))
> > -			return xstrfmt("%s/pack/pack-%s.keep",
> > -				       source->path, name);
> > +			*is_well_formed = 0;
> >  		return NULL;
> >  	}
> > +
> >  	if (is_well_formed)
> > -		*is_well_formed = 0;
> > -	return NULL;
> > +		*is_well_formed = 1;
> > +
> > +	/*
> > +	 * If there is no ".keep" file, then there is no lockfile to return.
> > +	 */
> > +	if (!is_keep) {
> > +		strbuf_release(&pack_name);
> > +		return NULL;
> > +	}
> 
> Can we maybe have a single exit path responsible for releasing
> `pack_name`?
> 
>     /* If there is no ".keep" file, then there is no lockfile to return. */
>     if (is_keep)
>         lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
> 
>     strbuf_release(&pack_name);
>     return lockfile;

That is indeed much better. Will use in the next version. Thanks.

> > diff --git a/pack.h b/pack.h
> > index ada506b5c5..ddf2d52934 100644
> > --- a/pack.h
> > +++ b/pack.h
> > @@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
> >  void fixup_pack_header_footer(const struct git_hash_algo *, int,
> >  			      unsigned char *, const char *, uint32_t,
> >  			      unsigned char *, off_t);
> > +
> > +/*
> > + * Read the report that git-index-pack(1) writes to its standard output after
> > + * the packfile is written. The hexadecimal name of the packfile is appended to
> > + * `pack_name` and, if `is_keep` is non-NULL, set it to indicate whether a
> 
> s/set it to/it is set to/

Thanks for the careful eyes.

-Justin
