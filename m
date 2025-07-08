Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9112FF69
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016102; cv=none; b=YWnZa23NZQ6xgn5LsBoerGnBVWMRYRA6cKdw3xdtQHnmADM3mnluqgI9VNERFlSA0HCGxNuhYo858cbau1PeWla9RnHz4YWLmlsA40Rx6QvHrEVhXVRzzCulsi/n9A5moo617wVR+MOMVMrumHETyLNAJuJnQwVutZD8bANhwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016102; c=relaxed/simple;
	bh=OjV2fF/0R2o52ZJhMJLNaNroaI+O+U4KIY/4K8OJfKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea/wPiDroStZj2TpELTGn9boTijruVd0cl/G1SertRH5wPNb5oen/ga6nMpkBoqoac3D5h/7KrYfN1rYaMye+5A3+XdvLyGfMPvibTHdlNvo/QbkxPLF381k/UwKqlYhQJjCjXEoMredRJp2znkMAXnH6oT2Jl0X3wzL2x7nJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xiv6FZsR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xiv6FZsR"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df5249601cso38440595ab.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016099; x=1752620899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bd0kVtEdUGYkFF7J8Cjm0tPuQAFOjslJzIJ+nNiyL8=;
        b=Xiv6FZsR5rgJYk4S9WgJSN+BCKEDrojxtuZM/IjTyAwGAFMG3mNZOBJUTvjSFJsw3p
         ZVGy15FvGcYWFAaPO5+tPbUpRbhkUe0vFNycdthghAnjR+uOK+ao3Peom5W3W/BDhSp+
         ragveS5VD1AqWsajNpdrmk+GSfESZlouG/K0EOBDrWVAOefVs7jzY1AWiBrWyCCsQAoE
         AZTpRYmEPR37w3Q+yQo56P5h+wg8EhXx4FjZqKmvEiHEYRbrGf2zyIcgaLRHvjmjlDA0
         pbJWgLDRWW4zXIgivKZPlucvVBpOT70Qz97lRp/VDGaJt7KYdRQzMb2F64CVlU9i6dWL
         x58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016099; x=1752620899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bd0kVtEdUGYkFF7J8Cjm0tPuQAFOjslJzIJ+nNiyL8=;
        b=calYkRTC+raVSJsUnLogXsFda+GkjPnO5js0J8rsEZX8kXITeux+w+ubK9XnclOiZl
         omGvJ3U8g9kaO8w+a+tXdlPSZTWtj2P0NjYDdOUmJg2XaMZax14GS2BhVm87KkkWFrSO
         nMJ1HJSZfqO1r6A0WNE3KqHyNZNvriC89PBIaEnVEfQCdpTFsMPHY1evBdJa82ZyqpgW
         pc0w1Y/wmSjs5Tq+motwIkkZIS722dqImzAQTJu4wW5fDpW6cTztGdiqzsr3Eeb/C7Dt
         X7w4E5uYyzV9285uBWssJbximadAPthYFqqyTbDBu4/+KlPwGlLthjGk5Cf3fOQMy7wm
         RLZg==
X-Gm-Message-State: AOJu0Ywe2HI4SjEfEWgDDfqzIp189/a7r2s+TQ28zSE/XNjBC4HhaiZ4
	V7EhUobj5wGbrjlcrpgGKo+lh6AvXybt6L+rqtp17EPtj/PpUbJ7YHuMGXVDcmRFHFz+eci3L9z
	ZbXUlWrlNn90fdQoe19V2qagfl5kCp00=
X-Gm-Gg: ASbGncsxzH5c8ERVcnO7DHbpogup+xAJNFEupHqC3xS3S9l7S33Azb0vEIaVI/MVmhq
	CPrl6AuTNQ56pv2N2pRQKeFeLxbtqwLcSbfFOy6HT6e/Ai1N+iR1gJGBTUA0vifMMCviH17mAHJ
	ysK9h9hcWyoK38WLqf/v/tmLBehkmmnLC3zuO4RKq2SfCTmYP6uDHnlqhqdw==
X-Google-Smtp-Source: AGHT+IF3ka3jEKZEQSDvmCZFRh0elfLEbr/kACjGgmzusNTSEMLG11PyK5NuLgPR1dYsFoMOarUJNwk2zWrSbNyzSks=
X-Received: by 2002:a05:6e02:1a07:b0:3da:71c7:5c7f with SMTP id
 e9e14a558f8ab-3e1670d0a59mr6041365ab.15.1752016098287; Tue, 08 Jul 2025
 16:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619133630.727274-1-christian.couder@gmail.com> <20250708091738.4072857-1-christian.couder@gmail.com>
In-Reply-To: <20250708091738.4072857-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 16:08:06 -0700
X-Gm-Features: Ac12FXx9F8gS2FZxL64_RL2cA-rQJVSJ7zZZziNzOGy2rmxRsuXjrajk2uOyEwE
Message-ID: <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:18=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10), added support for signed commits to
> fast-export and fast-import.
>
> When a signed commit is processed, fast-export can output either
> "gpgsig sha1" or "gpgsig sha256" depending on whether the signed
> commit uses the SHA-1 or SHA-256 Git object format.
>
> However, this implementation has a number of limitations:
>
>   - the output format was not properly described in the documentation,
>   - the output format is not very informative as it doesn't even say
>     if the signature is an OpenPGP, an SSH, or an X509 signature,
>   - the implementation doesn't support having both one signature on
>     the SHA-1 object and one on the SHA-256 object.
>
> Let's improve on these limitations by improving fast-export and
> fast-import so that:
>
>   - all the signatures are exported,
>   - at most one signature on the SHA-1 object and one on the SHA-256
>     are imported,
>   - if there is more than one signature on the SHA-1 object or on
>     the SHA-256 object, fast-import emits a warning for each
>     additional signature,
>   - the output format is "gpgsig <git-hash-algo> <signature-format>",
>     where <git-hash-algo> is the Git object format as before, and
>     <signature-format> is the signature type ("openpgp", "x509",
>     "ssh" or "unknown"),
>   - the output is properly documented.
>
> About the output format:
>
>   - <git-hash-algo> allows to know which representation of the commit
>     was signed (the SHA-1 or the SHA-256 version) which helps with
>     both signature verification and interoperability between repos
>     with different hash functions,
>
>   - <signature-format> helps tools that process the fast-export
>     stream, so they don't have to parse the ASCII armor to identify
>     the signature type.
>
> It could be even better to be able to import more than one signature
> on the SHA-1 object and on the SHA-256 object, but other parts of
> Git don't handle that well for now, so this is left for future
> improvements.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This v5 is similar in spirit to v4, especially the format of the
> "gpgsig ..." command didn't change, but there are a number of
> improvements:
>
>   - All the signatures are now exported. On the import side, still at
>     most one signature for SHA-1 and one for SHA-256 are imported (and
>     a warning is still emitted for additional signatures) though.
>
>   - The code makes sure each signature ends with a LF character. While
>     this is not mandatory, it is encouraged and makes the output more
>     human readable and 'grep'able.
>
>   - A test with both a SHA-1 and a SHA-256 signature on the same
>     commit has been added.
>
>   - Some tests check that either "sha1" or "sha256" is in the "gpgsig
>     ..."  command instead of matching "sha(1|256)".
>
>   - The format of the "gpgsig ..." command is better explained both in
>     the commit message and in the fast-import documentation.
>
>   - There are some typo fixes, lines wrapped, and a few other such
>     small changes.
>
> Thanks to brian, Elijah and Junio who commented on the v1 and v2.
>
> CI tests:
>
> They have all passed:
>
> https://github.com/chriscool/git/actions/runs/16136587558
>
> Range-diff with v4:
>
> 1:  b3d8b13c0e ! 1:  5791617d7d fast-(import|export): improve on commit s=
ignature output format
>     @@ Commit message
>          Let's improve on these limitations by improving fast-export and
>          fast-import so that:
>
>     -      - both one signature on the SHA-1 object and one on the SHA-25=
6
>     -        object can be exported and imported,
>     +      - all the signatures are exported,
>     +      - at most one signature on the SHA-1 object and one on the SHA=
-256
>     +        are imported,
>            - if there is more than one signature on the SHA-1 object or o=
n
>     -        the SHA-256 object, a warning is emitted,
>     +        the SHA-256 object, fast-import emits a warning for each
>     +        additional signature,
>            - the output format is "gpgsig <git-hash-algo> <signature-form=
at>",
>              where <git-hash-algo> is the Git object format as before, an=
d
>              <signature-format> is the signature type ("openpgp", "x509",
>     -        "ssh" or "unknown",
>     +        "ssh" or "unknown"),
>            - the output is properly documented.
>
>     -    Note that it could be even better to be able to export and impor=
t
>     -    more than one signature on the SHA-1 object and on the SHA-256
>     -    object, but other parts of Git don't handle that well for now, s=
o
>     -    this is left for future improvements.
>     +    About the output format:
>     +
>     +      - <git-hash-algo> allows to know which representation of the c=
ommit
>     +        was signed (the SHA-1 or the SHA-256 version) which helps wi=
th
>     +        both signature verification and interoperability between rep=
os
>     +        with different hash functions,
>     +
>     +      - <signature-format> helps tools that process the fast-export
>     +        stream, so they don't have to parse the ASCII armor to ident=
ify
>     +        the signature type.
>     +
>     +    It could be even better to be able to import more than one signa=
ture
>     +    on the SHA-1 object and on the SHA-256 object, but other parts o=
f
>     +    Git don't handle that well for now, so this is left for future
>     +    improvements.
>
>          Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
>          Helped-by: Elijah Newren <newren@gmail.com>
>     @@ Documentation/git-fast-export.adoc: resulting tag will have an inv=
alid signature
>      +`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
>      +starts with `gpgsig sha256 ssh`.
>      ++
>     -+Currently for a given commit, at most one signature for the SHA-1
>     -+object and one signature for the SHA-256 object are exported, each
>     -+with their respective <git-hash-algo> identifier. A warning is
>     -+emitted for each additional signature found.
>     ++While all the signatures of a commit are exported, an importer may
>     ++choose to accept only some of them. For example
>     ++linkgit:git-fast-import[1] currently stores at most one signature p=
er
>     ++Git hash algorithm in each commit.
>      ++
>       NOTE: This is highly experimental and the format of the data stream=
 may
>       change in the future without compatibility guarantees.
>     @@ Documentation/git-fast-import.adoc: their syntax.
>      +The `gpgsig` command takes two arguments:
>      +
>      +* `<git-hash-algo>` specifies which Git object format this signatur=
e
>     -+  applies to, either `sha1` or `sha256`.
>     ++  applies to, either `sha1` or `sha256`. This allows to know which
>     ++  representation of the commit was signed (the SHA-1 or the SHA-256
>     ++  version) which helps with both signature verification and
>     ++  interoperability between repos with different hash functions.
>      +
>      +* `<signature-format>` specifies the type of signature, such as
>     -+  `openpgp`, `x509`, `ssh`, or `unknown`.
>     ++  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
>     ++  tools that process the stream, so they don't have to parse the AS=
CII
>     ++  armor to identify the signature type.
>      +
>      +A commit may have at most one signature for the SHA-1 object format
>      +(stored in the "gpgsig" header) and one for the SHA-256 object form=
at
>     @@ builtin/fast-export.c: static const char *find_commit_multiline_he=
ader(const cha
>      +  if (!signature)
>      +          return;
>      +
>     -+  printf("gpgsig %s %s\ndata %u\n%s",
>     ++  printf("gpgsig %s %s\ndata %u\n%s\n",
>      +         object_hash,
>      +         get_signature_format(signature),
>      +         (unsigned)strlen(signature),
>      +         signature);
>      +}
>      +
>     -+static void warn_on_extra_sig(const char **pos, struct commit *comm=
it, int is_sha1)
>     ++static const char *append_signatures_for_header(struct string_list =
*signatures,
>     ++                                          const char *pos,
>     ++                                          const char *header,
>     ++                                          const char *object_hash)
>      +{
>     -+  const char *header =3D is_sha1 ? "gpgsig" : "gpgsig-sha256";
>     -+  const char *extra_sig =3D find_commit_multiline_header(*pos + 1, =
header, pos);
>     -+  if (extra_sig) {
>     -+          const char *hash =3D is_sha1 ? "SHA-1" : "SHA-256";
>     -+          warning("more than one %s signature found on commit %s, u=
sing only the first one",
>     -+                  hash, oid_to_hex(&commit->object.oid));
>     -+          free((char *)extra_sig);
>     ++  const char *signature;
>     ++  const char *start =3D pos;
>     ++  const char *end =3D pos;
>     ++
>     ++  while ((signature =3D find_commit_multiline_header(start + 1,
>     ++                                                   header,
>     ++                                                   &end))) {
>     ++          string_list_append(signatures, signature)->util =3D (void=
 *)object_hash;
>     ++          free((char *)signature);
>     ++          start =3D end;
>      +  }
>     ++
>     ++  return end;
>      +}
>      +
>       static void handle_commit(struct commit *commit, struct rev_info *r=
ev,
>     @@ builtin/fast-export.c: static void handle_commit(struct commit *co=
mmit, struct r
>         const char *encoding =3D NULL;
>         size_t encoding_len;
>      -  const char *signature_alg =3D NULL, *signature =3D NULL;
>     -+  const char *sig_sha1 =3D NULL;
>     -+  const char *sig_sha256 =3D NULL;
>     ++  struct string_list signatures =3D STRING_LIST_INIT_DUP;
>         const char *message;
>         char *reencoded =3D NULL;
>         struct commit_list *p;
>     @@ builtin/fast-export.c: static void handle_commit(struct commit *co=
mmit, struct r
>      -                  signature_alg =3D "sha1";
>      -          else if ((signature =3D find_commit_multiline_header(comm=
it_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
>      -                  signature_alg =3D "sha256";
>     -+          const char *sig_cursor =3D commit_buffer_cursor;
>     -+          const char *after_sha1 =3D commit_buffer_cursor;
>     -+          const char *after_sha256 =3D commit_buffer_cursor;
>     -+
>     -+          /*
>     -+           * Find the first signature for each hash algorithm.
>     -+           * The searches must start from the same position.
>     -+           */
>     -+          sig_sha1 =3D find_commit_multiline_header(sig_cursor + 1,
>     -+                                                  "gpgsig",
>     -+                                                  &after_sha1);
>     -+          sig_sha256 =3D find_commit_multiline_header(sig_cursor + =
1,
>     -+                                                    "gpgsig-sha256"=
,
>     -+                                                    &after_sha256);
>     -+
>     -+          /* Warn on any additional signatures, as they will be ign=
ored. */
>     -+          if (sig_sha1)
>     -+                  warn_on_extra_sig(&after_sha1, commit, 1);
>     -+          if (sig_sha256)
>     -+                  warn_on_extra_sig(&after_sha256, commit, 0);
>     -+
>     ++          const char *after_sha1 =3D append_signatures_for_header(&=
signatures, commit_buffer_cursor,
>     ++                                                                "gp=
gsig", "sha1");
>     ++          const char *after_sha256 =3D append_signatures_for_header=
(&signatures, commit_buffer_cursor,
>     ++                                                                  "=
gpgsig-sha256", "sha256");
>      +          commit_buffer_cursor =3D (after_sha1 > after_sha256) ? af=
ter_sha1 : after_sha256;
>         }
>
>     @@ builtin/fast-export.c: static void handle_commit(struct commit *co=
mmit, struct r
>                (int)(author_end - author), author,
>                (int)(committer_end - committer), committer);
>      -  if (signature) {
>     -+  if (sig_sha1 || sig_sha256) {
>     ++  if (signatures.nr) {
>                 switch (signed_commit_mode) {
>                 case SIGN_ABORT:
>                         die("encountered signed commit %s; use "
>     -@@ builtin/fast-export.c: static void handle_commit(struct commit *c=
ommit, struct rev_info *rev,
>     -                           oid_to_hex(&commit->object.oid));
>     +                       "--signed-commits=3D<mode> to handle it",
>     +                       oid_to_hex(&commit->object.oid));
>     +           case SIGN_WARN_VERBATIM:
>     +-                  warning("exporting signed commit %s",
>     +-                          oid_to_hex(&commit->object.oid));
>     ++                  warning("exporting %"PRIuMAX" signature(s) for co=
mmit %s",
>     ++                          (uintmax_t)signatures.nr, oid_to_hex(&com=
mit->object.oid));
>                         /* fallthru */
>                 case SIGN_VERBATIM:
>      -                  printf("gpgsig %s\ndata %u\n%s",
>      -                         signature_alg,
>      -                         (unsigned)strlen(signature),
>      -                         signature);
>     -+                  print_signature(sig_sha1, "sha1");
>     -+                  print_signature(sig_sha256, "sha256");
>     ++                  for (size_t i =3D 0; i < signatures.nr; i++) {
>     ++                          struct string_list_item *item =3D &signat=
ures.items[i];
>     ++                          print_signature(item->string, item->util)=
;
>     ++                  }
>                         break;
>                 case SIGN_WARN_STRIP:
>      -                  warning("stripping signature from commit %s",
>     @@ builtin/fast-export.c: static void handle_commit(struct commit *co=
mmit, struct r
>                         break;
>                 }
>      -          free((char *)signature);
>     -+          free((char *)sig_sha1);
>     -+          free((char *)sig_sha256);
>     ++          string_list_clear(&signatures, 0);
>         }
>         if (!reencoded && encoding)
>                 printf("encoding %.*s\n", (int)encoding_len, encoding);
>     @@ builtin/fast-import.c: static struct hash_list *parse_merge(unsign=
ed int *count)
>      +                      const char *hash_type)
>      +{
>      +  if (stored_sig->hash_algo) {
>     -+          warning("Multiple %s signatures found, ignoring additiona=
l signature",
>     ++          warning("multiple %s signatures found, "
>     ++                  "ignoring additional signature",
>      +                  hash_type);
>      +          strbuf_release(&new_sig->data);
>      +          free(new_sig->hash_algo);
>     @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=3D=
abort' '
>
>         git fast-export --signed-commits=3Dverbatim --reencode=3Dno commi=
t-signing >output &&
>      -  grep "^gpgsig sha" output &&
>     -+  test_grep -E "^gpgsig sha(1|256) openpgp" output &&
>     ++  test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         (
>                 cd new &&
>     @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=3D=
verbatim' '
>
>         git fast-export --signed-commits=3Dwarn-verbatim --reencode=3Dno =
commit-signing >output 2>err &&
>      -  grep "^gpgsig sha" output &&
>     -+  test_grep -E "^gpgsig sha(1|256) openpgp" output &&
>     ++  test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         test -s err &&
>         (
>     @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=3D=
warn-strip' '
>      +test_expect_success GPGSM 'round-trip X.509 signed commit' '
>      +
>      +  git fast-export --signed-commits=3Dverbatim x509-signing >output =
&&
>     -+  test_grep -E "^gpgsig sha(1|256) x509" output &&
>     ++  test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
>      +  (
>      +          cd new &&
>      +          git fast-import &&
>     @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=3D=
warn-strip' '
>      +test_expect_success GPGSSH 'round-trip SSH signed commit' '
>      +
>      +  git fast-export --signed-commits=3Dverbatim ssh-signing >output &=
&
>     -+  test_grep -E "^gpgsig sha(1|256) ssh" output &&
>     ++  test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
>      +  (
>      +          cd new &&
>      +          git fast-import &&
>     @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=3D=
warn-strip' '
>       test_expect_success 'setup submodule' '
>
>         test_config_global protocol.file.allow always &&
>     +@@ t/t9350-fast-export.sh: test_expect_success 'fast-export handles =
--end-of-options' '
>     +   test_cmp expect actual
>     + '
>     +
>     ++test_expect_success GPG 'setup a commit with dual signatures on its=
 SHA-1 and SHA-256 formats' '
>     ++  # Create a signed SHA-256 commit
>     ++  git init --object-format=3Dsha256 explicit-sha256 &&
>     ++  git -C explicit-sha256 config extensions.compatObjectFormat sha1 =
&&
>     ++  git -C explicit-sha256 checkout -b dual-signed &&
>     ++  test_commit -C explicit-sha256 A &&
>     ++  echo B >explicit-sha256/B &&
>     ++  git -C explicit-sha256 add B &&
>     ++  test_tick &&
>     ++  git -C explicit-sha256 commit -S -m "signed" B &&
>     ++  SHA256_B=3D$(git -C explicit-sha256 rev-parse dual-signed) &&
>     ++
>     ++  # Create the corresponding SHA-1 commit
>     ++  SHA1_B=3D$(git -C explicit-sha256 rev-parse --output-object-forma=
t=3Dsha1 dual-signed) &&
>     ++
>     ++  # Check that the resulting SHA-1 commit has both signatures
>     ++  echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
>     ++  test_grep -E "^gpgsig " out &&
>     ++  test_grep -E "^gpgsig-sha256 " out
>     ++'
>     ++
>     ++test_expect_success GPG 'export and import of doubly signed commit'=
 '
>     ++  git -C explicit-sha256 fast-export --signed-commits=3Dverbatim du=
al-signed >output &&
>     ++  test_grep -E "^gpgsig sha1 openpgp" output &&
>     ++  test_grep -E "^gpgsig sha256 openpgp" output &&
>     ++
>     ++  (
>     ++          cd new &&
>     ++          git fast-import &&
>     ++          git cat-file commit refs/heads/dual-signed >actual &&
>     ++          test_grep -E "^gpgsig " actual &&
>     ++          test_grep -E "^gpgsig-sha256 " actual &&
>     ++          IMPORTED=3D$(git rev-parse refs/heads/dual-signed) &&
>     ++          if test "$GIT_DEFAULT_HASH" =3D "sha1"
>     ++          then
>     ++                  test $SHA1_B =3D $IMPORTED
>     ++          else
>     ++                  test $SHA256_B =3D $IMPORTED
>     ++          fi
>     ++  ) <output
>     ++'
>     ++
>     + test_done
>
>
>  Documentation/git-fast-export.adoc |  17 +++++
>  Documentation/git-fast-import.adoc |  36 +++++++--
>  builtin/fast-export.c              |  62 +++++++++++----
>  builtin/fast-import.c              | 118 +++++++++++++++++++++++------
>  gpg-interface.c                    |  12 +++
>  gpg-interface.h                    |  12 +++
>  t/t9350-fast-export.sh             | 102 ++++++++++++++++++++++++-
>  7 files changed, 315 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 43bbb4f63c..297b57bb2e 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -50,6 +50,23 @@ resulting tag will have an invalid signature.
>         is the same as how earlier versions of this command without
>         this option behaved.
>  +
> +When exported, a signature starts with:
> ++
> +gpgsig <git-hash-algo> <signature-format>
> ++
> +where <git-hash-algo> is the Git object hash so either "sha1" or
> +"sha256", and <signature-format> is the signature type, so "openpgp",
> +"x509", "ssh" or "unknown".
> ++
> +For example, an OpenPGP signature on a SHA-1 commit starts with
> +`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
> +starts with `gpgsig sha256 ssh`.
> ++
> +While all the signatures of a commit are exported, an importer may
> +choose to accept only some of them. For example
> +linkgit:git-fast-import[1] currently stores at most one signature per
> +Git hash algorithm in each commit.
> ++
>  NOTE: This is highly experimental and the format of the data stream may
>  change in the future without compatibility guarantees.
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 250d866652..89dec1108f 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -445,7 +445,7 @@ one).
>         original-oid?
>         ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>         'committer' (SP <name>)? SP LT <email> GT SP <when> LF
> -       ('gpgsig' SP <alg> LF data)?
> +       ('gpgsig' SP <algo> SP <format> LF data)?
>         ('encoding' SP <encoding> LF)?
>         data
>         ('from' SP <commit-ish> LF)?
> @@ -518,13 +518,37 @@ their syntax.
>  ^^^^^^^^
>
>  The optional `gpgsig` command is used to include a PGP/GPG signature
> -that signs the commit data.
> +or other cryptographic signature that signs the commit data.
>
> -Here <alg> specifies which hashing algorithm is used for this
> -signature, either `sha1` or `sha256`.
> +....
> +       'gpgsig' SP <git-hash-algo> SP <signature-format> LF
> +       data

Should the `data` be moved to the line above, just to make it clear
it's associated with it?  (Similar to the first line you changed in
git-fast-import.adoc?)

> +....
> +
> +The `gpgsig` command takes two arguments:
> +
> +* `<git-hash-algo>` specifies which Git object format this signature
> +  applies to, either `sha1` or `sha256`. This allows to know which
> +  representation of the commit was signed (the SHA-1 or the SHA-256
> +  version) which helps with both signature verification and
> +  interoperability between repos with different hash functions.

Should there also be a note added that fast-import is limited on what
signatures it can verify if extensions.compatObjectFormat is not set?

> +
> +* `<signature-format>` specifies the type of signature, such as
> +  `openpgp`, `x509`, `ssh`, or `unknown`. This is a convenience for
> +  tools that process the stream, so they don't have to parse the ASCII
> +  armor to identify the signature type.
> +
> +A commit may have at most one signature for the SHA-1 object format
> +(stored in the "gpgsig" header) and one for the SHA-256 object format
> +(stored in the "gpgsig-sha256" header).
> +
> +See below for a detailed description of the `data` command which
> +contains the raw signature data.
> +
> +Signatures are not yet checked in the current implementation though.

...or maybe that extra note could be added as a parenthetical comment
here for now?

> -NOTE: This is highly experimental and the format of the data stream may
> -change in the future without compatibility guarantees.
> +NOTE: This is highly experimental and the format of the `gpgsig`
> +command may change in the future without compatibility guarantees.
>
>  `encoding`
>  ^^^^^^^^^^
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index fcf6b00d5f..7b4e6a6e41 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -29,6 +29,7 @@
>  #include "quote.h"
>  #include "remote.h"
>  #include "blob.h"
> +#include "gpg-interface.h"
>
>  static const char *const fast_export_usage[] =3D {
>         N_("git fast-export [<rev-list-opts>]"),
> @@ -652,6 +653,38 @@ static const char *find_commit_multiline_header(cons=
t char *msg,
>         return strbuf_detach(&val, NULL);
>  }
>
> +static void print_signature(const char *signature, const char *object_ha=
sh)
> +{
> +       if (!signature)
> +               return;
> +
> +       printf("gpgsig %s %s\ndata %u\n%s\n",
> +              object_hash,
> +              get_signature_format(signature),
> +              (unsigned)strlen(signature),
> +              signature);
> +}
> +
> +static const char *append_signatures_for_header(struct string_list *sign=
atures,
> +                                               const char *pos,
> +                                               const char *header,
> +                                               const char *object_hash)
> +{
> +       const char *signature;
> +       const char *start =3D pos;
> +       const char *end =3D pos;
> +
> +       while ((signature =3D find_commit_multiline_header(start + 1,
> +                                                        header,
> +                                                        &end))) {
> +               string_list_append(signatures, signature)->util =3D (void=
 *)object_hash;
> +               free((char *)signature);
> +               start =3D end;
> +       }
> +
> +       return end;
> +}
> +
>  static void handle_commit(struct commit *commit, struct rev_info *rev,
>                           struct string_list *paths_of_changed_objects)
>  {
> @@ -660,7 +693,7 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
>         const char *author, *author_end, *committer, *committer_end;
>         const char *encoding =3D NULL;
>         size_t encoding_len;
> -       const char *signature_alg =3D NULL, *signature =3D NULL;
> +       struct string_list signatures =3D STRING_LIST_INIT_DUP;
>         const char *message;
>         char *reencoded =3D NULL;
>         struct commit_list *p;
> @@ -700,10 +733,11 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev,
>         }
>
>         if (*commit_buffer_cursor =3D=3D '\n') {
> -               if ((signature =3D find_commit_multiline_header(commit_bu=
ffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
> -                       signature_alg =3D "sha1";
> -               else if ((signature =3D find_commit_multiline_header(comm=
it_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
> -                       signature_alg =3D "sha256";
> +               const char *after_sha1 =3D append_signatures_for_header(&=
signatures, commit_buffer_cursor,
> +                                                                     "gp=
gsig", "sha1");
> +               const char *after_sha256 =3D append_signatures_for_header=
(&signatures, commit_buffer_cursor,
> +                                                                       "=
gpgsig-sha256", "sha256");
> +               commit_buffer_cursor =3D (after_sha1 > after_sha256) ? af=
ter_sha1 : after_sha256;
>         }
>
>         message =3D strstr(commit_buffer_cursor, "\n\n");
> @@ -769,30 +803,30 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev,
>         printf("%.*s\n%.*s\n",
>                (int)(author_end - author), author,
>                (int)(committer_end - committer), committer);
> -       if (signature) {
> +       if (signatures.nr) {
>                 switch (signed_commit_mode) {
>                 case SIGN_ABORT:
>                         die("encountered signed commit %s; use "
>                             "--signed-commits=3D<mode> to handle it",
>                             oid_to_hex(&commit->object.oid));
>                 case SIGN_WARN_VERBATIM:
> -                       warning("exporting signed commit %s",
> -                               oid_to_hex(&commit->object.oid));
> +                       warning("exporting %"PRIuMAX" signature(s) for co=
mmit %s",
> +                               (uintmax_t)signatures.nr, oid_to_hex(&com=
mit->object.oid));
>                         /* fallthru */
>                 case SIGN_VERBATIM:
> -                       printf("gpgsig %s\ndata %u\n%s",
> -                              signature_alg,
> -                              (unsigned)strlen(signature),
> -                              signature);
> +                       for (size_t i =3D 0; i < signatures.nr; i++) {
> +                               struct string_list_item *item =3D &signat=
ures.items[i];
> +                               print_signature(item->string, item->util)=
;
> +                       }
>                         break;
>                 case SIGN_WARN_STRIP:
> -                       warning("stripping signature from commit %s",
> +                       warning("stripping signature(s) from commit %s",

Nice catch; that's the kind of thing that could be easily overlooked.

>                                 oid_to_hex(&commit->object.oid));
>                         /* fallthru */
>                 case SIGN_STRIP:
>                         break;
>                 }
> -               free((char *)signature);
> +               string_list_clear(&signatures, 0);
>         }
>         if (!reencoded && encoding)
>                 printf("encoding %.*s\n", (int)encoding_len, encoding);
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index b2839c5f43..332073d0f6 100644
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
> @@ -2718,15 +2719,87 @@ static struct hash_list *parse_merge(unsigned int=
 *count)
>         return list;
>  }
>
> +struct signature_data {
> +       char *hash_algo;      /* "sha1" or "sha256" */
> +       char *sig_format;     /* "openpgp", "x509", "ssh", "unknown" */
> +       struct strbuf data;   /* The actual signature data */
> +};
> +
> +static void parse_one_signature(struct signature_data *sig, const char *=
v)
> +{
> +       char *args =3D xstrdup(v); /* Will be freed when sig->hash_algo i=
s freed */
> +       char *space =3D strchr(args, ' ');
> +
> +       if (!space)
> +               die("Expected gpgsig format: 'gpgsig <hash-algo> <signatu=
re-format>', "
> +                   "got 'gpgsig %s'", args);
> +       *space++ =3D '\0';
> +
> +       sig->hash_algo =3D args;
> +       sig->sig_format =3D space;

Really minor nitpick, but it might be clearer to pre-increment space
here than to increment it above.

> +
> +       /* Remove any trailing newline from format */
> +       space =3D strchr(sig->sig_format, '\n');
> +       if (space)
> +               *space =3D '\0';
> +
> +       /* Validate hash algorithm */
> +       if (strcmp(sig->hash_algo, "sha1") &&
> +           strcmp(sig->hash_algo, "sha256"))
> +               die("Unknown git hash algorithm in gpgsig: '%s'", sig->ha=
sh_algo);
> +
> +       /* Validate signature format */
> +       if (!valid_signature_format(sig->sig_format))
> +               die("Invalid signature format in gpgsig: '%s'", sig->sig_=
format);
> +       if (!strcmp(sig->sig_format, "unknown"))
> +               warning("'unknown' signature format in gpgsig");
> +
> +       /* Read signature data */
> +       read_next_command();
> +       parse_data(&sig->data, 0, NULL);
> +}
> +
> +static void add_gpgsig_to_commit(struct strbuf *commit_data,
> +                                const char *header,
> +                                struct signature_data *sig)
> +{
> +       struct string_list siglines =3D STRING_LIST_INIT_NODUP;
> +
> +       if (!sig->hash_algo)
> +               return;
> +
> +       strbuf_addstr(commit_data, header);
> +       string_list_split_in_place(&siglines, sig->data.buf, "\n", -1);
> +       strbuf_add_separated_string_list(commit_data, "\n ", &siglines);
> +       strbuf_addch(commit_data, '\n');
> +       string_list_clear(&siglines, 1);
> +       strbuf_release(&sig->data);
> +       free(sig->hash_algo);
> +}
> +
> +static void store_signature(struct signature_data *stored_sig,
> +                           struct signature_data *new_sig,
> +                           const char *hash_type)
> +{
> +       if (stored_sig->hash_algo) {
> +               warning("multiple %s signatures found, "
> +                       "ignoring additional signature",
> +                       hash_type);
> +               strbuf_release(&new_sig->data);
> +               free(new_sig->hash_algo);
> +       } else {
> +               *stored_sig =3D *new_sig;
> +       }
> +}
> +
>  static void parse_new_commit(const char *arg)
>  {
> -       static struct strbuf sig =3D STRBUF_INIT;
>         static struct strbuf msg =3D STRBUF_INIT;
> -       struct string_list siglines =3D STRING_LIST_INIT_NODUP;
> +       struct signature_data sig_sha1 =3D { NULL, NULL, STRBUF_INIT };
> +       struct signature_data sig_sha256 =3D { NULL, NULL, STRBUF_INIT };
>         struct branch *b;
>         char *author =3D NULL;
>         char *committer =3D NULL;
> -       char *sig_alg =3D NULL;
>         char *encoding =3D NULL;
>         struct hash_list *merge_list =3D NULL;
>         unsigned int merge_count;
> @@ -2750,13 +2823,23 @@ static void parse_new_commit(const char *arg)
>         }
>         if (!committer)
>                 die("Expected committer but didn't get one");
> -       if (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> -               sig_alg =3D xstrdup(v);
> -               read_next_command();
> -               parse_data(&sig, 0, NULL);
> +
> +       /* Process signatures (up to 2: one "sha1" and one "sha256") */
> +       while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> +               struct signature_data sig =3D { NULL, NULL, STRBUF_INIT }=
;
> +
> +               parse_one_signature(&sig, v);
> +
> +               if (!strcmp(sig.hash_algo, "sha1"))
> +                       store_signature(&sig_sha1, &sig, "SHA-1");
> +               else if (!strcmp(sig.hash_algo, "sha256"))
> +                       store_signature(&sig_sha256, &sig, "SHA-256");
> +               else
> +                       BUG("parse_one_signature() returned unknown hash =
algo");
> +
>                 read_next_command();
> -       } else
> -               strbuf_setlen(&sig, 0);
> +       }
> +
>         if (skip_prefix(command_buf.buf, "encoding ", &v)) {
>                 encoding =3D xstrdup(v);
>                 read_next_command();
> @@ -2830,23 +2913,14 @@ static void parse_new_commit(const char *arg)
>                 strbuf_addf(&new_data,
>                         "encoding %s\n",
>                         encoding);
> -       if (sig_alg) {
> -               if (!strcmp(sig_alg, "sha1"))
> -                       strbuf_addstr(&new_data, "gpgsig ");
> -               else if (!strcmp(sig_alg, "sha256"))
> -                       strbuf_addstr(&new_data, "gpgsig-sha256 ");
> -               else
> -                       die("Expected gpgsig algorithm sha1 or sha256, go=
t %s", sig_alg);
> -               string_list_split_in_place(&siglines, sig.buf, "\n", -1);
> -               strbuf_add_separated_string_list(&new_data, "\n ", &sigli=
nes);
> -               strbuf_addch(&new_data, '\n');
> -       }
> +
> +       add_gpgsig_to_commit(&new_data, "gpgsig ", &sig_sha1);
> +       add_gpgsig_to_commit(&new_data, "gpgsig-sha256 ", &sig_sha256);
> +
>         strbuf_addch(&new_data, '\n');
>         strbuf_addbuf(&new_data, &msg);
> -       string_list_clear(&siglines, 1);
>         free(author);
>         free(committer);
> -       free(sig_alg);
>         free(encoding);
>
>         if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark=
))
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0896458de5..6f2d87475f 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -144,6 +144,18 @@ static struct gpg_format *get_format_by_sig(const ch=
ar *sig)
>         return NULL;
>  }
>
> +const char *get_signature_format(const char *buf)
> +{
> +       struct gpg_format *format =3D get_format_by_sig(buf);
> +       return format ? format->name : "unknown";
> +}
> +
> +int valid_signature_format(const char *format)
> +{
> +       return (!!get_format_by_name(format) ||
> +              !strcmp(format, "unknown"));
> +}
> +
>  void signature_check_clear(struct signature_check *sigc)
>  {
>         FREE_AND_NULL(sigc->payload);
> diff --git a/gpg-interface.h b/gpg-interface.h
> index e09f12e8d0..60ddf8bbfa 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -47,6 +47,18 @@ struct signature_check {
>
>  void signature_check_clear(struct signature_check *sigc);
>
> +/*
> + * Return the format of the signature (like "openpgp", "x509", "ssh"
> + * or "unknown").
> + */
> +const char *get_signature_format(const char *buf);
> +
> +/*
> + * Is the signature format valid (like "openpgp", "x509", "ssh" or
> + * "unknown")
> + */
> +int valid_signature_format(const char *format);
> +
>  /*
>   * Look at a GPG signed tag object.  If such a signature exists, store i=
t in
>   * signature and the signed content in payload.  Return 1 if a signature=
 was
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 76619765fc..46700dbc40 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -314,7 +314,7 @@ test_expect_success GPG 'signed-commits=3Dabort' '
>  test_expect_success GPG 'signed-commits=3Dverbatim' '
>
>         git fast-export --signed-commits=3Dverbatim --reencode=3Dno commi=
t-signing >output &&
> -       grep "^gpgsig sha" output &&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         (
>                 cd new &&
> @@ -328,7 +328,7 @@ test_expect_success GPG 'signed-commits=3Dverbatim' '
>  test_expect_success GPG 'signed-commits=3Dwarn-verbatim' '
>
>         git fast-export --signed-commits=3Dwarn-verbatim --reencode=3Dno =
commit-signing >output 2>err &&
> -       grep "^gpgsig sha" output &&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
>         grep "encoding ISO-8859-1" output &&
>         test -s err &&
>         (
> @@ -369,6 +369,62 @@ test_expect_success GPG 'signed-commits=3Dwarn-strip=
' '
>
>  '
>
> +test_expect_success GPGSM 'setup X.509 signed commit' '
> +
> +       git checkout -b x509-signing main &&
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +       echo "X.509 content" >file &&
> +       git add file &&
> +       git commit -S -m "X.509 signed commit" &&
> +       X509_COMMIT=3D$(git rev-parse HEAD) &&
> +       git checkout main
> +
> +'
> +
> +test_expect_success GPGSM 'round-trip X.509 signed commit' '
> +
> +       git fast-export --signed-commits=3Dverbatim x509-signing >output =
&&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               git cat-file commit refs/heads/x509-signing >actual &&
> +               grep "^gpgsig" actual &&
> +               IMPORTED=3D$(git rev-parse refs/heads/x509-signing) &&
> +               test $X509_COMMIT =3D $IMPORTED
> +       ) <output
> +
> +'
> +
> +test_expect_success GPGSSH 'setup SSH signed commit' '
> +
> +       git checkout -b ssh-signing main &&
> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
> +       echo "SSH content" >file &&
> +       git add file &&
> +       git commit -S -m "SSH signed commit" &&
> +       SSH_COMMIT=3D$(git rev-parse HEAD) &&
> +       git checkout main
> +
> +'
> +
> +test_expect_success GPGSSH 'round-trip SSH signed commit' '
> +
> +       git fast-export --signed-commits=3Dverbatim ssh-signing >output &=
&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               git cat-file commit refs/heads/ssh-signing >actual &&
> +               grep "^gpgsig" actual &&
> +               IMPORTED=3D$(git rev-parse refs/heads/ssh-signing) &&
> +               test $SSH_COMMIT =3D $IMPORTED
> +       ) <output
> +
> +'
> +
>  test_expect_success 'setup submodule' '
>
>         test_config_global protocol.file.allow always &&
> @@ -905,4 +961,46 @@ test_expect_success 'fast-export handles --end-of-op=
tions' '
>         test_cmp expect actual
>  '
>
> +test_expect_success GPG 'setup a commit with dual signatures on its SHA-=
1 and SHA-256 formats' '
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
> +       echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
> +       test_grep -E "^gpgsig " out &&
> +       test_grep -E "^gpgsig-sha256 " out
> +'
> +
> +test_expect_success GPG 'export and import of doubly signed commit' '
> +       git -C explicit-sha256 fast-export --signed-commits=3Dverbatim du=
al-signed >output &&
> +       test_grep -E "^gpgsig sha1 openpgp" output &&
> +       test_grep -E "^gpgsig sha256 openpgp" output &&
> +
> +       (
> +               cd new &&
> +               git fast-import &&
> +               git cat-file commit refs/heads/dual-signed >actual &&
> +               test_grep -E "^gpgsig " actual &&
> +               test_grep -E "^gpgsig-sha256 " actual &&
> +               IMPORTED=3D$(git rev-parse refs/heads/dual-signed) &&
> +               if test "$GIT_DEFAULT_HASH" =3D "sha1"
> +               then
> +                       test $SHA1_B =3D $IMPORTED
> +               else
> +                       test $SHA256_B =3D $IMPORTED
> +               fi
> +       ) <output

This last bit seems a bit fragile; could the redirection of output to
the stdin of `git fast-import` be made specific to that one line
instead of to the whole range of commands?

Otherwise, I very much appreciate the work to create a testcase with
both signature types on a single commit.
