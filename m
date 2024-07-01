Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934416D9BA
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862869; cv=none; b=gOpmDVMzl495lPE6rNAraHojlAr4WbZyQUtJHQZH8oMrAuxO9WgjYEy8epwYFI3NOKtpLsN+F4+T0WmY3nA+iJTnRGF77prgeO9rTaX3KctREhd+cEGkdrf8q1Jf7HtAJjvFMBFfmJj2CBVvKuiLJOnJisljE9AYhMThcybMhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862869; c=relaxed/simple;
	bh=PPZW9zv4+N90Xnh5x7DxcccOCikBveuetuGye2OCOeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRatLMbDFdG3nXC/huCYkroYfu1lwutB+1z2u3rdP6coiL2bJQhye3ngQaN8lELCFGsZONn8dG1EINT3zL+RRnJ5Z9JXiIe14i+I1+Xgp9n6bwlOksvaDEEnHDmA2fy4daUZs9hWy81IoFH5SyY+VPNOSBB4nVj/khui6/JW9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b501a4344bso17415046d6.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862866; x=1720467666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJlpLFo6M6zX4XSKtjwju1IPo3mffwZ8QlzBP0HBGLg=;
        b=VIhyL285LubEBzHXUQEFFKKUgky6gx++3c2XMMpChdDUKie4iThl3tjrO5Db3Gy/bH
         7iX9XeGzrh+XTmVMr7gnlVeZ/GB+hiE9XuTgrCQFOfnd/9H6M3u1Hi4wMV10fMACCuTw
         PuOdSraHY9tvgwsnEX7qJq4VTvcjLSJqHxBAVGwqggx3IgSltCOiAgAyPE2JjdNdSiEx
         PygGOT2qR8dhadff2cuMdqZZQ0I0kYkpiMX0mgXcfXzh/VMiooCXXD814Bi1Ang0y+Ir
         uxTl/antzYSQJLPqDm1AMRt8ZxN269p6QGOibc9NwBudf1qBFMHe0Z8tKwM8LoAmqsld
         cO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4vdr49dlkugtX7bsN22cTmXCKr3b6NyUNRMQeKOL9bWHmab8SLQJPwb6teiiPh3e5YNNFFNT7YacCrrpmiQs8cnyW
X-Gm-Message-State: AOJu0Yy8hPP6BrwJ3UPeFFVUMHXYINo53DtOWmPiYcDzUr9VtzzZGqO1
	VoSsBp57+rexj5h0FoXgmp4D3FKk7UDs/vN+xsVKQqAgERBBYYZd90RDWUIop/1cu+JNSsleutn
	VKxbAt3Fm0Ne2u9RPFXiCSImtxDf/Bw==
X-Google-Smtp-Source: AGHT+IFjuNLyan4bqVbCSPEtI399nLCPKVRNtD+AWHzxhMdDMDPmzDZmLLFU4N0ey0I6GjOg2Pti90SK63W48ngaTGg=
X-Received: by 2002:a05:6214:1d2f:b0:6b5:936d:e5e9 with SMTP id
 6a1803df08f44-6b5b70be06emr80537606d6.26.1719862866391; Mon, 01 Jul 2024
 12:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net> <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
 <d244fb44-0bd2-4416-b24c-0a93835b75a4@gmail.com>
In-Reply-To: <d244fb44-0bd2-4416-b24c-0a93835b75a4@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 1 Jul 2024 15:40:55 -0400
Message-ID: <CAPig+cSG8xqfVcZmejRKKDww-+29fkyRZ=yn6NizcfTm8FzouA@mail.gmail.com>
Subject: Re: t0612: mark as leak-free
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:38=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com> =
wrote:
> A quick test tell us that t0612 does not trigger any leak:

s/tell/tells/

>     $ make SANITIZE=3Dleak test GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GI=
T_TEST_SANITIZE_LEAK_LOG=3Dtrue GIT_TEST_OPTS=3D-i T=3Dt0612-reftable-jgit-=
compatibility.sh
>     [...]
>
> Let's mark it as leak-free to silence the machinery activated by
> `GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck`.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
