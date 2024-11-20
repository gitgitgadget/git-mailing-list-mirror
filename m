Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B615855C
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133521; cv=none; b=OT8PvnTGP3Kiyy+Tq9+wVKkFJuoPRjQFhexc+egN928UBcvWS14fo8S0sUdtFctw/3Kxka45Bk1r71Z/N3FU831zyoGUp+jstg1tEoAz1dCk9qpblJp9S65pnQRN2utHSA3yC37jub5TZ2HYx6QBqZ5neaoXuxrVrbgi8h5JTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133521; c=relaxed/simple;
	bh=XXl2LYyQi7uLlbtE3Se2SkLy8+mfodl5iCkDZ+pryfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Jx0Kx29LKSJF7IrKxAnpmv2qQfY1vcjOp9q3tlVSFllx8JnC98n1fNsUbmX3CfgEWP/PH8HkZ8xQVr4M2xYbRnCAWB101VztrsmRPXPJ87joEG2l5APA1KiY3BHqAKL+Xcb1voodPLe62U5VldxlWjABlJcSceX3qNXj8I1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=psI2YQeR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="psI2YQeR"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eeafd42dd8so967237b3.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732133519; x=1732738319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXl2LYyQi7uLlbtE3Se2SkLy8+mfodl5iCkDZ+pryfA=;
        b=psI2YQeR7OpBr3dznQe2cbo4ml7BDUoI2Ad3nk5voVk6uSjMgzg9LNCS3BdqOcQWjv
         dBffIcR2aEcYSw+4Lb9NvnJDQsi/xeQzPzJaxYB4u001s/rNKxQCFdZbHsnN9Bl4AwUH
         PRTh7rIJ+KlVND09EgQtO3+z8dWtYKNUQxAiOtZcnoKAius4uWdeZQbAa8juNY0vXFnY
         ve3SUetrMW5Vi20qoYVs/1r2Vvos3MXDunxTMoXuHNRZq4ES+d30tOMVF5acxESlIkGa
         CZMi71wHA8C0NqdGqQHLw3ioMoPwzAJiYx+hfo6lOx9bCUk6ljSTzY9juZ0fg5kqSdXM
         a0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732133519; x=1732738319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXl2LYyQi7uLlbtE3Se2SkLy8+mfodl5iCkDZ+pryfA=;
        b=AJF7+frlOhP77OYNW3kDmhlO6+N6/iITCGRSGM9G+daPvmiryf7eH2eI/xWfjOPmay
         eU9TD+Swtp/Ft5NW0mTJo6X9iPNg/CYLlLsK+t1hQQ/gzIRvhYbYX8lGTxvQKKl+oDoW
         wbZwjh4eNPZNOY4/BUJDvxXBUMJb6uWitJVKlr10yEDqCnQMEkPCOE2gttMSkInE3x2u
         pUDyHwHEwuow72GHD+WFOdz6G7OAzHVUGOHrZipnBPOiadwk1+pvkVZADGoVe7dV6AeG
         j2nmfcvsjpwi0ISG/4QGUIJg2La8mRh6o3Jr4gccdGzVDpTThbFF3mdvfEe+BGkmj1jW
         d/2Q==
X-Gm-Message-State: AOJu0YyhMHFd+FXMOqXAeLKjPXsDotzQSRZjKBIytgqiHYUMkA7XzSsX
	1j4EAquHDKBjPg6PkQ4c3St2GSLKvNBaxIOwgMlOGHYeKQmQRWb9dp2orCTT90wKf3zQyAyg49i
	W
X-Gm-Gg: ASbGncvlfOfWn7tdxGM/HeJGndU6G1YVeRYrwHrGHJxqOQYQfID1SmRsZ+vwKX7n0J1
	pUTOx0uWdN7YrrBi5s7kOTOFxbfKe/yxGksRAt0a/IsXKNhPsBnz+PA8jmgRdAohUMPvcghX34Z
	0T5k0by5rYzycjGu6/YPWDODevR+rzwOBpAtERVXayHdouFmNNnLKyFCa/Y1n56WNw6JgoEPLSe
	7nJtY23jHgPqrf05+vc0bN4L9B6Sds6MO3BAZcOfzhAf5x2PCfAUSRbSdEgw7t8XMB1IVBhgJXQ
	9XjPwj62lHo2BEFaXXH8cA==
X-Google-Smtp-Source: AGHT+IG6dVgKVV+wDGMUsfkA/Wy5XBhz7zyHLZG7Yr9EzpOWfAELuda8UlMrC18uZeZTbw6+W5c82w==
X-Received: by 2002:a05:690c:7209:b0:6ee:af06:fdf0 with SMTP id 00721157ae682-6eebd1390b3mr44900497b3.23.1732133519090;
        Wed, 20 Nov 2024 12:11:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7137f39esm23920917b3.121.2024.11.20.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 12:11:58 -0800 (PST)
Date: Wed, 20 Nov 2024 15:11:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Subject: Re: [PATCH v2 05/10] midx-write: pass down repository to
 `write_midx_file[_only]`
Message-ID: <Zz5CjWrMFozkEBh9@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-5-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-5-e2f607174efc@gmail.com>

On Tue, Nov 19, 2024 at 04:36:44PM +0100, Karthik Nayak wrote:
> With this, all usage of global variables in `midx-write.c` is removed,
> hence, remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.

Very nicely done :-). Thanks for cleaning these up!

Thanks,
Taylor
