Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE521504F
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917244; cv=none; b=rnS15ojCDlZWDu0eW1Mx4QTgyP7wrfzPb8JoWNqyvAKXyhXV7e6CQdrNa1+jeaNltyAypGrDGur6yKE8kVqYJtvzZXuH2CdvEBntgN+izTErHr3WylwIdKWT98WqThCTCIaaVPDemZh91IhDB0vgpwgA79IKODPrq90fco3of6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917244; c=relaxed/simple;
	bh=eoBaGS6svbTLFAXDjQZTqtywYw6C8qRiK91y/4pwdPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P27Z3fN3YLfZ9LHPL6v+6zSmEZgRooqzZgOMD1Ex/p+EK+G2/cyZjoMosSNxBzVmtCsJxskWaFd9zLni357gHVNOGkrVg+FEIqvoZlqVrhTZ1TePQ4FpHXAFRfWPa4Ek7nJZhPXV7xxwRG7CUjnQ5hGeAVHy55qO+o2ZEUdJ1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRSfrgDT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSfrgDT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso24842705e9.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917240; x=1746522040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vyqt3axIN62R+0r1vdHgGXAJjzJnWiqAxHeOrURjAUg=;
        b=VRSfrgDTHnPxSncRJwQh5k6I7q14W1IHJdI0owF0TZAI+ui9kpJP/T40K3O+NPhENl
         oNS+0VSNS/UZxeqYG9uaX4nC/8B53KLGusG2B2BuPCdF3zvhR/ICBCcp/0OpfSpMEHe9
         cakqEuVvw8piui4tf3ijwUIiQ35Lzo5YWI3jEgYbwudwua0Ft2hdNOJmttQK0vankUU8
         KFrSIz3kaos/FkS7bwVowQSyi+tBFCH1Ub5kh0SSXcI7LAeB8bGO/aRqx/sjwhXrjpPl
         snUMm59L8YcBUsqXAkumwn75uC7Gi5TGcZkboAfh91ogBAFgIcEMRAnUXvN3TUE8ITS/
         GdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917240; x=1746522040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vyqt3axIN62R+0r1vdHgGXAJjzJnWiqAxHeOrURjAUg=;
        b=KbCYovlUaj36jQ0m2RnAH95Ky4P3tZhVeNh5tQaavpZ3VYOznEFS551LhI9/x8+d2U
         mZ4yd6yL1+Px2dXSmnbS4pDapOIT9zOfYewXKmnkL49dtU4LNtHh1fozLjwApNPC5QeI
         d51l+ETUMcboF2DPbjqAtTGtOhSNE7vV8Mbuzcty00d3IUOKzYRgUdr23/iIPkQ8o03/
         itlQzPxk6FRycZnUgJo1JKVkRtw6CCVtijmypseQq9d6Juv5CH6hQfIWqaxp5aTaja2K
         2jk+EfvlOOeliNmS+/7yJsiV0gm8y6vGx5AISzD8VCy9JdevLvoamP5wrqdObSgdDE5k
         yphg==
X-Forwarded-Encrypted: i=1; AJvYcCVhMO5t906/jhujdUpAKQhV71M4ZTfsYw8IMWGpTSxMGFP8v8pd8CLRCR8Co7MR/iwQwBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34FBF9riDwNI+VUCDKPrGWoOKna6bKr1E1NNBJsy3X/QwKqnb
	r3Z+aXajIyMAMrnPpnnq5HiM9KnSrPivpKlUU7G2PkH4tsn9kgq5
X-Gm-Gg: ASbGncvUDuRUMTDNohqbJOQhmlaEzut5C2r3leEEUD55n0H5SNCOvJdkstXqDbkEoZD
	ILsdaPeOahU9YR9vkVoOsO0HNkdAV2AU8j/gyPFFurF8T9uCmjr3WEqUpmblB35Nce0NWfMqwk3
	hScm6v4WxxzUVOaOn4ssfAckjurUP+n1Q+gtYqonMY6MVURY5Y9kY2fz/QGQpKK1LV45YTv7r1z
	4KEDeYjjR3zhZM+GjF8p7jvQgthPeHLumQfixMnGWKAWIaLHNkEGQlpdzDcyrn/2WfB6hYccTUW
	Y8gE19fGheCpNmCQ8uIF2wzoRUC6wk8ToO50H7amecB5vKgYAbAClYuNWjVxBEwz1I3Bdt5Hit9
	VDC64JaqJyxyMY+JiZafck+81OqQ=
X-Google-Smtp-Source: AGHT+IH4Uw4RGnwLGVNgC0tUTH8yKoSyiZuFystm+oLOBild1V94W+mAEo6ZUse28z/j/2OmRgQPOg==
X-Received: by 2002:a05:600c:3b95:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-441ac8cdd6cmr18488295e9.3.1745917240298;
        Tue, 29 Apr 2025 02:00:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2abf73sm182054625e9.20.2025.04.29.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:00:39 -0700 (PDT)
Message-ID: <10aed56b-8036-4458-97ad-7fa319b18f10@gmail.com>
Date: Tue, 29 Apr 2025 10:00:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] xdiff: disable cleanup_records heuristic with
 --minimal
To: Niels Glodny <n.glodny@campus.lmu.de>, git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
 <20250427220653.2325573-1-n.glodny@campus.lmu.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250427220653.2325573-1-n.glodny@campus.lmu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niels

On 27/04/2025 23:06, Niels Glodny wrote:
> The cleanup_records function marks some lines as changed before running
> the actual diff algorithm. For most lines, this is a good performance
> optimization, but it also marks lines that are surrounded by many
> changed lines as changed as well. This can cause redundant changes and
> longer-than-necessary diffs.
> 
> Whether this results in better-looking diffs is subjective. However, the
> --minimal flag explicitly requests the shortest possible diff.
> 
> A performance impact of this is not measurable, and it results in
> shorter diffs in about 1.3% of diffs in Git's history.

Thanks for re-rolling, the changes all look good to me. As Junio said it 
would be helpful to put the performance numbers in the commit message.

Thanks

Phillip

> Signed-off-by: Niels Glodny <n.glodny@campus.lmu.de>
> ---
>   t/meson.build           |  1 +
>   t/t4071-diff-minimal.sh | 14 ++++++++++++++
>   xdiff/xprepare.c        |  5 +++--
>   3 files changed, 18 insertions(+), 2 deletions(-)
>   create mode 100755 t/t4071-diff-minimal.sh
> 
> diff --git a/t/meson.build b/t/meson.build
> index bfb744e886..8f2e9d2c50 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -501,6 +501,7 @@ integration_tests = [
>     't4068-diff-symmetric-merge-base.sh',
>     't4069-remerge-diff.sh',
>     't4070-diff-pairs.sh',
> +  't4071-diff-minimal.sh',
>     't4100-apply-stat.sh',
>     't4101-apply-nonl.sh',
>     't4102-apply-rename.sh',
> diff --git a/t/t4071-diff-minimal.sh b/t/t4071-diff-minimal.sh
> new file mode 100755
> index 0000000000..4c484dadfb
> --- /dev/null
> +++ b/t/t4071-diff-minimal.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +
> +test_description='minimal diff algorithm'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'minimal diff should not mark changes between changed lines' '
> +	test_write_lines x x x x >pre &&
> +	test_write_lines x x x A B C D x E F G >post &&
> +	test_expect_code 1 git diff --no-index --minimal pre post >diff &&
> +	test_grep ! ^[+-]x diff
> +'
> +
> +test_done
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index c84549f6c5..e1d4017b2d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -368,6 +368,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	xrecord_t **recs;
>   	xdlclass_t *rcrec;
>   	char *dis, *dis1, *dis2;
> +	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>   
>   	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
>   		return -1;
> @@ -379,7 +380,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>   	}
>   
>   	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> @@ -387,7 +388,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>   	}
>   
>   	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
> 
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3

