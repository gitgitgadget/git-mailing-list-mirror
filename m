Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990964CC6
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133777; cv=none; b=BvY1RtG5S7/DEaRWkAaHFpM5vJDBhgKw0UHD3VwwVqGCsE5oQM4rq7TyjHfV/uJjVVpYxYt5H8x4V2yMfYk8t7PgE046V3ylJ9i0gqSboP286z6I67sjKbOgc46sMof5fIzzSW1C+TPWFBWkejS4wH8rjr/ZyNOs2SzaleDiPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133777; c=relaxed/simple;
	bh=63UxLTedZ/PELUzVZtZDCOtwajh0tke7eowBgvJCSP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ5zlJg5/n6vADAhg9mCal8Gm6AV/ZTxCAnz83UV+SCaTwjTxoXD5oaAdh5CmQ13+W4v9HWWYLHeQu0Me6Fuxza+YKbW8KLSYGdC2IUKblrn3fFLovW7XF0IHRcy5idyr9jhI+Dab00QwU3uMCKunVYndCsF/keSXeYgblayuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8E5D5HR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8E5D5HR"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c36dcb305cso1125523b6e.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133775; x=1711738575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1InE1iBsPO8lNJtIzS4Yn7Gf368r/UVolH/6ljMOV4=;
        b=g8E5D5HRiKVaroklV1Y0IKhATbtSSnMPC9W+rB9xwfpw3UAaOfDzD+tqwzqA2/oYy4
         WKiSrIOdDJdfcrpMQQ1F1nY8LuiUrPxyCng5/fSOIzhoGWCCAE7k3fHAfFn2bNO5qcL+
         /zSrGhwvG+EP5GoR9kOs2IiBc5hBCXZLkuAhX7FmkwSKihxEjJ+Hxq1WURi6JslSHv91
         IkeQbSkem0VkRxbB2SdVBRlmqlFJduUPdgoP3edqc5+mhl2AKP44b4wnIDpC+Qc3/jBn
         FCpBhHy0UUlfG+op5sdEZX2wdl0HGsZr+w6q8b6wgoCal9JMTa87PM9yeD4KEGojdahI
         1R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133775; x=1711738575;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1InE1iBsPO8lNJtIzS4Yn7Gf368r/UVolH/6ljMOV4=;
        b=A87omKwU47MEsFlvBc6tUDrVHi+S3psGuPvkbeioUz1R0ko7FKwj+aErvFIHXi09ig
         o71kQjpWSj6wH/j66zvsf0JlRxnQdrOLvZn6XlZBCH5igzcUXwv47axZ/Tv39zPCBCom
         ilJHtcYEXMY0zwmGJkjqqad3M6zKuvOSvSTQVmywOyCe3Up1QHUhukz43pCqj71AZ+Xm
         O7nB+t1T0SAr7S1P3DMAZIQOgtP7/XiV0ddSbap/hhnn1vEGEyFbwT0avMN/LReWBLuZ
         xWg4nSz/YttikXec7f2P8fFFGWFrl7R5Z4sSCWgauXi5B6UNPk6trKVVaaTTNFEA6IvM
         3e4w==
X-Gm-Message-State: AOJu0Yx13LCb7yDfa/iGfDK6BReALWAN2LEwUzSAr+pZRAfOnPLEL5GB
	acAKUKDOpxpDHd62j0qeiA4wsM+EtZT4rscE3MpuJdtUZXDb1oP2DBgt1uih
X-Google-Smtp-Source: AGHT+IFPMV+HXW5beuJg5DklORRFgl77lcEKSn4WaDA381VOWSw7LN/PX2P8SkEN/o9amkhR/udoUQ==
X-Received: by 2002:a05:6808:222a:b0:3c3:a69d:f4a7 with SMTP id bd42-20020a056808222a00b003c3a69df4a7mr195180oib.25.1711133774772;
        Fri, 22 Mar 2024 11:56:14 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056808229000b003c3829794d3sm33221oib.28.2024.03.22.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:56:10 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:55:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] reftable/refname: refactor binary search over
 refnames
Message-ID: <4ea7gnm5gbuvqnoyxdll3ccxxhr4bmlgzwpjtc7kqzbaf5juzb@5kwcy2qhblss>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <44386818ce681da02f00a498acf66043aa55558e.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44386818ce681da02f00a498acf66043aa55558e.1711109214.git.ps@pks.im>

On 24/03/22 01:22PM, Patrick Steinhardt wrote:
> It is comparatively hard to understand how exactly the binary search
> over refnames works given that the function and variable names are not
> exactly easy to grasp. Rename them to make this more obvious. This
> should not result in any change in behaviour.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/refname.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/reftable/refname.c b/reftable/refname.c
> index 64eba1b886..9ec488d727 100644
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -12,15 +12,15 @@
>  #include "refname.h"
>  #include "reftable-iterator.h"
>  
> -struct find_arg {
> -	char **names;
> -	const char *want;
> +struct refname_needle_lesseq_args {
> +	char **haystack;
> +	const char *needle;
>  };

I agree that the previous `names` and `want` are a bit ambiguous. What
do you think about `refnames` and `target_refname` instead?

-Justin
