Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907F29D265
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784403585; cv=none; b=NVaKt1LYhS5lI3WKnNAoqF56Pw03topYEYVrFxN56r48gM/+AgPbCNpgJDinL2Ys08qdr+MLTBF1nL+TkBWpvYLAZxMwnIUz8my/UgeUZUw+9zhXJkkC/fOzZ5aRahsYmmwnosLAAO322xYm/fe+QTc6B2AxlDMXPN4sCshThHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784403585; c=relaxed/simple;
	bh=3fvcQL8dW38LQ4jYG56sfUspUl/LNsLSUlVkj2nNrq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0njAuzvqqLNs3PTn9jLW6l3COclEUp58wO6m+aZxSJFywZq82joz5vKwkTuWL9dxdeJzia/jOXHFqOLlbyDDSma3rriyIy2Gko4h/YqHTiwRxhoHmlJSljWgFvTGma+DWudcITQyA/kJbVxYBJtzfUMc/IkZn7peVVorGS+4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E303gCfP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E303gCfP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f75f7172so68682165e9.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784403582; x=1785008382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEfoEicZBd1dbk50g5QhqbPq3I62y21K3rSxCSsgxtQ=;
        b=E303gCfPz6tv7vOPiGtP6ULyl/4VXBTZMQPUzxsz8/+SVYSkOKvBNsnXjjSmMS+rZ2
         l7Zb33wz7hU2bmzI0YrXDMibTIsd0xKeHGCt7PCBnqX0sJg6iWokTmx61UX8UDRA9z3H
         0eD2zWzMwtlxcJh5gwe2PdDF09clNLTXjX2K7jsiz1Ud9iRhCN3dU5u72tZzuk3nR0+Q
         17gIpYWXOJQlH9VDmxw3cQKtaM2U0wOgrm1q0YiCCl0FNATRJvH5Y7o4Q4kMFpTeEIGq
         Z7dfCq8ZDD8Q0l5mbNU1P9j7a9WWkXkkbDNltFWL4cBo4IZve4T8/ueKgCr9HCW/zNTW
         0G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784403582; x=1785008382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gEfoEicZBd1dbk50g5QhqbPq3I62y21K3rSxCSsgxtQ=;
        b=AHKUYQJjv/xJRkzvZcdKHvnMffU7S9homGF0HewTzqIqcJYIbHHIIi8xJKuNCcAw32
         M3vnPD3pTrH9/CkqYPO2KKp6URXRDgsJlr3oML+YoVx2Z/VZcGyHBX5Qi54pyigpsV0f
         Df5h1gGv2BLaO/tF2e3AhsqblNoiVQjhsDPkI5/cnXwCgqdvlKkt2QkiIILNvUOR5cv7
         +7pVKMxdrLm3n/QmXTuIVq4CRvPkw80QdocHrIkh8MwjMRG5GpFpgmz037oQNNAy3iPo
         Tm1o/cRridVs17/QZnXGYqinKZDYkud1a5pIOleLSYr/MtdiX3amE4UJ8yVyaXJwKW5s
         QhAA==
X-Forwarded-Encrypted: i=1; AHgh+RoJP7y94Ro0WnMEw7Ybty7Rj+IkP0PsecBlBJm8watEPVRVhphun20z00+0uwdyVIQIUqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqjnl9j/PeVz+Sx7r8ziUaELKXxy5UfF9XRt0hVLXvyL0Xb8i/
	sju7SWhOsx9yAm/TSvbRx0GiYJiPVaAYnJP7gn3p4RJ97KpWgSFgJfXX
X-Gm-Gg: AfdE7clIXGiSPxGdPtbWVe5gs9iM4Cq2NZshGLMD88P/Mz47y87knJku0sStH2FNz4O
	qYHWVqwRLb1JaUKafj39L8L9e9ctFM9Tf6PvTXC7w4jOvs7XbYYSFhCdRqAUkId/91RYM8FX7Oj
	Uh0z8QeevdBmFrKsQC8L+tDJFogEdtlRw0qqvNdTf+nOxfEKxezYsg6NXwna4B3q8u9u9XBumM7
	/IIYbSqGIJ5rJWUAKNGizbbb5Vdns4CZrvdAk+y7ZRuHtW4GSwVFkbwNdxQznnGgMSrSQyjKt5C
	kvTto3g+8J6fiXqN43WQmAAVUA4teKBMgXrDCYEW4x6FMg/H33SSMWrwX803ZeqR9RVxSVoIDwm
	mxbmPxW+KGhSExabFIQPDWAgwiRBNBc0q94HMQfQRGpYhZfSdFbAEHINXp3wWbN+ey6Hu6rt8gr
	GJ6Sh2ZUYSOLVVRVN3esm/YdrXTzm3
X-Received: by 2002:a05:600c:4445:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-4954a3e374cmr79215195e9.1.1784403581997;
        Sat, 18 Jul 2026 12:39:41 -0700 (PDT)
Received: from localhost (94-21-29-149.pool.digikabel.hu. [94.21.29.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b87c6sm245470215e9.7.2026.07.18.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:39:41 -0700 (PDT)
Date: Sat, 18 Jul 2026 21:39:40 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 0/9] object-file: move writing of loose objects into
 "loose" source
Message-ID: <alvWfOJb6vAsusai@szeder.dev>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>

Hi Junio,


On Fri, Jul 17, 2026 at 11:32:08AM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series refactors "object-file.c" so that we can move the
> logic that writes loose objects into "odb/source-loose.c". This ensures
> that the logic to read and write loose objects is mostly self-contained
> within that source's implementation now.
> 
> To achieve that, this series first refactors `force_object_loose()` so
> that it can work on top of the generic `odb_source_write_object()`
> instead of having to call into `write_loose_object()`. This is the bulk
> of the patch series.
> 
> This patch series is built on top of 44de1520f0 (Merge branch 'master'
> of https://github.com/j6t/git-gui, 2026-07-16) with the following two
> topics merged into it:
> 
>   - jt/receive-pack-use-odb-transaction at bdee7b3013
>     (builtin/receive-pack: stage incoming objects via ODB transactions,
>     2026-07-10).
> 
>   - jk/git-hash-cleanups at 9e396aa553 (hash: check ctx->active flag in
>     all wrapper functions, 2026-07-07).
> 
> Note that jt/receive-pack-use-odb-transaction requires an evil merge:
> 
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 06b31dd743..cbb06da038 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -545,7 +545,8 @@ static int odb_source_packed_write_object_stream(struct odb_source *source UNUSE
>  }
> 
>  static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
> -                                              struct odb_transaction **out UNUSED)
> +                                              struct odb_transaction **out UNUSED,
> +                                              enum odb_transaction_flags flags UNUSED)
>  {
>         return error("packed backend cannot begin transactions");
>  }

It seems that you performed this evil merge when merging the topic
jt/receive-pack-use-odb-transaction into jch as 9727bd8447 (Merge
branch 'jt/receive-pack-use-odb-transactions' into jch, 2026-07-17),
but forgot to do so when creating the base for this patch series as
1d64e64326 (Merge branch 'jt/receive-pack-use-odb-transactions' into
ps/odb-move-loose-object-writing, 2026-07-17).  Consequently, neither
1d64e64326 nor any of the the commits of this patch series can be
built because of the mismatching function signature:

  GIT_VERSION=2.55.0.256.g1d64e64326
  odb/source-packed.c: In function ‘odb_source_packed_new’:
  odb/source-packed.c:778:40: error: assignment to ‘int (*)(struct odb_source *, struct odb_transaction **, enum odb_transaction_flags)’ from incompatible pointer type ‘int (*)(struct odb_source *, struct odb_transaction **)’ [-Werror=incompatible-pointer-types]
    778 |         packed->base.begin_transaction = odb_source_packed_begin_transaction;
        |                                        ^
  cc1: all warnings being treated as errors
  make: *** [Makefile:2924: odb/source-packed.o] Error 1


