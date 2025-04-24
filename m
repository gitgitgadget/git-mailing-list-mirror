Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B5198851
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530922; cv=none; b=FJzn17nDJYYKpFUagChxyUC+O/t2ee4n43x6a+lLAv22Hd0YXmOdBN2MSHNQuUyBT7sIpbEgF58gy05qXDj0LtAGCA36n8f+Y2Q1NDVSIAbFaJUm8deK5X0IDsjXnu1trp+MNi65ByVs7CX0vk6uTdgFyySxi9hAmwu9n9Bjxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530922; c=relaxed/simple;
	bh=gugbETl73jSNGFy6/tW1R1GtzQgsXSUXq3/4owNmU2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/RfN9+0N4w08amMYul04m+1KiJjLLZxLvvhMu1M1b0D+8MJ8WUNoQGqgimpPUPrXPbBIyRrDyCu442OvvT4ggbsEEvYE/PM1s7UVlktu5YD0EiXP3zb18GeYKkQqLr8aNsGlxM0D/2w0axGAAXmw3wEG3igMjK5AbyYv8gsj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB/faqwX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB/faqwX"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d6d162e516so12802295ab.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745530919; x=1746135719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve6GsqM9597dPZ86PiXiMEyNJNG6bBU71RwHKNH5Nws=;
        b=XB/faqwXIUMmCr+EXobi2ExiceGzkTYwzn6Fjf06OMCEJNE2LIYLGwwrloQFPOv59U
         XhXO6Crt4k/CrKbppD/InKN1o2zd7KV2u25RLHuQoPCnkOHj3LJsVfTaPnAq+s/c4m3+
         wCbptHZZ/jiqgqBAE+qfDoqJNPEHJ6Wxf1vpxN3ZjZ72mDOJ7AnfSRAebtKULoYespiG
         zzuJr0YHBn7G66zHtnrw8mXuEC14ULdeYfJnIzhtxzHaTw0ipjbVpDRO27ARzSJ72djn
         4fQOelK0GcCYiEbnUvWvOx0V0v3waPANK4WBL9kqQS0dQQ+No3bUJAKdJoAp6DChngZx
         3WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745530919; x=1746135719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve6GsqM9597dPZ86PiXiMEyNJNG6bBU71RwHKNH5Nws=;
        b=FEtTaC2IxVbcsg21rWzcblkEO+DkzyCNMSIW+kTOXPR4i0MkYYT2CAomROFpM5aUl1
         7PcMIWoNjiCSKZwPhh5obgjUPjHMjdXeUFuPRIa0KM/HHoSupaGm2DHQhaDCxZC6smJp
         Rj2x5VXJ0jxXmeP9xkNJf2precsMraaaXTvocvVGwFCpuNb0sBRIzA4Nto9k3DjVSyaF
         C5axOsPyXujwE9VX2yBr4zpfOe1WptgI+LW9eL4773mm8s/kDyVefAw2zXmKUjM4zUFB
         ei0rnE5eeAHrZkkoUBnsMINSmDKLoTpwlwGZyqQ1qM2R+XVrkTfs6iHzqFCUARR0zJnx
         +H+g==
X-Gm-Message-State: AOJu0Yze6as2l/R43GXHteblzyg9+6IgfDXHKAle0IJBc+0iTZK1AHem
	+v6GdNki98erkkRIRQqJe2LcFTrg8mwtbzpKyCoyxC2pAnPadMoZOjIqGW34QIdCHNUgDxBprKs
	HM6KEwu6wGQ6gnKN/OEC0hcRaygw=
X-Gm-Gg: ASbGncscTm/ZSgGVzNr/pofiUSlOaugvh3QpvNbm6sz3+NjRpSey5e1ctieBWD8FI7M
	3NRvOY0scS5D818EiPOIZAtVfXpz2V+fdrYto/Rsah5O3TyIE5qbMY/GBIIBoWMtjNr38pkm6iB
	+bLl8ptMOTrN4809XtGp6P2WSMuHH8aNHGUSNU8cxIBZdlVtV88fga8g==
X-Google-Smtp-Source: AGHT+IEwNg68Nj2+MwFgCyMuaSreZ8IPxrz7M5qNO5m5nL+6/2nMJxR1Og1G0fFsvRHG9eMFKOHK7X0O2Hv9t9cI7iM=
X-Received: by 2002:a05:6e02:1a45:b0:3d9:2fbe:2bb1 with SMTP id
 e9e14a558f8ab-3d9303bf717mr54747045ab.12.1745530919002; Thu, 24 Apr 2025
 14:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
In-Reply-To: <20250424203904.909777-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 24 Apr 2025 14:41:45 -0700
X-Gm-Features: ATxdqUEwXCNOOc0teTpXFmw3_Qak5ZEsAJ9kBIJbB6oQp5-mVI5xgawmqWU1pzE
Message-ID: <CABPp-BFrau4F1a_+umYw0qu8HYz3dTPXZ9oiHhawTSZpgAoGLw@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 1:39=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10), added support for signed commits.
>
> However, when processing signatures `git fast-export` outputs "gpgsig
> sha1" not just when it encounters an OpenPGP SHA-1 signature, but also
> when it encounters an SSH or X.509 signature. This is not very
> informative to say the least, and this might prevent tools that process
> the output from easily and properly handling signatures.
>
> Let's improve on that by reusing the existing code from
> "gpg-interface.{c,h}" to detect the signature algorithm, and then put
> the signature algorithm name (like "openpgp", "x509" or "ssh") instead
> of "sha1" in the output. If we can't detect the signature algorithm we
> will use "unknown". It might be a signature added by an external tool
> and we should likely keep it.
>
> Similarly on the `git fast-import` side, let's use the existing code
> from "gpg-interface.{c,h}" to check if a signature algorithm name is
> valid. In case of an "unknown" signature algorithm name, we will warn
> but still keep it. Future work might implement several options to let
> users deal with it in different ways, and might implement checking
> known signatures too.

The last sentence is somewhat ambiguous about whether it is only about
the "unknown" case or whether the second half of the sentence was
switching tracks to discuss something else about the known cases.  Do
you perhaps mean something like "Future work might implement several
options to let users deal with an "unknown" signature algorithm, and
when we have a valid signature algorithm, we may be able to not only
verify the signature algorithm name but start verifying the signature
itself to ensure it is valid as well."  ?

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This is a follow up from cc/signed-fast-export-import that was merged
> by 01d17c0530 (Merge branch 'cc/signed-fast-export-import', 2025-03-29)
> and introduced the support for signed commits.
>
> The format that this series implemented was lacking a bit, so the goal
> with this patch is to improve it and handle signed commits a bit more
> consistently in the code base. It also shows in the tests and in our
> documentation that SSH and X.509 signatures are supported.
>
>  Documentation/git-fast-export.adoc |  5 +++
>  Documentation/git-fast-import.adoc | 15 +++++++-
>  builtin/fast-export.c              |  8 ++--
>  builtin/fast-import.c              | 14 ++++---
>  gpg-interface.c                    | 11 ++++++
>  gpg-interface.h                    | 10 +++++
>  t/t9350-fast-export.sh             | 60 +++++++++++++++++++++++++++++-
>  7 files changed, 112 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 413a527496..d03aeca781 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -54,6 +54,11 @@ of tools that call 'git fast-export' but do not yet su=
pport
>  '--signed-commits', you may set the environment variable
>  'FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1' in order to change the default
>  from 'abort' to 'warn-strip'.
> ++
> +When exported, signature starts with "gpgsig <alg>" where <alg> is the
> +signature algorithm name as identified by Git (e.g. "openpgp", "x509",
> +"ssh", or "sha256" for SHA-256 OpenPGP signatures), or "unknown" for
> +signatures that can't be identified.
>
>  --tag-of-filtered-object=3D(abort|drop|rewrite)::
>         Specify how to handle tags whose tagged object is filtered out.
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 7b107f5e8e..50b6d2cc1d 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -521,7 +521,20 @@ The optional `gpgsig` command is used to include a P=
GP/GPG signature
>  that signs the commit data.
>
>  Here <alg> specifies which hashing algorithm is used for this
> -signature, either `sha1` or `sha256`.
> +signature. Current valid values are:
> +
> +* "openpgp" for SHA-1 OpenPGP signatures,
> +
> +* "sha256" for SHA-256 OpenPGP signatures,
> +
> +* "x509" for X.509 (GPGSM) signatures,
> +
> +* "ssh", for SSH signatures,
> +
> +* "unknown" for signatures that can't be identified (a warning is
> +  emitted).
> +
> +Signatures are not yet checked in the current implementation though.

Thanks for calling this out.

>  `encoding`
>  ^^^^^^^^^^
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 170126d41a..d00f02dc74 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -29,6 +29,7 @@
>  #include "quote.h"
>  #include "remote.h"
>  #include "blob.h"
> +#include "gpg-interface.h"
>
>  static const char *fast_export_usage[] =3D {
>         N_("git fast-export [<rev-list-opts>]"),
> @@ -700,9 +701,10 @@ static void handle_commit(struct commit *commit, str=
uct rev_info *rev,
>         }
>
>         if (*commit_buffer_cursor =3D=3D '\n') {
> -               if ((signature =3D find_commit_multiline_header(commit_bu=
ffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
> -                       signature_alg =3D "sha1";
> -               else if ((signature =3D find_commit_multiline_header(comm=
it_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
> +               if ((signature =3D find_commit_multiline_header(commit_bu=
ffer_cursor + 1, "gpgsig", &commit_buffer_cursor))) {
> +                       const char *name =3D get_signature_name(signature=
);
> +                       signature_alg =3D name ? name : "unknown";
> +               } else if ((signature =3D find_commit_multiline_header(co=
mmit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
>                         signature_alg =3D "sha256";
>         }
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 63880b595c..59e991a03c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -29,6 +29,7 @@
>  #include "commit-reach.h"
>  #include "khash.h"
>  #include "date.h"
> +#include "gpg-interface.h"
>
>  #define PACK_ID_BITS 16
>  #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
> @@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
>                         "encoding %s\n",
>                         encoding);
>         if (sig_alg) {
> -               if (!strcmp(sig_alg, "sha1"))
> -                       strbuf_addstr(&new_data, "gpgsig ");
> -               else if (!strcmp(sig_alg, "sha256"))
> +               if (!strcmp(sig_alg, "sha256"))
>                         strbuf_addstr(&new_data, "gpgsig-sha256 ");
> -               else
> -                       die("Expected gpgsig algorithm sha1 or sha256, go=
t %s", sig_alg);
> +               else if (valid_signature_name(sig_alg))
> +                       strbuf_addstr(&new_data, "gpgsig ");
> +               else if (!strcmp(sig_alg, "unknown")) {
> +                       warning("Unknown gpgsig algorithm name!");
> +                       strbuf_addstr(&new_data, "gpgsig ");
> +               } else
> +                       die("Invalid gpgsig algorithm name, got '%s'", si=
g_alg);
>                 string_list_split_in_place(&siglines, sig.buf, "\n", -1);
>                 strbuf_add_separated_string_list(&new_data, "\n ", &sigli=
nes);
>                 strbuf_addch(&new_data, '\n');

I'm not very familiar with gpg and other signatures, and was stuck
trying to parse this logic when a review from Junio came in, and I
decided to read it since he often "thinks out loud" to see if that'd
explain it better.  Sadly, didn't help... ;-)  But I'll watch for any
follow-up response you add over there.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0896458de5..dc6ea904d0 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -144,6 +144,17 @@ static struct gpg_format *get_format_by_sig(const ch=
ar *sig)
>         return NULL;
>  }
>
> +const char *get_signature_name(const char *buf)
> +{
> +       struct gpg_format *format =3D get_format_by_sig(buf);
> +       return format ? format->name : NULL;
> +}
> +
> +int valid_signature_name(const char *name)
> +{
> +       return (get_format_by_name(name) !=3D NULL);
> +}
> +
>  void signature_check_clear(struct signature_check *sigc)
>  {
>         FREE_AND_NULL(sigc->payload);
> diff --git a/gpg-interface.h b/gpg-interface.h
> index e09f12e8d0..332707facc 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -47,6 +47,16 @@ struct signature_check {
>
>  void signature_check_clear(struct signature_check *sigc);
>
> +/*
> + * Return the name of the signature (like "openpgp", "x509" or "ssh").
> + */
> +const char *get_signature_name(const char *buf);
> +
> +/*
> + * Is the signature name valid (like "openpgp", "x509" or "ssh").
> + */
> +int valid_signature_name(const char *name);
> +
>  /*
>   * Look at a GPG signed tag object.  If such a signature exists, store i=
t in
>   * signature and the signed content in payload.  Return 1 if a signature=
 was
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index dda9e7c3e7..2e2c83d153 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -326,7 +326,7 @@ test_expect_success GPG 'signed-commits=3Dabort' '
>  test_expect_success GPG 'signed-commits=3Dverbatim' '
>
>         git fast-export --signed-commits=3Dverbatim --reencode=3Dno commi=
t-signing >output &&
> -       grep "^gpgsig sha" output &&
> +       grep "^gpgsig openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         (
>                 cd new &&
> @@ -340,7 +340,7 @@ test_expect_success GPG 'signed-commits=3Dverbatim' '
>  test_expect_success GPG 'signed-commits=3Dwarn-verbatim' '
>
>         git fast-export --signed-commits=3Dwarn-verbatim --reencode=3Dno =
commit-signing >output 2>err &&
> -       grep "^gpgsig sha" output &&
> +       grep "^gpgsig openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         test -s err &&
>         (
> @@ -381,6 +381,62 @@ test_expect_success GPG 'signed-commits=3Dwarn-strip=
' '
>
>  '
>
> +test_expect_success GPGSM 'setup x509 signed commit' '
> +
> +       git checkout -b x509-signing main &&
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +       echo "x509 content" >file_for_x509 &&
> +       git add file_for_x509 &&
> +       git commit -S -m "X.509 signed commit" &&
> +       X509_COMMIT=3D$(git rev-parse --verify HEAD) &&
> +       git checkout main
> +
> +'
> +
> +test_expect_success GPGSM 'x509 signature identified' '
> +
> +       git fast-export --signed-commits=3Dverbatim --reencode=3Dno x509-=
signing >output 2>err &&

Is --reencode=3Dno important here or does this work with --reencode=3Dyes
as well?  (I understand the default being --reencode=3Dabort and fact
that you are reusing an example that used a specialized encoding means
you need to specify something, was just curious if this particular
value was important)

> +       grep "^gpgsig x509" output &&
> +       test ! -s err &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               STRIPPED=3D$(git rev-parse --verify refs/heads/x509-signi=
ng) &&
> +               test $X509_COMMIT =3D $STRIPPED

Ah, --reencode=3Dno is critical for the test, but only because you are
trying to ensure you get the same commit back.  Should there also be a
test for when something is tweaked, such as the encoding, and whether
the signature is still found?

> +       ) <output &&
> +       test_might_fail git update-ref -d refs/heads/x509-signing
> +
> +'
> +
> +test_expect_success GPGSSH 'setup ssh signed commit' '
> +
> +       git checkout -b ssh-signing main &&
> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
> +       echo "ssh content" >file_for_ssh &&
> +       git add file_for_ssh &&
> +       git commit -S -m "SSH signed commit" &&
> +       SSH_COMMIT=3D$(git rev-parse --verify HEAD) &&
> +       git checkout main
> +
> +'
> +
> +test_expect_success GPGSSH 'ssh signature identified' '
> +
> +       git fast-export --signed-commits=3Dverbatim --reencode=3Dno ssh-s=
igning >output 2>err &&

Out of curiosity, any particular reason to export the entire history
instead of just the new commit you just added (though you'd likely
want --reference-excluded-parents if you did that, which really ought
to be the default)?  Anyway...

> +       grep "^gpgsig ssh" output &&
> +       test ! -s err &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               STRIPPED=3D$(git rev-parse --verify refs/heads/ssh-signin=
g) &&
> +               test "$SSH_COMMIT" =3D "$STRIPPED"

Looks like your two tests are for different signature types, but as
noted above, I'm kind of curious to see a test covering what happens
when the resulting commit doesn't exactly match the original but still
retains a signature.

> +       ) <output &&
> +       test_might_fail git update-ref -d refs/heads/ssh-signing
> +
> +'
> +
>  test_expect_success 'setup submodule' '
>
>         test_config_global protocol.file.allow always &&
> --
> 2.49.0.392.g2fa1c74b07
