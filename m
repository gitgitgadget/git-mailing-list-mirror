Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7157865
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792138; cv=none; b=jqTeKd2Gy7bRM0R2ynZ+ru5U66zyc/JxXdyAD9jpkZ48j4XpaDMS0Vvf4cUVCh9vIqeGwCUdbiy1NBBQHuOu+npcP8DGSwq9XDxp4oNNigxvqGMKeMSIB46cFeYySoV9DWakv2YGdsB+oECueK33NrTiv8M09oH3wU3QNClnVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792138; c=relaxed/simple;
	bh=57IbVwlv7wcygz+qCEJPVRtqvyrA6pGxyM9Zt9v2d88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSumlpaLT4EfTXcskX51CH3iCXqYZy0tIvCZvhNJp631q88kTXWTteariuaWAK1GDWPOuPPfkChAnpiEJFoujV9+C5x9sR+pH0iZIZfApvlzayTM2ORKjUqNZnqCUqqqNtGg0ZjIW1MnsWzTCNmhiyHydkw1wST1rZeWE0fLIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430c4d0408eso11675061cf.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 13:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792136; x=1711396936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QweQ97E75TTuNJoFaYH9cYBVtsIw2Mb/iwPN1lg7FuA=;
        b=cDboZXJvQuuy3TZtWzpTxuqn/uxcN/y0RguI6Hrl5HPZGMYIXRz8YSjrXN4wAkIuZV
         24dcbfM30Z4T+QhUs2K6ZUkeaiWDnMrAuQHHplI1jo/7sSnpFtTVzW+D0CPDdnkoem+0
         cBQjvDLAfSdfntPIaCxQbg8fh+dZ+iBE9aj1Ti/EmIXE/unLm2VGdsx7HxWi5vswV89d
         /HHo3B1OjsNFLT0F+PBLYiaKy3uf8n/BKN6WdiaEQRCi4WrUS/R9gw1Ptf7IoI7E89+D
         xBOy0VwUff/7TRn40Hsi2G2Ioe0Az3Bk87CfnN0QwKIafwf4XHvyoa/DbCJ5An0wClTS
         SiPA==
X-Gm-Message-State: AOJu0YzMSnl2qBRCG+o9COkuzLAR2VtkPQbcTSZJs6Cd8fBE0k/StUPU
	y6oMnZqtC6+a1C/vV2bytu4wFzMuXlg4nBoeJcRJrGUcFs6bqwAIiuKOqQMfX6VLlE0GdnH55yp
	FrkHSCv01b74v05uUae1PO3AWDoAmbrShyus=
X-Google-Smtp-Source: AGHT+IE4SRuO/dx33WsBlu9aTBZ/kHLT4WR7D2ILnLugDYslhKLmi/6ysj3CLmWGb+ObYvpj6uJsDFS84KRxU+F1g0Y=
X-Received: by 2002:a0c:8c41:0:b0:696:31c6:f1b1 with SMTP id
 o1-20020a0c8c41000000b0069631c6f1b1mr44535qvb.16.1710792135914; Mon, 18 Mar
 2024 13:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710781235.git.dsimic@manjaro.org> <784912a8d9156fa00ddee218fd600254d7bab160.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <784912a8d9156fa00ddee218fd600254d7bab160.1710781235.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 18 Mar 2024 16:02:05 -0400
Message-ID: <CAPig+cQc8W4JOpB+TMP=czketU1U7wcY_x9bsP5T=3-XjGLhRQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] grep docs: describe --recurse-submodules further and
 improve formatting a bit
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:04=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> Clarify that --recurse-submodules cannot be used together with --untracke=
d,
> and improve the formatting in a couple of places, to make it visually cle=
ar
> that those are the commands or the names of configuration options.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.tx=
t
> @@ -24,5 +24,5 @@ grep.fullName::
>  grep.fallbackToNoIndex::
> -       If set to true, fall back to git grep --no-index if git grep
> +       If set to true, fall back to `git grep --no-index` if `git grep`

Good.

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> @@ -65,8 +65,8 @@ OPTIONS
>         <tree> option the prefix of all submodule output will be the name=
 of
> -       the parent project's <tree> object. This option has no effect
> -       if `--no-index` is given.
> +       the parent project's <tree> object.  This option cannot be used t=
ogether
> +       with `--untracked`, and it has no effect if `--no-index` is speci=
fied.

I believe that there is a patch series currently in-flight which is
re-styling in-prose <foo> placeholders as _<foo>_, so you may want to
make that change as well while you're touching this.
