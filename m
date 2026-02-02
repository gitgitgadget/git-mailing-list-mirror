Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493722DFA4
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064281; cv=pass; b=afx8c9Pzq+Z0bYZXU8VyUDwxOI5N2JZ9yL+1njm4DCBJn9jeoy6fKaHYbHQ/9zDlvqGzu8VO8GIBE96QjAONvOf6tdsGnQYZR4VAo99aBQJqAhiDFJD7OXypyEOB8HIg7efr8juzIK4zYS1VZ1BDJL6iHg6LrkfUBAd1pwcvjbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064281; c=relaxed/simple;
	bh=9j5wc5j7MOXW0+myGYQR/5QM3q6D3doIjcncRIRje3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srutPkQllWvZXMz8y8WQdnR6Sh7LdNwJMSWo0iH2Mwe1sRsRhguls/7ZR2xF1+RfOae/Uxd7dP3HxL73NRJKhEwcLV9nlhwfyeV+FJd9OaDM0+WWNE+crDASsz52jcxzIqxk5zT3Z3Iug5V4GZydWfPFIlxsCvHWPM9fJb3VTsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr2b/lZU; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr2b/lZU"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-663064bcb53so1873407eaf.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 12:31:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064278; cv=none;
        d=google.com; s=arc-20240605;
        b=iL2/kwvqhUaPc/lYHquXwHuuvQx8nqPHZs+2hGfQrcCMFTHKU2SbJ+hgBRVKbjMQb7
         3VKop/1SC4NNdwpzzUECcFpyM9T7tkrf32rtMefhKDFl14pYmEQ/tjwcjfsVenej1GQE
         tM7UJXfViaOUcuMjBfjHDe3/fbrkB+i0+dVn9UoVN0Sxw7HY05SweeM+7SHMyJVWUzgs
         6RVoieNG6pQkOpuvaLN+EO5pEE9uULQ2zjILjcu0JNKz7wcaEkL2uDWiwxDd+ihXNQZe
         yLze8GP1Xrh/Bt4cT1ot904/loEU4EnCUb7QJ3gPUsMRrrBeJircv3Rxxs+o0GfpRubZ
         RIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Pq4RwSGZdkPQaO4qofFxKlhilgKdDrDtlLK6VOmv6I=;
        fh=kud2QCBUESDoweLTDYivbcmQeKnY5vck4e/wP7UKJcI=;
        b=jRU40NSjFrvjyfvvKpXwzcfN6UhXoE7gEaZrVgOIYstSiINMum0qZ0kmoeQvPwH7Dd
         LtEtXfrwAP6t11OzPk+FxeQXBcJSWLbn+CjzVvw4OWujaYFyPV7b2JnVcv9crIbNWYoT
         Evn+06KOM3JYx61X1WyjV9luRAIOZky6hFPY6CqyC5j/D6u0BNcqdVSDnI7A9N2GU5Sc
         456YshP9/KqT1jf7joOolQCydb/8xaHllFXLUz0zT5NdwcSGJGvct5bAfatDjB62D0hJ
         4Z8V9hjgaxJolp7IwyFrynKVPCgqdoFpHasl3qydgB9vMgOeIGABi+kqsx1oWCjgLqFn
         JUbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064278; x=1770669078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pq4RwSGZdkPQaO4qofFxKlhilgKdDrDtlLK6VOmv6I=;
        b=Cr2b/lZUlocq4SdPPMtRyhLeW0xwH5hbJwvieU2GTlh/M2YK68H71fKiaR/edSzhIB
         4Fp0jPSfRdWaibkYiJu3rzpoN2rjGEZo3LtYLB/u+KIenI+s/EGu6Xo/agdu1TV9yJ6q
         +qoyCf1b4g8kDqO/nKeEH/gh7aI3UMvVA4m4Y5ICNLLsR/qEgZaLs2DDPrkfzWQBjECp
         gSadopUKfbFKQ3M2Nm9afPOb49OFgO6HbZWp4n9atWju3tXPu2ZQgBPL3/YlI3XExMtg
         GxiWv6eCLWxtbpUlLib2EeIYcX8xbHGw7ma94rU+YvEoLA1c787r58IVtYD1XJFrylru
         ICEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064278; x=1770669078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Pq4RwSGZdkPQaO4qofFxKlhilgKdDrDtlLK6VOmv6I=;
        b=nPrlCBVo2hE7LvP6jpbYziw4AlHSlfyjvNUi92JWtDhozC/7iv7i3SiS1O0V4oYQoz
         qkcaO4Lr8ZXg/NV08EVFg7HwX6CjnhnO869BM+eMFte/7+eS8UNNtW53HaoXcz7CjZB0
         0ILZ3K+5cD7Q7RGYo/g+2wPahCJ7GuDv4zgBfAtuh7xfScGvd9AvGSq8ubhlgEdLzN5k
         hdjP2nygzqo9OETa7fFk5DNZ3JK9+6Cxwr74Pj9Ow9v6YLn1I/S4gFPBO/fNWoTdgPFE
         xmeB2pBcvpI3+yhhPZoQVyhF5xNkdvMpLL/HkEOoxyICvKtyO/A1cP/KWW44qu5a5595
         fcew==
X-Gm-Message-State: AOJu0YzPjZVRsTmArc7XDwU0xCz4vcC37R5Vz93j0rFgnnoe0Jpzmsit
	QrpPJdhWcd9HIgwCH1rny4XIdt8cYXopR6o6kLdjtk2pX8yceOXD8c2bKQqIEYQIEu1AGDXYzZs
	6pk+KgTo/BfB9Ic9RFGZHsDxsTnH96h0=
X-Gm-Gg: AZuq6aLKVPMuVRcFcp98RHN3VbD6XyLRB7kn/QAdrktRENWkkQWQBUKzcHoKKIYvzBh
	al2E9fPZceTlnxj2f6vYVcBplWXnDzy4b4QEPtnI5IB7jH6OE1zKUOONW5syMUOyjhn5ImXPwzc
	Fpn0ycyg9+LdnBDVRBWfAc7HJZlpFv8zEynmX8e61UXyGADfYsy5UEXSZp8gHxgGozloU0o2vb+
	+RCOa2R7el03ApGbAQCPjyw56zsVWFckkX4YnUEvlbnuVzf1b10DzK0iTWReynkpBUjapvxcmGb
	P8m1N0Ll1tLBd5TO/oVLUrM+Asn2Okpup5N6C8M=
X-Received: by 2002:a05:6820:2288:b0:662:f543:5d3f with SMTP id
 006d021491bc7-6630f5166efmr5255902eaf.79.1770064278370; Mon, 02 Feb 2026
 12:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com> <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
In-Reply-To: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 2 Feb 2026 12:31:07 -0800
X-Gm-Features: AZwV_Qhb9HbEARkshBldLHadgcVSdmKlp0M2zE1BtjLmvTa3_5ohi50CXMBKEVI
Message-ID: <CABPp-BEZkhYW+fWgtGn8yHuLfak+UYo9A_HwdiCkAf5A0H6hBA@mail.gmail.com>
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, 
	karthiknayak@gmail.com, ps@pks.im, kh@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 8:37=E2=80=AFAM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
> is given by downgrading INCLUDE_ALL_FILES to include-untracked.
>
> This fixes ignored files being incorrectly removed despite
> --no-overwrite-ignore, and removes the stash FIXME by plumbing
> overwrite_ignore into unpack_trees().
>
> Add regression tests covering both overwrite and no-overwrite cases.
>
> Changes since v1:
> - Use OPT_BOOL correctly for overwrite-ignore.
> - Fix stash -a cleanup when --no-overwrite-ignore is given by downgrading
>   INCLUDE_ALL_FILES to include-untracked.
> - Add regression test for --overwrite-ignore.
> - Adjust no-overwrite-ignore test to explicitly use -a.
> - Add Signed-off-by.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  builtin/stash.c                    | 14 ++++++++------
>  t/t3905-stash-include-untracked.sh | 16 ++++++++++++++--
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 82d10520fe..c3ee33cce1 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1858,9 +1858,7 @@ static int push_stash(int argc, const char **argv, =
const char *prefix,
>                 OPT_SET_INT('a', "all", &include_untracked,
>                             N_("include ignore files"), 2),
>                 OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> -                       N_("update ignored files (default)")),
> -               OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> -                       N_("do not update ignored files")),

What's the basis for this patch?  I don't see any "overwrite-ignore"
anywhere in builtin/stash.c .

> +                        N_("update ignored files")),
>                 OPT_STRING('m', "message", &stash_msg, N_("message"),
>                            N_("stash message")),
>                 OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
> @@ -1894,6 +1892,9 @@ static int push_stash(int argc, const char **argv, =
const char *prefix,
>         parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORI=
GIN,
>                        prefix, argv);
>
> +       if (!overwrite_ignore && include_untracked =3D=3D INCLUDE_ALL_FIL=
ES)
> +               include_untracked =3D 1;

This suggests that --all and --no-overwrite-ignore are incompatible,
yes?  Shouldn't they be reported as such rather than having one
silently override the other?

> +
>         if (pathspec_from_file) {
>                 if (patch_mode)
>                         die(_("options '%s' and '%s' cannot be used toget=
her"), "--pathspec-from-file", "--patch");
> @@ -1965,9 +1966,7 @@ static int save_stash(int argc, const char **argv, =
const char *prefix,
>                 OPT_SET_INT('a', "all", &include_untracked,
>                             N_("include ignore files"), 2),
>                 OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> -                               N_("update ignored files (default)")),
> -               OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> -                               N_("do not update ignored files")),
> +                        N_("update ignored files")),
>                 OPT_STRING('m', "message", &stash_msg, "message",
>                            N_("stash message")),
>                 OPT_END()
> @@ -1994,6 +1993,9 @@ static int save_stash(int argc, const char **argv, =
const char *prefix,
>                         die(_("the option '%s' requires '%s'"), "--inter-=
hunk-context", "--patch");
>         }
>
> +       if (!overwrite_ignore && include_untracked =3D=3D INCLUDE_ALL_FIL=
ES)
> +               include_untracked =3D 1;
> +

Same comments as above.

Also, the commit message claims you are removing a FIXME comment, but
no such removal is found in this patch.  Is this simply a patch
against v1?  If so, don't do that; please send a corrected patch

I took a look at v1 as well, and I'll note here that if that FIXME was
the only line that needed fixing, I would have just fixed it at the
time.  I left the FIXME there because I knew it was *one* of the
places that would need fixing and didn't have the time or energy
(already being a few levels deep in the rabbit hole) to track down all
the stash related issues in this area.  Perhaps the other sites have
since been fixed by someone else, but if so, that should really be
documented in the commit message.  I'd personally be pretty surprised
if the other locations have been fixed; see
https://lore.kernel.org/git/CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKx=
JDXQ@mail.gmail.com/
and perhaps the references to stash in
https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.=
com/
; there may also be other issues within stash, those were just the
ones I was aware of that looked fishy at the time.

>         ret =3D do_push_stash(&ps, stash_msg, quiet, keep_index,
>                             patch_mode, &add_p_opt, include_untracked,
>                             only_staged);
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-u=
ntracked.sh
> index 9c5421cd76..a979831a64 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -427,17 +427,29 @@ test_expect_success 'stash -u ignores sub-repositor=
y' '
>         git stash -u
>  '
>
> -test_expect_success 'stash push --no-overwrite-ignore preserves ignored =
files' '
> +test_expect_success 'stash push -a --no-overwrite-ignore preserves ignor=
ed files' '
>         echo ignored.txt >>.gitignore &&
>         echo before >ignored.txt &&
>         git add .gitignore &&
>         git commit -m "add ignore" &&
>
>         echo after >ignored.txt &&
> -       git stash push --no-overwrite-ignore &&
> +       git stash push -a --no-overwrite-ignore &&

Isn't this a non-sensical combination of command line options?
--no-overwrite-ignore is explicitly setting include_untracked to 1
while --all sets include_untracked to 2, and I believe those are the
_only_ things each of those flags do, which means these ought to be
incompatible flags.

>
>         test_path_is_file ignored.txt &&
>         grep after ignored.txt
>  '
>
> +test_expect_success 'stash push -a --overwrite-ignore overwrites ignored=
 files' '
> +       echo ignored.txt >>.gitignore &&
> +       echo before >ignored.txt &&
> +       git add .gitignore &&
> +       git commit -m "add ignore" &&
> +
> +       echo after >ignored.txt &&
> +       git stash push -a --overwrite-ignore &&
> +
> +       ! grep after ignored.txt
> +'
> +
>  test_done
> --
> 2.43.0
