Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B719923C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546621; cv=none; b=ibIOjHnVcyCPThQ2Im5AsK8ybRphFXHI4mz+n2iYmApGFY+S7apSLnnxcqBWFNfYGh1Qd4VUsstqGyxg0Vdnc5+01gTA0EjUPZS4L1/bPTyvTATlTt/4JSz8UV3SZL71kf4/WQvCpXCMf2/X2X+4qc7EKo51qAbV4cqP9qyiE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546621; c=relaxed/simple;
	bh=Y0t7Gs9SFc6Wla7Z3y98ZFYpDvBLNHc6r65hmkhyw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSA+LAHgPi4zk9Orq7eKR+cCBc/CfJj/Z0UiSP07uS8zEWK/v4Ibzc0JxEQUobX6Q9CZgqBfJ4eoRWf+f9qCkfw2QbgNZS7nQiht/UxnOkGS5s288QJWs0tYRVPJntZGjzxCWnQLpo+LQvQaejxA/JS1WCP+sR/O08Rw/etV8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IqGnKsGO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IqGnKsGO"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5cec98cceso26485587b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546618; x=1730151418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PABJbpJdCC6TyCWRWUBCz95ASstB8dhsB96fVEP8N68=;
        b=IqGnKsGO4jeWfOljLD4d5nlm2w9LWa8QJqdMloXTMexoi2Y8LBqc0s0FTCSlN9ORkG
         nTZZAeRGGV9t9GamcVGqQS/ZLNEXUMpbVIhQCdM31OgMweFfvGGwtT8T5ITs77SEdmIl
         ZYY8Mv8E0KeBA33VnYBrdohNFuAsk2zsRupbB998jFSu44nQ/w/eQWSWJEtOeupAiPR0
         icczcxyQBeSkW+o1v2FEZCfX4TGlWRWAJjaptAfgzMAS493TN63dRo9yuyBThEnrwwOr
         +uvv2dGXvdj/xSKjCKG0W1Yu2ovmLc0Pj77cMKBlpUIQCDGHAmFmrjOmT/fBtcVoMqC2
         zxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546618; x=1730151418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PABJbpJdCC6TyCWRWUBCz95ASstB8dhsB96fVEP8N68=;
        b=izaxGZOXZ9j99mdMTXL6eWgA0P0NynlDp0XNp4fE0mgM13XvuHU0RtZDjG+ULzmIWp
         mxbCMO8ILkCO6ZiVG4aMekAOllTqvVI9v3k1YVng8w2l+bP5coYZJbNTa62f0CwVgyC/
         X3+ImZE3QFIF8ztqjL+/6EX8Xxxiw4x/BdvpFfoqMMffW+gYEcwNiETaPvrLV2kI5Z8P
         Zg0Iip4HZB5cGrj2OUEJYrx2N+THgn3krTPIifxJjf6gyvwZhb4ZPyEie8V0qSWZqf0Z
         LJE/+VIlg+4zfmH3H+bJ0COaXVnLqEVwlqRbJd3dElMDdNYawYRz3KPTDxeIxzeR4z/x
         QGCA==
X-Gm-Message-State: AOJu0YwSoVGaifcw4wlNAqBl2h4OFs7sasKZpoIlp4WnNuqP8OlrJPTu
	ZfJNa3wW9vKx5MrDZHUmYbLgY6aBrXyd6RBZN7gpbRQSs9rS9kdI58+9yniA2VI6fSOHV3r7TQ+
	K
X-Google-Smtp-Source: AGHT+IHbqlxSYXu9wbKehb0qpsWPmfEMIlCspGbqz0KDKtkP243rLgGld4pJ9uHKdYa35S1Wv0fj4g==
X-Received: by 2002:a05:690c:385:b0:6e5:d35b:ca80 with SMTP id 00721157ae682-6e7d81e6ccbmr5484267b3.5.1729546618542;
        Mon, 21 Oct 2024 14:36:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccc4d2sm8210197b3.101.2024.10.21.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:36:58 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:36:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t4205: fix typo in 'NUL termination with --stat'
Message-ID: <ZxbJeSozYRPattwq@nand.local>
References: <20241020191910.31096-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020191910.31096-1-five231003@gmail.com>

On Mon, Oct 21, 2024 at 12:48:47AM +0530, Kousik Sanagavarapu wrote:
>  t/t4205-log-pretty-formats.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for finding and fixing. Let's merge this one down.

Thanks,
Taylor
