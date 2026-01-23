Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0829DB6E
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126784; cv=none; b=pEiKEcuU6nyBcCTITzzCHxvusmvyC/mwRndrnSmFc0TNfddqsPSGEIZTR7P4VzBxUN/txDxyDUv2LwS2BkklQ1jcGSKJ0/nrVNvZszBOG0CJl+cTcUGr1lkipmUL0lKU81MpRM4f/24+xVuGo31zdPKgelwOvgWF/1Q1gabUasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126784; c=relaxed/simple;
	bh=9DegSvNPaOtEry40se7otK2JNp9W/eTuh0Afsmx1B1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFmvDpeJ66VqQhKEGwAHbE6dWNL9ovyqGmErl9kd7q8o8aDFbebb+ewCPJOOu38flDt75iKf2xHVV+RuFNhe/n67WJN5Pne4EcRiK3RL/29ZkeMxVGdAZkPUgCf39KbXuw4w85UPr7R43Euu6YAdXuyYKah+HTJx42XqMvJAGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DO9K9FrC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DO9K9FrC"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014e8b1615so18470611cf.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769126771; x=1769731571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYw+4Gmihu+4dwD7kjPxG/MeFE/jB17ZVb7ScpZdwko=;
        b=DO9K9FrCDx8QPMnWZBb1Fb0vVtqB8nqhTee+fOrg/XC1pKUjhWMR2JiQ2o3LxNTOTT
         2IhI9W4tX9aYRZoGn2wp1UBvU9iMGuML1jgaiyAwXOObezQd+il0F55ndJI2TKxpmcA6
         /oJl09rxASPKevKrcfvwcDvt8PRFZGUy050qz3fJCYDT8VkdyPzlh1fUvEE/M3XNtMM0
         cKW67ZPnZmHM2oF0NsCw1ToJIN4zZpALkK7WhH/FHeharjHnNpCGEFmWfHrUvnOHi0Bz
         K9AmjteyBTEhb3FPlXHw18uT4DILGWp93RmCm9mjj1LAHK4Yp7W9Hl1KsT7dMgeV5PbG
         nFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769126771; x=1769731571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYw+4Gmihu+4dwD7kjPxG/MeFE/jB17ZVb7ScpZdwko=;
        b=l5nmtVDMWOh7zw3ROROaWK3feCjVL9YEul4SsZHl4/1k9tIDzExV3f/hvpW7y+NYSi
         8KZYHe/vKzOIBBjO2tMDTkyyS6IE3DfG1MGRXmcNLMOX43SAMePJoHGEgxBL+9Op4pCJ
         WXHIygFxjHNuFSbPH0hzMALR5awZZhDYcIwCgLTTpWULP4x4rFuPej4jpKst0URQWMFh
         1y+6EMSOAnOfhQDNMS98FNCVNJ8ZUBY4GTso6FmZPxF0EE7VfV5pd8MXWljoCVA83Z4P
         KRZvWlsml/EPdqhZQVTup9Q29SufyLJG1QmWi0a8rb2IadINRKBMMuuu7IQy/aYLmWLw
         ivuw==
X-Gm-Message-State: AOJu0YwDqJ98tl2PK8Lb4Z50o42p7+EsB9xMvDmrk/qVWdGMUGsHjss4
	ZnWZm9EKl0OL+jVWjVod2gTV4ArkfJxWewpNr5x9CJ8XD45Ldza3ONnrTZ5BCNw3jYA=
X-Gm-Gg: AZuq6aLoLel5a0DmHSNnKZ65FtuQknPY6/emeLm65puqQY7a2Qm8g3oW5MjF1WjZYWc
	EqhJR5CyZ7+Hcg11vEHcj18+jJerMajtc50bQuBUimcEUTz4G194FYXlIa1wio/k8os4hZh2bQs
	cHY8gBtrgSvbXxwY9LhG3tEit6eeF26iy09VD/FETZxq+JWJCBLbpyd8ic8CypcK6++QEoDI9Od
	NPdYRJVIUInSufym3w60Z69lbx4gYY5QclusJN3w86cfkRfqDl3xmnZwAlZ4ExCOJJSnjtLbam9
	FANckqF8WP7xUoJ42mngpfNzYFvKeqnu1yLNJvV9azi+Ul1sEVkfu0+KYfpMTySRQ0BWl0BRA6U
	QLvWwCe2RxrBYUo8rm+/iBX5LyCLoDxgL9RKf612MXAgNY+gWBqIRY4E2BcLu+LOYMbswgHAsmf
	qhdU7N55eidVQGIeoI2mom2OSo2Fb/rWvUzgY6qVlEmIvWK0teg/s+Lsq/EfECQDeNnJY702i5D
	NC+p/DNvYw8LQjeVg==
X-Received: by 2002:ac8:5acb:0:b0:502:9fe5:a36f with SMTP id d75a77b69052e-502f772d9d3mr20762591cf.11.1769126771140;
        Thu, 22 Jan 2026 16:06:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7e9c561sm5128551cf.4.2026.01.22.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:06:10 -0800 (PST)
Date: Thu, 22 Jan 2026 19:06:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/14] packfile: introduce function to iterate through
 objects
Message-ID: <aXK7cSJW2syew89a@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:22PM +0100, Patrick Steinhardt wrote:
> Introduce a new function `packfile_store_for_each_object()`. This
> function is the equivalent to `odb_source_loose_for_each_object()` in

s/to/of/ ?

> that it:
>
>   - Works on a single packfile store and thus per object source.

s/thus per/thus/ ?

> diff --git a/packfile.c b/packfile.c
> index d15a2ce12b..cd45c6f21c 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2360,6 +2360,54 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
>  	return ret ? ret : pack_errors;
>  }
>
> +struct packfile_store_for_each_object_wrapper_data {
> +	struct packfile_store *store;
> +	struct object_info *oi;
> +	odb_for_each_object_cb cb;
> +	void *cb_data;
> +};
> +
> +static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
> +						  struct packed_git *pack,
> +						  uint32_t index_pos,
> +						  void *cb_data)
> +{
> +	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
> +
> +	if (data->oi) {

Interesting. Is it the case that if the caller provides a non-NULL
pointer to an object_info struct, that we will reuse the request portion
for all iterated objects, updating the response portion as we go along?

If so, I am a little uneasy about the potential for us to mix portions
of the response from an earlier object with a later one. Skimming
packed_object_info(), I don't think that we are in any immediate danger
since it overwrites all fields in the response section. But that feels
somewhat fragile to me, say, if packed_object_info() were to at some
point conditionally assign a field.

I wonder if we should split the request/response sections of object_info
into their own object_info_req and object_info_resp structs. If we did
that, then we could invert the pattern for providing the response,
filling it out ourselves and then passing a pointer to it back to the
caller via the callback function.

TBH, I wonder whether we should push this onto the caller entirely. If
they need to make an object_info request for each object, is there any
cost to having them do that explicitly themselves?

Thanks,
Taylor
