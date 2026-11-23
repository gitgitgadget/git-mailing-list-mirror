Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434052;
	b=Q6o78T297mcgwe0XHXfwf4cDjYX1LQEkM6yKfFu5Xdeyx6oBzddL3X/Bl//LCpM+tSg6
	 qhmbexa+mzmd2aupXJMjLbCW8cAf9U5XLFtpX9m8/oqzcdpnXr75LQ1SOv3X8s4cjQGRd
	 4zk0hJEWwxTODtSfi21d85iz/j/7Gi1nMvqyqdlLVPjKAvcKxXbp20pFnroge4jqOU65T
	 jAGyXKO/usISK1FUfGa5JfhgcL1JGVuBeE3cngIISrc76gD0ClFv+3nmu3q/HANXpjt2G
	 XXJOVB31BIpnwfocTnALKUrVif7ofE5iaVyYZRnU8qiBJTu/KUqbldjAJ/GC7oLi2wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T2izLLGVyDjxd+JIin7gjA+lvP05SmPo/4aybkLuy8A=;
	b=j0Q3E3zPgqqNRiZbXfY3WITNxTxp2GJKAzCeLw0c/l5t2sR0Ek9qMkLGybWQlnxCJLXu
	 xpHdZqCjgkAxb4G4ubfPL2mE65OhpAI29gX2A5TMfdehCvtvvva30qc1iJH5FABhjvADb
	 H3w6q0Qi6XAetjEGfv8+Or4ZVaQivyzD2bRFKdPutpcV68hIM+FFAEAVobPGc00kUs0hN
	 6WVJimtsgZa1EwSqI921aOGGPsUr+c2NZT+V44gNzs5JDNjUrv8JVORVOZArRY/LU+6AL
	 TaOzkzvBbDL5PyZmcYfjBl5yzdj5gXTmk0GwBZJDtIW6TpZYnlU+JThxGomOl2aPhRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIAYDRjT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043E606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C043E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIAYDRjT
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2761c69fbso1824682c88.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 03:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795434051; cv=none;
        d=google.com; s=arc-20260327;
        b=F0+FDf7+2ScmO4FE+Iek7q3/oZZg9uP+FlyR8+M0Wl63/VAIfu4Emzn3yqMrNkXgy3
         pDTYYPFR+xhS8BqStHjEBVnyIKgCyQGSYJre5ar+/WLNJAnybE1Xx05RUHoyISIOVPUz
         xy4W64B91dN5JofgIeicCpgpDQxDEKQWmZB3rFLA6m3sjm9nQKJI+Y1sVWEiKTa5d9uE
         uE5ooo6WKLyD9HNcrxWDjIORcvbT0/zGkCUr0gxPqAulTJ65qXduDuarIZgrn1ichvjq
         5BwBqX4utsirnpStaxl4N1RHjfhZzy2bW0ORN5X1zKHCTwuyFqU0XOGxp4j784MJQPt5
         c1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2izLLGVyDjxd+JIin7gjA+lvP05SmPo/4aybkLuy8A=;
        fh=UhphZ3w+E2hfORWTIIHDzG/MmbRxi+fZui9MBwr+4xM=;
        b=hZLBXUYbZrVwjYRG6CtMxuNyC4BO0VuR0yMK0D+pUPv/j7RAjRvqyEyGEdKASayFwW
         FP/ZT5wN/FyCWHrBF58uj1i/b+Oa+N0W1F+bJhBZwlTEv5t8iTqIYllTuHsPirdhrFtz
         ThXHBW68quz2ImEQ/orpOMQBH869W0oLfwveeTuVgaZqsM4DY0EUVD34bbG+mUxXJwDE
         FiX0LkDLW0zZBy15zmsqmMkWCbnQedw0I9Kud45EdWh/DpRfs13SPil5JyMatQSO/AZg
         fcZV84wFUmz+w7ovGPT7UCm4qVnskJov/gE6km9No/LP0VUpZIfKjRFpn5DnSqdiXVAy
         IIbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434051; x=1796038851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T2izLLGVyDjxd+JIin7gjA+lvP05SmPo/4aybkLuy8A=;
        b=bIAYDRjTcdx40/JX6nDKNO1eq+bChakWIH2NCXYSGEpWRbvWK9oT2kLmFDGNDB8UY3
         CIeA70cNA8ImtKIJGP2ne0SynscK/pgQxDnFSlW4IQG6cV0xnx9o2Mnv/bYPDYDxD8L5
         3E/hwjxRQXIPYKarriGJwwW4QfrJYeKuXZZNZi+lpFswL6l3yWWaOoqC+0+R2DN/ayWi
         eSnGC+Tmv3tnSnyoERsUHYsux6js8bU3u4lB/g/oXN21QPwesOfIW8oybqBzowtKCEdQ
         qN9p8O33+TSz3hE9zppfJzgGYulXIDEVznNCdTjl6l/lCoen9ijpvjMVFLb6pMltNoa2
         ugXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434051; x=1796038851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2izLLGVyDjxd+JIin7gjA+lvP05SmPo/4aybkLuy8A=;
        b=HkBBcm08tQpZt4sJNZJ3ULAXntPhv27CIMtCbk+Ps0Peip+nUR00uWSq5J/e8mBQID
         3DzHXrb/j4BvDBx9Rv7LvOc3eAWE1Nr4f172VOikr/QCrxJABa2ex3y8LMfOPkzs03Yp
         qsYiHuPr13f6UW+3UyHgeo0UjwsmLk5h+JFYugk4xfTvOQx1crLimSKBsbPyUkwefTbm
         rziWJTxF/Vn9+BXe0/AW7/K1DGlnPmzmvZWVNezwYfZdYGnSeu7G7njJhXJkoDJMXkfq
         7cs8Sth2R8WTknoEgEHaJLb18St9GuAM1qWk794Dg90mAbHqcUjm9l64mwLK8I5oC2Ye
         1NAA==
X-Gm-Message-State: APuU4Z9AxZhJ4QdXMpRaLcGyeMng8E2NwkbP0icBaJS3nW1jJvImWj2k
	ZHaTYi2JaoB29A4ATy8SWEey66BKw+GE2l1WXl7gpwn094e9E1F5+jbJaKygxmxwYx7NpUnXrIJ
	x/N1rBFzr1hQFOWYqz3amTrfv9iAzCXw=
X-Gm-Gg: AZFdTZdCvwkF2dMtZkwP/iKHyvoCSOZNOD6TzFlJKJHcCJsk/WjnFnYbhiSNFMe6XRk
	DHt8NTeBuNP1tWoRH/D8qXdYdYbS0HaG1clCcnZ1zmq7YOthVUI8OGrVJyeZeTRIp2glRqCo+l3
	ZbV121nrtM06l8yWXvv7p0a9On90hYTHuLJvMReCwYzCvw56XKev2HpP8acVtLKbA7TfnRUMN7u
	NG2WTA7uqfs3/0Ot11o87KtxMaCWyQ7jGsNnjX2CJ4eGygxVNH6B2dntngPPWb3TNU4Y9GEFaG5
	hyFbW2fnh0JzcpuPjd+lpNnw+u3VcGijlJY+KknIslvjnkVws6CkrHgD950h7W67M+LBqC1umBa
	Oz0aqkcwb9HTEL9azNgXsYP0828oxbb0mmzf4sAdRWCVfV04iM+qjixe8NfkEgJJ9aZNffcZBcE
	GPsDpdZSP3jiEkJQ64B7rtubqjhDdd68ylWSzvtSNOJ/dv1giKtFEw1+pb85vWY5tD4YJcBacVi
	tkhYRSWiqQCN59Mx/JZ4A2D
X-Received: by 2002:a05:701a:c972:b0:195:c6c2:c6b with SMTP id
 a92af1059eb24-1b556916d9amr10963729c88.35.1795434050837; Mon, 23 Nov 2026
 03:40:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
 <1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
In-Reply-To: <1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Nov 2026 12:40:39 +0100
X-Gm-Features: Aa3M54qHW-jk2an5RNf0saEBIC2IyGOByFnMTm8lEvNAOTz3qv35uiTQKVh4l8s
Message-ID: <CAP8UFD1Kz3NvgU+vhi4FMyDwo4RF5=z-Nutn-4y1QSiWLF36-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] convert: use size_t for buffer sizes
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>, 
	Shuqi Liang <cheskaqiqi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 11:16=E2=80=AFAM Elia Pinto <gitter.spiros@gmail.co=
m> wrote:
>
> The conversion code receives its buffers with a size_t length, but the
> helpers that scan them, gather_stats(), gather_convert_stats(),
> gather_convert_stats_ascii() and count_ident(), take an "unsigned long".
> On platforms where that is 32 bits wide, like Windows, they only look
> at the first "size mod 2^32" bytes of a file over 4GiB. The decision
> whether a file is binary, or contains CRLF line endings or "$Id$"
> keywords, is then based on that prefix, and we may convert the line
> endings of a file that is binary further down, or not expand keywords
> that appear after the first 4GiB.
>
> read_blob_data_from_index(), which feeds has_crlf_in_index(),
> get_cached_convert_stats_ascii() and the reading of .gitattributes from
> the index, gets the size of the blob as a size_t, but hands it out
> through cast_size_t_to_ulong(), so on such platforms "git add" of a file

Maybe: s/a file/a "text" file/

> whose staged version is over 4GiB dies when core.autocrlf is in effect.

As some of your previous patches add tests, maybe one could also be
added in "t/t1051-large-conversion.sh", for example something like:

test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
                        'ls-files --eol on a staged file over 4GB' '
        test-tool genzeros $((5*1024*1024*1024)) >big &&
        git add big &&
        git ls-files --eol big >actual &&
        test_grep "^i/-text" actual
'

?
