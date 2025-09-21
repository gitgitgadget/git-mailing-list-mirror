Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF322FE10
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459964; cv=none; b=Pp8Jx4REBcEUVjypDrX6x2nt5PIS5SF01GeVFY5XTH4ejnbFyaw+an/rMzuyF+tohLAwUZ0QVYqRs2v3dG5H0vhcdmMCRL6PiPOUDiny+q5GM288nHVyt0cbnN78OpxM7gbU+YDrGM/JsfoVhUXtVmms42iQ9sv/Tg3R59+BYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459964; c=relaxed/simple;
	bh=S1yFEMah+0M8h3ckHW9lUAQF8W/a3NTbmHFqizIxjAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbsQFDHDR0jAUjccW7eDvgFmOFG6Znat6YLwf1xnD/U/n/o9Kq/y12rah1cYVZh7MtRt3whPfi57rzk8zuE82LlvOw5zUtjeG4xz3ZN8LqFNAxSCKQWGqaL9Ir0TmRMYFl2vkxmWQVHTa+JlxYGSCA4DHW7GoM4NDC5uYWS/6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/8rzHsk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/8rzHsk"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3274459f8f.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758459960; x=1759064760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEGLdy9/++e07cIj24rUcyNzboCgIZ8CcwtG3njDPCI=;
        b=d/8rzHskD2EH+hqiOoeGL6i5DIPs8cNqz6i+PfiNJjMMJO6sSZTaKExrbCMPwvpSUh
         TAsbMNBREyNsnUZ4SdZI2RHGDZBWnQ3c3dUKLrqA27taJDB/n0rEr114XNUbjqyBw9s9
         8Q2vHwf7HIWi3jQkBDz7Vte/ZFoUTr1vpnz1aouwhMmyFpeynkoi72tC+3/2MKkAes4E
         GL9B1shRmB/+Zw8p2/X330ENP2SzRW1ooN8lPjJnKpno/wFfOOEAUw1Q0MIzwX9sMdPs
         X/XKR7gVfv3BXSgr7D1HHaO+X9kMZS2cIA8WgR3Wdj9YgYR3nkF7AQEPjAi8+prABmke
         nJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758459960; x=1759064760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEGLdy9/++e07cIj24rUcyNzboCgIZ8CcwtG3njDPCI=;
        b=NURDfiG+H59KzrTHNokB8M1sJi/8s3sAH1FQcj0//AeVu2kktBXzK3SZsjR7Psd5zz
         7pBR4I/yV4plvv+22yCNga1ucyGPt9EEHu4jwHCu2TOqr1seq3Ahud2qWm++5V1KD1Ob
         qDd8iVtSOv91rZYpNfzQDnAh+ZquHV83GXhGsPexWNpUQnxByl56cQN3z0xwOHfEd1BD
         cpDEcJdJGhFMPIB7dN1qNOE5BXjvb0o04/oBsAY4yaw2YNRjUS/CEpZVIGhh/Gp2Aqkk
         AivI8f8KGC1yNDJ4RFkMukVJwyrbn8nBLm1U5K3dnPvjiU3QIiwkVC4ScZxyZeud5xc0
         Xlyw==
X-Forwarded-Encrypted: i=1; AJvYcCVMt/ZjyAzVWauZHCMleN10ZPKyWF7IBYv4jGN7rFHUN/1mrs3XjGhnN8U0P+wJhIePBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZb4d1LuMDWHacXMX8tqxop+6Jo04qTXKkTr1wIeH55dtv9hF
	jMIOyAxuw62lmU6zA8NnQDXgAKNlk+1nfZvBRYsd4Z2y6amDcXzcUAMF
X-Gm-Gg: ASbGncsNeXfiKXOJfu6sERjivL75U/MPt4hXPTxClWmNj1kHOemEXE7/uHK3Baiob3R
	9QuNcnpDxIlsgFPkFbLnEJrxlL72OoxbQGTU7dyA0z7bO7FpI0yvPE9rDgXz/zF27ChBAqAOCsP
	0w5KUISEf1uJo3SM7hLk1eTYutKitkXO5FE8X8tt0J4tDU3q2+NaNhvmr7hGsyA0tkP2P/0ICR9
	BDtfo1cfsNVCFApUHpEy+hvnVVhnIL0/237sF21OAX/dbf0HDSbyTIoxHo4SSu8092vkfl6v0et
	GczpfNd5qxhv3U6Px4jlken09EEfl49Lq2R2upF40RtgySaQJbZvsmEoaksnwMCprXjKsuOyPp4
	ia2K+rlcCWLloS5C00Bo53ukuQsUz7pGihk24KX/Xpm6ZlMT8cdDFEXQFwCZUDDmKeprnshRSsU
	MRllBZ
X-Google-Smtp-Source: AGHT+IHdSLzFlLO/x7NxRfR37x8Ke2X4KwkMh1Wr0paEyJnAHejme6j5MD3bfMJowoch0zId1bhyFw==
X-Received: by 2002:a05:6000:40da:b0:3e4:64b0:a75d with SMTP id ffacd0b85a97d-3ee83d9ff66mr5668381f8f.30.1758459960387;
        Sun, 21 Sep 2025 06:06:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:600d:1d53:febb:27a5? ([2a0a:ef40:62a:101:600d:1d53:febb:27a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm15877393f8f.18.2025.09.21.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 06:05:59 -0700 (PDT)
Message-ID: <cd39a321-a6c4-4126-a716-dc0b0cffa68d@gmail.com>
Date: Sun, 21 Sep 2025 14:06:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] xdiff: delete xdl_get_rec() in xemit
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 19/09/2025 16:16, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> This function aliases the fields of xrecord_t, which makes it harder
> to track the usages of those fields. Delete it.

Patch 6 goes the other way and introduces a getter function that hides 
the field accesses so I'm not sure why this one is so bad that it needs 
to be removed.

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xemit.c | 38 +++++++++++++-------------------------
>   1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 1d40c9cb40..b3793e81e2 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -22,21 +22,11 @@
>   
>   #include "xinclude.h"
>   
> -static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
> -
> -	*rec = xdf->recs[ri]->ptr;
> -
> -	return xdf->recs[ri]->size;
> -}
> -
> -
> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
> -	long size, psize = strlen(pre);
> -	char const *rec;
> -
> -	size = xdl_get_rec(xdf, ri, &rec);
> -	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
> +static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
> +{
> +	xrecord_t *rec = xdf->recs[ri];
>   
> +	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
>   		return -1;
>   	}
>   
> @@ -120,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
>   static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>   			   char *buf, long sz)
>   {
> -	const char *rec;
> -	long len = xdl_get_rec(xdf, ri, &rec);
> +	xrecord_t *rec = xdf->recs[ri];
> +
>   	if (!xecfg->find_func)
> -		return def_ff(rec, len, buf, sz);
> -	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
> +		return def_ff(rec->ptr, rec->size, buf, sz);
> +	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
>   }
>   
>   static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
> @@ -160,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
>   
>   static int is_empty_rec(xdfile_t *xdf, long ri)
>   {
> -	const char *rec;
> -	long len = xdl_get_rec(xdf, ri, &rec);
> +	xrecord_t *rec = xdf->recs[ri];
> +	long i = 0;
>   
> -	while (len > 0 && XDL_ISSPACE(*rec)) {
> -		rec++;
> -		len--;
> -	}
> -	return !len;
> +	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
> +
> +	return i == rec->size;
>   }
>   
>   int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,

