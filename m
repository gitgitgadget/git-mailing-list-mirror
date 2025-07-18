Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A01E9905
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866026; cv=none; b=FVIZl63yGAW39W9EqSqcPu4tdTPe34+Xyag5ANUWaUuEWrwjbrS/FQUwQ0ifKHmbQUBJtphbrEQR/sFfpOR9sYD2UDfV2MPG492vtOQ0DpSwb/sdCt63UNaWdiG0CVRCZEjmSzwyX6i0hryz9qtBLFJskFTHfxck5sjfU9ZobnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866026; c=relaxed/simple;
	bh=8a2Fy8IxRHH9tHGHBctSiCRr8m84Em2CoOt9RcB/Spw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SquOwstDTjq8xLlW/w2jAy4S39bWbKU1IAB4tT2AEGNmOd6nFJPGZLTbRGbcQ8wRVg9s7GZDPiigimq5LiXD0FN/4bx8roBwhwQd65hNcGN9Qr3qA+QCL2Fgh2YRDqaY8xU3CBc26h8j736ToM3xBdeseFkByyTos0LFbPw51YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpM+c7DG; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpM+c7DG"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-884f22f9c90so1016211241.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752866024; x=1753470824; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a2Fy8IxRHH9tHGHBctSiCRr8m84Em2CoOt9RcB/Spw=;
        b=WpM+c7DGLar3YCZihbFQesMCs7Ld3vIFHdBttiSxcdQVLF8eiWotOF37jRfIV0kCxF
         OSvFB4ZLzl8Z8I0G7ASbTmb3OaMtR9d98OmqRXZcpw5cPZwRZ3GgMJZq0VNKmC3ssqlf
         bstOYI20zFpyzBrW6VK0LKg+cV+RGfMbgzrJEwcqkWQ1G+4rUJQTcspvckqliZ8EyMsh
         umRDGh7/kq4WQPkBTc/diIjfMH6Wnm24MBNq8R6CuRUfKKNNTMwgA+hrMMyiQTWL4vC8
         rCeRoqthNofgXrDg3CPgL8HjoLeLw04BoI3O5z2abHjdkwW1ZvRKwpmG70jl9bxKPJEh
         QhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752866024; x=1753470824;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a2Fy8IxRHH9tHGHBctSiCRr8m84Em2CoOt9RcB/Spw=;
        b=AP/edmttH59klsD26MJVbtL9GdRftHO0EmujwxA0UXPsA8iasQkNg0ZOiqlOuMODiX
         OaPPPBK/whq6e5OzNdPO3aW/DPMa0GJZ7NlpVSZepp69Gi0x1LpG+jBPvjHt6zd+IMLp
         gHMduv8ZnXhcpyS1r1OCbAoazcbUXSBIY7zsUez1Uil6jw9oFgON+J8mLYCPyB5aTIYx
         KVDFD07oWezUbrYO0cNfHxpVphAnHoS9YsmJAgWtvzflPphL11+XOVEoghR6alrj3LRQ
         ie1EeVy45RJCcha0VwBhk++LzVTE0iW0+Eq7d2G6u6SuhmnPeEfDtF4DWtsIi4meqAxI
         VjLg==
X-Gm-Message-State: AOJu0YxD2s7VkLuESzL8r7WLUJrwzJCvAjmzxj4wEKJ3TY73mxbTvyyg
	38OSxEZYikPZS5NXPQ1Fz+P+ozbGKCzYAGxQX4hPTSvZiLP49sqSpnHD
X-Gm-Gg: ASbGncsQxFQOqHp8XxhJ/EKmLb9A0hf9/wmKesVIdiucrdATZ1sU6HD8WM0x05AlNep
	rLSk811ajTSklL4eT9bliE65iuprE0WOPWpvuBQO2ik++9eFpTuMcs6Zn+ugEycvSfolwlfsSIR
	kf/ReDUa4wQXBikFrt62UQW3kwHWkib0NBVeECFqdMNM+eBkQ0J/yVUbtbuzWmoc1c+FwFE+m4A
	ysQKt4tz4DFgEG+31OGWidNVEJ+7oL3QiPZz31151yBdodIs81ODwshk2Z6wbHCTy9ZIQHcQQbJ
	IBIEAMRkvKrOOZEDiB7+k/vLh3EK29seMHDZZSmhcfs0/EnaqW524J+arrO1f9OxueeRubbtMVR
	BeXj6s3EoJiftl/B9Xl2Roy/48ZqadZOQ07rWy11oiANJ3wIO
X-Google-Smtp-Source: AGHT+IHqBEJ/taOV6PjMrAOlHbvXywznm1/Mfgi3qWomGBHJBQcDdRfb72dTfmPoXHmbYFrK+D4X1g==
X-Received: by 2002:a05:6122:88a:b0:531:2906:752b with SMTP id 71dfb90a1353d-5373fcb7fdcmr6973728e0c.6.1752866023902;
        Fri, 18 Jul 2025 12:13:43 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5376ca72df6sm375436e0c.0.2025.07.18.12.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:13:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aHZCipKCPIu8mPly@pks.im>
Date: Fri, 18 Jul 2025 16:13:29 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <A5D456FD-C8C3-4087-8C08-E931BD254390@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com> <aHZCipKCPIu8mPly@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Is there any reason why the callback appends to a buffer instead of
> printing the data immediately?

Even though I answered you about that in our meeting, I'll answer you
again only to make it transparent for the other reviewers.

My idea was to build the output string and if something goes wrong
(e.g. the user requested a invalid key after some valid keys), the
process would exit without any output.

After our meeting, we agreed that this wouldn't be so important and it
would be better making the code simpler by just printing the key-value
pairs.
