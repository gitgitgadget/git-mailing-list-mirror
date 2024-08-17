Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282689450
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905163; cv=none; b=AK+8EOf1HLxkukfs3VMB2elNJYucM4QeLoDQaZWmapnEFZszThFk9W7gXn8iDDcbzDFZk574EvTrRho4cNjR1MUlPxnfiGTMZPlQPgHbY/ccg1cOcROMzyTLyt02/SVndUX1QK79yXDe6WPrb3W3mfnDFvyIYfUNdxAZrjaWQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905163; c=relaxed/simple;
	bh=LFoeZ/3qapUe5n4d/GUZz9yBJbdVW/w6dkxvDKQJy70=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=J5r68RsQlHO3y0D+adKxnpOlX5Qi+Ws4fXfqXPNfgHo2R3Yy2G5kDjCPqNf5hf8sn260V50r3tVhJCiPg+za0iEOju0Q1Ds7U/vVBHJonDRgOFzcrZfwLph/imGCyRwqismbbWi2qVc3GJdzWgQBcgsRRPKeD/CB94WY4WN9msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxwRq16T; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxwRq16T"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd9e70b592so29036315ad.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723905161; x=1724509961; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X33+abtKJ1AovjGOF0iSip7CPkE/6vg2DcgXC4b944=;
        b=XxwRq16THr46+Xq4ueZv5f3si6TBFc7gi0W1Z3hMv5m/OhXvELp1TDgURqEMG4SQIg
         ehK+DqFiXaKaCJlPTXNrtCvMfkAvuHgr0BbBvAWuVT7Ud18zMIV9sL70pBQeRRaVj9EO
         gB+fUh8qgifUam6cwJwU/tfW9towEdVJArvSvnlnB4qeTb7dbo3w1TebrRspFm8BY34m
         Wm5x+RfsOiko8hhKCoA/BbYppo5gFO3DavUYr7E6AAhxB+tU2Nsy2jd6WHIw0aJBJAZM
         HEKYaxgkn1xk35z9uawQAlCJlGaOKdVBTIVx3m580CfOmiIJyiQbOb/zAENQkvwgcuYr
         MWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723905161; x=1724509961;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7X33+abtKJ1AovjGOF0iSip7CPkE/6vg2DcgXC4b944=;
        b=gLrrlz7ZAmrS3vfbFf2sQxz4tMjZgd5v9x/gLiNcgIqH6t8Prqcuesjer1PEwIxtby
         qJpM8NR+9LofkCjW1Bb5qJOmGp0M0YtqvKc+TXxHLmVlj6LKvNoQjtI9DRvtOCsmsQvF
         9YCJd+IPuaE1SZ18NQ7FmSBgR53pTFYwF3dBS3WXKnjcUrqA/N2d/FVQ+3VaNu6jY23R
         t8uxiHh+O7UKqwG+zb8xZ6pOsgpUXGYzuMWsANHLTXEgvuPN6HZyoYnxqdcMQ6XGVzpk
         GZEyV5SQRK/3CatC88RYa0qFDCT/gZXwKjbgsjstqr+IqAf99NIL41gjn3WSDVi9xN9B
         PPPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSIrpbs/hNOBEuw0ua2Rin941hJepHYhU8ynWuYJZcmnCg+rkm52VTS0aKSUCE1VYjcpxGTA8v+JXjTfxJCI7mslk9
X-Gm-Message-State: AOJu0YyAQ2hlOucf1YtuyaMoffaL6SD8BkrAMcO5vim0bEju9td33Zdn
	WcvpVZdnSE3L0kF1xJloW8UCN61bozb0Zk0YeVEln6S8Ct/ZDA9PXDskOLi3
X-Google-Smtp-Source: AGHT+IGPHhom5DYB66D3KcazpIXBN2J/XkYDc95mg54DgVueN/6JVhZ6+Et1ZpdYmS+rC01z9UWMkw==
X-Received: by 2002:a17:902:e744:b0:201:e52c:9e53 with SMTP id d9443c01a7336-202196c54f2mr25156095ad.62.1723905160884;
        Sat, 17 Aug 2024 07:32:40 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03751ebsm40194005ad.162.2024.08.17.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 07:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Aug 2024 20:02:36 +0530
Message-Id: <D3I9DJRMAQD4.UIBX5HG0XYL2@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [PATCH 11/15] t-hashmap: mark unused parameters in callback
 function
References: <20240817082101.GA6761@coredump.intra.peff.net>
 <20240817082447.GK10287@coredump.intra.peff.net>
In-Reply-To: <20240817082447.GK10287@coredump.intra.peff.net>

Jeff King <peff@peff.net> wrote:
> The t_intern() setup function doesn't operate on a hashmap, so it
> ignores its parameters. But we can't drop them since it is passed as a
> pointer to setup(), so we have to match the other setup functions. Mark
> them to silence -Wunused-parameter.

Sorry, but I didn't understand why we can't drop them and just call
t_intern() instead of setup(t_intern) (I should've done that, when
writing this). By 'other setup functions', do you mean other test
functions which use setup()? I don't think it is necessary to have
uniformity in function signatures of all the test functions.

diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
index 09a48c2c4e..83b79dff39 100644
--- a/t/unit-tests/t-hashmap.c
+++ b/t/unit-tests/t-hashmap.c
@@ -322,7 +322,7 @@ static void t_alloc(struct hashmap *map, unsigned int i=
gnore_case)
 	free(removed);
 }
=20
-static void t_intern(struct hashmap *map, unsigned int ignore_case)
+static void t_intern(void)
 {
 	const char *values[] =3D { "value1", "Value1", "value2", "value2" };
=20
@@ -356,6 +356,6 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
 	TEST(setup(t_iterate, 0), "iterate works");
 	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
 	TEST(setup(t_alloc, 0), "grow / shrink works");
-	TEST(setup(t_intern, 0), "string interning works");
+	TEST(t_intern(), "string interning works");
 	return test_done();
 }

Thanks.
