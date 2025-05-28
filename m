Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5054764
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398110; cv=none; b=QNY9Xkrky3ohOBYU9S/aSlFClNg8Kf7flaZqF1CjfL7lwi2Q8IVND5aGO13w23YMd4S2VrG6f5ojC/TSYdYnLch1d4YgawkWxfNaeBKCduQS3bu6CKBRLRmaKlXse8JK7PT4SGLTOkEcbvKunzj5qvKWU+sM6/hlCIugcTo0erM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398110; c=relaxed/simple;
	bh=pZ6kljvIPwT5TBnDrgh+nzxtKbpJe8669M3GrZT5SbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfTDCNtZ49xyyHWP7LApRv//hL4FNORi0OxEL/PeBTh6E5LznJKg5zOXuyFc+tnYIl9vvx7LeQ7apVYIFPiiwTcOOkTSsmZ8ocSBSmMuyCOpr1T230ByY6kwybI2BUTLnFnPYYtKgZMX1ckVVAlZSq+himEr166hBwIg6KOW8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bFGfeQTb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bFGfeQTb"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-477282401b3so39798591cf.1
        for <git@vger.kernel.org>; Tue, 27 May 2025 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748398108; x=1749002908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ6kljvIPwT5TBnDrgh+nzxtKbpJe8669M3GrZT5SbU=;
        b=bFGfeQTbvw3XsZ06HFdwbl1LbvNoIxuiFPfa2Mmwqu95/LqMGWUt+agjb0FXHvNV3P
         WJdqaOst93xixU8JIQOnxHeTIcGdgNvRDJFrGaTtaHeiOErhq5UYnN5iUOnsXyPknLxX
         Pn0G82tKFxscRTA+XHuXkX6vBOvHPur/pStags4YWiYu2Hw1K5tn450VX8clFtsTCoiG
         1yIBXFZNOjHllgesDNsdWQemvRUVdS9kLE/NuKaXkkBnMkj0YTJ/D9kyuMPjvWrt4Fsx
         QHRxS2U8CDjeVoKjtgHoBHORAe2cbQwwJ3OWCVJJe4XjK+7D6QOGLwYU7CaiVp7UYKV3
         9Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748398108; x=1749002908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ6kljvIPwT5TBnDrgh+nzxtKbpJe8669M3GrZT5SbU=;
        b=K/dc7VuS0qyQd2flhHh4VWLGbU380sZ8p/A/5YpUVJAHfx84cRUpDPcDMmzInJvlL5
         fhHinnYtiFz0fiK2nuR09DVBunBSg+/lgWTofD1Owtkmk/2rDyFbAUy2WybyYgbVp9Jb
         pQvcMA9CEgS3HhJKGoB7jxoop1zpTma1FeDZpVEF06mV9PGOB9A0KxEC//0H2jc8oTKG
         MDIMb7pgG+fhkR03yZQOt1SbK3ZbzxLg+xFrnBH11upLYoi17ftlW7g5tC80/6hELEtg
         KT93EeTFcjuXBHfKcQMEupArms5k294d4yakdX4EYiCE/yFBWWzOvhndVF0LXmI/Xa+F
         cX1A==
X-Gm-Message-State: AOJu0YyLjeQ5gE5tgMD71m9+Ye4OeN65gJEmZSZDVvlvBtFtEB6xSajz
	ph4WnvgB4Vx3TkWx+h6XjKuAUwDMAtU1b9ip+mnVRXo7KF4VEmkjguMK0Bm3jWB1+9Y=
X-Gm-Gg: ASbGncsQuMGT5OrAlPysXRtsGqE9OtuOu7OW1wBWGSUYeCjgA2JVY02FuLDHV6QJE+D
	g4dDx+w6YiwqVNieq5zapibxyJ0YbRIqplPO6mmZr5sy2PGGDloBlRbmdSyItbBx8IxCPDlpbKx
	ktDuaBC6ggQCCsTe/576KtUMIlMLZdgx7URFSiBuomsPKhu80RZgobOKIIeJNF+WF4AUIz/gc9Z
	sx0PyisqKcDtfq6RafUnaMYsGAAO/BSpLYFuGsdLODdTPl4JcYl3RALuD9AqDx0Y4EQQi1icfmD
	hjuaIEoztqHmM79m8kZAryMZnHLUvg1M+JFE8TxvtkET5AiBuJezwLZLmljTXDcTDIZtdkAU8E4
	g4r1c73Dej1CDY7ta8Imdw8k=
X-Google-Smtp-Source: AGHT+IGhJsxTO8GYhT7+csBSOViGGKZrd9B1CBdyCWfE17+fWWKrHL0VLBg+wPp1NYqrNRHrQ5EW5Q==
X-Received: by 2002:a05:622a:5a96:b0:494:acc8:b4ce with SMTP id d75a77b69052e-49f466580b6mr287112001cf.11.1748398108004;
        Tue, 27 May 2025 19:08:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fac0bc8d4esm1020636d6.98.2025.05.27.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:08:27 -0700 (PDT)
Date: Tue, 27 May 2025 22:08:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] midx-write.c: guard against incremental MIDXs in
 want_included_pack()
Message-ID: <aDZwGsBpTjTwe6BJ@nand.local>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <d2f9645aa15b58824531fe5d981d2a73372b9482.1748198489.git.me@ttaylorr.com>
 <aDQXDOelx3fc8W2n@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDQXDOelx3fc8W2n@pks.im>

On Mon, May 26, 2025 at 09:23:56AM +0200, Patrick Steinhardt wrote:
> On Sun, May 25, 2025 at 02:41:54PM -0400, Taylor Blau wrote:
> [snip]
> > So want_included_pack() is OK becuase it will never encounter a
>
> s/becuase/because/

Thanks for spotting.

Thanks,
Taylor
