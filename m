Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564F3DA7D1
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696103; cv=pass; b=cWUVCndshwWzxBZv1LpFhdU14LgOKKBj7+ozr3QJHTwtTIzNw4FwDo55ZCIZKqHdS6eJfWUYEuFPXHbk8zoi9FYwzoqXqSgYBVQT7VdaTJTmV8hyNCC/FTPLNM3FkXwWhkxyLGDN0uCwBQwwu8VS7MTX547dTUrsDuHwBcppjag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696103; c=relaxed/simple;
	bh=xx+Vt7bJBA0hskcTWdMf0Mod8QYZxgRkV7hBUesbbhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLvXzVjvHS3aRGE3yWW1/ixUiCCrY9VeLmexWQ3SuMSw/l6UE0ratqKBWddfRJMoaTaMrxtlM2Vsd5EGhhFAl4xdicwBDbIDyTfbSCAg8jB3+FSSrWvUgsevQIfVauTA6hXJ2c6Q6Am95l9Y9y0fNm3nVR4hORzU/myKcu3m+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvgYV1w6; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvgYV1w6"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso240205a34.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787696101; cv=none;
        d=google.com; s=arc-20260327;
        b=TuN2Ch9rdXjWjL8rubWtgxV19YqSrU6IcVkRvrkKZHKt4KShf9foPgrAMLBlq2WKhj
         z646F8dWhvNCd+cf8o6+J22z+ru4t7/f/ec+aqQGEJVrz7+e7cxIZcahs6uouQfIPwQc
         jnPs6KlV+DLaIwhr4POE5YIPNycLaVdOxiUeY1f5uLQoEJGy/p+auvj6g/JjZPcsX9PW
         Hu6jX1rQ+SWFQZY2hHsb4LATeJONQFxNCCYLnBhdn6xweNhX+aVEqT9ZBeoZVSkk+eUX
         j3Lxjy+eILoMMoEh2Xy4xY4yrBx16bGRfwowsG+C4hJOAfXtxVUwd3jqvJdOaxusWHWs
         qChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6YKp4kr1KdnjgstnCFqEAYw6+ngwla7NB9ydWvM5YoI=;
        fh=8kE2VkWfDdS5fLCIXYYt7RvkWfuys8Lc4lEVxWzzsJQ=;
        b=oBYO6b/7k/ERH5DxcLrI/SMZlw1BhXjqKhlLvaE8007ZoQrIhzjcmZni3H8oB8KH3I
         i6c+yQA1Y20mSdsYeoZD2y0SYxv2SXDTMKFXhriE6f+T7CBzm4OUT0yeKhM3gEdnGfFH
         wXulFjVNN+5cQ8M0i77yfiUpF8Xec8XKExB7ufU+f+Pcy6sCjD1GCabOm2noxKjMSrTi
         9tOrCfWRS3KHViJa0qRqe5ldsESfiRgkd3c7l9hwrlV+NBnFIeZqRkygbmR6kwYmcjxS
         iwhO7CfZJCAv63MhBXl5Zb+4BnerWJj/zXzY3jlakdHSxE+coHP2A5cELQlDQyRRNI8o
         C4WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787696101; x=1788300901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6YKp4kr1KdnjgstnCFqEAYw6+ngwla7NB9ydWvM5YoI=;
        b=qvgYV1w6xNVA+itvpi4CrFxZNGSGM0H5S/hawqI8PyC8gQgwCPv7t5rlst5DZ8POcH
         AscTNZoNvMybrPXzHES2ttsSvTJfiYo1vAK5QUsHECP38NnsgVyiSf8DNlPa8WVdmTbe
         U6OxSToBxeND9SX82kaMOetHhED78VfXX9Jx6jjzdRuI871aAJ3oDpOoAZ/d0Lsr83iJ
         +qRs6jJKD9Q8qSsk+tEILRRZVj6s/p9YMR/nPdoaeLPUTK7U7fOxw7p+eZfpnIFksWy9
         kj54o5vxSZzZ8SWmUlegVacZo/efRYdTASpPd+l6DFbavz5txR5b3eGgEjdxro7SjBm0
         Rwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696101; x=1788300901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6YKp4kr1KdnjgstnCFqEAYw6+ngwla7NB9ydWvM5YoI=;
        b=UCaSaLXArb2F44eCrvbV0ZZP05flUc5L5Te8QdUqYujk+rGnrSPO7+w0mwn0h2RNi7
         p+3fUEJW1weW4XqiErdpAYyiOSz+EcyY7ooCNnFw5nZPSEkC3lEXzfmBpi6HP9ymoIFq
         Y7Sr+WuR2qthgUwajB0w9DaT+dP6v/YZefYbrBxacGtuXbzqVq4Sju23xZc528YCVidN
         eUhfdjUmwRZBGwz7KHyhtsU6acLZIwksDksdVOTflCzmu5oEkF0To8/pq35ZXuUyyall
         ugx9vs9TqFH1hIkPNZtC06Fd4CfsUTAuQnmC8EFBpeJqhrz7Cmc/UFlChyU8ELAfkanK
         LpNg==
X-Gm-Message-State: AFuF++nWU092UyoU0ad+3KS3yd26MXwN+QlEABfphhqMhD4BjJS2sypx
	iDU+HPhNX5fv7iLQ1DDJu7cMPrRwqbyVEWUoH9Jb4DkMZTEbxSao/XGPi98d+nu0eg2LSzFMIOg
	JbjfUzGVzC7Sqcn2pAow9iFTZ8DBhUeE=
X-Gm-Gg: AR+sD12a37bJTrRmuQQ8CHhkw4jORxyoeQTis4KCYTaz6+z8sOvnL6XTnuO7unGmNzp
	w+TXWPXzK57sa/7i0qBRtVXm68XpN4/3wC1z5nxUCmmBq+9f9+YU7q7my+6nobYzW954V10gcNl
	7Sf0ORN6KEJxx3YJ8Zco0MOJiRhWM/MRDs2if3oucTpm/t4BE+uIdXcz2ExRTK0sHGn5bnjE+kK
	aIa5DKPERnc7SEBcfsFkvvO3P2MwvQgvlYg9Bw22XkMfEvgC4slrPsf5dX+NQ0QVnDWLUFHnUYI
	QepbknV5xHMymV4NSPSwcgC7YKHEDfHHpnUWMcl/IFhcmgqp4UHCgFWW3yaSxA9nmiRJdTWU7ay
	kbyxn601BtR/JogNQQ8Nsw/A/akDimmYNsgiCfv9dPsLO/5ttp/w09tExbGUaXx7hSvc9SnI=
X-Received: by 2002:a05:6820:152a:b0:69e:b8:ffe4 with SMTP id
 006d021491bc7-6b1a0599c25mr2364615eaf.32.1787696101432; Tue, 25 Aug 2026
 15:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com> <7f0bb405ad380fd35ae6381961ac667fd7e5dfd9.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <7f0bb405ad380fd35ae6381961ac667fd7e5dfd9.1787684181.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 15:14:49 -0700
X-Gm-Features: AcwNN1US4ktH73yy9x3rCvo6KAXkmg0VP0cD_hEDFmsv0YPJjdRv6nhkxSarFe4
Message-ID: <CABPp-BHxpt1UBTY5LCn9OFMZ6EtOcUPc-61RMWvjpjDBmv1rzg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] trace2: remove use of xstrfmt()
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:59=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
>+       const char *redact =3D ":<REDACTED>";
>+       char *redacted;
[...]
> +       memcpy(redacted, arg, prefix_len);
> +       memcpy(redacted + prefix_len, redact, redact_len - 1);

Only copy redact_len - 1 bytes?  So only ":<REDACTED" without the
trailing ">" ?  Why?


> +       memcpy(redacted + prefix_len + redact_len - 1, p + at,
> +              suffix_len + 1);
> +       return redacted;
>  }
>
