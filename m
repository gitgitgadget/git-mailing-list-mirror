Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114081547C9
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271443; cv=none; b=VYP4rZCtei4Ws7R2knydXLK2xEZf5p4vPNGnMfui/ZyboTUFOYk8G1zx0WF7wn7OSmtrLgX9E7B9UYxav+ih+CFC081eVXXyeG0N2RvYvisyQCwFG0qxlqsE1/vljAdQB9sBVMiIDrWQqR0UO4StqCaeLU/GBtQCpZoN+v8qNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271443; c=relaxed/simple;
	bh=tuvWqCR3nJn0WTDzMDCBEGpz/tLNKj+zQnmK17I2vpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skV4lvLwzZbQL78ePrPnQn5chZTgSeXWdBPVTh0DRhqvcOVISB5T7SrIPAD6GLPVd/z3XzT1cUDAI/5PtT1sS8c8xli3AUkryuCtXASDlufUN8vJ5ayK91A/ODvNe/UPM0FWeRGqXJO/laeyoeVqsQmRrosEmJQzFvF8Kji+YfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbzIr4Te; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbzIr4Te"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-431d65ad973so6662265ab.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271440; x=1761876240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgxx0RG9bxWcawT1uCaxV1CmsxwMPMfQazExWwf7EYM=;
        b=PbzIr4TefNAAEw9sD9LohliRHkFzV2MHGilFU3EBRh2xIqmoPY22WTet5WF3PBzHbW
         Zi2qX8rUmoBWSb0y0gckcvcetovk8SawqmStZSC3Q2j10RvlfqXMQ2LUxJJlOMXS8bCr
         1D4vaGiEku2dn43LeGvkMnOCi+WiFQi2G7BOj1LAXF1Ay1mAfC3lDt6FIysot0wPSULx
         1J6uEYH5wvEYSgVoiyzK/cFnG3xQ8Iw0ucalSIg1FNPtg+UeSEE5z0RhBOvGtC9iTuQU
         GKYzLtNdpp5n67gKwKsNRDoMMpMgWA4zAa29FfVWxT93lH4xtVulex6pWx061gu+DNJN
         jNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271440; x=1761876240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgxx0RG9bxWcawT1uCaxV1CmsxwMPMfQazExWwf7EYM=;
        b=DD/OJSuym2S+oheAzxZIJK7zi98VFNldXJVvnO4udGLWBbbcWzXqJ0OQCmeCYjSeoj
         QK26+xpfxne9Uu1iDkQPemld1DnHb2JJ9LFcg6eSdfherdQCHuZUIxfyT29cwfU+4E3Y
         e92RjivbhxnUo7NYsumWq9cQH5lOwjplDNfzGrIY2yX/vTbnGXuZs2tzsmoRccZktjbH
         8hoogloU6i3JGVS59evWvhHoEa9EG8oTA48o4e5s3K8zWL1O2MFB7D1SIjvPqjB78LAP
         mle1ZBsNFs9h00dbi9H0ElEINB4yJEtsdscVr4DV21clzxsslgN/0I8qceTBaD/+Eg5Q
         a4BA==
X-Gm-Message-State: AOJu0YybHG4nMunlnifxd3vavUBTvUnrgDcDA5+meBNCtj8Qwd4tzeCT
	7xIIrCQYK23Ew+IacZwRJq1Eot2oI/+f7dbee4+PeTZZrjFEa4PFsFYPIiSfJYAqC/VMoC+Dgeb
	JHGLN2iggDX93tD9iFWBh95D5EHkOHTs=
X-Gm-Gg: ASbGncspRYG/PN71H86wTpYjemluIdmaUMrS37gpxjTPsVGL2Ru+2FTGOiUPHy+3Ctb
	zbG1VZr3uldLA4pSsgThkGVcWP/3pmS3FZPb9+OQ5zA1wQpGC5QypfJ4hGby4JA/+J1bZQeYFv2
	06X/6P8joe4GsVoxdGTWXjZy75Axe1Yhji/48YC89TcMFTJ9KlaNh3R9EMm6VKnaZEJqCzNXMFf
	yyAyFByVY4hGflK/FVsEePg/0itKO+0E9wkSUfOpeX3TpGcf9vLfegGvnD3gdEdakTL+vh1uF/o
	P7/atg==
X-Google-Smtp-Source: AGHT+IGjn74j7uN1+T7jyfJMBHa8J+WkZxVPMqWemc4v9K1dcqJCwojfucvTp/244dy/bHMyJGpINKh4BKWLSeGSm/o=
X-Received: by 2002:a05:6e02:16ca:b0:431:d83a:9c7 with SMTP id
 e9e14a558f8ab-431ebed4198mr11575805ab.24.1761271440057; Thu, 23 Oct 2025
 19:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <20251013084857.1646783-6-christian.couder@gmail.com>
In-Reply-To: <20251013084857.1646783-6-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:03:48 -0400
X-Gm-Features: AS18NWAu9MHHQ9QADvubVoVLqjh7CkqfXNFADIZCu5yYPjDHGS-feOHhL-cEOdY
Message-ID: <CABPp-BGQ=3Tuik-PCerkaK4R0b1roSVLXLKs2-+E11vDrH6WaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-import: add '--signed-tags=<mode>' option
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Recently, eaaddf5791 (fast-import: add '--signed-commits=3D<mode>'
> option, 2025-09-17) added support for controlling how signed commits
> are handled by `git fast-import`, but there is no option yet to
> decide about signed tags.
>
> To remediate that, let's add a '--signed-tags=3D<mode>' option to
> `git fast-import` too.
>
> With this, both `git fast-export` and `git fast-import` have both
> a '--signed-tags=3D<mode>' and a '--signed-commits=3D<mode>' supporting
> the same <mode>s.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-fast-import.adoc |  5 ++
>  builtin/fast-import.c              | 43 ++++++++++++++++
>  t/meson.build                      |  1 +
>  t/t9306-fast-import-signed-tags.sh | 80 ++++++++++++++++++++++++++++++
>  4 files changed, 129 insertions(+)
>  create mode 100755 t/t9306-fast-import-signed-tags.sh
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 85ed7a7270..b74179a6c8 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatical=
ly for
>  remote-helpers that use the `import` capability, as they are
>  already trusted to run their own code.
>
> +--signed-tags=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +       Specify how to handle signed tags.  Behaves in the same way
> +       as the same option in linkgit:git-fast-export[1], except that
> +       default is 'verbatim' (instead of 'abort').

Sorry for not catching this earlier with the --signed-commits series
(was otherwise occupied), but this worries me.  If we ship with this
as the default, people will come to depend upon it, and I think it's a
bad long term default.  Long term, we'd want to check if the
signatures are valid and keep if so and do something else if not (e.g.
re-sign or abort or strip).  Maybe verbatim is better than abort out
of the options you've implemented so far, but I think setting the
default now to verbatim means people start depending on it and we
cannot change it later.  Could we change to 'abort', for both this and
--signed-commits, before the 2.52 release, and then re-discuss once
you have the other options implemented?

> +
>  --signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
>         Specify how to handle signed commits.  Behaves in the same way
>         as the same option in linkgit:git-fast-export[1], except that
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2010e78475..60d6faa465 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -188,6 +188,7 @@ static int global_argc;
>  static const char **global_argv;
>  static const char *global_prefix;
>
> +static enum sign_mode signed_tag_mode =3D SIGN_VERBATIM;
>  static enum sign_mode signed_commit_mode =3D SIGN_VERBATIM;

Here's where you define the defaults, in case there is no
--signed-{tag,commit} flags.  I think we should go with abort to allow
us to later change to a better default once one is implemented.

>  /* Memory pools */
> @@ -2961,6 +2962,43 @@ static void parse_new_commit(const char *arg)
>         b->last_commit =3D object_count_by_type[OBJ_COMMIT];
>  }
>
> +static void handle_tag_signature(struct strbuf *msg, const char *name)
> +{
> +       size_t sig_offset =3D parse_signed_buffer(msg->buf, msg->len);
> +
> +       /* If there is no signature, there is nothing to do. */
> +       if (sig_offset >=3D msg->len)
> +               return;
> +
> +       switch (signed_tag_mode) {
> +
> +       /* First, modes that don't change anything */
> +       case SIGN_ABORT:
> +               die(_("encountered signed tag; use "
> +                     "--signed-tags=3D<mode> to handle it"));
> +       case SIGN_WARN_VERBATIM:
> +               warning(_("importing a tag signature verbatim for tag '%s=
'"), name);
> +               /* fallthru */
> +       case SIGN_VERBATIM:
> +               /* Nothing to do, the signature will be put into the impo=
rted tag. */
> +               break;
> +
> +       /* Second, modes that remove the signature */
> +       case SIGN_WARN_STRIP:
> +               warning(_("stripping a tag signature for tag '%s'"), name=
);
> +               /* fallthru */
> +       case SIGN_STRIP:
> +               /* Truncate the buffer to remove the signature */
> +               strbuf_setlen(msg, sig_offset);
> +               break;
> +
> +       /* Third, BUG */
> +       default:
> +               BUG("invalid signed_tag_mode value %d from tag '%s'",
> +                   signed_tag_mode, name);
> +       }

Makes sense, you either keep the signature as is, or strip it, with
potentially sending a warning (or error) beforehand.

> +}
> +
>  static void parse_new_tag(const char *arg)
>  {
>         static struct strbuf msg =3D STRBUF_INIT;
> @@ -3024,6 +3062,8 @@ static void parse_new_tag(const char *arg)
>         /* tag payload/message */
>         parse_data(&msg, 0, NULL);
>
> +       handle_tag_signature(&msg, t->name);
> +
>         /* build the tag object */
>         strbuf_reset(&new_data);
>
> @@ -3544,6 +3584,9 @@ static int parse_one_option(const char *option)
>         } else if (skip_prefix(option, "signed-commits=3D", &option)) {
>                 if (parse_sign_mode(option, &signed_commit_mode))
>                         usagef(_("unknown --signed-commits mode '%s'"), o=
ption);
> +       } else if (skip_prefix(option, "signed-tags=3D", &option)) {
> +               if (parse_sign_mode(option, &signed_tag_mode))
> +                       usagef(_("unknown --signed-tags mode '%s'"), opti=
on);

Re-using the parse_sign_mode() function previously introduced for
--signed-commits...

>         } else if (!strcmp(option, "quiet")) {
>                 show_stats =3D 0;
>                 quiet =3D 1;
> diff --git a/t/meson.build b/t/meson.build
> index 11376b9e25..cb8c2b4b30 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1036,6 +1036,7 @@ integration_tests =3D [
>    't9303-fast-import-compression.sh',
>    't9304-fast-import-marks.sh',
>    't9305-fast-import-signatures.sh',
> +  't9306-fast-import-signed-tags.sh',
>    't9350-fast-export.sh',
>    't9351-fast-export-anonymize.sh',
>    't9400-git-cvsserver-server.sh',
> diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-sig=
ned-tags.sh
> new file mode 100755
> index 0000000000..363619e7d1
> --- /dev/null
> +++ b/t/t9306-fast-import-signed-tags.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +
> +test_description=3D'git fast-import --signed-tags=3D<mode>'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
> +
> +test_expect_success 'set up unsigned initial commit and import repo' '
> +       test_commit first &&
> +       git init new
> +'
> +
> +test_expect_success 'import no signed tag with --signed-tags=3Dabort' '
> +       git fast-export --signed-tags=3Dverbatim >output &&
> +       git -C new fast-import --quiet --signed-tags=3Dabort <output
> +'
> +
> +test_expect_success GPG 'set up OpenPGP signed tag' '
> +       git tag -s -m "OpenPGP signed tag" openpgp-signed first &&
> +       OPENPGP_SIGNED=3D$(git rev-parse --verify refs/tags/openpgp-signe=
d) &&
> +       git fast-export --signed-tags=3Dverbatim openpgp-signed >output
> +'
> +
> +test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=3D=
abort' '
> +       test_must_fail git -C new fast-import --quiet --signed-tags=3Dabo=
rt <output
> +'
> +
> +test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=3D=
verbatim' '
> +       git -C new fast-import --quiet --signed-tags=3Dverbatim <output >=
log 2>&1 &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/tags/openpgp-sign=
ed) &&
> +       test $OPENPGP_SIGNED =3D $IMPORTED &&
> +       test_must_be_empty log
> +'
> +
> +test_expect_success GPGSM 'setup X.509 signed tag' '
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +
> +       git tag -s -m "X.509 signed tag" x509-signed first &&
> +       X509_SIGNED=3D$(git rev-parse --verify refs/tags/x509-signed) &&
> +       git fast-export --signed-tags=3Dverbatim x509-signed >output
> +'
> +
> +test_expect_success GPGSM 'import X.509 signed tag with --signed-tags=3D=
warn-strip' '
> +       git -C new fast-import --quiet --signed-tags=3Dwarn-strip <output=
 >log 2>&1 &&
> +       test_grep "stripping a tag signature for tag '\''x509-signed'\''"=
 log &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/tags/x509-signed)=
 &&
> +       test $X509_SIGNED !=3D $IMPORTED &&
> +       git -C new cat-file -p x509-signed >out &&
> +       test_grep ! "SIGNED MESSAGE" out
> +'
> +
> +test_expect_success GPGSSH 'setup SSH signed tag' '
> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
> +
> +       git tag -s -m "SSH signed tag" ssh-signed first &&
> +       SSH_SIGNED=3D$(git rev-parse --verify refs/tags/ssh-signed) &&
> +       git fast-export --signed-tags=3Dverbatim ssh-signed >output
> +'
> +
> +test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=3Dw=
arn-verbatim' '
> +       git -C new fast-import --quiet --signed-tags=3Dwarn-verbatim <out=
put >log 2>&1 &&
> +       test_grep "importing a tag signature verbatim for tag '\''ssh-sig=
ned'\''" log &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/tags/ssh-signed) =
&&
> +       test $SSH_SIGNED =3D $IMPORTED
> +'
> +
> +test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=3Ds=
trip' '
> +       git -C new fast-import --quiet --signed-tags=3Dstrip <output >log=
 2>&1 &&
> +       test_must_be_empty log &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/tags/ssh-signed) =
&&
> +       test $SSH_SIGNED !=3D $IMPORTED &&
> +       git -C new cat-file -p ssh-signed >out &&
> +       test_grep ! "SSH SIGNATURE" out
> +'
> +
> +test_done
> --
> 2.51.0.438.g6987fc0bae

This all looks good to me, other than the default as noted above.
