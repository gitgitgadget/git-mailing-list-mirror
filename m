Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB928D8CE
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232051; cv=none; b=px/rgp2jDPnfVy+Ws6VsOP4hk6Y3D9Js7bUtgzborKTbJJpwHDpuM9t3S2T1dQAhUew1632u+F8mkY03GRodctr/OFZ1lpSZH+aj1cKdcL+bh3l/HKn0p6aan5L0pwgFtOO7hAmJfxZNW9/d9isBneYKAEwG8XMsUe/ZVZJW1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232051; c=relaxed/simple;
	bh=JPRdZh2iMl7zF3hbmqTQMKFG3Y/A8f7dGltD2qKBCZA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vCGTkJJMcs9QtoFVkBKQWv8qZupstTaKijKavbjnMtmO/sWognNm0gsmDbQYcyv5LY8pupPuzrC7QSVvbewnLVYGdlLA8SkdPM08PI8NRdkI1KlLw6frqDBza5fJhqczr/qC40Z73qFzE1l/YYQ85xoXQ4wAFq52M20w5qy5va8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqKGWM//; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqKGWM//"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so4361335a91.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756232049; x=1756836849; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwqpxrPRK7ZIKFRwr896Rq2joJyj/Y30e89DOlXh2g0=;
        b=HqKGWM//4+paRGwjr9sK9vcC/lwVpF42nOk4/mSLvmpZ4UPsx00Flf2a9XY9DOnoK0
         XmXXu1V23raxob40c8Gsme7HwkqJg129zaO6oJlrjmgKfi+bEvfLxqAMYFtsKMrpcwY4
         0sm6yRXYyRUA11+P7kfcrFqAnZU2czi3eYx1uPKnem1OSHzAOeThAlkwu3UU6Vqdm8PY
         Al81ps97pWNPKSR6iLSUv7w3rapu7maZYh32GfOyiCNR7x8oDgCRQUIu6xbtg+mgkIwq
         /F3+dlK8ZsdfHXZvqmleCEjSnwS7rPZNuh9mIZXCQtJEWY9OgAlTOXKVjm6OdV/WPNfp
         FDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232049; x=1756836849;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwqpxrPRK7ZIKFRwr896Rq2joJyj/Y30e89DOlXh2g0=;
        b=LO4erO5UStX7FLRyKsCK2zZ9a9wAakbMWJ0FxOEwtc0znxJG53JQ/6eIAWF8WRZtNu
         F6IlW/kGOvGR1+q837VSuP+xiVz7JjD7a7IXlMRjsBTSF5Kigi7Wk7bOWYsNwRbxBVV0
         45GmWHUZMDIFssO2Y44MrvcTUZfpPjqN3VcH9Cn+y1Twj9KACaAAIcQaKi6jmQ+L8OtR
         aq4iznZbD8yCn02t/kTVryvwnxBhG5DONsNly+4PeZUel5j8U9WtKvBFzP9Mye6M4p2u
         m4XvWrHTVWB60PMfQn1l9mc0zi6/Emd2nb+XkdWZQCa0CWmp+01E0zOn0Hi/vYz2v7us
         QNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYVWGMZtD6A9zE1C6FPXgZQAg/Vr54AyYc/TBt8rgdyJHJD8PpxGQ5Qa47jb4WEOjlWuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67EOkg8IVNyI/WB4GqzOK7Z/9dlftMbkC8kgTmEJc1zc2zQNb
	Ua2g9Lv/ZnAQzca4SFCfaTWnM8yr+MYUNzI+XhuwcqYkrp0otMRaPKI/
X-Gm-Gg: ASbGncvKLLomlOxxVCtDefEur8d5v6eqwnMtp/OsavdGT45RD0stnpTPegiyrIVsFNG
	pgUaCymzKv0aasvKJKYAi+sz9BNdccetaVEwUTCWRcuoq3oASD/aXgt1oM/bFaAZr42BBA0MX76
	B9fsbMBqYKOr+qUVIWshNTJGyb46rsp0D+RE1zItANCa/HermKK5b7kyRRWj9W5VfzWcp4H/gOK
	lCnCjrhdLDBORZpy6bUPsjnkOWp9eoFRsWxbIfZiwAgdXz7gLcmFQXn/Ezjxtces7wAK2/XUBll
	ArU+nXWm5XdiCL3b6kqxFiDunTwlWuW74+4fQLxr3JFFa0yUTknjyUge2wIve+nAVKeSJ39bnQY
	hx+SJw0T8+WQaPuOEUFYcWxbDNBA5RpxnGmW6vfyV8vBW2gH0n22gtzYJ
X-Google-Smtp-Source: AGHT+IFpnXWnCVERShZ/jiFkv542AzSqPlpD+dK5VGW7aTXQ5f8cjLKO+6lJzwaQ9aWYAZI5AWLpuQ==
X-Received: by 2002:a17:90b:3fc3:b0:325:55cd:9fd9 with SMTP id 98e67ed59e1d1-32555cda1b6mr16771696a91.28.1756232049065;
        Tue, 26 Aug 2025 11:14:09 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276b078d28sm131427a91.17.2025.08.26.11.14.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 11:14:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq8qjc37q4.fsf@gitster.g>
Date: Tue, 26 Aug 2025 15:13:55 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <8EB9C032-6739-48F2-9097-9833FC3CAA28@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <aKb1AfeIWB_SfJiI@pks.im> <2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com>
 <xmqq8qjc37q4.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> Basically you would want to say
> 
>    This is built on top of <commit> with <topic*> merged into it.

Thanks!

But given that lo/repo-info was already merged to master, now
it won't be necessary... But I'll be more clear about that in
future patches.
