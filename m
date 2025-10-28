Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38194A07
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678973; cv=none; b=gLKu0uLNvBZJ7n0esnFmG8Bp6oZfMs8V9ywBuH/1hRqEeoj8xhjWb5ftkFwT8+zYSiuYx3tdIdxOpTn0kcey+2hWIUKeG2M66nf6YQrxxNrB4DAIkkDk0oYbDJPVP33f9aXB8qfrAyFmDinZ71vQf9TJgPG1dgo+beczrW3hnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678973; c=relaxed/simple;
	bh=GTXDQ089vtLXdQ9jqXaftpWs6+/hVJVofgrh9P34yX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmO8sHf5TBrrQkS01CCG+AwtnbDenj/+8tlLElpeJWSk/lRkIxB8nHCJ+gXtFEfPeyrfUk+mbLm6fNZVcNXotx1BFbKLtjyu1nvDacgck9rDftalcFk+O+kcw5IsO0RUDVNrbUZuX3V1euGiUeEnu5boNKcBgNX0BSsZMH6tUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6z36dPY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6z36dPY"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3737d0920e6so99567971fa.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678970; x=1762283770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fqn4FuuyCQ84uggq2PEigRC2CGGUw7ALIk4528AT9g=;
        b=e6z36dPYkbCmgXE5SgE6EAb3lIop4vDWzPqYi1WqOgvNqhGycAKRJ2p1JJ0+a8G1xh
         ZIWqnwudXV6EAq83ggnebO6b44L4QybhDTJoz3418V/kyT9r+g0baPo1rkOf5Ox2Aceb
         qUbiXsuxCOKqJyxMp3DtIm0UJzgB1MVHoQxalSOWeglsreQA6OOmXwcoQ6ttx8n911AF
         B53wU613AeFtgNd93jncb+ZVm93C6+rU0CMN48xVdjMFWzwwv+WaMc3ToB4eulhym+W+
         Mzo85Jrey/JkPtjTbzOG1AtqOIwJqILL/ctjvqYfbMyvyKUveVw+8NS3yEAuw1+LMZhG
         g9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678970; x=1762283770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Fqn4FuuyCQ84uggq2PEigRC2CGGUw7ALIk4528AT9g=;
        b=EuTL7+GX0dU2YlF9m8ei5fBGsE6Ph5gb+5QFZ6143W0M1kinRYWZJpOQTOjZU6L1W4
         3TczL6MeoyAu308/NKizQyCfwoICJMZirF74md8wc7S6lb/QfQzxYDOX8lh7UgnBPtJA
         T8edOS/Asn/THtKvo3aTkLMLwUuYfzPJX73jpY7dnvOKlOlOgKOxYjMKHD9BHNPOD81P
         FzzSMVIEDaWMr7lNzNbpGB/NR+CTEI+pLVhYpwh08wjkdDgEIsrivsEBXlRiXWFbFAI/
         WvbWu8CI4gqi/qtEOBBOpmvs8UcdukA4mKnw8hwfekAmlPapG4wvMYmw/z9dZ4DfgVCZ
         1Jjw==
X-Gm-Message-State: AOJu0YxqTJqqakRpui8rcIoFdX81Qpn7DhL2SfKiQmTGxsxbSfzPtzqq
	GG28RG1lbxtNXHHsMGwvhqzTw5HvbhIInboCXakXtA28p1MrAMhlCYIbdkcA+YTeg1ng4s7ZPGC
	ZoE/bzOmEVl8ZU+RIYeKHNCqICkMjgsI=
X-Gm-Gg: ASbGnctmj/mtcJN3a0ZKwDxweMU0ylhjqj2K241Uq4TGLZ9rphM3TcTX8h4kmdSeH5W
	ryIzjKMitQpFthCzPoNdvCzH7lqZ02EdhVMpwZ75BkgZU8F0MMx2nDQ31fNFnUI0eDu07sjScMB
	6wH/WryrJUecTIceKCvw3p9f/uy8Pn3ysvIZOhl+F3fpvFYIyOG0Pj/U7hbCOcyXkoGAzfS8w1G
	zx+qzwWe79xF6/JfexPTImh9kntZLdRD1a352BLJXUFJRNeu1KIgKfJ+wRQSEjbndmaEX9q
X-Google-Smtp-Source: AGHT+IEflG1gQmFN7SskvZsTeZBXQM0MlzaRNSawhr6UWozZCl0YEicXf1+3expM5PhOkDp41a2BAVPbgANAagR/ydc=
X-Received: by 2002:a05:651c:1ca:b0:378:d5dc:17c2 with SMTP id
 38308e7fff4ca-37a023c4a5cmr1909511fa.11.1761678969741; Tue, 28 Oct 2025
 12:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im> <20251024-b4-pks-rust-cbindgen-v2-2-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-2-4b4bd4f18490@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:15:58 -0600
X-Gm-Features: AWmQ_bl2QuKdWG80E5m2k9N_EBE0wLfl0MDeO3LZPTPBKmJ9EYy4jI3r2xAoQIo
Message-ID: <CAH=ZcbAvg0rQugxq5PF8s+-WCEQeD98YcT2sqXKcE_dx1j7OMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gitlab-ci: backfill missing Linux jobs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We're missing two Linux CI jobs in GitLab's CI that are present in
> GitHub's CI. Backfill them to ensure that GitLab has the same test
> coverage.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml | 6 ++++++
>  ci/lib.sh      | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 1dbf236b2cd..f61ec2b6989 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -67,6 +67,12 @@ test:linux:
>          image: alpine:latest
>        - jobname: linux32
>          image: i386/ubuntu:20.04
> +      # A RHEL 8 compatible distro.  Supported until 2029-05-31.
> +      - jobname: almalinux-8
> +        image: almalinux:8
> +      # Supported until 2026-08-31.
> +      - jobname: debian-11
> +        image: debian:11
>    artifacts:
>      paths:
>        - t/failed-test-artifacts
> diff --git a/ci/lib.sh b/ci/lib.sh
> index f561884d401..a5c4eb40bea 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -250,7 +250,7 @@ then
>                 CI_OS_NAME=3Dosx
>                 JOBS=3D$(nproc)
>                 ;;
> -       *,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
> +       *,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/=
ubuntu:*)
>                 CI_OS_NAME=3Dlinux
>                 JOBS=3D$(nproc)
>                 ;;
>
> --
> 2.51.1.930.gacf6e81ea2.dirty
>

Looks good.
