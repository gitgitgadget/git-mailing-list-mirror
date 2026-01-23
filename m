Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D00239567
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129175; cv=none; b=Tvup23/JmX0cDbrVyacXSgw6u3W1WOqUrg5dr0cD4L7/N2ZFKY3Va5kQ7niOi4UVtQE8l4cYH4Tzgz1yUY9Jbj2zFCgG+HhDZlDsBAldkfosI6GHM+4AN0q+TMrRYWhTcF+Cflk++9/vxtC357ine7nXjf7s4NNDEgAGgNOMQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129175; c=relaxed/simple;
	bh=7VC8BoGWAkNiLcQh0hnatwc6BusaoIEavyBHV9rcUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7l1VkcK76lFr4tRsRft0AFwpeBUeJafX3o1HSVIhq7mk2MKRtbkQX+4DWxSqhV6904GBQHgGEyQMojscesARC9KdmmjP90NvPbgPN7vyPdpvqQPUhtBLSEAsILtopUeprKM0IJFAGjgaiDF3HvWe3lkiFlBeLW5tDJPZC5xOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jV9mfzkJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jV9mfzkJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6aaf3cd62so221585385a.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769129166; x=1769733966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0UoMveSWCgDlY5p+8LRMBSi/ZmIPcNu4JB3zZnrX6s=;
        b=jV9mfzkJCghgGSumuZgoDrjW8P5NQw6jglPM+a4pnMIw3+RoHISXdts8cqSzms0e5u
         xp0tkXRzMu8km7PWM14aVnXnAkik6Mx90fzbzOJ92XTTzX4S2tDquQMka+MWZOpF1cAM
         I/hju8pIaBKM/XdlOyicZdOFmM4HFf9LKjARjJsx0oCpwiNtfcPTx2STdp6Ngjnbp/Gm
         OfNdDoXrgvizf2YaHvkCmZ4bzJabf0wt79OP0mPtASgx+PhTHVr3Apbn0nmCc2wCksP0
         Egoww4L/f2hvkMHURRB1WW1GBdeu5oQ3RkE9GtKWPdUBuV91AWgAmIkK5/fbZzO6NrTh
         ZH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129166; x=1769733966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0UoMveSWCgDlY5p+8LRMBSi/ZmIPcNu4JB3zZnrX6s=;
        b=KHCqBgZoeh879t1KdyuA+cLMau/axcYGyGmhrvQYS3aVkgmExAowaqBSHLyIYw1H2H
         ZgWgmAksk4M9C9j8+r7FMgpHlapHTmk3y8U6taMXMKunr+Wo3pJHRShbiZezit1oVx46
         VqYiwdLEvOjX53zqtP0Or037Wdo40Ci3dmea3/Q4olkHM2PCpFCNwteK1Sfq3kJJ0hcH
         y2w9Yc6HfHIdbjqFyqL4vSvGojcfdzKtt1GWE6qHOT7UlbE3sZ2ofzFFVvebc0kIfXCN
         MNCkW0c+1D7yZgUlzN5U2fjnoDS5bFzsOBihedqzAOitt2MFA/Spy7fPRALU8u0ZN1I7
         zxLA==
X-Gm-Message-State: AOJu0Yz4ROtSAp74SJ4BJOy9H9CXgf6QWS4FaOEptPcWFXuba20qnSKK
	id4KVyAK4ydmrh6kcf26P3QrusyYmkuCNCp8AVOThj+9rhx1qyiPHRk0qS7mpL5vCAY=
X-Gm-Gg: AZuq6aJ/5i2Z/HaJX4zWOQWSr8oX+d3sEPIuCqcQtUm74srXevwV15HBWEDDr+itfSG
	4h4qW3h4M0Ajz5Wu3wUdGObv16HkOcvPDltFh5eCSKn7nnj1U/P0BZI0r+JuGO0PkUBZDMbPqVG
	bXVTtDnM3Ro8n/Gblz1wXfhsY5toYgohElbB/gC9sKyv28t0OqW1/upm0zVBc4uBLOyQfbFZN8S
	ujYiiq7awMI3fx8UgtijvUw/SkbMkFsl0PbiF+HdOosi5L4T7RTfceHYTrldfvhJ05/Q7sReDYD
	ErTmgwqtAQ3pALfGLQ0ofWCmxNlqAkGPXh29QGK8iv1YdYofVLrAFLj818doRsIcDWdY7cgWEF2
	9s0VMqboEuI5ORoUZCaaK/ijsLEsU4Gx+Cp6KA/p2AG9Y2tyBCxHxGvSRGZBIEjgcfnj0ICsYfj
	cHsGaer3/zo/S7QtQ7OjiRYMlozp9gp0wwMS4d4e/VhOuNvPWgih/Jd/5KCoMd8I56w02x4pKF7
	l/nG8f3Bak1vsJNKA==
X-Received: by 2002:a05:620a:4149:b0:8c6:a72f:fd56 with SMTP id af79cd13be357-8c6e2db184amr189134485a.29.1769129166385;
        Thu, 22 Jan 2026 16:46:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f848b9sm5367981cf.25.2026.01.22.16.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:46:05 -0800 (PST)
Date: Thu, 22 Jan 2026 19:46:04 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aXLEzAnNRTf5A6bt@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-10-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-10-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:26PM +0100, Patrick Steinhardt wrote:
> We're using `for_each_loose_object()` and `for_each_packed_object()` at
> a couple of callsites to enumerate all loose and packed objects,
> respectively. These functions will be removed in a subsequent commit in
> favor of the newly introduced `odb_source_loose_for_each_object()` and
> `packfile_store_for_each_object()` replacements.
>
> Prepare for this by refactoring the sites accordingly.
>
> Note that ideally, we'd convert all callsites to use the generic
> `odb_for_each_object()` function already. But for some callers this is
> not possible (yet), and it would require some significant refactorings
> to make this work. Converting these site will thus be deferred to a
> later patch series.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 28 ++++++++++++++++++++++------
>  commit-graph.c     | 44 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 6964a5a52c..7d16fbc1b8 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -806,11 +806,14 @@ struct for_each_object_payload {
>  	void *payload;
>  };
>
> -static int batch_one_object_loose(const struct object_id *oid,
> -				  const char *path UNUSED,
> -				  void *_payload)
> +static int batch_one_object_oi(const struct object_id *oid,
> +			       struct object_info *oi,
> +			       void *_payload)
>  {
>  	struct for_each_object_payload *payload = _payload;
> +	if (oi && oi->whence == OI_PACKED)
> +		return payload->callback(oid, oi->u.packed.pack, oi->u.packed.offset,

Ah, here's a good argument for having the API provide the caller with
the object_info response it requested. Obviously the packfile_store
knows which packfile it's looking at, so asking the caller to
re-discover the same information is wasteful.

That said, I'm still a little leery of the way we're passing that
information around for the same reasons as I shared earlier in the
thread, but I definitely can see the motivation.

> @@ -846,8 +849,15 @@ static void batch_each_object(struct batch_options *opt,
>  		.payload = _payload,
>  	};
>  	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
> +	struct odb_source *source;
>
> -	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
> +	odb_prepare_alternates(the_repository->objects);
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
> +							   &payload, flags);
> +		if (ret)
> +			break;
> +	}

OK, I'm guessing that this is one such case where we can't yet use
odb_for_each_object() function directly because of the refactoring which
you alluded to in the commit message. That seems reasonable, though I
wonder if it's worth adding a /* TODO */ comment here to that effect.

Just out of curiosity, what does that refactoring entail? I'm curious
because I wonder whether the caller is just written in such a way that
it makes it hard to immediately plug into the new API, or whether there
are more fundamental issues at play that make the refactoring less than
straightforward. If the latter, those could potentially help inform the
direction here.

(To be clear, I figure that this is likely work that you have already
done, I'm just curious to see if the details would yield any benefit to
the immediate patch series under discussion.)

> diff --git a/commit-graph.c b/commit-graph.c
> index 7f1145a082..a3087d7883 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c

The conversion here all looks great to me.

Thanks,
Taylor
