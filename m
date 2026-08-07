Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016E43B3DE
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120189; cv=pass; b=pLxvWNGYbC/HTjuI1uHk5OzvyzSMrUU6VbZVIhY6sQTbyxN+MO2Al1cDrM6zGPG2BdeTENApi0GYW03cPJ1EPwqzlMgC3Dojo4r8TDb71EYzuQYoJFankghywaIkp2quEApBb1KvMQLmEZkEqBuHfWeNIQuoCCLE0XrVNHVI+ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120189; c=relaxed/simple;
	bh=ttkYXpNxhPMaWI20cpxTXcOoCIbg575L8F/kqn8Uuxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjATfPd9byYHq8JwhuT2coto5y27LGiJFdLKgkOGcA/ztUjAIIrqt9658jQ4meFTPS0I2u0JoPwqT/Yglny5ezoXuN1awQgVnzAHG0ANipoDk6bRVnEaADjxbynvbxZ8kDRKdW6VC7OFLCtPj/RmdyF2tpEAe/WLqtjDN9PtRC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8/1TAoR; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8/1TAoR"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso3731070a34.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120186; cv=none;
        d=google.com; s=arc-20260327;
        b=sRxx1EBTXXSu9s+yOhWeAQpgMGsF/sxMYxtT6iSwXDPIt2MSS2Ht+3veQZffchZ62n
         VNHNH5L1yLPUPQYl0yGzy3x0gS54jRpoaQUbZMucMobfKE7BsasPknxI08nMgih+GI6G
         NfLvIZz/wPLZQXouB/tIjMMEBu+6aiJvy4Sk36bZerEHEZIBSAxTDO+070OJKhkv3kgY
         KDhyaEuyqdGPZoE1VyAnCo2mdnj0vpSJ1YAha+DlhtrJ2xHgr+ChkQvJ/M1WsWn7YX+z
         j88RoeBh2Gr+WGIacAnrjjw3O+aJrHYnpvT807A1tYVOUjdRpIy8uXPfj8rsV0L6v1vc
         mnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttkYXpNxhPMaWI20cpxTXcOoCIbg575L8F/kqn8Uuxo=;
        fh=iEaF+LU0qsxxO+aLpzhpKcJqu2rYCJBd4pihUzRL5PI=;
        b=Yfcw/wnVtXBnjjLPZOtRWeOsLFDUtV3E5QVGJDU5I3cCWJPqEhGN0LlPUiker1fRmH
         SWRIq4HJhDNM2O5lX5ciiiFn3f0W1P/TINHxlNEVYJAsTIC3WkkAb0U5tyjAAXvV4lx0
         o7j9fjhrkJ9ZjwKGnmvvwRGewfr+GdcztQrlKCV0NQxSSeDqLch+w52gnXsSmBYceKob
         x4XTmKc0m01Qzp5zP2r+fN83hnvulZaF81wrdtFIEGb0rU7axUwHAcbbJIi7gDNM0xfL
         O2H2kqzbQx6kWsFSkWMRnIfPcDc0altkUpYPGqOfYn7xvXnGkcQD4QzdlNANh+rCh9+I
         OLPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786120186; x=1786724986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ttkYXpNxhPMaWI20cpxTXcOoCIbg575L8F/kqn8Uuxo=;
        b=m8/1TAoRrgmTgQdPGtbwCcO5C4/dOf+HssiAYL+EJaGOwy4Ifcq+pyaOL0cZWQC2Mm
         IHbYvXKo18ZvcHYw6DZejiY3aj3pVB8GpoLajHziM9fWFpN24Mi2Y0J9+MK4kbhLQWdj
         9icCjGL7EgQWo0bKFcaKoqSg6bi+Ipht9flShX3aXf4bQEZYfF3wND0KUe9JSvnsPa9n
         dx2BO4MjOtI9utOAP0vk4vmhuxYC5UT1Gq9BrcS4kZWnvkqEZ++Pxa0PX+ET1uIfDXm3
         yQlLp02QQPNvk4f2uqElOlba6SsQxZAxDOK6/6yT3j4H+4rudLfdzvvI2qCzpF+e6i8N
         BP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120186; x=1786724986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttkYXpNxhPMaWI20cpxTXcOoCIbg575L8F/kqn8Uuxo=;
        b=NUe8D+4Ww3czZN6gIBGJStKD7WTgCG7rN1iDew76KgYTvK9aQpGjc0mtSpGEPql4gM
         tFtxIwoQ1cSNC0YRlwDeH/YHMocMw0qVRKLbqt2NBYPHEswrSmGgdsuln/u86wvBW0jE
         eQKdn57o1OG3qZFp27XW5p0ZanZnS0DEa3xxwRmQBDNgQTOQf3zKaiG1mM01xR3U4sD9
         nqSJ0+IYTcMmsiC5h63npo0jyaJF8lMBzheaL7n7GAKhbylke7Tl/91mshM29tanXX2v
         QWM3gHU8Sq4xll6+qUnwJLS1kanCfk96ThlaQKG4MVcmxSlD4YlhZ0kClJCMWTX1atka
         /88A==
X-Forwarded-Encrypted: i=1; AHgh+RpJjDGRdVuXuZzCsn0z0IOIxrlQKsQ48EkHA6QXvVezVFVfHyecHalFeSS52MVtf1qYeDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+v6wQi2VU2i88QRy8yUDHLyhOXpfG7wG2slExexdr2zfGyu+0
	pF2YKrFKnQ+2MkpfhWtQIlkoi1NWculjXIO+ZB5VWsWYpnwJyALMMHCWSvqAQUm8JPwGaRQHuOL
	AKQoke8hpuyLeUcr17LG/qEp8q2GMR8Q=
X-Gm-Gg: AR+sD11FcHNU8Gr/IhptrItYzw1QFUpSWUtuc0Ww4qI4b6KbjIb5j8FpZeZxfcQ5kCU
	cIH8svsdp6WwQwlp9FBqex07daqEjUE+YyjbYWkBnYqRNbj7qdwvxJ2GE9ysVctfPuxZDiLFw/9
	nyTn3tsY28LokONRdSTCmMFwhVTpoy2eYXAVTXEL1ajL78kGGqz8cwCnIjDOTrvX6ijZbU1Id8d
	xpUxls5ItH6ppNCwTIEBWKzjvB6whgT4y+U1WwhQJP9biY0sj/IHXL5ZpM8V//asvY/Y2I6bMy2
	lijyTWXrWtP/59Mt/Y7TwWfO17qgjwj/URhYxVtRYo4cwQnsEKvUiIOQg3crZH1CHMFnY8f/g2L
	dlvxXnTBwBI7y4alxYbybLkC4xpdQGphiFyjIfPkHInepiwI5Tb0gjCmW6mROqdE=
X-Received: by 2002:a05:6830:6119:b0:7e7:352:2f74 with SMTP id
 46e09a7af769-7f1e5eb411fmr17468460a34.13.1786120186500; Fri, 07 Aug 2026
 09:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com> <79b56402c0d5d8b709f41b25ca66aed98ebbb007.1783704657.git.gitgitgadget@gmail.com>
 <anGcwAZgbarxi6_k@pks.im>
In-Reply-To: <anGcwAZgbarxi6_k@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 7 Aug 2026 09:29:32 -0700
X-Gm-Features: AUfX_mxRyYAlDccQnM8AUAzU6aUzhQPG7HyYml2EC5NWRM8QdP1UvjE362oXT7U
Message-ID: <CAC2QwmK=K3EqvZWKQpy8ag+A8kMghNB6N=0dW7pjY1xJup4_Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> > +
> > +out=3Dout.$$
> > +modified=3Dout-modified.$$
> > +"$GIT_EXEC_PATH/git-http-backend" >"$out"
> > +
> > +if ./one-time-script "$out" 2>/dev/null >"$modified" &&
>
> Is it intentional that we swallow stderr of this script now? We didn't
> before. I assume that this is to swallow the error in case the script
> got removed by the concurrent request?
>

Yes, you are correct on both counts. This is an intentional change
meant to swallow (an expected) stderr in case the script got removed
already by a concurrent request, but that is not clear on its own. I will
add an explanatory comment spelling this out.
