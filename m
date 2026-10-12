Received: from mail-vs2-f6.google.com (mail-vs2-f6.google.com [74.125.227.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A34C9010
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827225; cv=pass; b=WuizQkgQXtBIZO9mYROozH9Knb3Zv6aG3JJdDV7Bxl8RjAxfFnKfQ343QtNDFG9vt1W3APVtrh1wFUQXo3+bycxhvvm+28Xxz8ro1vkdZKQbRPaewE4xHih9wSsLvAJUR8OerKcAqyVBfVgeeOIezyShxJHjniE2JxPmZ9DvdbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827225; c=relaxed/simple;
	bh=sQGMcH9wVTw4eNUQfhW/eWfhrc6dkjQjsTlPX4uG1BQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OJytIpn3XFCYazvrv3emZgAgcoIFzn10JDjL9b6nJxAwDdiZiAuB5ax1ns5fyVoHRjGRjRHu3gcPhzBo5HeW2sIJdyOAXzVmhP9aWhITqgKopESE4tBf4wSYzX5WUe/mhLJabP0fYKKEoC5dI2znTXg1mtG5ZpzazSdJiojj26E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri+zV3kf; arc=pass smtp.client-ip=74.125.227.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri+zV3kf"
Received: by mail-vs2-f6.google.com with SMTP id ada2fe7eead31-7c02963ec8aso633976137.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827222; cv=none;
        d=google.com; s=arc-20260327;
        b=O8ur8N8KtWOgzoj2yzRfZMhxm+Bk5az4Yde4xuwQSto9N1U8mJus+b6UOrHkDPihLG
         +0n/+Xzwa9IThqCE33M6ItbrdjZ13EW467b6dGwYNUSkUw6bJ04JBwteALdDLVrF2qAb
         ifNktPJSrsJ+XOSqmStgsPY17UWQpW9chJDFz0yLar4K2EHml5wciMmQz+yVHd6HMz4c
         yoJQza0BqhTZEtyfTTqwtcUy7jcZxQzBrWjCXBLkP44Or4oVFJec0P8peqkGsrL0BDfY
         wyNwMo5aES1LKBHxCa3Z+WlQ8y0T6cBZ6h/sgfvobt9A877r2m8IkeBNUEDObsJcD47n
         kXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sQGMcH9wVTw4eNUQfhW/eWfhrc6dkjQjsTlPX4uG1BQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=S2nC4BRSIXUiXL93S3arRO3Ja2uJ6TnHGG1CZgwtAp9b45oWJmjI5J/e503g9GUcVt
         J1k/c/RLfrexP7BaAHcFv2G31irtdM2as8X5C01HNz5uKao3P3GW6664/Yht8SB9Q9SM
         UwHrz0R803+JwDqDHtZZ6zZzu7qSO9lg3Aq2LZkjtzfQZPZsLj4a1hgnV/BERUmwB1jg
         nx4dYMri9KKH1PAgRilLd1qtSd7GjHiKYkXpIv8Bve5qklLSP58iGiwPL/vMR8wtuEBd
         5hxIIAE0yWzTnSbInf2Conhglt4hUKKYrnesoPnn9Koot9bp85rIzIIk4d8b2bJqYWRI
         5aOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827222; x=1792432022; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sQGMcH9wVTw4eNUQfhW/eWfhrc6dkjQjsTlPX4uG1BQ=;
        b=Ri+zV3kfuO3LQe1gl1T6ZGZQYto5STptc/U+A4IjNLG44hwoRV0jtGDXtEgh1gWpa+
         uJgTvedtezP4nOAdzaT4OgTVpsRUcQzZOKlb7gUmjV+Ytx+VOshiqBuVlQ3YEKo0w+KM
         9zIvdhNORlYZV0JiNr0peUl4JDuUf6kl5Jhm7MKi8uTo0qNEcvqTj32odPEvYpRXrfpE
         PntDL+PyeJAg1xwKInzGO+DAp5x6dSGG/v89M4mTzH6kPwIlVrREOn1LNQD4jTVQpujK
         +/FCjeQkuoHINimXmgETL+5wYrn3IezMKmOV9j/354ugZ+uAe8hwiwqgIBagalaKXG/D
         0eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827222; x=1792432022;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQGMcH9wVTw4eNUQfhW/eWfhrc6dkjQjsTlPX4uG1BQ=;
        b=tqPtvUi7vkZtKZ/AgPhlhZ0zBCvaWW8KGb9D/dygPoGAmJRjVFnFOR+mEqHLkSaQsI
         0NMwTGJFctIsCABMW89mZ2hIUEd84I1HGd7bUWOHVbDk8hpaS9nvUvSC4ykybZDrLR0U
         sztxOnn9wzeGlhlo0FBAVkXYQ9dLVRZHd+6E1g6FPGdW7XlFVsH0dkuJzDNkPFY3Uuvg
         2pOGWOsarI40Vs9e0ZVqQ1IEjmqXsmuVjwq7zOz/5a7ROirXfrlpRkkixnbOEzZCNrOn
         Ct3t6x8WuaBi1UWrzmoE0DtMkAiiiwrNwUuxm4r0cSWvNVP7XahMENXOzcjlh7FFqjT6
         stmw==
X-Gm-Message-State: AFq9FYLQ2C9vOZaPvG76NbBRimzIDT2vwO9Jmkd++r+cL6V7L2SYLLMJ
	Q2APxfwohU7/CZ6j0cSmi+tWuodM1g9o/a03VSe3PDzrELMLXXipLzg++z4jyWCFsO7tYC7RnuM
	Qk4so4vmOXR1mSgSf6WmtZnmmRpeghkTk+tyN/b5MWipw
X-Gm-Gg: AYBFou2doFSvkHBxewaDzuGCh9MTNTLsmOsI0VmCSkqYfqudEJUyYjD104v9qe/KC5L
	TIvhqCxTdQXErxYeEeW+Y6OUBOSzHqVbENJgNkSakSfk0SyarAbRjX+TrquU9irna9jCadT7Fgo
	DF/759GmnTF7WvEzxHbmHu81600xoXrc2sAWS3zDzDv0aqGloDMRgiCZGnAVrK7ZbnbemOQEtjt
	Cz/N+FvJ4KHt1CiTitxVA/KzeGQGIGbGLuV1h/QuM46jwG3nV3BZ1mSkZjIg1no9xzLffVIBHCc
	kylvyZrpW99QlbdqTB6MD2xAOcMCZ4e3yOaNodcNMWkWTbqj9Zn8ixNT0GpkvcL9kwDAcyDd95p
	iWJHlF/e3p40=
X-Received: by 2002:a67:e7cb:0:b0:7c3:ab54:105c with SMTP id
 ada2fe7eead31-7cb37254ae6mr2341085137.7.1791827222383; Mon, 12 Oct 2026
 10:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joy <cryptocurrencydiva@gmail.com>
Date: Mon, 12 Oct 2026 18:46:32 +0100
X-Gm-Features: AclHuK8PWqv2mWFV7_c8nOzD3kUdyNx15aSfyC_n_vhJ5JoV9v1yAtKaontSGeU
Message-ID: <CAKA8Uu30SPCV9uAtn2K_0sVrD=FEt7DzdgYUWfwtbh019xK0MQ@mail.gmail.com>
Subject: [Outreachy] Introduction: Joy Gundu, applying for "Reduce Git's
 global state" project
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

 My name is Joy Gundu, and I'm applying to the December 2026 Outreachy
internship with the Git project, "Reduce Git's global state to enable
Git's libification".

 I'm based in Abuja, Nigeria. I'm a software engineer specializing in
Frontend Development (e.g., React/TypeScript and APIs), and I'm
learning C through this project.

 So far, I have built Git from source and run some of the tests, and
I've started looking at how global variables were handled in past
patches.
 I plan to work on a microproject once chosen and will send a patch to
the list soon. I'd welcome any advice on how to approach it. Thank
you,

Joy Gundu
