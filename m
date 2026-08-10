Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D3D9DA8
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366725; cv=pass; b=ND8Mffq73EgRkIcLWC/BCZV+uWVjt1Cf4kfvkNTgaz9X04Fd6MoprMI3J1iVWUT0ynJhe0crVZ58xRwrTdjGO0T7cVvCfPRhiwfjGaAzR0jGigVGCsVgi3N+vgShM7Bl6rUyqMFyqt0O4PyBad1p7GLdxEK5TBJ+FrwzHM2lKT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366725; c=relaxed/simple;
	bh=jntowxB0oFseYgo62v/j1ATVh0UUEKRFyotnbirQAVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inV8kTmTzN7zAOllMvI1nnlu3OTaPLeah51XtjyQQUIMTtiV6L8tgEtzGGRGc27+4DnjgNk2Z6+RZNXHxEc/uBiQa04ZtbGRR5IX0iFcqe6z1ILx0eXvtn+gWUD0Z5suIT56/4NMKtkal9/X0AepwUIm4oyJvh8xf7COkE1GXmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVyYHM8w; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVyYHM8w"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1899847b3a.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366723; cv=none;
        d=google.com; s=arc-20260327;
        b=jT6RHfVuL+chCGY5hWB8nAEd+NdOHmJdIrPpGAu95q6dMSotaEsonqSdMaS4pqr39F
         Yvd/rlkVKJuC7JmTUq9yp3oiXqXQ1FMA1M0mLPvvyZZFblaqPoMBe/mc7bHSwFFJRTtk
         pdmgHLIID4HjOMKPspeEeUgZpZhNbBce5XViXCeF5yrL6vhv0sVCcor4uuaiIjzu32M9
         Xb/u8k73vg6TyCHV/4zEbPYlx3bnCPWzP+5fUq0JMWBQWwwjMVATP5vLTz9sI/1GWoi1
         QeGsqIe4L8p53fou8lTyXZ411xVwKuiLohCSaRfKLrKBO1jaYsCMfo6tQ3xRCgxDcw0x
         KNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NanavU13UbatleB6oUtkEll/18su5IVNU1NrUe/bwEw=;
        fh=H6lokUr+VJOb8K/s4/XQEDUqD1mgPN6Wv/mJsHIkuwU=;
        b=lypUNNQbwVOBQTqEL+icqv+MyLM1tvTTcel18P+uRw2OhCdSvlgnz8ARYq443Lu0EW
         WmpSA8EHFikgu7aRZbUMp64nKPdMMy07ybzAJLGh1q6IlsRzGFC5oc3GaEI8bRLPF72M
         ukehD9/sNFqWdxjPPLbA2Wd6tLVjzn5kREznDuDjPYfU0H3wQXQ75ygqSC92fdbpFhq9
         v+KCvbSCfYuJL9wwGLJwCmiFLqMifDjycbGbtLkFMtTR7ldyKpjufZ7Yn3Ik1DKC/HSu
         JKFT8VXnwiSrUrWoJ1I5p3Lv1DSQOJAA1wlJI4AW6inaHoa6Yug98j4rgpWZPD3wx4Cb
         8dEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366723; x=1786971523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NanavU13UbatleB6oUtkEll/18su5IVNU1NrUe/bwEw=;
        b=ZVyYHM8wFCGusjAwNL317vmz8LN2SRm83nRFtCeaEfvSykJaJiH3p7eVC1NnTRvVMv
         kQWlK1lcJjUKjwIb1X6kjC2FXjI/0dBp0fsD54al4dK3U0mzbc1TBDPfXhqCVbG3Migl
         L5tH0kqSg/qWIrRDnjsi7adx0/7ns3U1yMKzw1wj4W39F0PpN3R8EILvsZcYECfa1FEB
         Ke6R06f6GK08rfBltyHXTjtlI6a7DxjEhkbQAqRA7gOG6oVFdExiclS+tfLPE8LGP1Km
         KLQN6DL6TrtcYw+DCUrZm1eU4Floj8Ung7LIF5VrbedYRiJRYpT30j9NLwJoW6kJGEg7
         WbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366723; x=1786971523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NanavU13UbatleB6oUtkEll/18su5IVNU1NrUe/bwEw=;
        b=GvobrdQScjDc57VL+GLcrWl8OQZcutGUFDEOyjYNs1sncqU1Br+ngcwbFfFGXt43ky
         r3tp28DIZyD0lGAEswQ1jtqgbIubwDZsL2ApkuzAG5MwO95CpY5USm/g7ZgwX0ctkDrn
         kVmqqXFWNJm75Dl+eiIGgox/bW2yZMvxN9aSgTtgEQpPOUp9gA9jSOfugMjdzYqG+JuW
         kuSiazBZA6qwKKE8dLgjQFqcZnu+2/mHTvqyPkzb6tTsy5tv5X9jOlSz1S9kWPTWbTOz
         IV7sOeX2FIVrjuSoeegWzXtMIHE0Ufpk9yChXQUdIRAXfxRLyBipGIhQQJwLfHlOmuMD
         NyvA==
X-Gm-Message-State: AOJu0YxU3ieDBghFvhWm0l+YMpBdsyUqNghDiykyYG5l7qsmh8e3+NuR
	ucUspRxFFZm8IR3cDG7FEz2ll7ROSzHri+8dJwpcP5SOmwN24VKOx3yZqwY3RaJnGrUa2LCB7zr
	hHvCQLmYb/PBuVLohllVtuxEeFyixgFA=
X-Gm-Gg: AR+sD13pn/PTGDqPa1eWG5EH4ckMW3Mc4CZ/UiPreKjGS1a7x1wkIA0WwE6zoLH6Qvd
	d5QYw3gbuHlxwF9Kl6smRU2FKLIHxAVeKuvbFv5AxsA+ouUU2I4+U7tI9Mjc5f8MbGqtMK8ARbz
	Kh4a+jUnsyPlUPxgz8FqlsEKxwtG6lDEAxu59/XRzkCXAMbv2LTveIzaKACJG9YqoefeJGkl28U
	GffwkWaTW4qLynYSjLIBEHRFt5IUnzDrp3bTLlXzZANgsYcPHO/XRaHjj8y4C42POXINeET9jiE
	YQjvvk1LVeLHvEqH7BPzvvzTNe1XoFonzSLD4UhPj8oQvYHGJv4znnGiIOAEzntiXPeGw+d3AQl
	PXg4XyTwVBc051iv7zLMHFSCVZrVoFGq90IQSMyHygQc0LV/QOtj7NWQMTEcHgxDCNypFbV9O7p
	bapFq00eKmrkkJJ+OKWpLq
X-Received: by 2002:a05:6a00:3026:b0:847:9ce5:d293 with SMTP id
 d2e1a72fcca58-84f2e03b823mr49484961b3a.24.1786366723078; Mon, 10 Aug 2026
 05:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org> <20260806-history_autocompletion-v2-4-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-4-7e60f52a1c20@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:58:32 -0400
X-Gm-Features: AUfX_my6K4dCKoM5kC8kSLH-cz6hqRoke6kysR5CjGQu9G6qgJ_2KIlTW9DW97c
Message-ID: <CALnO6CBThicX2x_acKoSvWMOkr4pa5bVMH=RNMXO+BjEAxKSHg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] completion: complete 'git history split' pathspecs
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:37=E2=80=AFPM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> Arguments following the required revision of "git history split" are
> pathspecs. Complete them from tracked paths, including after an explicit
> "--".
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changes in v2:
>
>   - New patch.
> ---
>  contrib/completion/git-completion.bash |  6 ++++++
>  t/t9902-completion.sh                  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 6f1ba96763..d313780d8b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2197,6 +2197,12 @@ _git_history ()
>                 __git_complete_refs
>                 return
>         fi
> +
> +       case "$subcommand" in
> +       split)
> +               __git_complete_index_file "--cached"
> +               ;;
> +       esac

In context, this seems late to me relative to other completion functions:

- complete subcommands
- special case a few options
- handle revisions
- split

vs., say, _git_notes, _git_reflog, etc. where the pattern is

    case "$subcommand,$cur" in

to dispatch on combinations. We could use "split,*)" to dispatch there.

OTOH! The split completion wants to benefit from the other things done
(like revision completion), and only then (before or after --)
delegate to pathspecs. So, I dunno: I think this location achieves
that goal, but it diverges somewhat from the way other completions are
written.

[snip]

--=20
D. Ben Knoble
