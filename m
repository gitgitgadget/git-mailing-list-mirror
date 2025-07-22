Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00731A3A8A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173391; cv=none; b=XO7MU+c9Z9+J0V4rK9oVZfq1CzOhkp1exxx2yud/e2xZrNGjkLG1U8q/q6McG9ICivm2xXNjcFzDp+h36R1jCeIPdEJNXYCJCWybk2HGwmncWwT3Jv+pZ3WGmUDjGUGgGvPzYKIRaXsGH0Q5NQFvH9yE2wyV2dM0ZB3uST7Q44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173391; c=relaxed/simple;
	bh=CyF4dbLHe4U0tAL9aXVXQYjjixXL3BF3D5FIXAI7V1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owpzDd70IL90NZuuj7eh0Ib1A3toE+Bnmzm+CJoquk2ao0JKXz8FX5XKIykX3GmFzvErEsrcT7pkKMGzkjodwdgbu2zJDhtozpXSjrqs2dgYVI4fyQ3BQ0J4pXd3lG5FqimW/+yIQA9/HAOCqafTnyxVcrxjN3AqAelSVIrVTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab703d578aso11172761cf.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173387; x=1753778187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Osl+Y6I4Wn0NhChZCfOdiVAuJldPpFvgeu2epxGlzhg=;
        b=NS4kZzNPHSR5K6TbDA3Mf8yojDDHrMFqLYe9IvnnhgraWfHlUdBa1/Iz97KQPzN4VW
         KpW8fYciYmBEMwMIL2gwxBrWbHD6YNuqhiGjl4Fnz4oEm1Fv3MYLey01gw7oeCa7hzS4
         xT8DiHbo3KwRIlCuT+OiWbRdVeRk49GjQtGlLQKcloxV/QQUrKirmE/s9KpkK+9BnbNy
         x2pilji7WNewBBNpi7kKTP2IsFh4mtEwKnEaval3KSBRTR29Qrg4QMVEsEg514wNxMUm
         4OPQ9FUOmwhOIU6JayQ8li83KMLpC5/m8HNseKYCoQ+uiFdFThjrtCpcHul7DfMvmsXJ
         yBzQ==
X-Gm-Message-State: AOJu0YxeDVSiSll58XULKNUcB1CtXHouz+rP872qWvcOrj1I+Iz+WHRe
	YPCm4ZJxtRWoabumhvQLX5Zx5k6vRXgAX2tzlL94sKOG8FlIBvzcerwxR7lxa0AyF5aHyfJFEti
	DJXhaTRkQ5DKIL/1OO8ttJpE6AZtD9U3SiQ==
X-Gm-Gg: ASbGncsJ/HQ1DmnbDAowOHMf+ZRrFaP6CYY+cs7wN4Wr3kJeVvUHnGhGLwUOgHd1QCW
	/eteTIQGxuOBEA0PQZ0sSUayQ4jWSkOaYfnduaMYJfBKT7zF4am4ENZaDwqpjjg09aAnHznlt5I
	ypOI89Vs/2VG2/FANmCnXfFzoDaYaRaqAhvFePtgPF/drLuTezzYIac7TF0GbwdNMI13aS4xkv5
	Q1IRduFOEKYfvfVkUMc+GSX78fLNF+4rzJeGdOk
X-Google-Smtp-Source: AGHT+IGyiZsK95ew4ou+3bKHfEOyiU5CKv2v1TgrV0IcTEMv7CaxcsJFqSv+IERMuaQEE5L6GgXAU4FO5gN3qgyPn2w=
X-Received: by 2002:a05:6214:2465:b0:702:d3c5:2bef with SMTP id
 6a1803df08f44-704f48158b4mr168062366d6.3.1753173387497; Tue, 22 Jul 2025
 01:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722081219.1086866-1-lhywkd22@gmail.com> <20250722081219.1086866-4-lhywkd22@gmail.com>
In-Reply-To: <20250722081219.1086866-4-lhywkd22@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 22 Jul 2025 04:36:14 -0400
X-Gm-Features: Ac12FXwN8eZJrfroWCfij9vfIva4Y087JUBj9Z0FvLrOcYfEHpkQcIk-NixrxGE
Message-ID: <CAPig+cT1hzz4_7JqesqFmgYdpsNezurcsF9XF1ep8KzvgMUc2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] t/helper/test-delta: close fd if fstat() fails
 after open()
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:12=E2=80=AFAM Hoyoung Lee <lhywkd22@gmail.com> wr=
ote:
> If open() succeeds but fstat() fails, the file descriptor is not
> closed, causing a resource leak. This patch adds a close(fd) call
> in the failure path after fstat() to ensure proper resource cleanup.
>
> Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
> ---
> diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
> @@ -31,6 +31,7 @@ int cmd__delta(int argc, const char **argv)
>         fd =3D open(argv[2], O_RDONLY);
>         if (fd < 0 || fstat(fd, &st)) {
>                 perror(argv[2]);
> +               close(fd);
>                 return 1;
>         }

One condition under which this block is entered is if `fd` is less
than 0, which means close() is now being called with a negative file
descriptor, which seems quite suspect. I'd think you would want to
either restructure it into two `if` statements:

    if (fd < 0) {
        ...
        return 1;
    }
    if (fstat(fd, ...)) {
        ...
        return 1;
    }

or at least protect the call to close():

    if (fd < 0 || fstat(fd, ...)) {
        ...
        if (fd >=3D 0)
            close(fd);
        return 1;
    }

I think the separate `if` statements are probably a bit easier to
reason about, but it is of course subjective.
