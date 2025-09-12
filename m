Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71131846F
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681154; cv=none; b=hn2ZL80GGU+dXf09GBNXEcwLl2akKz4Ew4qzGXwckg2zYtKAA7Pz6sc3NZVWmqGBfBAVhHHB5uKfWuGQjlVE6+2qojhOHQk9m6booUEnyeRqv9I/b/GwGzmERFZMoRXu6casXNU/ufK5/y8nuttDzmVl7q+aXdyNfU7qGotcaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681154; c=relaxed/simple;
	bh=NKA1okH9U0MLyhQvuWiJruKJcGFrCT2stC96p+8Da/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zvlm4Tn8AOnl4XdxTu3OWhBNbCbJfSTlq2bLf7TxOu8mb4ConLT9R9sPBYVabnAcdbYk+l4gHRNFALfG+dlV6bY2Z9FzWRvEux6n/w9TFiBQWcDRiYx1givrttoHvw2HeJ0fldeeBB5eK0R7ibpUakzI3Is6RYhfyxwluZuhMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp/raPu5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp/raPu5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so2303181a12.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757681150; x=1758285950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J7KosrS2vzHbppFSu/dz1Pyo5iHr4QmL0g21NlAHaE=;
        b=lp/raPu5Hnw3vNt5dXk0IF1WstqMiy/kR4lQBmQnK5x45gcnq8TneczuF75Vb+rzQX
         MJ6mNXxMwGDTW64kGFw7bPv77h0OkJMAobq6GfoaycTlPwMPhnMj9qbJGAssPttbM7ys
         zeAIr4bCEuKyIRlLP1lQi5mWnmgOtDBPIikgRzF5DWT/Rwxvoo5LAEsHLIWAhXoSYk5b
         5EHbKr5iStNE9SJnbg+xD3zL07zLl6AYZXqsJQMy8JEp3G9cIbt9LInTpuGP2hIxVvJE
         6NXznbu50Tpp6rBauWTDT/80rgPxTdJpwxbqwFAN86VXIgtvoCBTZsNlFPpB4J9y2Hla
         IRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681150; x=1758285950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J7KosrS2vzHbppFSu/dz1Pyo5iHr4QmL0g21NlAHaE=;
        b=rEptz4uQLW4tgUSMG3AqNMp7ZcEyNhif3pzgS4mYHa8nAb6M2IzvQfL/QoLbdnHd5s
         QgTYcBdHUeBHkCSJPcig7IaYTrz6jxRcg4t7KFh3ISi4ADehLLi52LkyFhY/yMDBXUi+
         Jjl6IXOhYcWc/uOZTbWeJ9IGK475hgZ4R+M7p/vCdoUvf4Z2hOpJK2Iosz3B+nJoS9Nz
         vFkl+HuIZoO2hNiuut9f9vnpuAdBl0APjyANg6sjAHfSh4sLPnh7/7+M41hBbj8J6wwG
         ubzxClcKYcwq0d7dDbkdLruNqfNekhb/IWcULf9MrpsoXMf30P4LO48QeQWqN5+EjARF
         Nfjg==
X-Gm-Message-State: AOJu0YykTklm4zJ+AttZjBxEkhu7vRniLLbGXiP0XwnVtfNmhMTPPpjX
	1fDD3LlUTKbdo9Lj0OcXquqbqsL/a9zHBdxPJpAU1iRnwT5iObXe0kK0fwMBXkSKFt+VdZnPMox
	/M95UGcpwKdiBEpFGwSaX9LuoSELP3g4TpPqI
X-Gm-Gg: ASbGncv3EXR/sIm5gGU5PSIMEoTf8t/fz7l+ZoSyBCQygDegjM/xWjaWuI4BvztZW4N
	Au7ew+BopREy5JgZcgLn18O2u6QFxsqmhC4Py9OJWB0BZFVmhA+cSazNQSSGClGATstpRtGiGvu
	tteFEJZEqw0ZG1JzNIwZMtluyGm5cdZahQHk1i5OWLTfHXHzWpR70NpDKvau6mbw6RIrF196DGl
	bhE0a4XnQ==
X-Google-Smtp-Source: AGHT+IHV/fvGaOaRZqRNQzUIAbrkQHzYr1m477+DzR+nvDpiE35kkhoe8uRPztHWJLrwjgiVT7d9w88xYX5OcxqFKA4=
X-Received: by 2002:a05:6402:2102:b0:61e:ca25:3502 with SMTP id
 4fb4d7f45d1cf-62ed8302337mr2937440a12.17.1757681149674; Fri, 12 Sep 2025
 05:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912124042.2523683-1-christian.couder@gmail.com> <20250912124042.2523683-3-christian.couder@gmail.com>
In-Reply-To: <20250912124042.2523683-3-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 14:45:37 +0200
X-Gm-Features: AS18NWBSdeGBiWbvt86tp91E7VRMgfrgVNP8_MmpCedqlMPblFk93N4uZ5iNGDA
Message-ID: <CAP8UFD3guuRXR6DEEBLaO3AqzSfs_woj6WcrCxJ3krdObokD3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I forgot to use the
--in-reply-to=3D'20250910080839.2142651-1-christian.couder@gmail.com'
option when sending this series. It is related to:

https://lore.kernel.org/git/20250910080839.2142651-1-christian.couder@gmail=
.com/

On Fri, Sep 12, 2025 at 2:40=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> A '--signed-commits=3D<mode>' option is already available when using
> `git fast-export` to decide what should be done at export time about
> commit signatures. At import time though, there is no option, or
> other way, in `git fast-import` to decide about commit signatures.
>
> To remediate that, let's add a '--signed-commits=3D<mode>' option to
> `git fast-import` too.
>
> For now the supported <mode>s are the same as those supported by
> `git fast-export`.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-fast-import.adoc |   5 ++
>  builtin/fast-import.c              |  41 ++++++++---
>  t/meson.build                      |   1 +
>  t/t9305-fast-import-signatures.sh  | 106 +++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+), 8 deletions(-)
>  create mode 100755 t/t9305-fast-import-signatures.sh
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 3144ffcdb6..90f242d058 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -66,6 +66,11 @@ OPTIONS
>         remote-helpers that use the `import` capability, as they are
>         already trusted to run their own code.
>
> +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +       Specify how to handle signed commits.  Behaves in the same way
> +       as the same option in linkgit:git-fast-export[1], except that
> +       default is 'verbatim' (instead of 'abort').
> +
>  Options for Frontends
>  ~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2c35f9345d..890f05de4d 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -188,6 +188,8 @@ static int global_argc;
>  static const char **global_argv;
>  static const char *global_prefix;
>
> +static enum sign_mode signed_commit_mode =3D SIGN_VERBATIM;
> +
>  /* Memory pools */
>  static struct mem_pool fi_mem_pool =3D {
>         .block_alloc =3D 2*1024*1024 - sizeof(struct mp_block),
> @@ -2817,19 +2819,39 @@ static void parse_new_commit(const char *arg)
>         if (!committer)
>                 die("Expected committer but didn't get one");
>
> -       /* Process signatures (up to 2: one "sha1" and one "sha256") */
>         while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
>                 struct signature_data sig =3D { NULL, NULL, STRBUF_INIT }=
;
>
> -               parse_one_signature(&sig, v);
> +               if (signed_commit_mode =3D=3D SIGN_ABORT)
> +                       die(_("encountered signed commit; use "
> +                             "--signed-commits=3D<mode> to handle it"));
>
> -               if (!strcmp(sig.hash_algo, "sha1"))
> -                       store_signature(&sig_sha1, &sig, "SHA-1");
> -               else if (!strcmp(sig.hash_algo, "sha256"))
> -                       store_signature(&sig_sha256, &sig, "SHA-256");
> -               else
> -                       BUG("parse_one_signature() returned unknown hash =
algo");
> +               parse_one_signature(&sig, v);
>
> +               switch (signed_commit_mode) {
> +               case SIGN_ABORT:
> +                       BUG("SIGN_ABORT should be handled before calling =
parse_one_signature()");
> +                       break;
> +               case SIGN_WARN_VERBATIM:
> +                       warning(_("importing a commit signature verbatim"=
));
> +                       /* fallthru */
> +               case SIGN_VERBATIM:
> +                       if (!strcmp(sig.hash_algo, "sha1"))
> +                               store_signature(&sig_sha1, &sig, "SHA-1")=
;
> +                       else if (!strcmp(sig.hash_algo, "sha256"))
> +                               store_signature(&sig_sha256, &sig, "SHA-2=
56");
> +                       else
> +                               die(_("parse_one_signature() returned unk=
nown hash algo"));
> +                       break;
> +               case SIGN_WARN_STRIP:
> +                       warning(_("stripping a commit signature"));
> +                       /* fallthru */
> +               case SIGN_STRIP:
> +                       /* Just discard signature data */
> +                       strbuf_release(&sig.data);
> +                       free(sig.hash_algo);
> +                       break;
> +               }
>                 read_next_command();
>         }
>
> @@ -3501,6 +3523,9 @@ static int parse_one_option(const char *option)
>                 option_active_branches(option);
>         } else if (skip_prefix(option, "export-pack-edges=3D", &option)) =
{
>                 option_export_pack_edges(option);
> +       } else if (skip_prefix(option, "signed-commits=3D", &option)) {
> +               if (parse_sign_mode(option, &signed_commit_mode))
> +                       usagef(_("unknown --signed-commits mode '%s'"), o=
ption);
>         } else if (!strcmp(option, "quiet")) {
>                 show_stats =3D 0;
>                 quiet =3D 1;
> diff --git a/t/meson.build b/t/meson.build
> index 82af229be3..08ad6938e2 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1032,6 +1032,7 @@ integration_tests =3D [
>    't9302-fast-import-unpack-limit.sh',
>    't9303-fast-import-compression.sh',
>    't9304-fast-import-marks.sh',
> +  't9305-fast-import-signatures.sh',
>    't9350-fast-export.sh',
>    't9351-fast-export-anonymize.sh',
>    't9400-git-cvsserver-server.sh',
> diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-sign=
atures.sh
> new file mode 100755
> index 0000000000..c2b4271658
> --- /dev/null
> +++ b/t/t9305-fast-import-signatures.sh
> @@ -0,0 +1,106 @@
> +#!/bin/sh
> +
> +test_description=3D'git fast-import --signed-commits=3D<mode>'
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
> +test_expect_success GPG 'set up OpenPGP signed commit' '
> +       git checkout -b openpgp-signing main &&
> +       echo "Content for OpenPGP signing." >file-sign &&
> +       git add file-sign &&
> +       git commit -S -m "OpenPGP signed commit" &&
> +       OPENPGP_SIGNING=3D$(git rev-parse --verify openpgp-signing)
> +'
> +
> +test_expect_success GPG 'import OpenPGP signature with --signed-commits=
=3Dverbatim' '
> +       git fast-export --signed-commits=3Dverbatim openpgp-signing >outp=
ut &&
> +       git -C new fast-import --quiet --signed-commits=3Dverbatim <outpu=
t >log 2>&1 &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/heads/openpgp-sig=
ning) &&
> +       test $OPENPGP_SIGNING =3D $IMPORTED &&
> +       test_must_be_empty log
> +'
> +
> +test_expect_success GPGSM 'set up X.509 signed commit' '
> +       git checkout -b x509-signing main &&
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +       echo "Content for X.509 signing." >file-sign &&
> +       git add file-sign &&
> +       git commit -S -m "X.509 signed commit" &&
> +       X509_SIGNING=3D$(git rev-parse HEAD)
> +'
> +
> +test_expect_success GPGSM 'import X.509 signature fails with --signed-co=
mmits=3Dabort' '
> +       git fast-export --signed-commits=3Dverbatim x509-signing >output =
&&
> +       test_must_fail git -C new fast-import --quiet --signed-commits=3D=
abort <output
> +'
> +
> +test_expect_success GPGSM 'import X.509 signature with --signed-commits=
=3Dwarn-verbatim' '
> +       git -C new fast-import --quiet --signed-commits=3Dwarn-verbatim <=
output >log 2>&1 &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/heads/x509-signin=
g) &&
> +       test $X509_SIGNING =3D $IMPORTED &&
> +       test_grep "importing a commit signature" log
> +'
> +
> +test_expect_success GPGSSH 'set up SSH signed commit' '
> +       git checkout -b ssh-signing main &&
> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
> +       echo "Content for SSH signing." >file-sign &&
> +       git add file-sign &&
> +       git commit -S -m "SSH signed commit" &&
> +       SSH_SIGNING=3D$(git rev-parse HEAD)
> +'
> +
> +test_expect_success GPGSSH 'strip SSH signature with --signed-commits=3D=
strip' '
> +       git fast-export --signed-commits=3Dverbatim ssh-signing >output &=
&
> +       git -C new fast-import --quiet --signed-commits=3Dstrip <output >=
log 2>&1 &&
> +       IMPORTED=3D$(git -C new rev-parse --verify refs/heads/ssh-signing=
) &&
> +       test $SSH_SIGNING !=3D $IMPORTED &&
> +       git -C new cat-file commit "$IMPORTED" >actual &&
> +       test_grep ! -E "^gpgsig" actual &&
> +       test_must_be_empty log
> +'
> +
> +test_expect_success GPG 'setup a commit with dual OpenPGP signatures on =
its SHA-1 and SHA-256 formats' '
> +       # Create a signed SHA-256 commit
> +       git init --object-format=3Dsha256 explicit-sha256 &&
> +       git -C explicit-sha256 config extensions.compatObjectFormat sha1 =
&&
> +       git -C explicit-sha256 checkout -b dual-signed &&
> +       test_commit -C explicit-sha256 A &&
> +       echo B >explicit-sha256/B &&
> +       git -C explicit-sha256 add B &&
> +       test_tick &&
> +       git -C explicit-sha256 commit -S -m "signed" B &&
> +       SHA256_B=3D$(git -C explicit-sha256 rev-parse dual-signed) &&
> +
> +       # Create the corresponding SHA-1 commit
> +       SHA1_B=3D$(git -C explicit-sha256 rev-parse --output-object-forma=
t=3Dsha1 dual-signed) &&
> +
> +       # Check that the resulting SHA-1 commit has both signatures
> +       git -C explicit-sha256 cat-file -p $SHA1_B >out &&
> +       test_grep -E "^gpgsig " out &&
> +       test_grep -E "^gpgsig-sha256 " out
> +'
> +
> +test_expect_success GPG 'strip both OpenPGP signatures with --signed-com=
mits=3Dwarn-strip' '
> +       git -C explicit-sha256 fast-export --signed-commits=3Dverbatim du=
al-signed >output &&
> +       test_grep -E "^gpgsig sha1 openpgp" output &&
> +       test_grep -E "^gpgsig sha256 openpgp" output &&
> +       git -C new fast-import --quiet --signed-commits=3Dwarn-strip <out=
put >log 2>&1 &&
> +       git -C new cat-file commit refs/heads/dual-signed >actual &&
> +       test_grep ! -E "^gpgsig " actual &&
> +       test_grep ! -E "^gpgsig-sha256 " actual &&
> +       test_grep "stripping a commit signature" log >out &&
> +       test_line_count =3D 2 out
> +'
> +
> +test_done
> --
> 2.51.0.195.gf8f8f06677
>
