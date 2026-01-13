Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65F23D294
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768270673; cv=none; b=k16s4XMXz5rpP0t3TT3gG0GLaNIStQn9K02q74+YBPHRgYUuaHks2270qdcgTu2ZDQfyMgq+asUmWLdyCe5TY0Uggh+49EfgaOh3icTsNvf25xPS65dZDl72F9wfXYDq7nhBYFmgmrEtf6ZkVY8sl0VrHvFUAchu1YEdH19fyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768270673; c=relaxed/simple;
	bh=orE2YfJrlxBvfT6zfT79rNoleqyUqBigHdvikNYLdgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cf5TtaoGRw77B5WHTVJ70tki5Knd53XQIfyhdo34sHQNL5IDk3LVv97y458u5GqWosA2uPSNVpODuJJofqEbsT1OCqlhS4uIbo5tC+Rppsoiwrqp3H1r18X0s402KaubBccDq4y9RrK0Pb7OgvdYUfCVho2AndRmB5zGzoUe1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9b+HIoU; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9b+HIoU"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec47e4c20eso4460241fac.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768270671; x=1768875471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U621+rmAqeiC5eEnYgKL+8/NZw4WMszus7nkcf6nO8U=;
        b=Y9b+HIoUFMQN7gbyuWzCsAylYKk81Ph/P+7Vzbv3U5hFTTMzGva0q1ENzY/CD/2K6n
         9c9GVi0P3RlPeL7wzxULwl449LXHTIY6Wrm66hK2ZSKjTQMfws6U+40hHHaLPII4vyPK
         gBUvLWS31sc3L57Q5GwMxBGwDsA12cTx/ViqFuRoT1ZlVYQGs+aXpXqDHi45j5Q/8nQl
         ZBUl0/8LiLpxsqxEv+m3PP0AABZPzpcnInh0/MxveBfxefzsML88EgXj93M6+ILZle1Y
         zQfLgD1lEzvT5kKKq9DyGPTdUciDpopMlqlov47Ddo+rcqhqFkA/u+NIlgAXIipe7H6J
         /5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768270671; x=1768875471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U621+rmAqeiC5eEnYgKL+8/NZw4WMszus7nkcf6nO8U=;
        b=EZTTdmTMx+EYqWt8bVThFSnQ+QsKpjYw7OYxwgKURBmiRmeAZ5oAeAbHiCflPGaz8t
         fRudHQSpJXJJnMXv4PiNP9p6o1EcY0XAh+10dzhwO1h8C/yp9UIH8hkImp3Nq45GzE4D
         0+cxs8M7kBDCEQgbctvmkIQOfCR4uOYkWWSZe9aIXeO5E3FyciLjQAa/6RjT/aimHVKw
         bCwpxDDNdRjLiYHtW7cA/enKj7667PksyPbdwmSbGjTHQlEz+gGpxhqIZjvIJWRlfg5p
         8hh3cT2qtpLUHJwx0KsvAyX9qQnPMpX7mXaXB1iMBL2E3Rdkw/vWLJQzPYV8R8JYVapB
         djfQ==
X-Gm-Message-State: AOJu0YyC2Y7ZpNEPw1KqwKw7+Ww24pTedomA8Xcu/beUMbJuxg5Ihslf
	gbFucmDHJs8TKNO/VI84a8BrleQfRg8fzr63lxa4lzZUQ/N6uBHmxlpRw38P5HGrJei7JZw2g26
	v8wbMw5mrzwGf29nrqH+UA/xRI/7wTO99Cypq
X-Gm-Gg: AY/fxX5Yw4TTVYxvjzw8RICufFcvih5LubqcHMO8866qhtP95A0Za4pfj0O13FMYwhL
	NuH1E/oISSdpVrpyx0B74G04vtdczPFdCxXfG64QLUaTxqIF2DXuGwJvgkoHaoXdExc2iJG5B1g
	mc4ocl3gV4XbZSPC4SRsGAMcAHZgFihgK3/pZltQ35M8LTe7WgvqLCzqO1w4vEPiDWoyZ68yOX2
	fHXp0Yo1zPEfH9wXGCwLMmMyyUsTU1bquz3zYWc+yKybNt0XOtr8Hrm8pe04eu8RtozcQ==
X-Google-Smtp-Source: AGHT+IF+r11GLU0KopAax38sgjfgAkwEEpNHK/bUjciU1oqCVz/8gr36HwVksTsksuJGsDzp1DhuFITPlSEmywtB0aY=
X-Received: by 2002:a05:6820:16a6:b0:659:9a49:900d with SMTP id
 006d021491bc7-65f5507478emr8856977eaf.58.1768270670664; Mon, 12 Jan 2026
 18:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
In-Reply-To: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 12 Jan 2026 18:17:40 -0800
X-Gm-Features: AZwV_QjEYdRjXtVBbComcxOgX0du9flVbraI9JIU491c0MsYDiz_tuZXRAf9nD8
Message-ID: <CA+P7+xoqOnU+H_jRq64AsT-Jk058ZTk5M8gpEjREaq799oRHWQ@mail.gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:36=E2=80=AFPM Nasser Grainawi
<nasser.grainawi@oss.qualcomm.com> wrote:
>
> When be76c2128234d94b47f7087152ee55d08bb65d88 added support for fetching
> a missing submodule object by id, it hardcoded the remote name as
> "origin" and deferred anything more complicated for a later patch.
> Implement the NEEDSWORK item to remove the hardcoded assumption by
> adding and using a submodule helper subcmd 'get-default-remote'. Fixing
> this lets 'git fetch --recurse-submodules' succeed when the fetched
> commit(s) in the superproject trigger a submodule fetch, and that
> submodule's default remote name is not "origin".
>
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> ---
> The original commit was a bit over 7 years ago, so I guess it worked
> fine for most users. I've now run into cases where it doesn't work while
> using 'repo' tool manifests that use a non-"origin" remote name and
> contain projects with submodules.
>
> I kept this as a single commit because most of the code delta is in the n=
ew
> test for the new submodule helper command, but it could easily be split i=
nto
> two commits if that's preferred.
>
>  builtin/submodule--helper.c             |  38 +++++
>  submodule.c                             |  17 ++-
>  t/meson.build                           |   1 +
>  t/t5526-fetch-submodules.sh             |  52 +++++++
>  t/t5572-pull-submodule.sh               |  21 ++-
>  t/t7425-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
>  6 files changed, 312 insertions(+), 3 deletions(-)
>  create mode 100755 t/t7425-submodule-get-default-remote.sh
>

I've had this exact same issue due to setting a default name of
upstream instead of origin due to how I like to name things for
fork-based workflows. The change looks good and the tests are
appreciated.

I recall trying to fix related issues with the following series, but I
think I lost track of its development and never saw it through to
merging:

https://lore.kernel.org/git/20250623-jk-submodule-helper-use-url-v4-0-133ef=
3d89569@gmail.com/

Reading through that series, it doesn't fix this particular hard
coding either, so this is an improvement regardless.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
