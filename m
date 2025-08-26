Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA391FC3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174207; cv=none; b=eYTLnFWRpQs0XrSoFbnioUaJEE0ZL2rWVsPL6fzmOnrzjAFD4AGGfRDS8nqwp3+Eh14NanCfbm6Vajb5fV81QlgU2By/gev4yjFKnn/JM0fawJ+LLs+74jXXMcKHN6OxFadzYY36pDdI2EZ4fUsxybJvBYafDGF6cfEcEz2Fbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174207; c=relaxed/simple;
	bh=kGgnmpBkjGEASfLQbMbcXxnPV4JvIzZSfWliFtr2XQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2p8H1RmR9RxPH6nHRDt7T8IAO+TKavqT0jqmcLSS9mcggYJgRzFja1tF7plJa50S0K+qoiegm2d6M+0IcJ2O6abnZUHlOUAyovX3kH/CttZWUCq+f0e6fXSEU4M0P5ZshJ0IaU8c179crMZRBkW4tuYoIM/3w0NLf/HYWYDS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GdM0oo92; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GdM0oo92"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432d932d6so62113139f.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756174204; x=1756779004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfpBIvTuEpKnDAv4O0Pap7OT9nQWgmfvmPWdgMrYp7w=;
        b=GdM0oo92SYGAU65icWqHp54UT7/OZ2fWSKmwBMCNAzDdwRMfEGqMBPkoomlveBo2wT
         c7JM+d5h7JZuEFFj4fd0UtJossYHDXnM6mnTU5JykEcUYbKNFJ1lWgm8yfTj6N0erjOy
         9vjOd+RQA1UR6qfxMiFs2giIoYYFRi3VTiGWn/NTxkugVHuptja37C9jaNM3IZR6RMWL
         yrwsmrZ5o6aTK2gBNutA+Rq48hNtl0gIEKgptlhn3iPmh7EB3jyM/kbiOJq9deljDxdU
         rhiml2f/COCtOyGR6fUPtFvouL9Uft4QqpMGV8BYGmxaWx+CMeQcVUE4+xt55HNHfZbh
         U5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756174204; x=1756779004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfpBIvTuEpKnDAv4O0Pap7OT9nQWgmfvmPWdgMrYp7w=;
        b=ZTYlBOUMWgifr8I+xqBhwFyd0UE6iy17s+cVo1QN9y1YizRehaGCWQHkNedKKU/hM+
         xMLYttVBBlaRRS40yEqt9UIDT3mjibuTZpIAyFTkCZdih1Luyp+kSoIj2TzceLGVdEwx
         /ifbzUoWW27qc9xnXLFV8/OY8w3tlA25pk6v/5h/oSmS+CpP28PTtHC2FN4/ugLixOFb
         53ECmmJXJ9eV8mw3OKFG3EI6skwaxen5TQCGSmPDuEw0fbuCQ6OCwBQYiisnvDMeZKB8
         dbQY+Zc56mOhUTiCWc6rdFxsdv1HEZZyyqQz+2lXUeXU52HwiXXztE5rPUhwtj2RSYVE
         rfYg==
X-Gm-Message-State: AOJu0Yw/Ii9fLhfF9+etE78gm2xsZmXGa/2ifDteUh9e++C6TdK1oksD
	Wu1hLGapu7huu1brnNloigkif+6addgJbeo6jgbG7cMF43vsTgZvvBXH/uOQ5kUW1gs=
X-Gm-Gg: ASbGncuKBcCEy+lgoT6XOyl4zgJcV1f9vc4p/E4zIQd3rcy6z7PObR9bIlxzx8f6awa
	mFl0O3Y5IlFmae2S67F0gDHHD1qoc5OFD44MHqeZHznMH/ME7qBnuwSOMQOgYYV1wpA/GjCSNuF
	zI+rstFUIc4uWmGLDgKVN8P9TE1IHAcj3rPJvBQLCeK8CcO77dbsUKJxb1XSB5soiSUTJ6TLewK
	KsZ/TjPESY6Ov+UHYTgiPBLSbvhqzBglWXu0fLgn7VvBRmncKxzxlbA1UurUuV0tLBeukEitw+d
	7q0a2ppXY+JWEaWi+onCle/XYD6RSyiPd1k3pDDLyY47aVypheCkopXaqkR+6piagc22QEH6oQD
	fbAzBJykr6N/w+rla2LozsfhWQ1wCcXMXFxaPTLHE8LCmHHxGC38+9Ws7DUJA5KOkhRwogwmK1H
	3ldxRfHrr3pE6a367/eepqZVIe8g==
X-Google-Smtp-Source: AGHT+IFkJvlmWgkPlmoJInaP3S27t5UJMTGkc2MGkrn7iNR0sjtGD9fVPiXXlNR/Jcm2htpEB2mHbQ==
X-Received: by 2002:a05:6602:2c81:b0:884:28f7:a121 with SMTP id ca18e2360f4ac-886bcfcaac7mr1584146739f.0.1756174204472;
        Mon, 25 Aug 2025 19:10:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886cf7a8c45sm449312039f.15.2025.08.25.19.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:10:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:10:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/16] packfile: split up responsibilities of
 `reprepare_packed_git()`
Message-ID: <aK0XeiRz13O7j+HO@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-9-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-9-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:07AM +0200, Patrick Steinhardt wrote:
> While the logic is hosted in "packfile.c", it clearly reaches into other
> subsystems that aren't related to packfiles.
>
> Split up the responsibility and introduce `odb_reprepare()` which now
> becomes responsible for repreparing the whole object database. The
> existing `reprepare_packed_git()` function is refactored accordingly and
> only cares about reloading the packfile store now.

Makes sense.

> diff --git a/odb.c b/odb.c
> index 80ec6fc1fa..37ed21f53b 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -694,7 +694,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
>
>  		/* Not a loose object; someone else may have just packed it. */
>  		if (!(flags & OBJECT_INFO_QUICK)) {
> -			reprepare_packed_git(odb->repo);
> +			odb_reprepare(odb->repo->objects);
>  			if (find_pack_entry(odb->repo, real, &e))
>  				break;
>  		}
> @@ -1039,3 +1039,26 @@ void odb_clear(struct object_database *o)
>
>  	string_list_clear(&o->submodule_source_paths, 0);
>  }
> +
> +void odb_reprepare(struct object_database *o)

OK; so here is the new location for the non-packfile related portions of
the former reprepare_packed_git() function. That makes sense, but...

> +{
> +	struct odb_source *source;
> +
> +	/*
> +	 * Reprepare alt odbs, in case the alternates file was modified
> +	 * during the course of this process. This only _adds_ odbs to
> +	 * the linked list, so existing odbs will continue to exist for
> +	 * the lifetime of the process.
> +	 */
> +	o->loaded_alternates = 0;
> +	odb_prepare_alternates(o);
> +
> +	for (source = o->sources; source; source = source->next)
> +		odb_clear_loose_cache(source);
> +
> +	o->approximate_object_count_valid = 0;
> +
> +	packfile_store_reprepare(o->packfiles);
> +
> +	obj_read_unlock();

...I think I am missing where we call odb_read_lock(). The function
packfile_store_reprepare() has a comment that it must be called under
the odb_read_lock(), but I don't see where we acquire that lock here.

Are the callers of odb_reprepare() supposed to acquire that lock? If so,
it seems a little awkward that the caller is supposed to acquire the
lock, but the callee is the one to release it. Is this function missing
a odb_read_lock() at the top?

I looked at a few callers here and none of them seem to be holding this
lock. pthread_mutex_unlock() is supposed to check that the mutex lock is
held for recursive and error-checking mutexes. IIRC we initialize the
the odb mutex with PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP, so I am a
little surprised that this did not cause a runtime error.

The rest of the patch looks good.

Thanks,
Taylor
