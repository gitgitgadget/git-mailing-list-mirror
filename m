Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810234;
	b=wR20ZKFj24/f9GsXvl7uzTDD1uj3uhtOWdC4xFvS75CDQGT38YaLDD+oMk/ge+2QWLTi
	 jT344Q3ZuUzfD/AxoB07GK0sdBiha9fWPH83eia0UEyH1FB26wUEo0S1kM9urNVQrnxr+
	 I3l0vxQEVatUUZcB+sfsgU+OZxovmkNKLYFn5jcyhROrJzipFMMldhd7tZgwvQeLSELqL
	 VUVlx44Nt2Fq+jqfVT6L6iWk7iJhFDvBFQ6Y9KgFfJb7PcBrxXydeBBPQo0NPB9ghNYQT
	 y1FQvRRfqe7RZrZKGd/Odm7dCEdNtfEuzHieyENM/Z+xo/+0G45z2mtWmgIMS+ik65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2LyqkDcLlllCTTkxR8A51gOPwlbuTH7GF/50v5WSiAc=;
	b=ef5lFi1TN85deVVRLP4G81WrWn16IXdcFuAM9ltvob6NCtW8rRweQiiGrxdt5bDdtECD
	 WZpBrr6m8LYjxZH8zrkeVAMn0li0GYVrDvhdp5tYcLaOzLkWuVJzAlu0ZnM20coGd2VKG
	 wYlRHaMZJ8AJt2FU/XsKmzVTCZZQ704OkD19zkIldu+Og1TDwuoh6ylGI8c/hbfPGP1gQ
	 POsg1QiGYGOpdXD5rIbLRxaVp5mMBamkad5/JIWb8Xfj+kBzSQwL8NmPePqMazT4heuKU
	 rmdpXXQ1agW++udU5SepJoNZaLDTkT5z74O36yOnEoYATbeYckyCf6T8oD81zyK+deg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQtzMMny;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8396606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8396606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQtzMMny
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53e1d40628eso23475921cf.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810233; x=1794415033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LyqkDcLlllCTTkxR8A51gOPwlbuTH7GF/50v5WSiAc=;
        b=MQtzMMnyGAuc4ZjOP7CzeOzdwByB5oFWcYWlSeCWfWbmM3xU3HLVHU8dT3XK+4gE1X
         jW3bqy+AwUndRDJOTvO9X/MK9bYhLAHC03Z12HTJr/yZuKkcNCcrUZFZFE/jmbPijJ1n
         JiFQg6hRchSGMVUzFkB5+6kyiN1c15szYDw3V7+vL+fAJEzkONiF7y2fP9hPqw2QWIPT
         OUV+XCrSnqmbeClOIlobOx6aDPAR8RbrOEV6G6sJ9zfyGLcxQ4NmPx2HbEYd7KbndgMx
         UNQP3NzvRVDukE1SLOOWU2qZEjQI8zMuLStGJpcZ3GLGONtHeQhLrPOdTNgDTxz0jCgq
         kkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810233; x=1794415033;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LyqkDcLlllCTTkxR8A51gOPwlbuTH7GF/50v5WSiAc=;
        b=YxLUYszCHjv756GrnYDyrpatJ6ZkV7WiT01l+T5rCq5chKADjv0nWzk4CNgq57AYJS
         zv1JfjZ8Tw+CjZaxSs/E8UdSbwJLYbVjq7RRzlOUT8UI5dGqjKtIr2tGUrwm56VlDQct
         MHzY1hj93GYCuRYV+UYC0Z2L7CPxN62W90Km4ys5gyxYcDKtCGOQpLmR/Ggs7R9fEZlC
         gny8iLQxcsaJl1PaHGTYK8547H/HDtuaua3G09+X17duuI/C2Z3A+PuvccAwTfupLosh
         AQm6FW6yeqWi4QQV7S1VNzdY3E2X91YABLahmjLolQ+ZoXOPd7EAoy5QggZFAO/k16gb
         xRUw==
X-Gm-Message-State: APuU4Z9k6/i9HKU2Zb5ggTL0E57Ac2m/7lWhoQimwcbPpDmoSczRd9Ib
	vPoGN7M14RwOgLvhxA8gyu52loRMhHE8zX/qsqTPzYDQC6UTekR0nVpxH+OPAQ==
X-Gm-Gg: AYBFou12VqAkKVR6bwK8OUJv5xv/SBzB/wi9CVqg1wqCpOp4jbqmJ/zBEKB7S6MNoU2
	7vykt6Kh5wU5h+4nlhx/CsVJ8vOB6l64MjAjNToq3dwFZLSlKbT8KdT9R3XZUpGPrdKLQeoNdDh
	o3NFahG+iofPpgSDNl4DI/A+S+UFVBvtRK7FTaJDI2y0GjPv3/Qu2L7d4oOLlU/l4wDuYdDQGFW
	COB6e+RxJMCYWWk3WqTxNXZgx8FtFolaJHDBn7PStJo/aGZPIlAfja5W/2ISu2SM1TPxfW5xRJw
	7Zz8NbP5Q2k6AxJVrHR9QDW2FF66MCqF0AY2UjdyBdMVa6tcAr+05XGH/AtJh60U0hONlWk4Bzo
	/AaeBFUJAo8LQ10lUdX4IfTLYGGauMYlMln+78fgonHvLwPjjlD/6XB8we9215+VziuicFpPYer
	A2p0zjW9jKV7ZKwFIYGPzGx3ySL6U9+L2822Uf+N4BuerAz2Nr+FlSpuUxo7ErN20azdKrpblOR
	6g+D5zRRgbh5MYAq8OCPI7xaFZ04MzY7Ror26jIO4YSpB7wiPEc5lYvSKMKe1gV/JXLeNnWqR/o
	gReb1Bk74QsM7uASQiw+fvDDLL+unyOnwTxvIuBEWV8ldUZmJoy1brH0XtDxp8SvRpGA3aGUXCE
	amY4IZ0I/xKTuj9hFO24/qLZ2/pe6AsuVpjIfiHgyP9Tni3OvofwQRvJvOSkNzfVw79TjLgoaU7
	yOfWdGFeU5hEYqmEuDQkk9S3rLNgA3SXh5IklSsXepXzWqm0w785p8
X-Received: by 2002:a05:622a:514d:b0:536:68ca:af40 with SMTP id d75a77b69052e-54121738e1dmr303903491cf.36.1793810232664;
        Wed, 04 Nov 2026 08:37:12 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100ab8e4sm28011631cf.7.2026.11.04.08.37.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:37:11 -0800 (PST)
Message-ID: <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>
Date: Wed, 4 Nov 2026 11:37:11 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
To: git@vger.kernel.org
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series includes several small cleanups for the interfaces for
> writing commit graphs. Most importantly, the series refactors options so
> that they all get passed via `struct commit_graph_write_options`. These
> cleanups are split out of a bigger change to make reading and writing
> commit-graphs pluggable via the object database bakcend.
These cleanups look great. They are carefully constructed to be as
simple as possible at each step. It's good to bring some of these
conventions into a more modern style and to simplify things in the
process.

LGTM.

Thanks,
-Stolee

