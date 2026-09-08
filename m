Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB6599A4B
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907395; cv=none; b=T6fkPMqJJgs2upg32ZBPTKpgZ41uAFwcrL9Ma7e1uYBMHD5u3eUx4cmhoWLeQe4mQJrltPBdKzO+MpvLPYEMdViuxWcSDVbsrgoaqqKN4FD+5oeF1+3phvFIityCwEW4/vgrTadxT8xcG0JhhwzuSgWRySMJfly0WYH3+eLIb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907395; c=relaxed/simple;
	bh=mwPabIPbEaVpiRgg2/8yqEvgaJjAxaVBSRYbjJe3KcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNHFQ3jD0UAbYpg7cBzbcHle1EtBYzWnCA88sYql28K+Amt9naD4QOy/Yz+otVKqcq611qd6R22iI1z5FDzLi/mwBrkHg71LrBzX3xWkJ20eiZlTSqkuyV4GdH9kOCcvJ3wtQHR4FBKrdkLuuwBK+mHVHnZxhTEYOSBs7Q6cBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkf/tViR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkf/tViR"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a483a552efso2210180b6e.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788907384; x=1789512184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KhE0zC8dGBjAgJW/aXQKqo2Zyjvwrsor1pC0ZLAC23U=;
        b=Fkf/tViRpXT/vAbh2oeMRri4KvU29OH/T6ifUYnGXmuQqheop8uDRGfzppjQpFerhr
         JtwK1dXhyA+hBVzEfq/zkL7fKRbQsy5McHiwwN/xZDmqTovSaeuNZ44DoaQXuspAS7Wu
         QoSB9BXMiKKTLVKbunXPYbw/soNv8xDuMZsJfWl9mdDEWTpUmAeUjSuHr2Szl4dy/H8H
         Cf+5+43GpUZJ51+SnOxs+GgOe3s4GueV/uciERE7ZrfteEpIl6kTWe/8nT76Hs/Z93f5
         pL9rqPtoJZNGBuz66kYRSxKMtACZ4jJ74KO8fcCLRem9La0+e1gj+UJpEXjRrrfTsRbu
         r67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788907384; x=1789512184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhE0zC8dGBjAgJW/aXQKqo2Zyjvwrsor1pC0ZLAC23U=;
        b=msO++/8Bs2xMvp49fRR6Km5L/kHjXtZX683Qv/UnQju23Fn/G+slg+t4kJbKQp60AK
         w8JqcLjKPcUoxngCzvuxP8ns6JJB4D88cKPFARofKxo95OK7sCSEygy7OnZWKDHumEWc
         cxiDu5HoNTVAtxeVbgcN5j/7il8UVJVpWeZu2IfwpbcutkuW2cowop4e8HKeeg4xcjEa
         sQKsWQVTBmpTxGXmXu2N3PKiAUKmXpJeHt6h3eKkDwIL90UO0in+4U2eJwxIJBEe0Vjq
         Gb2ODNOj95z7W2U7/O5MPrmmLzXi0OacC5lJHLHISIs3KSTLtqEAG+UeMH36JqfhZUJT
         Rzzg==
X-Gm-Message-State: AFuF++kLV9A/gWaWnBWwlJglfOAHXqXdsc5xZUISiqIGURL1DOHnDuFo
	fRi0fmiletCVCRY+1y2jYV0PXAWZru+4MP4piawUpbJJwA4+Pq3YiTI1
X-Gm-Gg: AYBFou38Uz8nhF49V0ePRZKKADOQXX1LAag0GksgSieERFJWd0W4NAqb4fXeZZsRRed
	MnNx4mojfJmYximdDLDmCdlNHlUheS4Mn++XwXBUYX5GHDCI0zHcWBdPmPiq8jzQRLVXtpGKsG7
	jArCyzRc+vfesQxvrWWH49amYLwxvPNecl8reDeQkfYNp3ItOik3X5dqNyJ1YqpJtIFuurX90A0
	4HPca44KDDMugu8dncKP6H9lbWh5mVOCPG6n+ZMOv3h/ubBqvebLD15QyeSMfMduMJZKoP12Lrs
	d845DupvRNpaTg4mbjuhsd4FOcC1MI1FbLbUF6h0xwNIGYrWLC7M4a+twzXz+V2/qhTLRd8UFxN
	WavbLxy9dk6E71pBcw+YllEL4pIYohBrbNE0aYdxP36U2gc788sa7Sp8njdfIy/xRyHWwr22aq2
	xJrcGsFlbJ8X1U2q8niFajnNio4V/YGh6LJK4gP5IDSD1MK6lY384yg2exo8ZL1bYPcX+pJDlpD
	ys72jOEpChtmw==
X-Received: by 2002:a05:6808:4f27:b0:4b3:7aeb:1b73 with SMTP id 5614622812f47-4b9645205c9mr19505165b6e.2.1788907383699;
        Tue, 08 Sep 2026 15:43:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675a96sm15118112b6e.11.2026.09.08.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:43:03 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:43:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] builtin/clone: move setup of alternates for
 shared local clones
Message-ID: <aqCOe7cf_uSIz_Eu@denethor>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-5-735d0b5b3e00@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-5-735d0b5b3e00@pks.im>

On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> When cloning a local repository with "--shared" we add that repository
> to the new repository's alternates. This is done in `clone_local()`,
> which is responsible for performing local clones.
> 
> Move the logic into `collect_alternates()` to unify our setup of
> alternates. Furthermore, this will allow us to set up alternates right
> at creation time of the object database.
> 
> Note that the logic for cloning a local repository with "--no-shared" is
> not yet part of `collect_alternates()`. This will be handled in the next
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8786a49332..011fc867c8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	fclose(in);
>  }
>  
> -static void collect_alternates(struct strvec *alternates)
> +static void collect_alternates(struct strvec *alternates,
> +			       const char *src_repo, bool is_local)
>  {
>  	if (option_required_reference.nr || option_optional_reference.nr) {
>  		struct add_one_alternate_data data = {
> @@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
>  		for_each_string_list(&option_optional_reference,
>  				     add_one_alternate, &data);
>  	}
> +
> +	if (is_local) {

Could this condtional instead be:

  if (is_local && option_shared)

> +		struct strbuf commondir = STRBUF_INIT;
> +
> +		get_common_dir(&commondir, src_repo);
> +		if (option_shared)
> +			strvec_pushf(alternates, "%s/objects", commondir.buf);
> +
> +		strbuf_release(&commondir);
> +	}

-Justin
