Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6B492515
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398508; cv=none; b=pw3pRuh1M0PhPLtSRBatvrWeJBXooP5FFrr6VdLABVreeiFGcwiMhJV3npl2VB7esbBzDx67Fzpvovdt81rOudznYMGYiMXHjP8HOAIh72s6Xx4C9DEM4jpZANJOnRWYTmgQ80ssfuyD5wf9/ZmINy/vjHtDuQ2DIMbqgGlc1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398508; c=relaxed/simple;
	bh=Tr0kb1KHa1bjo2HgdBP3j1ltM3EGN5BkPIpe1GD+CGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krDxaZgdTRmQS6K61KBEV7kkJYo4k4xvBWd5c+5Z832QEygnLWe+K3O9J42CgTDDD6mCdDKpIPg8uv5GoaYD+s5r+EERJDkRn6k8jes4TyeRMJh/wP5UrWdzLJWrrc8UBIydn65stGfrb9sxIUgQLoW0rgjuPRMIxPh477vCpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svCMfinT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svCMfinT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso1789314a91.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789398505; x=1790003305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJD3IQp9GifzMeBj1oz+7P9ajAUT3TnOU84twGgeDmw=;
        b=svCMfinTv/UWWnzPJVEBa7hMK4p5bNkUuvcZerCnpDlEzydV0ejM06AcQEpFrM0b5R
         JkaUYdCUfg/uZyYnN1DQG7R51RRPtZDjkfJsWP2dHzq//WpekqsZff4fpki32VQgIrzz
         Kqs1EPSaiOvre+Bs7RM/xnQt2CWpwM7FZ2/HbJ7seuLJaSJiDMFnroZ43YC7DTOeJYDy
         23mh5UC213l942LhxTE7335EWP1MYbaOrfaggXMM7gfO40ndBlkU4FIiSqKqz3LjYHvv
         yB0otyvjjfPxyWPT6/KoMQL9ZRF0nkmrEALsYo5+3Y+iya3cWMHml8IoBvfKo4nXQrjm
         IX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398505; x=1790003305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJD3IQp9GifzMeBj1oz+7P9ajAUT3TnOU84twGgeDmw=;
        b=LqwQMRe+ZWXRHF4R0c8d6lDet/qFccQ8EOiayw4MHXxcDocx2zuGXbvpEzY/2a5DRl
         Tz8wiJtkyXBDWEfiDa/ghkCbgrJ2rYS/l5kF7wz+WLUu4vaalZcr3HGgTAwvlEkMvAoK
         ILPrNm0vDs5UIkwiWg7Ad6RTVY/WQ0M92rEDRxFBX/zjY6Tfe6myfEWA5X/I/ZjiyBXq
         elYDjbLdD55QH/eSeJdWRFG4scrVFi5b3PXJpAKuyvNlwcI7QzotiPUIk3R16AjaSJUP
         zWaNchPJ9xAoWk9Va0uhTVmzHQutQtPVjWSo5RMyyFRsMX23hjzpsDygfamL6pEUsZHn
         B39A==
X-Forwarded-Encrypted: i=1; AKwUvBytFDq+cEq8H9QvyJLfm6j+RA//g/IPkCduDbqFGscnc2VOjUxuJndI1ppxRb+lzUVEjQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++n7KNdZEiVEXOyVLNtVSVJkdmKJwKQpKnStcMRNK9Bz5TS/TLO/
	rbhZPLxnd7JfNNdLp9g383XQl2eTIkH3yH1H/7cN9nUFbM5yHUicW6QE
X-Gm-Gg: AYBFou0Xezuh5Pvz/RaCztgcdciOA50lYEa5AxiFCK5tELyO6RRFSAZO2+MUXJ7tlC/
	P9rH7d5ev/cSR0lQAW00Awo4AJzEYd023CNs5eed4VNvWCRJNY3ffCNZqJ1pnpJGDUhB5zc6QrT
	nayKWmmZt82dkahSRB4GbJeeFsGZnBSz34HClNUy7gh5aPR+Lr1j8XQfAVKrsx9vcMFXB1v5W1C
	NTT1rD76lgBeFaOBWrbjz30ZLhL0L5pg6qaW6jdRUw3cbLSlJRvalMn520xcFfTqzuUWzX2CKRl
	q6BwBoNR8TdqCYOOO/lQoqlefYaeBLf2vtQwqEWgV1QTqDnL2Xtdg3vTiLbxiGYJbiQVuIl2BKo
	LhCcHdyVGlEaNCt0By9h1J0LGQr2iVY74nCYH5O8Mmo4ytY3Gjx42Vw88n2y6ngz7j74Qa3R6id
	JbPg4TXeulAajIFra6ORgumiF4c+FzGpfC/7Z+9/YyfCqKqalTij4SWoTbXw9O5ZKKEzM+mijmP
	BTa5ZutuDO7x8owb4WxgwFyBRDe/02GxHPvpVlCu63vSnQoWUz05XCFGtcwt/XOYg==
X-Received: by 2002:a17:90b:2803:b0:39d:ef3e:9035 with SMTP id 98e67ed59e1d1-39def3e96e0mr6109884a91.10.1789398505452;
        Mon, 14 Sep 2026 08:08:25 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:bd88:c038:9fa0:eb21? ([2406:7400:12b:61a6:bd88:c038:9fa0:eb21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba7d166sm286117a91.3.2026.09.14.08.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 08:08:24 -0700 (PDT)
Message-ID: <5e062976-d584-496d-84e0-e4b59c8f6876@gmail.com>
Date: Mon, 14 Sep 2026 20:38:19 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] Fix inconsistent ref storage format terminology
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 16:42, Patrick Steinhardt wrote:
> 
> Changes in v3:
>    - Add breadcrumbs for the old names to our documentation.
>    - Use `OPT_ALIAS()` instead of manually aliasing the options.
>    - Fix a comment in one of our tests that still referred to the v1
>      "--ref-storage=" option.
>    - Print the correct environment variables in error messages.
>    - Also rename GIT_TEST_DEFAULT_REF_FORMAT.
>    - Don't adapt "ref-storage-format.adoc", as that documentation is also
>      shared with commands that don't support URIs yet.
>    - Link to v2: https://patch.msgid.link/20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im
>


This version does look good to me too. I just had one though while going 
through the patches. We appear to be rewritten the tests using only the 
newer variant of the arguments / environment variables. I wonder if we 
might also need a test or two to ensure the deprecated variants work as 
expected too.

-- 
Sivaraam

