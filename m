Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648884;
	b=NMg2rOtIJvhsDKioDBAt8l9vS8LYn5NKzJoktTqFWkNGdRPSBvIbJVWxi9ry7IS3OZEV
	 UXHD+pnH3RbuLQIVoipYWHQ1I7ZwDF44kIEMhUDQaSNlqxBY+LwJevMMqNOVe50ujKTtc
	 V0vmFK/9g9phpvgMEkcDwaPoMMfeVNsSENCe78VfQGats+Jm1FyGyoNMOi9k/FwnhG1vd
	 V3VJ6HwZRxei7NhjLzeOkrpPmFPl5nsp/EFgSH7sG1qfPHCpaC29Qx7k9Fxl9mH1koo1R
	 A4h/vMQILI3P84Imx9M3FW1KdwbYLPXdehorZaqFQiOv54/1CHbxUcVpX1UBv7INEtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=SqRdue9oPJgtX0JxUG0taojuWqE9Sjammd2Gj7pEL2g=;
	b=V+PhKvVOKtdJDjQvJlxRZ7mlazdr1JUo8bvy/wrUzhS1SGLIk/2uPQz5jb3FtQ6t7b1x
	 tpfuXj3OSQllatpZEFZu+Pn2An/NFMVAYtAJaozJQgWqrqDgvcNXmx2KZx34qyPiOjGUw
	 WSjGVc2cjF7+tDj0wYmmBNJ+Zntabh04T/HwAb07esB6icKm7rUC5iOspBxWO3Fe9yrTl
	 I3zLDD7gd8jqz/GVPXa1e0OGFFS+C04OaZO+SpfRRpyibP6LUT6ruaJlm67zNPhRVRPVn
	 tJeFng81Hz5Iop9l+L3B3Ek1F1QFkLDCwaOtA6sHXDv3c+gyV1jhhuqaonmUnvQ8bLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mh7SbVdS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B332606A33A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B332606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mh7SbVdS
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6f8a519e215so3429259eaf.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 11:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648883; cv=none;
        d=google.com; s=arc-20260327;
        b=sAJ8SxB658mD5rdoccSaearhAbxxjxvPHwLa7HyDQKU+2oGKs5bDTVqaee1jEpu3qA
         xiyPP7oK/XaGv7YV1QrQyVi7KEiy7GPmlXUzWQeIap3FmTg4PnVAPJQNwc3GMp8iwDEB
         oPqLj15GB0ABlFL8qExnLr35EiaokhVB8xi3xq/aMeosZGpTFI2qZEMAbg2fE0Crz1tQ
         NcaGn0Mf9v5l1PBfU6bmRgoGLWgoLlCKE/t0W5AVpndHHydXcSet0Fj0H/WLmlPriz1d
         ZUgbdxaJYG+5NDA+aCt0wNYvPwYwBQtajl2OlgzLqzzUAWP8QsB61kohBcxwFl72Y56F
         CfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SqRdue9oPJgtX0JxUG0taojuWqE9Sjammd2Gj7pEL2g=;
        fh=5PFJeBr7a+nhkSJKkBd2FkDf8aw85ThIkZJzXtcSCYg=;
        b=VBffjdveW45TvuibeudafZJWURQFLTFFT7Id9nifDj9S6SvsA1b3Ikzmm6KCy0ZU2b
         WxGh2xQdgY9uGzqvPiNDbh38AJewU5YLjYHwu2CNJrea1cbDeTMOcKhEacF9t/arzoOb
         +doOz/v9yYQKeWYjhM/+c4tkY73VXl2pL5AyNWRZLSFWDlmeBST/srZDgYQJG1c8q/cC
         q4XMNV1KY8o1R0b8nUd//VO7989UKDXSxtbtvq/LwHrJcs7YtOFSGh8a6c/dVrOSHZ7P
         jmWf7aq+9zCRlYNkRsDuiJ8bFtrqOYP2k6a+S/K2uUR3aNDpJvdxhGnRpJNOAi7J1Bzd
         4gTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648883; x=1794253683; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqRdue9oPJgtX0JxUG0taojuWqE9Sjammd2Gj7pEL2g=;
        b=Mh7SbVdSDf+CZJSw97AJ6xmMva6ojHSf6+2CBnq7Y+AqLkfqj3Bigi89/2oqsHiISM
         huoY4NGJqgC4WnZNO9AA6gVzJM7QrR+xm4NzKEmtj8HCxcIeKcKJ+TQh7150hLMagqKB
         8Fi7hWBlVTy7THTZ+RLX4FeNSc2LyVD9vCSNwCMJgSOWluQBCozm17CXqmtPNw19ib+B
         OAbFXCDgnEnVk0WLkGWNLMLmZH4DQHwqZRArz0kVOyX377OZebD0ynxCYhhBVelp/NU3
         Wy69Am2Wvdk6SoWOTkhuDMlzCKexlJ4XnJHvMdxqKSlzOtc1n3PeS9wktkhV2ixYQagA
         1n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648883; x=1794253683;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqRdue9oPJgtX0JxUG0taojuWqE9Sjammd2Gj7pEL2g=;
        b=lOB/VvpuRjp0LbM40PpjkA1nEq8wZli4n3DKbqNxPZ5UA7el9DqVeAxATEPskX2L8w
         CIqhrSiFY4Shrhkmz5f0XGEUYRVopvx++uD6KuGdAmwX+aCgQ4E/rpn3iaby+b+eOIAE
         NG3dljL2uhEWAoabDtWYFq0IWwpE4yTiJGvWee6DXWdOObBFVPme631wZSUV2LJsrAT0
         gOs4eOxHhUOFRON2j3Y/yxkNIQhOlVUs0FMFiL8ixQBMtalG4VAE0LSMQsjUd8NH/OpT
         apPXlaFc+txHce6tQv5deHI+984VpUfO/sRF7tPhTzD8FwxOgYFUn2tKVKxKLIjrDNKY
         +LSQ==
X-Gm-Message-State: AFq9FYIyEi2cfHuOskMoEFaooB+HUaIRlrQyiZGpxMz2HXERrJeQBpZ1
	IBpyP7uZMErCKET8XN5C5tVsS5BS+e6ekmHdNI3s4FYdhWdFk3qWvBSU4/TzveZ+TjRy3yeIoaF
	RYZgEJmXYD/RKPo7+z1ntM1b9uGEWs1gB+L9E
X-Gm-Gg: AYBFou1KTiAHtpJlkb5RMcR8COu6GOouK+fHp0lTCyv6OKS2qDBIUmUd/h2N/eWMdhH
	fcZ67IerVIsAqd1YDlDuiQX+0LLD1A8I+olSiwZPKm7EY+ch6uJTe3rshL9oKSRYqsMQVsGOquf
	Wk/Em3GBsWkSm0e4f2mxqE2/8mttv1bD1Hjn+P1gktUgdlfJqlDFK3LIPL2lilXx/Rg87qbS8Fs
	MQBce6UidiCqwLPLCZmXYvdVpOl9QxuTtHqJk16EC9g+ysh8XJeKUh4fONGqUL2RmqT9qYewM/J
	qhBokU1OTFESIjCQjJv1VMBhry474r0D++gDZ/0BjpWN+ZytddYhE6h7+p538O23m2Vx4fQfGpI
	tbjHiOMFsMDZZ6uWs+hPV7nNmolMK+wPbVh4=
X-Received: by 2002:a05:6820:4d02:b0:703:6903:75f5 with SMTP id
 006d021491bc7-714ddf5e83emr7425726eaf.39.1793648882877; Mon, 02 Nov 2026
 11:48:02 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261101230326.3675597-1-andy.koppe@gmail.com>
 <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
In-Reply-To: <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Mon, 2 Nov 2026 19:47:48 +0000
X-Gm-Features: AclHuK9Z-yYKHXe6gS3KzaSyjzb1qLqIK2NL-Sd-IJQp4LGNI705G5U2eh9coek
Message-ID: <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
To: Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 18:20, Julia Evans wrote:
> On Sun, Nov 1, 2026, at 6:03 PM, Andy Koppe wrote:

> >     ++[[root-refs]]
> >     ++root refs::
> >     ++    Git may also create references other than `HEAD` at the root
> > of the
> >     ++    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
> >     ++
> >     ++[[pseudorefs]]
> >     ++pseudorefs::
> >     ++    linkgit:git-fetch[1] and linkgit:git-merge[1] create the
> > so-called
> >     ++    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not
> > references as
> >     ++    such, as they are not stored in the same way, but they can
> > nevertheless
>
> When I look at my .git directory during a merge conflict, I see these
> files:
>
> $ ls .git | grep HEAD
> FETCH_HEAD
> HEAD
> MERGE_HEAD
> ORIG_HEAD
>
> From the above, it sounds like ORIG_HEAD is a "root ref" and
> MERGE_HEAD is a "pseudoref", but naively it does look like
> they're stored in the same way. What's the difference?

Good question. The differences certainly aren't obvious, and they
barely matter to users.

Root refs:
- Can be stored in reftables instead of files in .git.
- Contain either a single hash or a single symbolic ref such as 'ref:
refs/heads/main'.
- Can be modified with 'git update-ref' (generally a bad idea for
built-in root refs) and listed with 'git for-each-ref' and similar
commands.

Pseudorefs:
- Are always stored as files in .git.
- May contain multiple hashes, and in the case of FETCH_HEAD, carry
additional information about where each hash came from.
- Are only modified by the commands they serve (i.e. fetch, merge and
pull) and can't be listed.

The big thing they have in common, apart from the *_HEAD names, is
that you can pass both types to commands such as 'git log', 'git diff'
or 'git checkout' to refer to a commit or tree, just like any ref
under refs/.
