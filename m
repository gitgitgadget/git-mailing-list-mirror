Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87261BE857
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941365; cv=none; b=lX0V9JAUK7FkdCC+KQqp459XHl92ona9w37eCNCXKoIZGMVSwAlgUrSq6z3Bc1Pwb2TUZIM93tzhz/bCGs32hrVn5AIBxhOKqSjVvqwR7ZO3iUvPn9eAUFmYEdIUahRuRlqbLM2tvUybR7HBYEFVSyB9HIhBjYbnQ0CixCxWJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941365; c=relaxed/simple;
	bh=3MGqPoZ2WytiPRkk9B8HDemCs+qv0nxJA6FTH8mgDGs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tXQ8VIPO6mTqbQiuOHfzgV2rhrpwibSvf/7jM+5oP+vbvJjVVb69v82Qr22E6HDy5bu4mmJE327KgAr55ctbQm1MILJX2FhrLWZMe7HggrbzNtRjMKOnl7kAKhz58U+cLSlkOdx4y+hJfCgsVLDhe5yvrwazSjytVM4Y6xkR8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYzjPVJk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYzjPVJk"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so3462763b3a.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719941363; x=1720546163; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iHdxJqVyijZe0Vs6nMj7/NapwpSDmcw5lC/RBgmt4c=;
        b=nYzjPVJkBevUgQLXj7aQqO0MJKRrsRL4bKtonhDyqSLntwxJHi84h/NUGTjbsFTgX1
         /FHLLojDXihKkfdo0xFHQ92IrHSynUp9N00MRnBVEUfTJf/494VgGUZiDvykc2CmfVk5
         heNdGgfFALlKFYXrVMe33N19neKVWex9fKcjxHIgslqwpzPWRVM8LS/QbnXgP6c+vLNV
         Cf51V1QGCN90JSBJYrRraBwClucaLM1dNJCDAspzRnEQcJb0LxTKVJObLxzcWVGbbwOV
         F70dOih0kZtzrOlKCze9WM9K0rhMsK8iVoAkuoVbvQ9mhpWa7EP66lukGhZ+x1aAGuUp
         XB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941363; x=1720546163;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1iHdxJqVyijZe0Vs6nMj7/NapwpSDmcw5lC/RBgmt4c=;
        b=E+3W36OODRC/WImgym6+17RSoZrrSxJ5+K/WxX0MT81IDay1tqQBn7Tmr/MOjvch/Q
         G3YwtRAAR1E1CaNqXfQT5G+OagRpqJIMhyXNqCHXJAwL3FIAOBUGEbe44gIMhZOW8FMb
         Kkb9UacilAJ5FZVBf5twyCIXFMcgNMxoCS0TFqhw6IZIdWOrYxx5RLmezSS7oNW4tx8F
         3SiN2jy8nA2XzOhbY5gzxleX+rFnjaAVBDJ9LK5K/nRhDAiIIDGEDvKizljm7mdt+R1g
         frui6Wm7v7zjPc/rtWGjLkaUNIxcV9YhriCzLBLKKl7qhP0g6DTL+rB+sxjhznLemHnz
         1HbA==
X-Forwarded-Encrypted: i=1; AJvYcCUTfYaG32UUNqJSLdH+SnHR687yj4B0EFSgUfqEGDzdCtKtudkj7GqP8jvJeFI8SHo6yhH4c5AYAz6ZBHewjiocVDPd
X-Gm-Message-State: AOJu0YyfD4RaOsMbt3sHOM7eSayg1f7V5WXOrF7mcbnhGLPHUXC32wLg
	UG/8hka/yIMcLn9U3XzrSdvoPnK1t2QXdG2W8urFTXAy4z+YQEGq
X-Google-Smtp-Source: AGHT+IE8TT45AncCa9sElC5GmRsU312qOFscTQ2UOwRWwvt3VczpBEKTGgdvakrabrbtKjdR2V/vKA==
X-Received: by 2002:a05:6a00:3cc6:b0:706:6bf8:bd7 with SMTP id d2e1a72fcca58-70aaaeec9a5mr12062746b3a.21.1719941362865;
        Tue, 02 Jul 2024 10:29:22 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246c662sm8810670b3a.61.2024.07.02.10.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 10:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 22:59:18 +0530
Message-Id: <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Josh Steadmon" <steadmon@google.com>, =?utf-8?q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, "Git List" <git@vger.kernel.org>, "Phillip Wood"
 <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
In-Reply-To: <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>

Josh Steadmon <steadmon@google.com> wrote:
> > -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> > -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> > -	TEST(setup_populated(t_addch, "initial value", "a"),
> > -	     "strbuf_addch appends to initial value");
> > -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> > -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
> > -	     "strbuf_addstr appends string to initial value");
> > +
> > +	if (TEST_RUN("strbuf_addch adds char")) {
> > +		struct strbuf sb =3D STRBUF_INIT;
> > +		t_addch(&sb, 'a');
> > +		t_release(&sb);
> > +	}
> > +
> > +	if (TEST_RUN("strbuf_addch adds NUL char")) {
> > +		struct strbuf sb =3D STRBUF_INIT;
> > +		t_addch(&sb, '\0');
> > +		t_release(&sb);
> > +	}
> > +
> > +	if (TEST_RUN("strbuf_addch appends to initial value")) {
> > +		struct strbuf sb =3D STRBUF_INIT;
> > +		t_addstr(&sb, "initial value");
> > +		t_addch(&sb, 'a');
> > +		t_release(&sb);
> > +	}
> > +
> > +	if (TEST_RUN("strbuf_addstr adds string")) {
> > +		struct strbuf sb =3D STRBUF_INIT;
> > +		t_addstr(&sb, "hello there");
> > +		t_release(&sb);
> > +	}
> > +
> > +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
> > +		struct strbuf sb =3D STRBUF_INIT;
> > +		t_addstr(&sb, "initial value");
> > +		t_addstr(&sb, "hello there");
> > +		t_release(&sb);
> > +	}
> >=20
> >  	return test_done();
> >  }
> > --
> > 2.45.2
>
> I think this commit in particular shows how TEST_RUN() is more
> convenient than TEST(). (Although, arguably we shouldn't have allowed
> the setup() + callback situation to start with.)

Could you expand a bit on why the setup() + callback thing shouldn't be
allowed? I think it is a nice way of avoiding boilerplate and having
independent state. And, I see the true potential of TEST_RUN() in
testcases defined through macros rather than replacing functions. I
actually think that the previous version with the functions was not
particularly bad, and I agree with Phillip that the previous version's
main() provided nice overview of the tests and it was easier to
verify the independence between each testcase.

Perhaps, the code snippets inside the functions are small enough to
perceive TEST_RUN() as more convenient than TEST() in this test, but,
for future reference, I definitely don't think TEST_RUN() should be
looked at as a replacement for TEST(), and more like 'when we have to
use macro magic which requires us to use internal test__run_*
functions, using TEST_RUN() is more convenient'. Patch [3/6] is a good
example of that. But, I also don't mind if patches 4, 5, or 6 get
merged as I don't see any difference between using TEST_RUN() or
TEST() in those patches, besides moving everything inside main().

Thanks.
