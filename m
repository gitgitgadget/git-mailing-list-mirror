Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B99149C41
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823325; cv=none; b=DexzEeMV36ADh32c5vpMiFGsp0rt5wCOpaS38LUzoTfvtFkctymJr4TXqBM4gsMZItjmMOy838YeuheQFnnL0R3btKIsb5DXb70gnofJ/B33j6lYaLfBlqSyd01/7rMQLV9wQaMk72KiaTObDC6FD991RpKMcTCZbPbUGXBOUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823325; c=relaxed/simple;
	bh=9hBjzKJFgSoiiOkiGUeZPBln30HSmRV2CLsgVTEAWbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq8XtEOGzb/2cG/S2qF2EqZiAg2ht1nxPSvKd4mIn932L4hQeiszQu1cTNrk+8BPB0ktmXFGzqrUrglXHR9d7DDSvExuM0ljoniNTbUL5/8PnlcyGwA7Gk3U1MTnhaEcBxowahRgpSXdrj6V4c8PObckDJlbBTZ2DkNH5S5Oht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjyI+U8w; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjyI+U8w"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso16191995ab.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739823323; x=1740428123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hmnx2slLr08KukDROwx0vcWLMd0BwRmj5tFAqP7uKY=;
        b=ZjyI+U8wdRHivSrWFIatfceT4Hts5ISbdY+Tvkmdw+tNMcTk+XK5VB4saNhVoE9N39
         98VMHVob33LQhZWEwbhAgLJtJDvhTOTN8sUKt1HPotIajG6qMXzzEJgQGYbGHjuCeAWW
         uP3Ac1cCVBUJJob9bL2Tf3qizs7yLCyGMbO+M+pmu1ha3rWht0SpcmINXetxTp5Dq1Lz
         tLtSUxqt+gnJdex+TzQmnkQqXtXqVs36/68pv1ur3wU4B/U5Q83xfFe/fsoikhzbtvZj
         Hk6WhBF4B+gMa5n73+ERgP1jpMX110ffZr8q8o2dbI3zPVQUBNJHJy96Az2ZKPvDo0tf
         5J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739823323; x=1740428123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hmnx2slLr08KukDROwx0vcWLMd0BwRmj5tFAqP7uKY=;
        b=Fu3AC8pTpcieA1XLIH4AsHglhPlSc16cF6PWvpZ4QAx6+TSl0QdWsfHh2ugQ57ZbX3
         0MwKax1wNPV3Fby6EZQpIGkiJHrl+hfxZsZNhYnh/qlwHh1X0xs3W/8NHqcdkrjT7AtZ
         KzeMpCF99Pnp4fic3dRjwuSwWLe7fca93wAO4H01JNMI0FygIWOa1lZse2fT/IIBYQUe
         61kzowHlDCr2VR743yFAQJnvRuZgDzsI1JlYl+C89bVL0qvd2B6WeMTRi/Qx6SmJqDeU
         PUGG6ov3scZQwTj5X99h+WAZQvrsawvE0bIQ/hKs3K6qF7eLhrw7YploWDfahruD/0MQ
         ejHA==
X-Gm-Message-State: AOJu0Yw1jaVjRq+4waF26H9nLfKsZNDE3NKgf9/BQ8H3NN87wGoiLpp8
	5RlRFX3IjN+tfzVWmD4BbmgYLohbL5J6nVVAYUPq8GJWVi4VuZV/67eri2rxWi/lc4nCxrtausN
	t4nQeNEOB2y0zY6jVhaM/PfPXi4L3cxh3
X-Gm-Gg: ASbGncu413feCIYrGbt63BTr/NHhJpD/+ZSdLjGOnLi6vRcLxL6broHBTYgzwYvPdTg
	+0CEwtfhbtNma3e4/oErZPu6dv1waijqHvUH1kc2zGO+Uahu2mq4RevWbvIGvb9hpzTwPr4ALpl
	Yxh0XtgsFIKoEtddpe8y+Oqgu+BRDlMQ==
X-Google-Smtp-Source: AGHT+IHKDlpjl+TZ1y8ASLAonr0ReWXJRtHoYSgaruyzBrNLh6FBeYFpNiU8D810kEaZVAErlurqA9bIpAFIm4o2Zoo=
X-Received: by 2002:a05:6e02:138c:b0:3d1:9ca3:cf95 with SMTP id
 e9e14a558f8ab-3d2796851f5mr71441305ab.0.1739823323014; Mon, 17 Feb 2025
 12:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com> <16fec87766f97d46a337f5c514f1aec0668546ec.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <16fec87766f97d46a337f5c514f1aec0668546ec.1739723830.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 12:15:12 -0800
X-Gm-Features: AWEUYZnn7XhIx2pP1J-U9R2J36ZqGTel4hXdVRrg2zgMvgdSwkvAF9ld_OR1k0s
Message-ID: <CABPp-BGTSciJMRWBGe9qOFh5wGuLppB6L+v9J5-KVdbNc6H3Hw@mail.gmail.com>
Subject: Re: [PATCH 2/5] merge-tree: remove redundant code
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:37=E2=80=AFAM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> real_merge() only ever returns "0" or "1" as it dies if the merge status
> is less than zero. Therefore the check for "result < 0" is redundant and
> the result variable is not needed.

Indeed, the only return statement in real_merge(), occurring on the
last line of the function, is even:
    return !result.clean; /* result.clean < 0 handled above */

However, it might be worth adding to the commit message some comments
about o->use_stdin here.  When o->use_stdin is true, that the program
exit status is 0 for both successful merges and conflicts but the
conflict status for each individual commit is printed as part of the
output.  As such, the return status isn't used in those cases and
real_merge() might as well be a void function.  However, when
o->use_stdin is false, the exit status from real_merge is used, which
is why that callsite (not visibile in this patch since it is
unmodified) still pays attention to real_merge()'s return status.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/merge-tree.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 57f4340faba..3c73482f2b0 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -601,7 +601,6 @@ int cmd_merge_tree(int argc,
>                 line_termination =3D '\0';
>                 while (strbuf_getline_lf(&buf, stdin) !=3D EOF) {
>                         struct strbuf **split;
> -                       int result;
>                         const char *input_merge_base =3D NULL;
>
>                         split =3D strbuf_split(&buf, ' ');
> @@ -618,16 +617,14 @@ int cmd_merge_tree(int argc,
>                         if (input_merge_base && split[2] && split[3] && !=
split[4]) {
>                                 strbuf_rtrim(split[2]);
>                                 strbuf_rtrim(split[3]);
> -                               result =3D real_merge(&o, input_merge_bas=
e, split[2]->buf, split[3]->buf, prefix);
> +                               real_merge(&o, input_merge_base, split[2]=
->buf, split[3]->buf, prefix);
>                         } else if (!input_merge_base && !split[2]) {
> -                               result =3D real_merge(&o, NULL, split[0]-=
>buf, split[1]->buf, prefix);
> +                               real_merge(&o, NULL, split[0]->buf, split=
[1]->buf, prefix);
>                         } else {
>                                 die(_("malformed input line: '%s'."), buf=
.buf);
>                         }
>                         maybe_flush_or_die(stdout, "stdout");
>
> -                       if (result < 0)
> -                               die(_("merging cannot continue; got uncle=
an result of %d"), result);
>                         strbuf_list_free(split);
>                 }
>                 strbuf_release(&buf);
> --
> gitgitgadget

Looks good.
