Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854798;
	b=KYVh5zo4cPk2mpYYHGKkpPWyDLIPbL7xbhrDyF6jrNbMfHBWeUzlQiX318g7Nlh8Dic/
	 vOaNUHsSXSJ2unTBvUYguqiWILczk/dIxqImM4ZxQXtK351CfIebJXHB7YGdwd9+cuZwK
	 6rahDZPplbLMv6dhtYt3A4EG0rYn6y0IfrinyGlm79YUGBxjrBwOA09ToOzMgIkPN6RGu
	 czOsX4zRxwfQEhNGxC46MuaUOnLd0a4vSzxkdka+xPwRNHfRIHb82vNYp5TgMoAQAhBcu
	 sL8scG81sn2811LVWeTtq0diJOd/kKGAC99LYmy11Bwxtx/+kc2F9ulJRr/vyrAvYIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GODKNYKeVTg51YRTBq4tQ9XudwHElJh2UaOZ9MxIrjY=;
	b=QOV8aFfbgc9l1/1R0iq+M426QNxM8N0s44k/ulcJXpcZBy69dRG6CM3aYxogngDomub0
	 ZfSDIxgIw+M99S56cUXttlhMyqlJfbkIg5SctVc8kVLIkNkOm8IDoPdakS0qkriaBz2UD
	 LtpqAEYnneqKNsU795tw5pLM4Ww29M+18aSTTX6b+HLjd8b61WGC4nYGSbMQC2Xc5zyPB
	 UjpQ5/DF5qqkznE5Ya4HgKZhK/SMXoGcs3EsTNfc0nQ4mf5kV5S5VTnYdO18QiPjWcHyu
	 O90svnNFZ4KerBmgINlIERKOMoaNQ9tMGg3hh+tA5udRmSCi6teoPrO/JcELUzpTHMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gseB5S79;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F2606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 555F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gseB5S79
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9d1114320so13024855ad.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854798; cv=none;
        d=google.com; s=arc-20260327;
        b=LWo/Htua6ubsn4puTnV/v26XtJ7mRdwzAMnO3t+Su3rz6t/bwQsx0Vnslnny7Azfsu
         VFgk3UjFJ3Zd9cE/H0Th1VICeFIlKgI0/Ih8eXGFT8nQGWowpLQ2Khx/qnfiEsOb0X6h
         xo+xlMkaaHaHgJ9E0QJFvyAcW5WmG+c0wJmHJVExYq7g8OhFqRpujTJfO8OF4RQOChLL
         ac5AKhgC8An/BGUGmxAAWD2hgGUspg0UGDrt1FfwtZ6mzh6oZXFN6NmNgp0nHuCFMqTo
         1dSvMVqeZlg8SevDZo6PJLQ8/9KFZ6Bf3Nk0Wf9Wh0RmXPVTKkYyEwB6U+2sWuKQ97pm
         cnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GODKNYKeVTg51YRTBq4tQ9XudwHElJh2UaOZ9MxIrjY=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=LNa6wDniwAGOG/ZmM/T2nL4rv9ZYcQga0aJB0/5aUnCLSRcNl0hubaEzlW7VXFppbN
         qnQEvdru6UXlI3nfDPsT95tDl+ZazP1CV+Qq05QHcuUD5iuBUwLXzt4KiayVO+Zbq6HB
         rHNcLWt2Do4Thdtyrv/Hu4xBDk2VqQe9sA+2/y/eSpWYyjp6dDw+r4w+Gzp8Cw+RlQRz
         V1zIQCxPJte3bY5iqdUanROcNCCBeGhSkqmNS55SlH8zPpgRLGW86e1EQWO6E3N7HJZ0
         A9ur3sLx+R5vayE5mXbAeLzqjuK0GJOU245iADGgh77ximRvPdmeaL5q3gMk3OFX+qZW
         AOPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854798; x=1793459598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GODKNYKeVTg51YRTBq4tQ9XudwHElJh2UaOZ9MxIrjY=;
        b=gseB5S79zDjSDuw8glEtgWwnZpjcJpkj/SB/MDLF6HrDOYLHstUbHlrMLa/LJncwuP
         LbbR7z0O2Pxqg8lARVQnO5lqmzKAcurwv9dmuijX5ZueQr0eGGB3biKoRZoF2PzkPfJq
         86wiXPvcZq2TlcovV2kht/DTobvOc1POdyfZqNHJJbv5HPpf6B3LUXtfQ38yE7fRgxOk
         Vio7igrozowwy41IBDNPt2FCNtZKo2VV/innj0JRH9aSr4gweYgewEM/HfMTbvwlB6y/
         n0G9Q4GcORU3gM+DggfgPrdZGvWxZSRo0FGxsRxh7712Ph6Rt5TuyG0fQktOFntPtRO2
         KB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854798; x=1793459598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GODKNYKeVTg51YRTBq4tQ9XudwHElJh2UaOZ9MxIrjY=;
        b=VcHCVh1jSKJxuYa3zRa3/bQkb5N+SQZ6SsuhYi0RhJc6EJpkH5Wr6NzL/uig0NuxvV
         E/f4v7bcQRm4cFJhJ3HGnIiOFr0v3QW1YgPmBky9VNPy5syPu8zL9F8oXVPYrcbMUEzS
         XMZmPVVOqdc6s2pgxbZRqHb1ANykpcwgMq9XK5sN40OxnshQXLdplvEyfgq8UKwVdZri
         PzHhXOu+utkuYggXfAo1hE1I6xqfO2KtylkGvEYISuS18kxzMDOyO77hbXeVPbrw/Mr7
         zab2Z8sODapdZKe7WyM6w3217knPHELfrEpGlH5ZIn+ndCAOUaxqJtT47iAeCQKiMY5n
         lhGg==
X-Gm-Message-State: AFq9FYK1hfmKxiM9kOG2QMriPocv6g4W5Gfm/EchUYfG7uC8pKPD9G14
	aXYxXb3oZYa/yCG3gj+9D461KH5UROM/F9lQuwYyQpeGu/OmXFPXgXvSMdcG2D4dtY2Omw5TXF0
	TXinA6XhSIXjp2nKc+dErNAhBpwkaewI=
X-Gm-Gg: AYBFou1hAq7lbfppRNFAgqzeeM3LN8AZ1mricPBx1gB4Pa784XOiAd/7lXOEkiyGH0k
	npfU+aoN6iJaCNNsgkOT+7D5U9I/trEfRDqt6zJWytnOHCZoLA/FyMF1C7H4UR6R+eVJaDXysnH
	YWkDc37nSN69eS2XVRoZB7/bXpmnybRm26bd+PiSz02b3SZSDpvXXfTW/kGdUWBc8l953KFKxS5
	9MZ3QUWN6i3VzwIt930EqmkJeGmwGlek24NzfNEWozrWKFnhSBTg57twDxyFw1e4cAVb8TayRZe
	uHE3CXvLZhVsjOzp2i7qHjG34Ej0fD2iK27UeUjCWQavlYXrfG2sRyfKUwb+E9ZlS/Gbsclrlsx
	DryfEfD+rrfvx7ZHa0ts4AK0lsjj8NQu4uD25lwc0ul3xYkD3Wcwp3sqa8RosWouJHzT1wYwlma
	AupeXbivpoyxHhIXyxSgl2QIXoVbEzssgdgISH71onSEBiWPRcRBBexg==
X-Received: by 2002:a17:903:3ba5:b0:2ea:33eb:7375 with SMTP id
 d9443c01a7336-2ea9c7fb26fmr19185765ad.45.1792854797581; Sat, 24 Oct 2026
 08:13:17 -0700 (PDT)
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
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <552bf08971be5204311c96bf232b5da49e852db1.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <552bf08971be5204311c96bf232b5da49e852db1.1792503778.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:13:05 -0400
X-Gm-Features: AclHuK82QY15fe4QmmeEifkwTboK8jPvSyNfRkhaOPqwkULWxRhs5bD8woXTxRE
Message-ID: <CALnO6CBA3oQMm--3VxhbUdDmXfAGjZo9H5bFxWOGUCY=GADk3w@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] remote: default to --limited-fetch in a shallow repository
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
> Adding a second remote to a shallow, single-branch clone used to
> still fetch every branch that remote has, since "git remote add"
> always set up a wildcard remote.<name>.fetch refspec regardless of
> how shallow the repository already was. That defeats the purpose of
> having cloned shallow and single-branch in the first place, and can
> make a plain "git fetch" on that remote hang or take a very long
> time on a repository with many branches.

First we focus on "single-branch shallow clones", but=E2=80=A6

> Turn --limited-fetch on by default when the repository is already
> shallow and neither -t/--track nor --mirror was given, so that
> adding a remote there does not by itself commit to following every
> branch it has. --no-limited-fetch keeps the previous behavior for
> whoever wants it.

=E2=80=A6now we only care about shallow. I think that's reasonable, since w=
e
don't have a way to track "was cloned with a single-branch" (and it's
not really the key criterion anyway), but the wording begged the
question ;)

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/git-remote.adoc |  8 ++++-
>  builtin/remote.c              |  5 ++-
>  t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.ado=
c
> index f8764394e7..f43d707c91 100644
> --- a/Documentation/git-remote.adoc
> +++ b/Documentation/git-remote.adoc
> @@ -57,6 +57,11 @@ Add a remote named _<name>_ for the repository at
>  _<URL>_.  The command `git fetch <name>` can then be used to create and
>  update remote-tracking branches `<name>/<branch>`.
>  +
> +If the repository is already a shallow repository (see linkgit:git-clone=
[1]
> +`--depth`) and neither `-t`, `--mirror` nor `--no-limited-fetch` is give=
n,
> +`--limited-fetch` is turned on by default, so that `git fetch <name>` do=
es
> +not need to negotiate history for every branch the remote has.
> ++
>  With `-f` option, `git fetch <name>` is run immediately after
>  the remote information is set up.
>  +
> @@ -79,7 +84,8 @@ With `--limited-fetch` option, instead of a `remote.<na=
me>.fetch` refspec
>  that tracks all branches, `remote.<name>.refmap` is set up so that a
>  refspec-less `git fetch <name>` only fetches branches our local branches
>  are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
> -details.
> +details. `--no-limited-fetch` explicitly disables this, overriding the
> +shallow-repository default described above.
>  +
>  With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is =
set
>  up to point at remote's _<master>_ branch. See also the set-head command=
.
> diff --git a/builtin/remote.c b/builtin/remote.c
> index a7c13946d1..8c4497cccd 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -16,6 +16,7 @@
>  #include "rebase.h"
>  #include "refs.h"
>  #include "refspec.h"
> +#include "shallow.h"
>  #include "odb.h"
>  #include "strvec.h"
>  #include "commit-reach.h"
> @@ -238,7 +239,9 @@ static int add(int argc, const char **argv, const cha=
r *prefix,
>
>         if (!mirror || mirror & MIRROR_FETCH) {
>                 int use_limited_fetch =3D mirror =3D=3D MIRROR_NONE && tr=
ack.nr =3D=3D 0 &&
> -                       limited_fetch =3D=3D 1;
> +                       (limited_fetch =3D=3D 1 ||
> +                        (limited_fetch =3D=3D -1 &&
> +                         is_repository_shallow(the_repository)));
>
>                 strbuf_reset(&buf);
>                 if (use_limited_fetch) {

I didn't read the tests, but the code looks short and sweet ;)
