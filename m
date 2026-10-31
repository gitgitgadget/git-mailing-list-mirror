Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441786;
	b=TPIKG8tXfAxwu04BY88QwJDVhuQ3hQlA9KJatX2SWbgY35yG815BbyDqchLCP/+5Vp0a
	 VXGZ0uokCnENk5q2dSQWrR/Aa4lQC7d0rlGQu501PGQ9tmSGEO6fT9pNyEWqsZlvB397T
	 wp+lnCeWDQ+L59SRd+8/dmrV/TEBE5pxaroT+UAZxqx9PHzjimh8xvfsF6KpkfOOsIUCj
	 FWeoU6uwYmrZvyBNCP+fj/WPeucmLlKFSc/8wZtOBMtumpGmbqk0o8k8Go1lyNzK05Ftx
	 VfWnMdsZMRzUxEiuDdm/LqwFRp8r9Xt+pgiQWdjgfbHH8FvoG1c8iqQdX7SEhly6ACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xj5ayNOzVZqhTKaSQL0FhSYsnH5IxBrdCK4vfUJpoXk=;
	b=EuzlXNjQLr8XmN1YIC2wiZ0uD4CN8RgHh3rco2BtgWsgiC/WagfkijVWViaVVsatJbeX
	 w3THBsHHfodN3Y7RPqM56VD35N50xUFOBay2GTo6bUtDPGZHr1B82tiEjN2vRxtJA6xln
	 CJoCtNz7/sa56JnFQMTrmzr8VACJrrn6Z9MdBFzwP6ZOEf6OtiqL1H8cgQrD6y7EvHxnN
	 L6EpsS6TkoVWlnwFqR9TMKfMHpmgjDIr99Y9HwU6Pwj4maL12lsH7fZ3w9bQdfGWiztdg
	 52CvCKH+U7AEnQnZG8opaHnUGczpwgKAdG38JlcGS3HYusqq110wNJ82ULyK+OIgFEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES38Q6mo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6A606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES38Q6mo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so12783945e9.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441784; x=1794046584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xj5ayNOzVZqhTKaSQL0FhSYsnH5IxBrdCK4vfUJpoXk=;
        b=ES38Q6moYaUpd2oM0ZHPVxrkWeD2yyxREntzpPKmWgu75irvXK6WICdcpkHJOLaFLq
         XOXCw+Yqm6fS0AND22/rlNErNOli6/VPEOuaZbSE/tXs91VhVt4AUdcJuTY6/w/1asmP
         iG8Ab66TxhVGs8Gn1ebEsGjborjc7TMpC5ZY0NebV8/60onGpczxnPYwvDPJdNVMHRuj
         +lsLVSjHI5++NTFseMvEYZsexXMued5QPDtIb8jcQvkNqs/dkiPCdo9J4GcM5pB39O2g
         hdaIV5j/zUkdoCiZs8fzaDRY+OP/y9CMtpWzXSNqL9yWKW7Dr3U+H1TI8jYyR6LAcN60
         UWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441784; x=1794046584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xj5ayNOzVZqhTKaSQL0FhSYsnH5IxBrdCK4vfUJpoXk=;
        b=Q78loqwdHorue5GFG9Xjc3WCLs8QTZBdOVlNxic+X5yIfSyt7+2rIorVciy0oHIBjz
         NUxHUZefWCXtsl0IsmT3rHBHvbUC8wymzUG3EKva1ltBnlGfhBvi64ugXqpZ9Q9caObV
         2lZIUq98rGDQKiem+XJ5nDpECmlp5qxvjGXzNtd950A2AycqqM10r8+///nFzwfqMVjE
         jH0kwEk5owYz1uNPXOApkVLLrq5wIL8opPtk4iUyK/zkHoi6471166MGYhw0xqX3HbrQ
         pecdQCv63GROOfOHWabMX0HtY3w2x6lEnV8+JfMphMyJCoCfhRfnF4bD+sQH2wz5zKsf
         JmrQ==
X-Gm-Message-State: AFq9FYLt0FZ96KJiqWgWngFILoF6HqP3Bbo5Pc+QmiE6MdGtVVYBgHUz
	VVlp5gxatFCljkAcUey14x+SsQJbsU6c5zuHjAi6t0ZJ/3j2gVC6G778nKZjTMyY
X-Gm-Gg: AYBFou3ayRpelZ6cCF6CQet4gp7qzlMSB9Lejo3SNv6rLINOrKZfJBIhevCgY1M0ByQ
	FBfusMfE2+D3irWm1TVYn8xnAbyWfU4toE/1l0XWv5PibWJwe4datJ+LkzWxZ//vAtDeylB1q42
	HOxsHAizNU3yLZhYQjVuOucGBGQ/LF4546dkiPW+4gN4oDg741zGLqn3lSWI8x2I+rLw6bxzNVU
	07b3h8LQMVwmdxhN2v9QJMHAzZ/XrEstnM5g90dsskOHej252qOO6fOxM1u+X2CeD3xtO2R4KJE
	nz5kIkmtDaCfXiWxjlFry5879F3djfwf1sspci+upu1w7pNPZESB6h1vv+a/ttznYmY91zOxGCX
	CjdruJjU5qm513CgQdidDsWyWYrWi+Lm9wtydLq5mzDljtCj4AanHgVBWAWJjXuNaRsnok849Zv
	q5ugI9Hw/ySEPN+U9mlpZolLBA26iJD/fvJx86zURxjMhVshUxKpfdcrww7Y4FWw+SoRS1hlEMY
	N5uTzin7DVdehdrRFUTGNobL93aWznIsagjJGz7qmSUB0yLr3i9LQMiObEdqSa3rLnk1fQCmfMj
	BOYDJTSCJso8y9GtqIr901tUxFKfsDpS+onIMwRW3NQcEj53iiG3j8stUUgIvRS58VTlSI4wjRO
	sOzyojPSg
X-Received: by 2002:a05:600c:8183:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4ac19802178mr89971875e9.34.1793441784109;
        Sat, 31 Oct 2026 03:16:24 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm195434335e9.14.2026.10.31.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:23 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] odb: use size_t for the length of objects to write
Date: Sat, 31 Oct 2026 11:16:18 +0100
Message-ID: <20261031101619.172770-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auSDFRHpLy65PMF_@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com> <8fcb9f10f13962acd5cdac652bea8fc4164f2e78.1793352943.git.gitter.spiros@gmail.com> <auSDFRHpLy65PMF_@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 30, 2026 at 12:44:34PM +0100, Patrick Steinhardt wrote:
> > diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> > index 463b38f990..0a89bbb455 100755
> > --- a/t/t1007-hash-object.sh
> > +++ b/t/t1007-hash-object.sh
> > @@ -297,4 +297,17 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
> > +		'write filtered files over 4GB correctly' '
> > +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> > +	test_oid large5GB >expect &&
> > +	test_config filter.null-filter.clean "cat" &&
> > +	echo "big filter=null-filter" >.gitattributes &&
> > +	git hash-object -w -- big >actual &&
> > +	test_cmp expect actual &&
> > +	echo $((5*1024*1024*1024)) >expect &&
>
> Isn't this the exact same as `big`? So...

Ah, there was a slight misunderstanding here: `expect` didn't contain
the content of `big`, but its expected size in bytes (`5368709120`),
which was then compared against the output of `cat-file -s`.

That said, your point stands: checking only the size was a weak and
redundant check. The OID printed by `hash-object -w` is computed
directly from the object content that was written. If the length had
been truncated (like on Windows), the written object would be different
and its OID wouldn't match `large5GB`. I verified this by simulating the
truncation: forcing the length to 32 bits in `odb_write_object_ext()`
causes the test to fail right there on the OID comparison.

Because of this, `test_cmp big actual` isn't needed, and running it
would unnecessarily cost another expensive read of 5 GiB from the object
database.

>
> > +	git cat-file -s $(cat actual) >actual &&
>
> We shouldn't read from and write to the same file. Maybe write it to
> "actual.size" instead?

Agreed, reading from and writing to the same file was fragile, even
though it worked because shell redirection happens after expansion. In
v3 this goes away completely since we dropped the size line.

>
> Also, it might make sense to use `test_cmp_bin ()` instead.

Since the size check is gone, we only compare the OID, which is text, so
`test_cmp` remains the correct tool. `test_cmp_bin` would only make
sense for comparing binary content, which we no longer do for the
reasons mentioned above.

Instead, v3 checks that the object actually exists in the database by
running `git cat-file -e "$(cat actual)"`. This is a cheap check that
confirms `-w` wrote it successfully without needing to read back the
5 GiB content.

Thanks for the review! v3 will follow shortly in the same thread.

Elia
