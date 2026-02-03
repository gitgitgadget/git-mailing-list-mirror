Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BC316193
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146591; cv=pass; b=gVSUcpAaR7BEgexG1RLhpelu6kWCvT8xOLHKk6aCe5WJA7Wb30ODWNDOAXge58ha5xXkCCmWgSqY6luQ+Bny45xQh4nN+4QoWoO5M97gqb/lvhZk66WD8FdCUBJDn+paVsdfH33TWCvRIkVSU/jqr1Pou5bppBuKqNRTv6/TrcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146591; c=relaxed/simple;
	bh=qHwW1jZ3rW/0FOMcRwnxmn6OphRSliMYTL5Tiz7TMm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLF32UVIOg4LoT+GkcAzqeUq9pcOzUd0WHWppgJtukTvom3wORwbxNrweCy8AIn3tX8yaNi7t5fnOWHqBnjv5hdLYxEWtl6lwDN9FmAJbfhbSeFcWfkuqdhsyDhfsFx/QLFZcTIpqrH5hERLoVUGK8gWvnR023QSm9I9wrawPo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPViSHck; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPViSHck"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40429b1d8baso2034908fac.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 11:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770146589; cv=none;
        d=google.com; s=arc-20240605;
        b=Tt1FRb9zuHhxB7NvYjCQ4ObtDvqFkMahCtfICEZoP4IwTKRoUTWwXVrBZocBxG6DjR
         vfeWqim6k4O1OkGHv4Tyn0x876F1Uky06LTFHo2KSZYpzVPYI6Vz4fPFnUx7GyXwyQCG
         s6ieIHg6gjGUZEYgRTu6ABgahsucEJWQOriTSg5JPMI/8M6NLymk7JawX8DpnlYdp2w1
         4af9W4kolL1icWg5S18HcwJv+jTqm8RkoFDontpEKOqsX+OUq+9hpu2gWGnbbEf7dNp1
         DmZv/auP1QtXOJd1J5DehPf9wIrDEULxtdlsv2RCqcX8BzT9ZvKg29O2+N3bnWT5VlOz
         0YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAuRGZSuH9VBo2xe2WgTsx3DC6HKHB6O776WIQRUCK4=;
        fh=epWJDPL5W/O17OQETcucKGZOPMkrHkOfUb6WPvdf4Ww=;
        b=iEv8zp/U0eziMXGmvd48qw8UW3oRLTbjIVEojmESdKSZBJ/uYE8kYxVW4rv0LwekXP
         ZGscmWaOEPC3B0hhoMayOKeSdLop9UGq9LqoKHpPGAzJFNe7leDTXGwhDAwzIQikrh6q
         PRp30dg6gnCPs2DDn8cREvkmPmSDY3gdcY9WERmCBykst4VEp5j/xlCkdkBoqh4nAt5E
         aYct6ccqgi6Ngg0bN3Ja1Wo4kS98zKp68v7bQXXyhyVni9i4Q8iAvd06xBi0E+Sg0IH9
         WJz1GSf4skk4FJT3gFYXfG2DQrLerTJ4GB8AV0UumVD6mPNC/LlCLmnCVP7YvO0WECi8
         BB+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770146589; x=1770751389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAuRGZSuH9VBo2xe2WgTsx3DC6HKHB6O776WIQRUCK4=;
        b=IPViSHckZtNYhAtwzqpYU2sXpWvbBhAKRFnz7iVZDImPtpfQV59bz67AjRCjLagKK9
         4RDe/mlLerNNwC7WWsa+6+yvkC92YCJHGfUBj6RsUAY3m3UA8iEmf7C0eot5amR4JjHU
         sJ9YSoX978vrF9e7Ww9ILT6TmwyaiFnZKyVj7oQsPJS6zg/FNPJ6vjfKs7OxzLiyE9tP
         IuiNp0srb5yb4oqqs3ZKmJLnqk03BpJNd6pPM/zXrfmN3tywK1HMyiZPNkKnK9IJ4ZzG
         b5x3nALWnklMEOHBBh52gQr5UcMRqyAxwGksSjl2Scz9PHCvGlHG112NgK+uBfiFGKrT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146589; x=1770751389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAuRGZSuH9VBo2xe2WgTsx3DC6HKHB6O776WIQRUCK4=;
        b=u2vOGXRu1K7aDqfbvoLkbJBJ9nuCVj8ioSgeNVWoG2h0Q94xqmh6uuXBZLAH34jdV4
         F6uTuj0KykxaLcOoJn4aSOCeDxYYEbkwz91QxjXEntFCOFF2DWCKmFywvVCpZYRgzBmu
         ChCu1JsHmXcg6s7MBLO6SSAZVe1703DUZnPxrLnRFqE47M7ya/mbpILkc/LTO4Up/lBQ
         sIXl96tdCu1iSEuvt9YhKUTv40Bt5fTSdU9Ox598RkKe0chz9H43K2FhS++MVYMAnYB/
         3dH0nTohPP1GpsdfR8zm7HGzVBXALk2NJITUGTaR2pR2MS2VnaIMTSJY7OfDe12jxzly
         Nwlg==
X-Gm-Message-State: AOJu0Yx5rmXhl9ooHCWF4ef+JWcln0pFD+Is4qX29160gkkkkeooAqGW
	i767P4m/6MOMZzgGWvXe6mUI3hBjJ1g3NJO91vd5qzgHxfpuptuBULWJWJoDVfZEzVVu1tUs6k2
	pYY05cPWn74u2rqLOsjxEHEjvBxbVppQ=
X-Gm-Gg: AZuq6aIaCgCDpLjoFC/8BStMOS+Lt05tAvrrlJlcdefUaylnBJtpNP0mQgFAEd9/hIN
	hoWEUabhe8y+mR5zJkUvbuhNArIYd3dpJPTSXVhCJrNuqSdcZLTBsTP3hcoSoAEAkym/stVUOjh
	18VaGoSElXS2+BPcnVEYc3ABF40c9uGhqn5w14A/4k+93aDUwFCOtdr1mQl4FjZM+uZs51nz5W+
	W2N9ImsVxd8V4x6uOPempSAAVJFIILMBVuBQHgY8WYWx+ZDlT4w+k53mae56zDO8zHP0FhWi/Ok
	LDLtg3tsth+3RpuyarevHFfwWYDQ
X-Received: by 2002:a05:6820:134a:b0:663:623:f2c3 with SMTP id
 006d021491bc7-66a22690922mr352208eaf.54.1770146588612; Tue, 03 Feb 2026
 11:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com> <20260203180359.602905-2-pushkarkumarsingh1970@gmail.com>
In-Reply-To: <20260203180359.602905-2-pushkarkumarsingh1970@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Feb 2026 11:22:57 -0800
X-Gm-Features: AZwV_QggWPVPn5YUN5tmVQtrifwWF9fiUHtHM-WPXUpBK5cRPDXHRp9Pd3EUtF4
Message-ID: <CABPp-BG6wM4p0wAizEppT7QdtY710xBJ8NwgfzrDpP3Oyg=a0w@mail.gmail.com>
Subject: Re: [PATCH v3] stash: honor --no-overwrite-ignore with --all
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthiknayak@gmail.com, kh@pks.im, 
	peff@peff.net, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 10:09=E2=80=AFAM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
> is given by downgrading INCLUDE_ALL_FILES to include-untracked.

This feels like you're regurgitating the patch with low-enough level
of details ("-a cleanup", INCLUDE_ALL_FILES, include-untracked) that
it'll only be intelligible to someone who has builtin/stash.c code
fresh on their mind.  It doesn't explain the high-level purpose behind
your patch, and, in fact, will likely lead readers to try to read the
patch in order to understand the commit message, when usually we hope
for the opposite.

> This fixes ignored files being incorrectly removed despite
> --no-overwrite-ignore.

This claim makes no sense; --no-overwrite-ignore doesn't exist in git
yet, and this is the first (and only) patch in your series, so at best
you're claiming to fix something you introduced?  Very confusing.

> Add regression tests covering both overwrite and no-overwrite cases.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
> Changes since v2:
> - Use test_grep instead of grep
> - Use test_path_is_missing for overwrite-ignore test
> - Rebase onto current master so patch applies cleanly

Great...but you still seem to be submitting a patch that is based on
your previous (rebased?) patches, without submitting the previous
patches, leaving us to guess how you got to your current state, as
noted below.  You should have been editing your previous patch and
then submitting the edited patch.  After v2, you should have squashed
and resent.

>  builtin/stash.c                    | 14 ++++++++------
>  t/t3905-stash-include-untracked.sh | 18 +++++++++++++++---
>  2 files changed, 23 insertions(+), 9 deletions(-)
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
> +                        N_("update ignored files")),

And here's where it's clear that this patch was broken in the same way
as v2: "no-overwrite-ignore" has never appeared in any version of
builtin/stash.c upstream (same with "overwrite-ignore"), so this patch
is clearly against some local state you have.  The base of your series
(or the base of your patch, since you only have one patch in this
series) needs to be an upstream commit, not some other commit that
only you have access to.  Might I interest you in using gitgitgadget,
which would make it easier to submit patches?

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
>
>         ret =3D do_push_stash(&ps, stash_msg, quiet, keep_index,
>                             patch_mode, &add_p_opt, include_untracked,
>                             only_staged);
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-u=
ntracked.sh
> index 9c5421cd76..63b59de47b 100755
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

Not only is the patch broken ("no-overwrite-ignore" has never appeared
in any version of git; so this patch is clearly against your local
state), but the command line makes no sense:
  -a : stash ignored files too
  --no-overwrite-ignore: wait, we don't want to mess with ignored
files, so nevermind, don't stash them

Why wouldn't the user just leave off "-a" if they don't want them stashed?

>         test_path_is_file ignored.txt &&
> -       grep after ignored.txt
> +       test_grep after ignored.txt
> +'
> +
> +test_expect_success 'stash push -a --overwrite-ignore overwrites ignored=
 files' '
> +       echo ignored.txt >>.gitignore &&
> +       echo before >ignored.txt &&
> +       git add .gitignore &&
> +       git commit -m "add ignore" &&
> +
> +       echo after >ignored.txt &&
> +       git stash push -a --overwrite-ignore &&

And this command line makes no sense either:
  -a: stash ignored files too
  --overwrite-ignore: yes, I'm explicitly giving you permission to pay
attention to the fact that I already passed you the "-a" parameter.
Please do what that other parameter says.

Why would the user need an extra flag instead of just using "-a"?

Additionally, if there is some user problem you're trying to solve
here, then these tests look rather incomplete; they only test the push
side and not the pop side.  What if someone runs "git stash push -a"
followed by "git stash pop --no-overwrite-ignore"?  Or is that flag
not going to be added to pop?  Do we only care about protecting
ignored files at push/save time and not at pop time?  Why?  (And if we
do care about pop time, won't we need to worry about both former
untracked and former ignored files both having the possibility of
overwriting files that are now ignored?  And if we do allow users to
not overwrite ignored files at pop time, do we have a similar special
flag to avoid overwriting untracked files at pop time?  If not, are
ignored files thus more important or special than untracked files?)

I don't understand the user-driven problem this patch is attempting to solv=
e.
