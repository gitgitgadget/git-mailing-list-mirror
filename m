Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854714;
	b=Yc7NQsVegPyoK7W8EeEJuEDFJOGi7lf4Cn9C3bL48jTSGlwEu0ZRgLHLCqUElhJFyBUS
	 cJkuKkU6OuJQBn23Ay5xDng84w7RLu41vA6V9G316KwOWemW+VoNMwq7WFDiddm42Q0Pt
	 mOV0AQbdvo2M970sjwSth+rztAcLesA2DTZz7xTWM+zv2iZftQIhc75KBVnYjIK49YfTt
	 4Rtsr4fRrajWSzvNn6PNYIryyYpVROGmNd/A+uYvRsYP90/1TW2dICv0L4Xrxd+IDiQLt
	 OoNHe6fRTzHVIpWiRfIgt4pr5unp9vlLdQZTi3dPUNI2TUEYntKyKLpOnaq1vrdbFow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SjCuQeyQ6Hzw1AK01uj1uFqXVNQNd7DfQ+Rw9QN0am4=;
	b=b1Yc4/dg73XCFtja3cPSg4eH6py/SM9bx9yv5YsmFfIrn9oLEpP3rdlb94kcHasjyxJG
	 e5BrkjHjee/kma4OF6Bsqx7637TTYYoEfdjOw2hLOG6m9NtjlmHnPAPseaJMxx/amS4qU
	 dEx4wNKGB8zOeKDFMxtp6v9w2YD5mCe4gXExRZuO/IsjO/biR64BnPQJfAetlA3IR4nw7
	 ObIGq/tR0y3HnPI3NVqvvJUxmL6xx3T07w4u4gYxQ+svAUWn8+0RPoZyHIrgKsiiqx4Wm
	 y1TleMQolxH7P44gUfsmPxIgbsfwkkVkCiN/j3+HaSzi/Neq83lS1Jnyb6MXbHa8fSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cr62G5X2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC0606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7DC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cr62G5X2
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f639ba307so664621b3a.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854713; cv=none;
        d=google.com; s=arc-20260327;
        b=GFPYofB6PELOGajwXOAjVWJZ6vAaeZ1mr3WAoNCzN8Fbw2eSBu7AjMRniSK52Ipvp3
         epxmB0NPDFkxOToPAr6WwUsTST7AbWihA/qAbzOBXXbjsN9OL+u9453WJIeegtnJ45/V
         tL3TRmmM0EuvZrCZG/08D+HezTmsdicYCRb+vuKWH6bJ9GKvEJnqUrTWASgajzChWebr
         NxEFsR6U1W1kJNV5d9S3FNrl1xCeG1Px4u6BSR2ZB+ArRkI2quyZkSgQY3OIH/D5mcc1
         L58dVs7wDQjld57i6FPj44/bksEFWUEvx8JBLpwYHmVfWavXMn3qP2Y5atk7c6/+Lvo1
         4cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SjCuQeyQ6Hzw1AK01uj1uFqXVNQNd7DfQ+Rw9QN0am4=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=PNk36TwBph02IRjtP601JPT26TkO5NYq8qQ1HgfU6TF05BaKSWudNUyM4BMRktmZwL
         ojvRolizZqnz3pIRkD9VwCcjnFPGwXxoLZ/jbmG6dt4VP+sIqDgZQzd5YBZKsqsQdtEl
         r9xlz6v56cNHj0PsYG1hfogEJZXplF3NhR5d3G2g9prYldlEGTLtEq6H3Q91XUq6C5mX
         BO5Ex0V/yxIkrYbuAt2FrAkVO07bz6/+zXPmFVN31mf370PofADoCDb4bnSavwUvm9DD
         zWdeBTDKRP8mFwmeZ5jNBUQCj5vMQom4upk9Skj4JmJeWnNjgpyvwWuVNsGpfpQyCAWr
         C5cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854713; x=1793459513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SjCuQeyQ6Hzw1AK01uj1uFqXVNQNd7DfQ+Rw9QN0am4=;
        b=cr62G5X27cferSpZtAVGXw6t30P5ZAWmy7rFYPYeUpfxVtgwDc+FkaHomEvtOd66Gz
         xf38IYONI8WhrlFYNRZo6sgH1Y1qmqcPXILQIPOYRiuOJ7bhmUnZUCOI3kQbod+VM/kk
         BfaYbOOegneswt9CfRGV7QY9poUjONbpkcIZ8BYbbUQQQvdc+2vkJmyS51mJY631Z/9T
         YhN0rPZXy1Lp26gNaiguRxtZMSP4KWWreEH/BM0ZEwzt96NeMGQOtNNKPJcI1Lk+alxH
         TwoFAzyllzX9dk0HTKWbtRT+TycL4e/UCLeSJIb9lHkpTEb9YVql3k6MYGw+qMkasU0p
         S08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854713; x=1793459513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjCuQeyQ6Hzw1AK01uj1uFqXVNQNd7DfQ+Rw9QN0am4=;
        b=FPPNyJxNVDB/ENpAky9vIcNJYk4V1qAWGiRjpXB/LxWpALYPd18yoeEe0V1TrxPkEN
         xO5pTBrWyjql0qG6wTUmlvFM/aiXM8Nw4ekisQFVK3uBBnEcRrs7mh4m5xeTsnNVlLkq
         +RxbNbZ5Php9rNWL5bgjkHME7lymZ3kwKp7U9oCXZr3Ew8bQdHMkhb57gVZju31uICMz
         76wD4HwRWDA5DguCsGMZbLGO+eocK8Bp/hhaA9r1I38O44sQzo+O3cgLbgYL1w3u7qFJ
         yproX4WocKYBouHP78YDTZYeR0XELAmnQJbIwjlpT8plP+iPDQS4A4S4aXsI3uEVGyu4
         rbYQ==
X-Gm-Message-State: AFq9FYJ71GbH3aDSXoqSniwjdDRR6aG2PNdbId0OS375frhFPsRsQ85d
	0HOkGlxmdNUjRUw2M0BXzohL+E9Q3jRGN1237HJH5q/YNH+3jTSIZdpXzZueARlRNhP91VR/Agd
	MbyoI+Je/4WOGcgHz2R7q7+nAiUh2UMQ=
X-Gm-Gg: AYBFou1JtblLlaaWSfBO4A7HmoJtl7VBzMds3YhdwbhlbQ4HcWHecrd5yT8SvOwPacW
	A+vIKo94tnGn+6OJDsC5/lwwcawEOJfRByGDjJo4xM2iQ/EIe8KcdmhkETtIvw+YGdaNvDQ/tUe
	6JQFpFle/JD0BN7eHG04XX+L76CNYOBF9tTpuLbjNSW4ART5REmhVkXEKlGoq08gv4JRW1twfcw
	Wf7fcRp/56jVZ+Qpmfm/Oig9GgfDraV0EjathEPK51xBzqI2WLQMBrjM0/ymUjd7tPcNiPixfhi
	xIaTw3nj0AsOxpIuR/mn7NboZQAfQQNkpYfjHhiLvP7GuJmkMP8ri7ueOLbXBbok5lXJJ2DdfjC
	ht4wYt2dJUegVMpX0zXd9XXE0e8JhLQbXh1Pr44W+NikRkGKVS2GnY+ZtA2yomIKcqsqncnjZmX
	TZkiA86K0Mhdcqw9oQFaFPmINuGUpYEXa5l2Q3qGG6g1XxoapOHoHc
X-Received: by 2002:a05:6300:398:b0:3e2:7643:30b2 with SMTP id
 adf61e73a8af0-3e7af800643mr1780064637.3.1792854713187; Sat, 24 Oct 2026
 08:11:53 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <80028d4f8638f766a73b84a5631d21101a413490.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <80028d4f8638f766a73b84a5631d21101a413490.1792503778.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:11:41 -0400
X-Gm-Features: AclHuK9HxUi2u_d2sO1cUfbDbnMO7stR2tfm14ADUWaK4P00fUslpzTlxFiPaNM
Message-ID: <CALnO6CAqhj91e6f=4_1fQRKDdkFx8t8RMyj-60Lt7a6vBV4uMw@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] remote: add "git remote add --limited-fetch"
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:43=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A remote added the ordinary way tracks every branch it has, via a
> wildcard remote.<name>.fetch refspec. That is wasteful for a remote
> whose history is only worth following for the branches actually in
> use locally, and it can make "git fetch" negotiate history for
> branches nobody asked for.
>
> Give "git remote add" a --limited-fetch option that sets up
> remote.<name>.refmap instead of remote.<name>.fetch, so that
> "git fetch <name>" only fetches the branches already tracked, as
> described in the previous commit. It is rejected together with
> -t/--track or --mirror, since those already say explicitly what to
> fetch.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

> diff --git a/builtin/remote.c b/builtin/remote.c
> index fb7e5b114f..a7c13946d1 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -179,6 +179,7 @@ static int add(int argc, const char **argv, const cha=
r *prefix,
>  {
>         int fetch =3D 0, fetch_tags =3D TAGS_DEFAULT;
>         unsigned mirror =3D MIRROR_NONE;
> +       int limited_fetch =3D -1; /* unspecified */
>         struct string_list track =3D STRING_LIST_INIT_NODUP;
>         const char *master =3D NULL;
>         struct remote *remote;
> @@ -198,6 +199,8 @@ static int add(int argc, const char **argv, const cha=
r *prefix,
>                 OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
>                         N_("set up remote as a mirror to push to or fetch=
 from"),
>                         PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirr=
or_opt),
> +               OPT_BOOL(0, "limited-fetch", &limited_fetch,
> +                       N_("fetch only the branches we build on, instead =
of every branch")),
>                 OPT_END()
>         };
>
> @@ -211,6 +214,10 @@ static int add(int argc, const char **argv, const ch=
ar *prefix,
>                 die(_("specifying a master branch makes no sense with --m=
irror"));
>         if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
>                 die(_("specifying branches to track makes sense only with=
 fetch mirrors"));
> +       if (limited_fetch =3D=3D 1 && track.nr)
> +               die(_("--limited-fetch does not make sense with -t/--trac=
k"));
> +       if (limited_fetch =3D=3D 1 && mirror)
> +               die(_("--limited-fetch does not make sense with --mirror"=
));

We need "=3D=3D 1" because default to "-1" for unspecified, which is a bit
atypical of boolean flags unless we need to know about that case.

Reading ahead, 5/5 wants to know if limited-fetch was unspecified so
we can act on it. Ok.

>
>         name =3D argv[0];
>         url =3D argv[1];
> @@ -230,13 +237,22 @@ static int add(int argc, const char **argv, const c=
har *prefix,
>         repo_config_set(the_repository, buf.buf, url);
>
>         if (!mirror || mirror & MIRROR_FETCH) {
> +               int use_limited_fetch =3D mirror =3D=3D MIRROR_NONE && tr=
ack.nr =3D=3D 0 &&
> +                       limited_fetch =3D=3D 1;
> +

:\ I don't have a better suggestion for formatting this line, but it's=E2=
=80=A6 odd.

>                 strbuf_reset(&buf);
> -               strbuf_addf(&buf, "remote.%s.fetch", name);
> -               if (track.nr =3D=3D 0)
> -                       string_list_append(&track, "*");
> -               for (size_t i =3D 0; i < track.nr; i++) {
> -                       add_branch(buf.buf, track.items[i].string,
> -                                  name, mirror, &buf2);
> +               if (use_limited_fetch) {
> +                       strbuf_addf(&buf, "remote.%s.refmap", name);
> +                       strbuf_reset(&buf2);
> +                       strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s=
/*", name);
> +                       repo_config_set(the_repository, buf.buf, buf2.buf=
);
> +               } else {
> +                       strbuf_addf(&buf, "remote.%s.fetch", name);
> +                       if (track.nr =3D=3D 0)
> +                               string_list_append(&track, "*");
> +                       for (size_t i =3D 0; i < track.nr; i++)
> +                               add_branch(buf.buf, track.items[i].string=
,
> +                                          name, mirror, &buf2);
>                 }
>         }
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 5fbfcb0848..0168d5abfe 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -137,6 +137,22 @@ test_expect_success 'filters are listed by git remot=
e -v only' '
>         test_grep ! "\[blob:none\]" out
>  '
>
> +test_expect_success '--limited-fetch works in a full repository too' '
> +       test_when_finished "rm -rf full-add" &&
> +       git clone --no-local one full-add &&
> +       (
> +               cd full-add &&
> +               git remote add --limited-fetch upstream ../two &&
> +               test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
> +                       remote.upstream.refmap &&
> +               test_must_fail git config get remote.upstream.fetch
> +       )
> +'
> +
> +test_expect_success '--limited-fetch conflicts with -t' '
> +       test_must_fail git remote add --limited-fetch -t main upstream ..=
/two
> +'
> +
>  test_expect_success 'check remote-tracking' '
>         (
>                 cd test &&
> --
> gitgitgadget

Looks reasonable.

--=20
D. Ben Knoble
