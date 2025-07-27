Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCC86338
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653743; cv=none; b=tC7iLiYwg6EFmy0af5w+9JQQGMVioOZaXAvXXBgMUChHP+0xrCZsjU+pxldbAyRl3RLx/L92vp50iHQG9e8tRDMRKy/1Bs8yne3kJDG3x4qY1M82fFcAlfTWMnuaKNAHt4k1hpzjipfkPOPt89TLWQuyu8iRO6QDy7NK0I9YR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653743; c=relaxed/simple;
	bh=1RgYqEmKBIte1vYna1p1L8po5yK3h6YOrto0Bh9Sx5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsmBxnQCsL5rPMS2IE5SV7Pykc6mq+LZMpy5GxLp+ZlVMkHhvRmylHOolaj1PhLYyLIbgX0a/xtACE+g5EiJH9YcMbG6QapePUAMqorodq0VAeuup6yHhVGrGDT6NjZKORYXtmpSIOrzlNAKiF4NTvpkeaMhomZNtb0t6YAVTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facebcd4f0so5362506d6.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 15:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753653740; x=1754258540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTut3Lnr4HBw0gVFaoyp/8g3wwUVl2Pag6rwEbsjUCU=;
        b=Fy0TGDEIM/xDFY7PM0HLfDVCwm9EsekhqEZD8bpZYbpxpRyhRturN2dIN+ViNh1JcE
         5VqpI30oom7WtJ8ZdwiinP28dLE2iL7I0bH/li2yjRcv5mZydUTxx+L004Kmwsbu/SVe
         jX+UK5XaDlGrowcUeGLOkaAyMMN3X3cUNLM6saZFT7q0ulbGbQIh2V/bUrofSG50XTDB
         tHCtuxcl+Jc8/l9AzwEsYcN75htWreGyziLqm4r+KttmIl850AVimpba3u7MMAxqNQjK
         aw//f0McoX3jhIqH2lf4bYnuYkZ3N0dObbDLF7G2lBsTQsP6yVOn5AtrAp+A8bfZbjuD
         4Okw==
X-Gm-Message-State: AOJu0YzUMBjg3LnKCP4jwJr42IgQD1YTr2lOH4YkXByRveCNwEcoDWeM
	k++ST0N7bNSkrefsIzC1O/LBx8SVK7qH9L4rVp8FH2y9J9l97KMJXIHCmxJijoyItX63ZLMtU4H
	HkC1EHxMGIF/n/JKsHNT1IvhDdAQlIAI=
X-Gm-Gg: ASbGncslYsmJF7fPH4PhTKWGXSaVwQVCixMLR1jA1lOQ5xyti1lSloICc9JmNyaALr1
	ca1aB6dioWtqBXsScTOQglIt+jCQRMzsaio7j/IpoxrpbrQdTQnOv6WwzS7YfK+tR0JWBblrQgA
	JXhm33XAr2a0IQcjj2XZvXmJbgiflGNzQrpwjWElLST6mOfC9rQEz9sAWrs3iHJdaoumFEqgvsv
	GdyNHxCElnvHlHDUT/VGAyxXPz3pQYErQU2r+Rc
X-Google-Smtp-Source: AGHT+IE4CsbQJFbs6IkDJD/nkveNNkXw8/RZyM+PxTjeVIFw+t0WaoB0g20ftN3boXYKbJhmVYoFht2GnMBtwHbyqPA=
X-Received: by 2002:a05:6214:4114:b0:707:6f5:7f99 with SMTP id
 6a1803df08f44-707205ae447mr56655506d6.6.1753653740539; Sun, 27 Jul 2025
 15:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com> <20250727175110.84770-6-lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-6-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Jul 2025 18:02:09 -0400
X-Gm-Features: Ac12FXx-9mmIf3dKTIMS4v7G0_eTTt--gE0qmBVVFXvB6EiLCg1w0uVUL4OGCSI
Message-ID: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 2:02=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
> [...]
> - keyvalue, where the retrieved data is printed one per line, using =3D
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - nul, where the retrieved data is separated by null characters, using
>   the newline character for delimiting the key and the value. This
>   format is targeted for being read by machines.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> @@ -18,10 +18,21 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE=
.
> +`info [--format=3D<format>] [<key>...]`::
> ++
> +The output format can be chosen through the flag `--format`. Two formats=
 are
> +supported:
> ++
> +* `keyvalue`: output key-value pairs one per line using the `=3D` charac=
ter as
> +the delimiter between the key and the value. This is the default.
> +
> +* `nul`: similar to `keyvalue`, but using a newline character as the del=
imiter
> +between the key and the value and using a null character after each valu=
e.
> +This format is better suited for being parsed by another applications th=
an
> +`keyvalue`.

s/another/other/

I haven't been following the discussion around this series, but don't
we also usually provide a `-z` short option? Should that be added for
consistency with other commands and to avoid surprising users, or is
it too early to commit to that?

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -20,11 +20,20 @@ test_repo_info () {
> +       test_expect_success "null-terminated: $label" '
> +               test_when_finished "rm -rf repo" &&
> +               eval "$init_command" &&
> +               echo "$expected_value" | lf_to_nul >expected &&

Simpler:

    printf "$expected_value\0" >expected &&

> +               git -C repo repo info --format=3Dnul "$key" >output &&
> +               tail -n 1 output >actual &&
> +               test_cmp expected actual
> +       '

How confident are we that `tail -n 1 output >actual` is going to
perform as expected across platforms and versions of those platforms?
It feels awfully fragile to me. Why slice and dice the output anyhow
rather than merely crafting the correct expected output in the first
place and comparing that directly against the actual output? In other
words, something like this:

    printf "$key\n$expected_value\0" >expect &&
    git -C repo repo info --format=3Dnul "$key" >actual &&
    test_cmp_bin expect actual
