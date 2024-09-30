Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC81A2623
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731377; cv=none; b=ICGtplU+RyhOoU59M5lvUhW2l91deEgC0469tNqzqefELgvLH/kfMtCWsi8/GkRQRJ8YHSKyCdOffsrnTAH3U6xRYCFhCspVDiy6mmKX6Y5KaU2wqWUb/ztXCJSiWUoWkpNPyPPdwXt7pbqIj0YErDQeLuDwv3HrbR7OdJqBHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731377; c=relaxed/simple;
	bh=aqPpdCexaejyMRCOYtW2QofCxcWyVwPEfk3Yef/PW1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1zrTk0TLiJ0lqrvuz5YyQmT1FKNEyU8YFlWOSns1odzikknOhXCRKuBQGPOQ2vRfv2CgM0tDaET1Hq5Ge334OU1QeZgxhyapWRu/T7USui5X32V2yYF5WHd1T8mOSjcVY9HpqpmTu+XypLR+q+r+0DrYZfrDcUyvT/0gTMA+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v8d7qrMl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v8d7qrMl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e1f48e7c18so41364597b3.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727731374; x=1728336174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPezcYC06eoTy0AyLzRxW8+YN3moUTSB1Xn4JQPqpW4=;
        b=v8d7qrMltDrRSnk6oy8/1SJBMhoaRuw07RgoxFghvAEiVWgdYQCXDP1pJ1Ex5dZlpX
         p0AFf9m4Son+VJK/baaqL7qmkXggKc83uWev2OK+L+7ia4bhWiJ+txBswAUiqy/mVSIh
         2qhV+o2PvrtcGXj36QNpkCqLGBaZESjZtXpNIbo/t5T695FPT8Z2SkkXV1iaHd0YSaSo
         vcHTdJo00DJr08y5/Io5lZifmHH5cVnz9jR1Hqrm+c3uQl/UNn0WI6wMHbyn1c4t0u7T
         wpLz/Dhg+IWbjNtv172wcOYF4NnmE+uZ5r5zRp1z3LIwpu3Rvmuv7T8mWmeGnmRre2+o
         0MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727731374; x=1728336174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPezcYC06eoTy0AyLzRxW8+YN3moUTSB1Xn4JQPqpW4=;
        b=DrUKmy3SoC8aa0w+0i9tgFv7HfYmuNo8QpVmVhSdPK2vUIE1eFk2iDc/vSX9H/ANMD
         dXITfHeIQEBnrveM1TQn+eR3IgUTziAYzFOAiFbOaJcGRi6cY/VBpogvs1FX8HkNJWM8
         tSUu9nqZacFInV+jTnanuw9bzSELiSoK814OVl4X1jeVTWC/dD3H29zAXltGNTb9CKWR
         K9dTX14mGff1tpTXr4/5XZmbAHxLcRZht47hnP++iMdW/zrpyLcrnCM6dd1LOjV8snZU
         nXGVg/MrBXLPhaHZHiGL8iio+/f2XFQ1FzgoQNDsIer8Tvm/PszhV0ahJHcxHYOPKWD5
         pqnQ==
X-Gm-Message-State: AOJu0YzkNj/Z9IX5NYvUeV/pBYMbS9b4Y8QGysfXu5/0P/NZ+GFhuzi5
	dy310hPIVXQyLq/SHkmv1CDyUozibU/0+8RaCJBQ0zxCc5a+TGGTGr0NvpTYMcLSfLfST/drqGs
	PR8w=
X-Google-Smtp-Source: AGHT+IEUiF7pjAQ+R8y3PBDdJkmcuZpqjz5REHl1ZZStDyWIbJxkAMNGGv1P4y4z+khjO9y8/IOuRw==
X-Received: by 2002:a05:690c:f03:b0:6de:c0e:20c3 with SMTP id 00721157ae682-6e247518b2emr114521077b3.3.1727731374678;
        Mon, 30 Sep 2024 14:22:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536ce42sm16047037b3.78.2024.09.30.14.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:22:54 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:22:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/23] pack-bitmap-write: fix leaking OID array
Message-ID: <ZvsWrRW2rwylzETb@nand.local>
References: <cover.1727687410.git.ps@pks.im>
 <98228243be04d7ab296ccf7516e092549bbd1236.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98228243be04d7ab296ccf7516e092549bbd1236.1727687410.git.ps@pks.im>

On Mon, Sep 30, 2024 at 11:13:58AM +0200, Patrick Steinhardt wrote:
> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index 1dd6284756..eca4a1eb8c 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -4,6 +4,7 @@ test_description='pseudo-merge bitmaps'
>
>  GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
>
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh

Very nicely done :-).

Thanks,
Taylor
