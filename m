Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8943B3D5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048679; cv=pass; b=t3YmoGTxjgGle27M/i2Kfhctb4C0Sh7e/ja/ZGYspKSanO/D05hSWadM0/hTlZzfMtaXdGjGpcNv+7Sx2sKFGIkJNHaiyHXcbEsKCbcMyv439ql5jA8DG9Ovi8xOVxCb4KoCGhuzPpxVToyTovVGl2Cc/F3ngfVNR5IOD7RqZn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048679; c=relaxed/simple;
	bh=9q+90G6oEDhbkoPo3ooP/1XTjhRZ3VySvBqkrwtLPug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCSPZR9CBL1+lj2G6JrO88xEqW+n2GBt0y9hcMKO3VYJmFg5Xy0MYyL7k08AVArGZP8kFVe0eyBfnoq78E606yZ8J5WMV7NcIl/vtoBcnd559m8LT4VoSvmSSlBNZbRtywykwlxricc9S0vKZsDhrc749BGWhKWZ6L2wyxAC2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7kJRNlJ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7kJRNlJ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso1080401a12.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 00:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792048667; cv=none;
        d=google.com; s=arc-20260327;
        b=l/H15kKjAVydwPmpjrvwabaJ4WaG4JoxRleVySkcF7ZE97422/+/YqnWDqch8Vyd3l
         FRn5CWic76Hq6GGUfz3hGH23E+RgGpVlmCTB07/nN6zb+q+6Id8o8ZWTOzXXFbe5ARl1
         YOX7leWujYfksC/T8bjpfuKFepdmAImOXB9YHHKujiYW48jhUR3vRa3wp+jBYqDOyvPD
         sHGP5zf98GNsa51I4QbUtSFYQHfBHSWutknGZhWVKc5wa6BQ0xTXwZG70pLDIblag1Oo
         diip6uomR9+enjgTeZMGLsN88cX1d+tkyRRPZ8PxjtUd6h+1qkFIX3+t4yfo3zjs68nE
         SsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9q+90G6oEDhbkoPo3ooP/1XTjhRZ3VySvBqkrwtLPug=;
        fh=O506H8jHtFXDx8D9z8K73AphRqpFfujhGonOIZpTAQk=;
        b=DFbxCmi3sMwzBd4Lj+yuvpK00Fzj9rjRgP/u0q0VyMugzoIvfdKwSbhhzzYJLiiElj
         dY0FYMzrWuxRSl7Nkxx0pqbLty8Vb7EoOtngLczX6YayRFyOxQhXBo4vd/UuSahUuBdX
         QpLqKbjFPCJ9s8Nsr7Ev22gUiMK2tP3Tfb5MLy2rrx9ivHWMB4LVIOWrKCZU3zzR60Mi
         sjU2vOM6iLJaAtNTP0PKR5M0hyCbFYiiKux5PZIR8wp4zjt5E9c7FPPDVr/dOwvfvcOk
         kt2d2JPZ51NXvlstVDL5mi7+BcdlRIU04mNRrC+NXp9eU9dEqAsveSV7/gquNJ0Nim/s
         yG5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792048667; x=1792653467; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9q+90G6oEDhbkoPo3ooP/1XTjhRZ3VySvBqkrwtLPug=;
        b=N7kJRNlJZh+PVVMcBCD1v+ZFj/Z3zjuMyB0i/+cCFXWrIvzH77cHDjElkMy6rGD7cx
         71pHDPJdHt44KrDR7TP+FEA9u6UtFl0siex68an+ujFul/XOICqlwB0k8LBdU8WfHm8+
         8GHeIzALsFbu1A1kzxz1/3gwdh7mShJ+jxyP2x1GdGBQSx9bBZiptZDJCG1dllWsG7u1
         vG5wm5DQfB9x8/UMvPB0lknJspGS2nj+wIMdnXdxZ68ejvXZBy5OudLW486JYKDYvf8e
         slq2XIysqJqJi9AP3SMkR8Hc6W2uUO1JNwShW37t7RqLAp+bXKx9CV+LooY/R9nh6FQv
         tJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048667; x=1792653467;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9q+90G6oEDhbkoPo3ooP/1XTjhRZ3VySvBqkrwtLPug=;
        b=YNunJKNqjU1SrHgXOMIKEwtiyYudiW5sbX6rsU75D0AsygVYm2oFdHfQdBtzk15DoC
         7JLOsRX76UbJSfx58wzM16RL/R4SZ/FZmV1DWcWfX2iL0ZaOyF87YFzkNJurtuHEPDMq
         9flihNckJBW4mmWxJDTI1mP5vl7u5uThiBtQ3byUBm/avK1Jz5Erpyv6Eu9AOx+uhH8Y
         DrSQywKlm7NX3p9Z1JsOtJ7YNS0GC6eu28vuObCh6SHtjjeOatDXOtbiXI593lyMc/YL
         BV6nQYPWeSikvnTdNaftRX9F3xcSVxnKyJrxIOmXF3Ibm9FWCkPj+hYNNpR0NRb2vkxO
         Ibrg==
X-Forwarded-Encrypted: i=1; AKwUvBxF9AmFFgO2jFhhJPS8U62q5cyZC2efqefDOU+fA3esHSu17yRRoj94GCqmFUmhvdKSzio=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgmhUGe6DyktghuhLTAW8Dt0TiqGM+EVIOW/hxpLttjYJQE/Zk
	xAxRIivMlWglc2h5Jg1bzNPRubzqIN2dg00P6HiZBT3kEo70eS0y3Jlnan1wU7QBpWD1FWqPJeO
	wL58qbJx+PQUjLzXEjiShcStd24HRfqKP0jTx
X-Gm-Gg: AYBFou3uGavvjd+SrF0FpnU7z2WdtR6mGS8P+knBtnsbHs2vdEhPChY668SGQi2rOIT
	zJQdhILS0k7oXsTib8R4w7NZtruZNRPUggmU4Yw870pfTTAm8f/yuABhWEfkn06anEl0EZKgOHE
	6lvwsnXZNYU2blez+tPpjlRbcPit71+zGmOyKxk+Ct+x+m5Gxo1CiVNJow/5n1moMkkiP3zN9E8
	a7morLYQu5sr8q6+O5Liqt4/sndcZmerDfswhi1QxKm1gfB7b3LcB0jGX9FO3g2bVcTjXRA5X7K
	SqAGbLzw0nqfs2vEolumI0tEyb7u4c/AFpRV6U3P5ZquQiuBISODw1d2
X-Received: by 2002:a05:6402:44da:b0:6af:bc82:e126 with SMTP id
 4fb4d7f45d1cf-6b17c2a2519mr11212213a12.44.1792048667051; Thu, 15 Oct 2026
 00:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
 <xmqq5wz4rthd.fsf@gitster.g>
In-Reply-To: <xmqq5wz4rthd.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 09:17:10 +0200
X-Gm-Features: AclHuK-TBPy7C4X-DpRfhOxasqgSMJ8GYBlkej4KGYSzqLudvUyvMvq6pyNZdpI
Message-ID: <CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
To: Junio C Hamano <gitster@pobox.com>
Cc: jyotish kumar <jyotishkumar725015@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes, seems like a hardcoding bug.

Is this for an in-flight topic that Jyotish is working on, or
something already in master?


Harald
