Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCA625
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172773; cv=none; b=pWppb8PyV93Yy8OgGI5Bj+fzDmQBoByGbQrfpQhPac4JZ79CfW6AqwQMTrLGRbT6AzJtAgfvnAs79i3JN618xcpFnHGsa7KW5W3OqYq8v1Jafr99DjUqV499d8wR+ly9ydLvXxRDqoZepntgcVafbt0xOTzxnTmIjJaoO1uMTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172773; c=relaxed/simple;
	bh=Z30WzvTTrPWgaUJHqgP4YQR45Ra309H2Cc5BrqzQcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWHbX7uBZ+fY6U/aPCn+5dKu2cbNfLAWERftdPONGq32StgtgW5WjxZlLCcZzVxCnzSHns4tRODdsv8BysMEb5T7VWJXPURZ/vzWrTPP/oS48R8q52lqQJ1wNJViOP67ZWSBex7N4Ezz+L36ZT9ftYb0C0WeK+DZzBou7rFpFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=l3F1+5lN; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="l3F1+5lN"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e9e0e38dcdso42663275ab.3
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756172769; x=1756777569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58dvA7LzdbJzvIuogMUhIzi7DF4CYA1dYB6KBdHFqCU=;
        b=l3F1+5lNqZcRZtGQR4L2Cf3eM73DQCbfUo3K/KIHSFsBSP4X6PBUzesdqYarr+EguI
         8WJ6/uOhhUPsp+OH3raDGaOiGy+Amibp/69ZAzrvCeF9TqKYdm3IToRoWxBeXk7641IR
         CPWv6PirXzKMPBqSYlpTCVSvnMjtcZfpZQSPPFZ97AjjL5mlDSS1DMca/5tJIardH/4L
         +qNLnKIUHjIss2CKmC8ryuvuocsfeNu+XLzXQHGySc7oaotTAT6BCI3Jv+5OTcLsygN1
         87AnnLfOn1AgSfmjfpxvjdOuO7oRD5vE5E+Ftlh56xJ3KVxBRtZzYoXdR8TOXt12dNKM
         Wkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172769; x=1756777569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58dvA7LzdbJzvIuogMUhIzi7DF4CYA1dYB6KBdHFqCU=;
        b=JpMYdvVUOweFYo/4wuQ2DROnjwd31+IaSM3ozNWN5+QbeRRzATtqsQpQo1O9J92pL/
         URgJTrO98HH9Y9lNSHwcxJ98ZznMHe/EYuqoPzFFdrDFTA/Pr4a6xycPM52W0mIG1HQW
         6fMi6Dy6lpNm6EA76kYC10Rmj2sxw+xEsEDVRVKY0BKNS3o7wj669KwZ7VCMyvHVCDRR
         QwJrxFX7jq10TbTWc+7E0QiyaLoeq9puxqnqY9Xf166UkB6MNgR/iAomAa+0Q52rGw5A
         2tw4rh7I4AawS74EjblijSVMKaD9AD1WI1pYUio6olQv+Z8gprKBP8s8+CGFnr5x0sU6
         AgQw==
X-Gm-Message-State: AOJu0YzIgpwHkdnkvM5Cx0onVy3ps7JE96mXecqBDZLy1wQ6BE0zIcIM
	BNsiiyEXfHGU8fL/WzWA92PqU80+i0cTwtDZqQEUhGSL3366vXp6x3w89QZbh/Rv6SnNLm0el5c
	oH3Y4
X-Gm-Gg: ASbGncvR9Wbf3as1UtjwWCgulxGghzlzowVm1YdG5G572v2ljccJIE+q6b1ht+bOlhn
	wd6nF8R1bKs1CE40sgTsT1BwATDb0kVfW1HC9lzETVMvPyWuNNJhMtdeMveV6W+SjeTOwl3rCsL
	ONeeRw25Dr3rZP3mjSGxNpy/3uA0QViw3qfVoBDfja+YzfVKZXr7tI/6jnPYwwttfL2nFe2ZneA
	TsGslrRuCYxoidIFFRapHHJemR6oGL3BfKi7ABhiy65wRZSUtWhgiqaWeCInHZW1DUYYxRvWVsj
	xSs1rKDhK6FTtLj74yGLyc+oVCVBicnNJHu8s2H7Q0uwsrL9hEgVSr5Y6EYmltZxU0Qmj1AJ9LW
	YxTKFUxPv6lvgcdmINItREVFXE6YOGYfD+qsO0nPBiwMi97epF8IDJS1GNHu+fFQCrmRyhHHqGj
	nTIVRQsw7JPNCYoSkoItcxo+67jw==
X-Google-Smtp-Source: AGHT+IHpddhT3RuQLIeie4VM/ottojsD5AWpji3/RzaL8WH8zVpGwr8XnVo0cx4x1QyAwsDCq7fDVA==
X-Received: by 2002:a05:6e02:1062:b0:3ea:4d5d:b2cf with SMTP id e9e14a558f8ab-3ea4d6cf68fmr117780205ab.30.1756172769069;
        Mon, 25 Aug 2025 18:46:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4effde1csm58743475ab.48.2025.08.25.18.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:46:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:46:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/16] odb: move kept cache into `struct
 packfile_store`
Message-ID: <aK0R38bfUSzbnlb5@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-6-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-6-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:04AM +0200, Patrick Steinhardt wrote:
> The object database tracks a cache of "kept" packfiles, which is used by
> git-pack-objects(1) to handle cruft objects. With the introduction of
> the `struct packfile_store` we have a better place to host this cache
> though.
>
> Move the cache accordingly.

This all looks good to me, thanks for taking care to preserve the
kept-pack cache's behavior.

> This moves the last bit of packfile-related state from the object
> database into the packfile store. Adapt the comment for the `packfiles`
> pointer in `struct object_database` to reflect this.

Thanks for keeping the comment up-to-date :-).

> diff --git a/packfile.h b/packfile.h
> index d48d46cc1b..74cea1a4a9 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -64,6 +64,11 @@ struct packfile_store {
>  	 */
>  	struct packed_git *packs;
>
> +	struct {
> +		struct packed_git **packs;
> +		unsigned flags;
> +	} kept_cache;
> +

This wouldn't be a bad time to add a comment here explaining what the
kept_cache is for and what each of the struct's members represent. We
can blame (at least one of) the author(s) of 20b031fede (packfile: add
kept-pack cache for find_kept_pack_entry(), 2021-02-22) for omitting it
in the first place ;-).

Thanks,
Taylor
