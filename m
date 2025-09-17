Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F230C118
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146347; cv=none; b=BW4RHOZ6nUsNFQ2Rzu05+erqmuiMAVcYFcSwcH0G6V1k92D8Ia+ukcEidV2Wt4bvLt8g9JutjbsXwAmzDohERjXh7WwlfCzJ5WtzvmsBSe4jPYwGBn9Qbhupt7EKhbykizTX9+hmBN+HD8pu0myKao7+/nrl/zrv0gvDiiZJlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146347; c=relaxed/simple;
	bh=rvJquYb2QGZkdKfETIxUzS0RwbD1P0IGZqwNUcJ/1Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+AxJIgvD++h4iKeKGs3+W9AGZ1AjWQiLft2/LDntjC97Uay8kwdBr+/0NRXBgJqapwnTwohMSJQAH91fS6AKUxPK288m0OGpNpQSsQxG7w7Ba2lZC1dceon9WuufhRjRksoM9oY0VxGb2pKcf+cADZkOAG7F3MDgpyKTVoYc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO8ifEEd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO8ifEEd"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3316cc5ba2fso137919fac.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758146345; x=1758751145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2flo2GsSJKizb3MRdYzxJTpTHlcC61iRM7ZcGFWoxuU=;
        b=MO8ifEEdN7Fow5c/LVWvmzInaWju/tKpq/WsnO028/K2roxgMwfGZ5DPaVPnsjPL41
         iYow9W872chqGSQAO9Znu7MF6swtSeltDGDPeYgul/w8K0c7tMSoMCINRdGR1nBqY3MV
         GpAjDJpG4b40idHzZYcntSSV8PZ9MDf5EdaJG0EZG9gy5DRAEx3r7PfORCgdvLceujqJ
         gZawm9QvDqnoqH86vV+Q+BW6zq81ALS7B7ifCIcKSKAXUKFmiYiL0DCI/6XZ3Iaf749d
         /DJSYJ1GO9v5/dKJYosGaLbDxZNzKQt7nc+JhgAm4MsK2szFU3/H4Hnfqcua193jdz+r
         wAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146345; x=1758751145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2flo2GsSJKizb3MRdYzxJTpTHlcC61iRM7ZcGFWoxuU=;
        b=d3tQhmjQtYovHGOSs9tghtEZ6/o3007Z8ywLTlddztaoILk6He/oiXU1HipJ9lzJTA
         0rCJedt/awW3+6Y8vs/qm9alhUBQ+SwsvxYADsRzQP4NvxQpjKk5HviA/51va6DoQDNu
         kd2QfAlShLGF5Murw+TaR0mqcUaQ1azD4IJTByoR0roB2/BhlPOscSmrTRzQq+j9EYzx
         FE0xyUFZUGKvX+OIWR45jxJsYofK9vUEHefKNTYlLvRl5HZ/7dyoBMq9bFzG2/hw8DFS
         N3KeBDh34/2f+wQuE7J+ETbezzUKqV6dFGTMbmj7Tk2GArLQTnu0ey4do0Eo8uDFAEEC
         vd0A==
X-Gm-Message-State: AOJu0Ywt/ShQSDos4rss4d+FveWDqOIbpeLFe/YoYbrNOp5/PLU47nLo
	J973SZxxo4Xu5cRbimeHJKpWOnQe4pGZL2mjTGdswh0wqzmCGJNUmRV+
X-Gm-Gg: ASbGnct+PyImHdic/xiFZYeCt6VbdZd1ilPRBKq3722TSGoNvoquZviBjSHaWzG+6KA
	v4/kXjWWkl0X7LITWZrBC8LMLgLIuULDFedCQqm7MA9lh3+ZAq9SDiujogVe+YqVYvZefhc37PB
	gEZkXd1+iMh6SIcjR+9Ozn54NtdAHyL/AgzBPvxrUpI7qPeQHW7A3ucS/AwQKOV4DL2OcWQ4ciw
	whVIGTPUZdthHYtV461jw+Hxn3+0H4z9o2j1gOMSNUvC+Vnkutg4Oc27AmRWhkhl9USmhtYKqEG
	JE+hqK1x5NWx2cSB9L5lTzhXp79yi/WSCVJhCWB6CBB+T7NCwhD1KnmiXAwX45wptcEdGH8z7Vs
	2Y8/UCxAWIXQHWPymStiOQ/460inzkYzsOZc=
X-Google-Smtp-Source: AGHT+IFmt4Q+pIxMLpOFw9whhEaEE68muq7MU1ijP91JZQJILIgl2N7RB6o5rAquzkPDUdLPZGa8sA==
X-Received: by 2002:a05:6871:2286:b0:320:ad8a:373f with SMTP id 586e51a60fabf-335beedc5e0mr2168503fac.16.1758146344841;
        Wed, 17 Sep 2025 14:59:04 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7692caf8b64sm301583a34.43.2025.09.17.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:59:04 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:59:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/15] odb: move MRU list of packfiles into `struct
 packfile_store`
Message-ID: <hvdgtjrfimowgsvshgt7dxbdbx6qxtuyfq5ylhgrfmfsymx7f7@gy4aazvvubk6>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-5-d6340350934f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-5-d6340350934f@pks.im>

On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> The object database tracks the list of packfiles in most-recently-used
> order, which is mostly used to favor reading from packfiles that contain
> most of the objects that we're currently accessing. With the
> introduction of the `struct packfile_store` we have a better place to
> host this list though.
> 
> Move the list accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1035,7 +1034,6 @@ void odb_clear(struct object_database *o)
>  		free((char *) o->cached_objects[i].value.buf);
>  	FREE_AND_NULL(o->cached_objects);
>  
> -	INIT_LIST_HEAD(&o->packed_git_mru);

Now that the mru list lives in `struct packfile_store`, it cleanup
automatically gets handled via packfile_store_free(). Makes sense.

>  	close_object_store(o);
>  	packfile_store_free(o->packfiles);
>  	o->packfiles = NULL;

I quite like all of the reorganization in this series so far. :)

-Justin
