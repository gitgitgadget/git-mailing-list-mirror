Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AA39AEC
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742163; cv=none; b=nhHY0KQwfbRPGAMdGLqEQGXS81Dhz42lwXLb20++Jcu0JUpJl4ULJDN78GgX4AMc0U05PXQRkWh1c2+hV7uuQ793+puOeCKzNJdOdITy/BtP+F3ZHyubuZHLRkrqgzHQOqvbxF+9IlqIavXOVGcbdhjZlGUwf6oD4wzo0g/PLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742163; c=relaxed/simple;
	bh=I4X9duTKrRyfLprPVuA5Bc/Eo9xUxM2UKeuDSsU/ALY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIRYRNh8jiey5KT382YIkKrbS2QS0n9oppdmX9jjGgV8p1YhwhV0PtJ/70SUPMCsE+KTizP6B9DiYAeXGU/C9yeXS0fLgq8jt/QrHHkxoJtqFLvbmPrBqH/HCsdxOApWSk9ooMGIcLqj6eML+2xMJLpARQa7q9hRoUoxVkMlE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHZcE2Yb; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHZcE2Yb"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d215a594b9so3091787b6e.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718742161; x=1719346961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSlO4NBQnhX2wluMiq12/lzoz5REjL415GnUPZcHAls=;
        b=VHZcE2YbRhuXYfeQhQwwYdyHisKKJHcHp78jP/Bil6IQgFRVPhMB15SmgvRJnflUz2
         +COoUsRFS3cC7h3gX9EurkteZEm9PRaGgEeTEwkBOjiVxC4RPkp0yB/bOV6jC5x9cR0I
         zJHKDgYezIHUulqVXIIKnShEUnQc+Zv/9TOlEXEjIwpls3P67kZ9F0ZcM9D9s347YUzY
         WxbOq78RWbRScL7BqWGytRF/2UDd5QelG3kFdyGQ3jl7oiOpo9qXgCDz82RJzTNpvCWc
         NmWzr6Fi5itF7D/IQTYuDx04uS5jj3T1Tsp/fMve3FJkz4BNdAonWfc39d0bhYhtJCoR
         83Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742161; x=1719346961;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSlO4NBQnhX2wluMiq12/lzoz5REjL415GnUPZcHAls=;
        b=ctLI/CFYVIpX16I80c9tCkjbD+P1MNnbi79OmD2SM4n1xI4aWndq/lItRcn4RYLvrF
         +3dquVEUkh8H/j4bwCcdhkBLBWYA4do44P8pSyo3042Zqweu5PiBDp9S4K7TnNParOHs
         wYxRtbSzZTTtnGYOJpwuTXCbp6mwXUONAVXQ7QEBNGLixd00kQOGo5OvdHkUVzujf81i
         2NefUVWFIB+vmIATIjzIP6Wkf9Zd1Ba+SuOVS1I1xdRzCIYOY3jwut/d2kUwje+BH57L
         cW51HCs+zGP21iJvod8pc5uFoBjE5G+ONRcBDU+kpJwyGKgCYxxxj1DiyiaxqwGLq42E
         IH1g==
X-Forwarded-Encrypted: i=1; AJvYcCWMuolHkkL91yz0vLUNNtLul5fXmZIhSKtOfyBdCayIgRgaBcyVcqhaQEVLmImMvFrUWPqEtialFyuHAZatefthib+b
X-Gm-Message-State: AOJu0Yyo8sIPeey6vpyJ0ZP3w2pswVzB6z8ePEE5MLHFOZ/4Bip0PC9e
	RaDM9su6ou3CPGQHfTgC/xmx/j3dDtAnR0EHXlaJUCVzbKAC4qmH6mo4drtiIKhzhl7YIQcD3UQ
	/9qtcqmbTNvpmkihaR1gx1PVQFpGfnA==
X-Google-Smtp-Source: AGHT+IGxdaSgKvCL9lnxwghWv5L/YdBIR3IOLNPB0TDv+Pf1Cj1MtQtoXbA8qRoO03VgEFtJxoRLwK8Gtcj7etwIjAY=
X-Received: by 2002:a05:6871:820:b0:258:39f1:96f1 with SMTP id
 586e51a60fabf-25c94a0652bmr998273fac.25.1718742161140; Tue, 18 Jun 2024
 13:22:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 16:22:40 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 16:22:40 -0400
Message-ID: <CAOLa=ZSVJsPvQOnC7byRdpo7eJZRFOiSq=Rzio8QRvW_A3StOg@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000f9da9e061b2fd7ac"

--000000000000f9da9e061b2fd7ac
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the third version of my patch series that introduces the
> `USE_THE_REPOSITORY_VARIABLE` macro. When unset, this will cause us to
> hide `the_repository`, `the_hash_algo` and several other functions that
> implicitly rely on those global variables from our headers. This is a
> first step towards fully getting rid of this global state in favor of
> passing it down explicitly via function parameters.
>
> Changes compared to v2:
>
>   - Note in a commit message that we aim to have a faithful conversion
>     when introducing a `struct git_hash_algo` parameter to functions. So
>     even in case the calling context has a `struct git_hash_algo`
>     available via a local repository, we still use `the_repository` such
>     that there cannot be a change in behaviour here. Fixing those sites
>     will be left for a future patch series such that we can avoid any
>     kind of regressions caused by this comparatively large refactoring.
>     I also adapted some conversions to fully follow through with this
>     intent.
>
>   - Fix an issue with sparse by adding another `extern` declaration of
>     `the_repository` to "repository.c".
>
> Thanks!
>

I forgot to reply here earlier.

I went through the patches and only found 2 small typos, overall this
was an elaborate set of patches. I don't expect a reroll for that
however. Thanks!

--000000000000f9da9e061b2fd7ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 91209187a8ad7b7f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aeDdJNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0tjREFDV1BzMzJ0S1ZuUmdrVGh2TUNVUWpnNG9mOQpIQXhPT1BvWVlH
NXdwS2dsQjRqRzhEb3l6eW9BVHpuSHZiMm83UlRPTG9wT1JtT1lxZmQrUE9FbkhscTFTT1FBCjJV
NmpLL09XYjdBV1NSclIyQTZyVHNJZ1BNQjhhNi9ES0V5NDRJamZYN3pYR1l6WGdCSGJDQ2krbG1L
L3JNa1QKQ1hvcHpYN0FiS2tYTzJQZjBLbTBONmF4YkJPa25Wc0xQRHVGQlFIV0xRNXpTdGN2OGR4
UlBUOXh4YkZQdHJMZwo1V1hWVTkyL0NrK0JaU00rVzkzSys2OW1aM2RVQkVFTkxJV3AvSWdYdmZT
YUV0aXRzUWdUenFZTjVjVVJjSWkzCiszakErQ0M5OGw3MVNpWHhmQ1F4eXBYUE92WU4vSm55dDla
SVg5TG1ZK0RNUTJUcmZMQjE3OTdYdmNjakZMNGUKamVDa1NoRE5CYVhKOCt4NUhYMWJGMEJrV2l2
RjhleWtCOWlYL3BqMkwyS2dwZUdMU3MwYjJGQXdjemI4dnFTSQp0U0JGYmtQWGFFSGdhYzdrTjdi
ZnhMTnBFaXVMckJQZndNb0JwOExGZzlTYlYzL0h3N1RTOFFsMU5na1RDdWlmCmxjWHZYRFYrS2V1
MDZXVkpYM3I5ZkRGYjd2UXRRcHd1Qmp0d3FWcz0KPXp1Z28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f9da9e061b2fd7ac--
