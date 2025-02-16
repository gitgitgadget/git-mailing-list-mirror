Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FD290F
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739684519; cv=none; b=KQ8CzDcCaJNquiyFrdXQdYSCUs14Rwf4laGxWn/jSY1zpLqecUKRrTmf+Ypea0ZlKcf/C/ZR8hDk9TeLuoDseNFJwC6Ww3EUEZwzWHkzo45h+9S56wTWBbFlqR1M2/e81baWVpoLIUFvRfwqi/pNS8Rl7benPnMNRl+ZuL0cmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739684519; c=relaxed/simple;
	bh=kRgeQhJJ38E7IxUthiRu3QioAINv/Tlm3eubNYF7Sik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVLJwY8CyXU0TaRFSx6zDHWHUmbmkk3G8wBFUeW86MH2lgdSaHwCKY3WXkXueOV4DQCjoHyaNIFqLv1alwe1OQpkrN1K3uCMxzfO7SiaEcYr/D7Y3ciXMLa5z0YV3VwaL58Jox8gKgLNXMVJHhSBIj6I9LDzYSCkIX/xkFOC/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea/FrlQR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea/FrlQR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22113560c57so10611175ad.2
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 21:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739684517; x=1740289317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFAurikrTVhP55+bHL64TJjTWwojYMojVnkT/P8sI00=;
        b=Ea/FrlQR4DN467ufPbiSZ6PCxaFrCv90HSrWiCF8xr43KSgBxv1TiGJL+tNVP+FnhY
         oEXxpVzbUNA/tTWdQq8twSMJoWkYnXTY13Tau/Eu+zQ14BSnMp2QV7c7wyUh/4u2g1tF
         8b4iBIFR5stsXA4Pcll5TNtWPWyTe4VNYmiex70kj5eXf0i+FTol/W4e+ywYA4vp03Y/
         5DK+opA8utT7aj7angv3WOgboo6SjS0wv8Bk17/K8U5lq2/Pizh0DrZj4pAuo54e8WLz
         0FkOe7g1xhjpDSYpzJytjgmthds+hTUkdLT+hR7GvCbBcNhJxjxeXDBxxMvSwlmZi+ex
         tP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739684517; x=1740289317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFAurikrTVhP55+bHL64TJjTWwojYMojVnkT/P8sI00=;
        b=BaiSmR2dVZ08galtoCaEnPFcZsiRT/Og3Vtg1iph9Sph4/bTWiT6Sikllg9/3pHAnk
         im8ZqRYx8jyJVUj0C26QAfTH3bH/xzdgM4DmGCEPDZSRxiHSnkELEDBQNgKzLD2QM+zM
         NDZLrBXEmCQJupNaWIP16d750sZeOdvYtvlTSKzjxSWtQUoIV6/xN7nd7fpi4eP1tLxa
         AJbDcKT4eP4kwxTqdL7R98gHG+pSMhYceTNlX8oTst/LLuRWaJ8wOV5tYBbgRI6F7mMi
         e3LwdkXnHmvwFYNlV5YclT6dMs6DFfoSbKsU9bgyWptnbNPpXGLJiamxR9sHpi3F7S3f
         Powg==
X-Gm-Message-State: AOJu0Yw/MQZinYdpem02DVi6EuHTtPs+3p5OEgdvqBsieaHxEQu7I6b9
	7GhuaQZSKiXFCbqR2vNxRzL3AXUDH3nJwIsQUhO+YKIPUqTDGkKC
X-Gm-Gg: ASbGncuPg1ScbI0wlhPVcOcxw7WUgGBLp+/ERaJPiRxnbtNIjkM3m7Xt9Edj1tmfxw1
	SwcYJTTsas+7Uv1J2HOz7NDxmVpoCTak0Qs4X3vSAWWGKJagK4nSBkqEpoCQbidjmdpE6CT13NT
	r54uaY3Mr8wt8FLK0pK9rI7AldlsDuUKc8enHg6obtiMpXWnWKDzdhgQf4BdnlFR1vZdC99ARfN
	LYKXETQPL9nqWm3IBPy8ut1k/EkLvVO+eWvJxK4zRXe6DIHzsvkDGkHK74X6jIiv9zXspuq/Vg/
	vI3iLu+/Av0=
X-Google-Smtp-Source: AGHT+IGyejDXPIz5aTOdDrW+MSQeQkltex1uyJiteK4g9GfQBitk1Oc4v70UuVI8O8v8pVC3H2R1vg==
X-Received: by 2002:a17:902:d58b:b0:220:ea90:1925 with SMTP id d9443c01a7336-221040ab9b3mr99337525ad.35.1739684517144;
        Sat, 15 Feb 2025 21:41:57 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556fc57sm50967295ad.194.2025.02.15.21.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 21:41:56 -0800 (PST)
Date: Sun, 16 Feb 2025 13:41:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com, ps@pks.im
Subject: Re: [PATCH 0/7][Outreachy] stop using the_repository global variable.
Message-ID: <Z7F6oSEkg4JSs9bp@ArchLinux>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>

On Sat, Feb 15, 2025 at 04:27:16AM +0530, Usman Akinyemi wrote:

[snip]

> Usman Akinyemi (7):
>   builtin/verify-tag: stop using `the_repository`
>   builtin/verify-commit.c: stop using `the_repository`
>   builtin/send-pack.c: stop using `the_repository`
>   builtin/pack-refs: stop using `the_repository`
>   builtin/ls-files: stop using `the_repository`
>   builtin/for-each-ref: stop using `the_repository`
>   builtin/checkout-index.c: stop using `the_repository`
> 

The commit message is not consistent. We should remove ".c".
