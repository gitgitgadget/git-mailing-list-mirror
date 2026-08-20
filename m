Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A4367B85
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261612; cv=none; b=l7BmOxW2QwglAD54CiWnkMTiuCoME7TEsvPX5YWv6NnnMwrQ6GcjJkcftRrE3NRQP8J4jAkTZzt4ByuZtRilXUZsaTmnS9slo64nR3Ga7fBGPJS2ChALXYquRTPKXjq/FqL7Ugob/2ErE8CNKEpLkJv0rKB3VjspTZ5MUMGRPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261612; c=relaxed/simple;
	bh=VK+SZHXcajuoPz/AAkzjWVbsLiHbUDY/jXHICv/meW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMn0Bw7Xfdo+b+msgXOyD7Fs8SAcR5BmVHDaN0vLvA65AGbIbgAjkv3NlYo1oNsCev7UPAeucVuq+AeT43D5lxODpnyyZjldiNDTXT7dHQZagmbE7eeIOlI8BJIUm9MtaRYcMYwno18x78fHtB/a6lcIGlFqk/LJ4yOBl2PO4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuZkuwum; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuZkuwum"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44856d185bcso223529fac.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787261610; x=1787866410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPf/YAKK7w6HCoWSdV//SQ8JRJs7TaE4wyrzI20mN6U=;
        b=TuZkuwumv1JAIPqewBu9AIcMb/z6dkeag78vEBDv5XjerHOL35PvFa9owo6SjDrB1u
         nMOHgPK0aMljo2MyWFwWq4ocQuH21WQx+wds9Fl8yfJKBhQqEpGwwTMZfym5hlYBBm1/
         K0B1ldsUPPEY09GVV9P0l09gDE0wz+C8xTVZGj/7WMVM3z8zMWlZ9uKq1ypwsdcwqrWt
         w7mkDW/bGfP4oJKiRbmYosf80fCCSmbMUhMNuA9eOzefcGULpfK0VHFaMlKF/DnSLElL
         PFlpW/P/WucusCRCW6jBsXXOv6Pqv4JlswOWrfNxvoo/hEJz8LhgbvNony0ilFBlDMYm
         HaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261610; x=1787866410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPf/YAKK7w6HCoWSdV//SQ8JRJs7TaE4wyrzI20mN6U=;
        b=CCwWoPlNt7bgcSpuDlA0hkYTNeM4PFK7PttDuAd42X/+2Aeo4q/uM+d+23Gka0GhjQ
         mG2Na/j4NrqFWc7UpVJIYR5HeNXlJlxQ04/H8qaIUY/olfCj8dPcf00YavgAxGIyBwiV
         tZnrMhr4bIeMoYCXY4wgzuTYe+DgPMwWJG8FpvJ1F6+UyDXM+mZn5lLutnNTeOakK8Gf
         tDhtpQ7bIhuuaUHfFx7zejS/ZMfAAqMTvLWQO5yTpRqeziYAVlh6mo9BhiV6PdvBolOp
         OkK/2qTWVKz1eyp9TzE/Zh3RY1gQfMAbbIHarTkmGiSCSRQL2deM5/ItdtDLQvSHqOey
         PuqA==
X-Gm-Message-State: AOJu0YzE6nvvInbXzBb4PlbcuKqaGdygPqTWiq9KD3rMEL8as4ip3+xO
	ZlOBNoJ23yUsowrYoV8tHZAVg6il54P/1I2XEbvF/h95wG+Mwc90sqbzjhsm4A==
X-Gm-Gg: AR+sD12FavYoIQ96jFi9gm0kiPAp/8EVra6e+fyy+9zu2Lz+kWG0LLkI0fUN1llJ5BE
	NEr2C4crGmygltj6eTR3jQBagu5pTUh0j5n5K3lnzX5hRgdcYHwIJhTHku8XkxSKRP0xlmYVrOu
	JBbp/cBJAODC8Y5OJnPuGsnIaZ1veqzdSv5YPcnIGVbCPyahjE7/nGWW1MNrKygZBaURZk6Acj5
	ViRm+yDuDHj8t1DYF7qEhhKHmQgMFCKMSt0mLpyM3TKZDpMhwW8arR9wa+KRRSZQfRx6GA50CDF
	AJGc7tNDpnvqzfeWYJkNbDV2ASRIDsu6tuIqG2wm9L5Ltr4Fe+JolqUDSss0meH3qBsswv2KNkV
	D0AFhOPcvcgwHHXl6R4BknbHg/JYAPZNziC7UGxGfSYXaAzWH/pTWcTygwzQnMM0n9u6jas5lME
	WcjTd2QO3hEQItas8Z77oovV9Yn/2hWFJkqh0jGch+x87YS2KS9Zr0KA==
X-Received: by 2002:a05:6820:c2c3:20b0:6aa:e252:dc59 with SMTP id 006d021491bc7-6b1591d5593mr1608930eaf.5.1787261610162;
        Thu, 20 Aug 2026 14:33:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440056836sm6071775a34.20.2026.08.20.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:33:29 -0700 (PDT)
Date: Thu, 20 Aug 2026 16:33:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/9] builtin/receive-pack: properly clean up keep files
Message-ID: <aodyeILDMaBOX--K@denethor>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
 <20260819215311.3880274-2-jltobler@gmail.com>
 <aoaixMF1biKYhWN2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoaixMF1biKYhWN2@pks.im>

On 26/08/20 08:46AM, Patrick Steinhardt wrote:
> On Wed, Aug 19, 2026 at 04:53:03PM -0500, Justin Tobler wrote:
> What we don't verify is that the ".keep" file is getting migrated to the
> target repository and stays intact while we're updating references. So
> do we maybe want to add the following diff so that we test for the full
> lifecycle of the ".keep" file?
> 
> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 3da253cc1a..a722a01e8d 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -83,11 +83,19 @@ test_expect_success '.keep file is removed after push' '
>  	test -f "$keep"
>  	EOF
>  
> +	# And when updating references the keep-file should have been migrated
> +	# to the actual repository.
> +	test_hook -C keep.git reference-transaction <<-\EOF &&
> +	keep="$(ls objects/pack/pack-*.keep)" &&
> +	test -f "$keep"
> +	EOF
> +
>  	test_commit foo &&
>  	git push keep.git HEAD &&
> +
> +	# Once done, there should be no ".keep" files anywhere anymore.
>  	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
>  	keep="${pack%.pack}.keep" &&
> -
>  	test_path_is_file "$pack" &&
>  	test_path_is_missing "$keep"
>  '

Makes sense, I'll add something similar in the next version. Thanks :)

-Justin
