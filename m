Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434077;
	b=NKPj3V1yn0xHqPohPZ1mldMUpty4zACiYfpclXcWvGZM7tB6t3JP2V4TMmEFyr8fwGTq
	 DSvzvpSrvi48/BBC7D211+7Zdbx/DEO/rWo54PQFP3CfUVmCRxVe4bdms/L0WAAXCZtWe
	 zUdPCX3y29JQNinsv7XgGghEirSX2Yzymd7JgSBFKJl9tDW9TeLpyqesa6BdHdqxdQhSW
	 +ft0iPoz61spPi+OMKTRpNDIiV3McmhdomprA6i6awpDGhsPQ/FVCtSzVV1X4QjGPnu9j
	 wkucIrjrh1TNaTZTxNOWDgWXk/ZhAKivpM4fThCeOLP+7Y/zsVtJOQwn1s+QGvvCKBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/QkitWvpDPke95Z2HwwVEGLGKXZAi/h5dc4629AYFkM=;
	b=pI+HZupTwYUTXnAbJSToJCu6uQ6Obi9PgI+54CR0yKp/gan1tIqB8RRuS6/fbGyy7tOo
	 Vcx9rl8s6CUaElErhg3nBu1Ych5mqSu2l7s46TOmOKvkQUsKDJZ6b10zWpnuqRDGcREfV
	 4k8x7h2BPZZzMtPP4eRUHDnR1s+dSkgtgdEuXAaWf39IzpOUgbn9L31/sYgsfycDdlOlc
	 rPCX2ucaqYVTcmbMKzaf6kG9yR+cBsnmxYo/tjogatJGTCcxGUY6c3b/gp/By+Zm5uw40
	 ESHHTAb99vC0a3rNOQ60ZtCaFJbbgbjGQf6X7//ze3V2vcSiU1ZCRQZNcVAOw/B4W9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4UN2h2L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE74606A327
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE74606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4UN2h2L
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so1761461c88.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 03:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795434076; cv=none;
        d=google.com; s=arc-20260327;
        b=NHOiJA3m5jvPaYHKxsgVgGJex8bJJQR/8TCuUw7rQHNI/JsUHwx85bUHyk9d+qNc/z
         cT20+PdAqVGkl5uo8DZNUir9PcUyPtO0UcM1XvpaOZ8mfFj/FRhvyotFbmOt6ursZ5Bw
         f8XLnhv5UJxv0QItlN6cuLeaygb5mcJjFdH8y+H5r1NPzgxMLKfBImVZeH51bWtClCxu
         zX6Nkm6+I2o9XvR/3SNAUEVHX8kkvdR33gTMneV+JXhi4VoSho3clgO5P3G4RG50WEtj
         9TrRfD6RH9TnPMhisi64ohBVYBIkt8LzzewENw4e/vEI9RhveGsi6s59J0lBInn+jA64
         3Mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/QkitWvpDPke95Z2HwwVEGLGKXZAi/h5dc4629AYFkM=;
        fh=avr5miqz7VZmNIy1b6y/1MuZdwmI+6/iyVfAaavX3TU=;
        b=Tm7kQVZa3aY32MNTSsumg//8n09BDkNTQ5EMri9XtijNb0ffG6NmwRaXvZ2WIeb2sC
         7IZRWSQSKEmH4G5K8+FPyBh/zfTIF3VHkUr2pYPC/k7q6+5aRCEZyW/BAZq0K+RWRybd
         ASguV3BLIMpO7FmJNJKH29EAuizKa1zdRup/47s28+LZ60+SUh3h2msi9fKZ0i/SgvmL
         ZwgPUU3WmXngnBLMwFA6GOrC0EuzZ/umD/WoKmaMZWd1y7eGI4OCCuXRbsTO/ViqayUy
         qFumjNALFt33eA+Jsq324u7cKqkxsXGw9AufuO3EQ1lONCXodbfaSNX1GkYe3l4Ow5r4
         zLsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434076; x=1796038876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QkitWvpDPke95Z2HwwVEGLGKXZAi/h5dc4629AYFkM=;
        b=w4UN2h2LyM9585hbs+e8xfTU0JsScf4RY1/dsSFMOisd4XYW97AI6WQZSA/1V6uM5L
         71vLXHdrVUyHDwMnRi9rvs2W/KjQRxz5iEZxGkCnXVvInDRTJxhIbKLjCwEOI3jBATx5
         J6rreswxg7K3bhFl2/IjOHf2+ABQx9VWyC6ZDwunBigyjwgKPIugwR2NFahrxtyzv/17
         n3GKKNpIfulTomj1Ff4CXqlcU5Rw7nINLmvs4djl0ll78X0zeyYMlPF++wCLGBveBBMJ
         +kGr91PulMEGe+g7QQZ5e2C96WZzHZ0UWJhjwuclr9SVyi8V7H7+YOl9TPm9zX0EIPPh
         Ug7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434076; x=1796038876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QkitWvpDPke95Z2HwwVEGLGKXZAi/h5dc4629AYFkM=;
        b=WgwXgDcmAJQg9knZYkCcIl664ZIfskrfPGICqVL0pNMAEjcoOaaE44l49t0c/iCVdE
         Bt+I1YoUjEy46nVO/krFUMmb1+8Nq/nwo4XINdR48KPc63fLkKZQTcxkfGJXAXSXFfou
         2phOUILki8sXEeMDltK1knCW39ryNw6arwxRCqoyTzEM/esbOHSTZb/ZwYrUfGjXtaQz
         G3hFp8EIFKecIY7e9xmUAlFyu0Q/Zu6PWG9fDTzu5AfM9KlatBj6Va/mAtva7RyHxOPh
         qxSsTp/JGk8wAbmwLsf5f55K2SaMc386pSbML7j2jDBrQ7fInj4H7HMlIWBve/mXDGXH
         2/HA==
X-Gm-Message-State: APuU4Z+h4iEVeQV4FXr34f2RLPYl+P9n7V5TXPenzKh8I/OY8JY5ZJcs
	Pp+stgekHqyMil1bVNbqmBLYoe0/spsjFqC5DSXbVWKNuMEmZEAXUSDJsrqJKTrfz1aWQJKAJ6s
	IGJ/F4R02N30fFiGvCby+PEwl1BemWXg=
X-Gm-Gg: AZFdTZdMNDEexTEfP4KgZKL+v2VlQVnKc6Szs30k9YlbLk/3ngqmTkcHd3ldK6GWI3m
	gNUGG0lao4bXhB3sBOFbCl1x/xvmYi0yOXWrZeIx2yrvQcTXY2vC3lhwapM/Fr0ousDpA59/GRe
	cQp4YyEZCkvHdKzcIIMp6LYnNDFmLDhphDPycI2xo0dPYYK89SOVHZwe3zP57kacdHSGZD/O3gL
	R1qN6FuAFmwPayROawvg5r9TPxMApvnUxEhgeZKmCqBbwyvNnfCIkgXsGLaDchPlH2tPcRZ6n5/
	BbfM8okLVzBASQsHWBDnNFo7YfpUfUNWH8aulezZkJzyme2u3E3lcH6Enh3bG/hYIz3gbHFX3Mu
	wkeX/dBHxgqgKfAQw5DRbKMVpRUhaPOIGlvHM02msV7vZkglMrs6N7GQ2O7DtqTH8QA+j0vl52W
	tn/kh28A6i5bsIOcKivjFxvw2ch+d1TWwuwrjLFvNf7piWwdGFCE0OLDEi6ob+GUf2rs5NPYDtV
	UrOhW5B48FGFwBYavINP/MH
X-Received: by 2002:a05:7022:5f19:b0:1ae:e0f5:2cdd with SMTP id
 a92af1059eb24-1b556903921mr11431967c88.28.1795434075923; Mon, 23 Nov 2026
 03:41:15 -0800 (PST)
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
 <153463b531b03e942247c0f6f9b3d89b8e55ac7c.1793439137.git.gitter.spiros@gmail.com>
In-Reply-To: <153463b531b03e942247c0f6f9b3d89b8e55ac7c.1793439137.git.gitter.spiros@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Nov 2026 12:41:04 +0100
X-Gm-Features: Aa3M54pKnwDnD4AgQfJUnoKFGeImr0o3SqMmYd5QNXs_q8-_BWhH3NWczkCbAzE
Message-ID: <CAP8UFD3_be3NdNBhF6=iNOZk4EG9d46Or9m=je_bRjsgzA-=Gg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] convert: use size_t for text statistics and ident counts
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 11:17=E2=80=AFAM Elia Pinto <gitter.spiros@gmail.co=
m> wrote:
>
> gather_stats() and count_ident() use "unsigned" and "int" counters to
> count characters and markers in buffers whose sizes are measured in
> size_t. On platforms where size_t can exceed 32 bits, large inputs can
> overflow these counters.

I think it would be a bit better with something like: "On common
64-bit platforms, "size_t" is 64 bits while "unsigned" and "int" are
32 bits, so large inputs can overflow these counters."

> For example, a file with exactly 2^32 lone LFs wraps lonelf back
> to zero, causing will_convert_lf_to_crlf() to miss the conversion.
>
> Switch the counters to size_t and check the size hint for overflow.
>
> Triggering this requires processing over 4GiB of input, so no test
> is added.

A test like the following:

test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
                'eol stats of a file with 2^32 lone LFs' '
        test_when_finished "rm -f lf4g" &&
        test-tool genzeros $((4*1024*1024*1024)) | tr "\000" "\n" >lf4g &&
        git ls-files -o --eol lf4g >actual &&
        test_grep "^i/ *w/lf " actual
'

might not be much more expensive than the test added by the first
patch in this series.

I am not sure we want to accumulate a lot of tests like these though.
