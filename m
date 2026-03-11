Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8F2C3268
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257465; cv=pass; b=B1/a0cbTnzXUaHwYKlZMOkYgE+hUpmAhsv0RPVqu/Id/aV5D0yCJOhsK+uXXJ901PvY5YPhKIT9Nhte1eCKR/1SxVB9UkOEGSalKKfUnj+qySvnlNJhDT5xdTE4K0GQIsrO0GK+lZ0Ofwsvi/vH70ThKW/TA+DaHstU5rGuVsGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257465; c=relaxed/simple;
	bh=l4TBorr/klKY0i1O01e9i5Nr6CGqxWUzD7tThiQIqw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTMcpEzto1a/L9Fx+m/6+AyXR6Id2DTZhnqEFqaC4mV98Ip9PeZoSXdaZv15Y92zFYYxRllKVvmI7S/YYHXS5cFcx5QAfRTWR80N+kkuZMDrAuWpX8W/4mDL9pDwL27u30yUpyhz1HxVzBEBGjofTidpSfJj4fwVEFiaKZcdFAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2fRvr61; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2fRvr61"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64c97997b0fso214438d50.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773257463; cv=none;
        d=google.com; s=arc-20240605;
        b=X9qr++TN88IuZSrUJb/95vQ3AviXp0inInTFYMO2FVjWvKgboG+a3eYoRhRu03+qU3
         eCJNBAEzJR2OocieA2ddKVbtHPclpqAb81qzqcLdtRtsvvLV6Q8AvDyltFIwDLdaVOQn
         XAzUr38zjzzyRnxY8l/+WLIP4qsMpJbeAd5WfaxCaqXYS6IMD/qweArDQl9CgSq3Grc+
         ssA8cTuqdfHwmMxTZlsA3joK1PLy0HoMkD7XVXuRIGSWCJTYrDUHalwQfkqInAVy0XUV
         dJudC2IiZwyiWJX2DcWndsBO+QC9TuGyKkBK+klT8XlTCk9v8FIVMgprQWel4IDt4p5O
         SaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ko1Kn1foYdD92T6XhYPOslz1l64J/2lHnsXPHfGCjXc=;
        fh=IFfuuuCMTwrsVn4dOiTNZ75UnTag8dwGLD1TGqo6Onk=;
        b=UeTemdAmX5DO5NtyZgpKD2F85/MopfJOmzWPsTZyqkgjwR2ObWGGestMCovl1wknP8
         lZB6119LZ50apTal0uVELWm62SqOZdIAE3wKu2Q5uaOzlg4m+n39N6yTkadpwSENaLur
         qDo1B65ovjT8ITi9tQqaFxYo+KD1iYRBzT5LA/shuRnOPD36z+3iGfrsLDcnY3XGPXbQ
         iJceHfNGlqILBp9dW+kNwdY0UOVM/KVjnbFON0vR8OINSA46a+TMLQIZjqiAKDoGH4nn
         ZVV5vFSwBnkUrHYTroSvOYEywrL2SnKS3L0JIf1PEy5tVViy9/8YHWv2rPkSIBXcIpV/
         XTgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257463; x=1773862263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko1Kn1foYdD92T6XhYPOslz1l64J/2lHnsXPHfGCjXc=;
        b=F2fRvr61cOWzaI8ozBO9xEWEL9MYmAFFMU7OxgyjPUH0tPK4ZUtOn7ym6r/zW6Zwtm
         K48Byu8l7fyaZytQz8nigcofigAEGZzqS7aEbqGmzZ/L+t1rD/H6lYS8e/hxLRyhGzGP
         1HrNrwxVc1UbfoRxhXzkOVo3df0rm8852JRB8H93znF+zr6uts/pBtDPaMqBgfdYeUxl
         fDi94CL+GLAGEYAyF1oMOS6EJIsSumIyG/h+zT5A4118qs5hgdJr/U0JahYX1crdLDeT
         DNYB7GThI0Y8clmAeVNuwQgtLZZJDfMK8uoZhSkNKjV4WhR0REPiWz+PvOOlO7epU30/
         UCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257463; x=1773862263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko1Kn1foYdD92T6XhYPOslz1l64J/2lHnsXPHfGCjXc=;
        b=Z0/hnjV0Vsp7rifV9Rgf9P7mpxoCB9r5zL5AAkac0RBNBGwwsWPqfgoUyj4+iXkDmo
         3ueAWLPQ+ITrycAwMS9bid9E2LpW6ZNyhcpcMMu/7HARFsjKWK6mQexjJXUNyCQzrXAm
         e3smQuKIGD9uahP/VR3Qj+TEfeNuIuboYMSdZVGFOBnKZDK6PHeSarwcmCFv8/Mtbzl9
         wg1nJPzE8Ejo/nXltJSfSqyR/73IanD3SVY1wRGpTpv8QDkPe57uDMAzy3wqRLszM0H1
         GSsuBQloPqsq6PssNz67gSirz3D85+Pq9febHNZiz+kUqJiz8KMzxSt2/gCukvJ6Q0Tz
         vDkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYIBrVrQ1WoBR6mTSBibH2thg64/zFK4h6TTeEKjMNbkQJYVWWNla5pVQhvlZ3rLpqWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp90cwr+Fn+OzmQkXdrD8DjvxRpoIOoAj+3JvX49+rpqCQnB8V
	IEptOySHXmaCXBOzvW5VBVeUbsn+mWXi790A7UKyXqbv40ZSgHAk4mO5OBxSBu0ROfJSaoJQAD9
	xIYJLyWByb0QhBTuaA0behYAd6+crI7N3PfBAsYs=
X-Gm-Gg: ATEYQzylNuO/GaNRYuHRGlWAqL8oSsa/NQc0I+AjTeycBMbT5QfUeeSdE8N952Dm91E
	H5OyW5q9RqYEVKpRl8Zm45dUy1UhrDEfcLcWOooXgTy+FMI+n/NM+M6KqohcDUhEgGtQ8wzQTMh
	mRo81k5cqtarxD+ybXM1Vyq5ZzN7G5aGQHBaR3w+tj6WGMGCZr3Al+KgdVS/GcoHm+cbpKjzE1g
	jyxlmsbopI0eCmLxvlSeY67v8rJ1ZWyW7VmPpH2GJxH55Hn9qmFbpjJz95WDFdev32k9RCvfpBI
	0pTj4l8ifETPBCGjJ8ZV75NZEXoD2NJEtB48ayWUmc/8SOM4Ig==
X-Received: by 2002:a05:690c:c4f9:b0:798:6e69:245b with SMTP id
 00721157ae682-79917f898ebmr34835867b3.44.1773257462921; Wed, 11 Mar 2026
 12:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abARj_VI9n2nB_xT@pks.im> <20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
 <xmqq1phrtoen.fsf@gitster.g> <CAGWgyh_dJX7TteKjwVXUwnmUL5kmZifpA0a4n1RiwRvCBEY5gw@mail.gmail.com>
In-Reply-To: <CAGWgyh_dJX7TteKjwVXUwnmUL5kmZifpA0a4n1RiwRvCBEY5gw@mail.gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Thu, 12 Mar 2026 01:00:51 +0530
X-Gm-Features: AaiRm53NhInd7731FWXO4fXpqEkQuXQnTy4PODJaYrr4j-PmFf8Fy5LV4zktLLQ
Message-ID: <CAPvEtrd9Yri5LQu9DiMAO4EDquyd-JxwNBGn+h=+=E+oKJ2ERw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/help.c: move strbuf out of help loops
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, jonatan@jontes.page
Content-Type: text/plain; charset="UTF-8"

> After looking at the refactor of list_config_help() in the
> other active thread, I agree that my optimization is no longer
> necessary.
>
> Amisha's new structure with set_config_vars() and set_config_sections()
> is much cleaner. Since the logic is now encapsulated in these helpers,
> my proposed changes would not be applicable.

I feel removing out the strbuf initialisation and release out of the
loop is still applicable,
I have added all the parts in v5 which were not fixed by my
improvements and tagged you,
check it out here
https://lore.kernel.org/git/20260311192151.60489-1-amishhhaaaa@gmail.com/

-- 
Thanks,
Amisha
