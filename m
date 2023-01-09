Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83682C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjAIJrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjAIJqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:46:45 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A54A45D
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 01:45:41 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c15c4fc8ccso106008197b3.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vnIpXCmgBBJ2D5VvsD8auB85zofY3ZQHx1voR60PSWs=;
        b=aC6LuH5vB/OiKgwr6a/XiRQZOXkjOz9DFHf5TtQHDxAk9vpE0bIJTLrz3huV/3YIOv
         sU6qMHbJx6JsQCleRdXNhWg1WX5i+BmQsSOsPyCJHr260Fye3M+kNYb177PY1s8rcgyB
         Ly1VVNXaA/PSTs/D5yKhJqA18fg9lfysEUPFc3/bcROe6/MIY8QnmRHoLCW40twmKY+y
         0bYGDEkMzf9hEjU4Fml2pn8r9ZCOhmvaVWOCHUqgeh9nnx+x7ng5CznCR0bfH5l5y9hS
         H4cQ0ZlTaW2CldZFourNj2gMInUpqzcHJ8Vd0KqBDhmxA3Spxgda8jwaIAK5ius563or
         8sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnIpXCmgBBJ2D5VvsD8auB85zofY3ZQHx1voR60PSWs=;
        b=j02MuQKwK/Wd6l4i5SG197MxCOw61yP5opmIqHAs/QsQhRr3LMklSB3UPBljeQzHpc
         TPwDf7E7EUjMeiCNCibALOkSR6977Uf/ndL0nqP9G4pB2VBFlDy86u7xBDPUswd2L5kB
         h20M2yW0gx5ZF/+xwLNpTW0/cKbAJhm1vVT1cAOTSN/i/a08POhCMZhJakcAh+6BHaX6
         W+j6RvQTHHTDpFwlmN+RlqW5xrqBl3IIayR3Odap4J2HdCkIaJCU5v1mOCFLIiEPzEct
         85dGf0hp/5KrvNw6p+2+ldH5VdGOA1+5lZOlgS0yS0+viqcEtQ2Htf4J4XfxqSEIbONK
         9sUQ==
X-Gm-Message-State: AFqh2krZDVYmlPsNfEnD7F5jAXmEoJqQIqzHacoLSWHmMdDhm4AeiOsu
        2SMrZ98V1Rqyd3cMI5AwLcNSAiuT5Ox25KDKZjVX+JUbnsM=
X-Google-Smtp-Source: AMrXdXvnwR7156sei15+5bx3HUThVxD1BbvboGt8Q9sfA4+WmOLHkfjA5VsPTU+xg1CMiYtppR2EYp4Q0ozQOybu7ec=
X-Received: by 2002:a81:9210:0:b0:4cf:a828:4018 with SMTP id
 j16-20020a819210000000b004cfa8284018mr123829ywg.157.1673257540858; Mon, 09
 Jan 2023 01:45:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1428.git.git.1673254961028.gitgitgadget@gmail.com>
In-Reply-To: <pull.1428.git.git.1673254961028.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Jan 2023 10:45:29 +0100
Message-ID: <CAP8UFD3cTnesN5SMcDjT3K2tpBOc82+aP=wr+DVzO3GomqwhRA@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
To:     nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 10:15 AM nsengaw4c via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>

This patch should be marked as a V2 in its subject:

[PATCH v2] ref-filter: add new atom "signature" atom

not sure how to do that using GitGitGadget though.

Also "atom" appears twice in the subject, so the following would be even better:

[PATCH v2] ref-filter: add new "signature" atom

I am not sure how, but GitGitGadget should allow to set the
"In-Reply-To:" to the message ID of your previous version of this
patch, so that your email with the version 2 of the patch would appear
in the same email thread as the email of your previous version of this
patch on lore.kernel.org/git:

https://lore.kernel.org/git/pull.1452.git.1672102523902.gitgitgadget@gmail.com/

(Please don't resend this patch as a v2, but as a v3, if you make any change.)

> This commit duplicates the code for `signature` atom from pretty.c
> to ref-filter.c. This feature will help to get rid of current duplicate
> implementation of `signature` atom when unifying implemenations by

s/implemenations/implementations/

> using ref-filter logic everywhere when ref-filter can do everything
> pretty is doing.
>
> Add "signature" atom with `grade`, `signer`, `key`,
> `fingerprint`, `primarykeyfingerprint`, `trustlevel` as arguments.
> This code and its documentation are inspired by how the %GG, %G?,
> %GS, %GK, %GF, %GP, and %GT pretty formats were implemented.
>
> Co-authored-by: Hariom Verma <hariom18599@gmail.com>
> Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
> ---
>     ref-filter: add new atom "signature" atom
>
>     This commit duplicates the code for signature atom from pretty.c to
>     ref-filter.c. This feature will help to get rid of current duplicate
>     implementation of signature atom when unifying implemenations by using

s/implemenations/implementations/

>     ref-filter logic everywhere when ref-filter can do everything pretty is
>     doing.
>
>     Add "signature" atom with grade, signer, key, fingerprint,
>     primarykeyfingerprint, trustlevel as arguments. This code and its
>     documentation are inspired by how the %GG, %G?, %GS, %GK, %GF, %GP, and
>     %GT pretty formats were implemented.
>
>     Co-authored-by: Hariom Verma hariom18599@gmail.com Co-authored-by:
>     Jaydeep Das jaydeepjd.8914@gmail.com Mentored-by: Christian Couder
>     chriscool@tuxfamily.org Mentored-by: Hariom Verma hariom18599@gmail.com
>     Signed-off-by: Nsengiyumva Wilberforce nsengiyumvawilberforce@gmail.com

Not sure you can do something about it, but the above lines aren't
properly wrapped.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1428%2Fnsengiyumva-wilberforce%2Fsignature10-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1428/nsengiyumva-wilberforce/signature10-v1
> Pull-Request: https://github.com/git/git/pull/1428
>
>  Documentation/git-for-each-ref.txt |  27 ++++++
>  ref-filter.c                       | 101 +++++++++++++++++++++++
>  t/t6300-for-each-ref.sh            | 127 +++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6da899c6296..9a0be85368b 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -212,6 +212,33 @@ symref::
>         `:lstrip` and `:rstrip` options in the same way as `refname`
>         above.
>
> +signature::
> +       The GPG signature of a commit.
> +
> +signature:grade::
> +       Show "G" for a good (valid) signature, "B" for a bad
> +       signature, "U" for a good signature with unknown validity, "X"
> +       for a good signature that has expired, "Y" for a good
> +       signature made by an expired key, "R" for a good signature
> +       made by a revoked key, "E" if the signature cannot be
> +       checked (e.g. missing key) and "N" for no signature.
> +
> +signature:signer::
> +       The signer of the GPG signature of a commit.
> +
> +signature:key::
> +       The key of the GPG signature of a commit.
> +
> +signature:fingerprint::
> +       The fingerprint of the GPG signature of a commit.
> +
> +signature:primarykeyfingerprint::
> +       The Primary Key fingerprint of the GPG signature of a commit.
> +
> +signature:trustlevel::
> +       The Trust level of the GPG signature of a commit. Possible
> +       outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
> +
>  worktreepath::
>         The absolute path to the worktree in which the ref is checked
>         out, if it is checked out in any linked worktree. Empty string
> diff --git a/ref-filter.c b/ref-filter.c
> index a24324123e7..0cba756b186 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -144,6 +144,7 @@ enum atom_type {
>         ATOM_BODY,
>         ATOM_TRAILERS,
>         ATOM_CONTENTS,
> +       ATOM_SIGNATURE,
>         ATOM_RAW,
>         ATOM_UPSTREAM,
>         ATOM_PUSH,
> @@ -208,6 +209,10 @@ static struct used_atom {
>                 struct email_option {
>                         enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
>                 } email_option;
> +               struct {
> +                       enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
> +                              S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL} option;
> +               } signature;
>                 struct refname_atom refname;
>                 char *head;
>         } u;
> @@ -394,6 +399,34 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
>         return 0;
>  }
>
> +static int parse_signature_option(const char *arg)
> +{
> +       if (!arg)
> +               return S_BARE;
> +       else if (!strcmp(arg, "signer"))
> +               return S_SIGNER;
> +       else if (!strcmp(arg, "grade"))
> +               return S_GRADE;
> +       else if (!strcmp(arg, "key"))
> +               return S_KEY;
> +       else if (!strcmp(arg, "fingerprint"))
> +               return S_FINGERPRINT;
> +       else if (!strcmp(arg, "primarykeyfingerprint"))
> +               return S_PRI_KEY_FP;
> +       else if (!strcmp(arg, "trustlevel"))
> +               return S_TRUST_LEVEL;
> +       return -1;
> +}
> +
> +static int signature_atom_parser(struct ref_format *format UNUSED, struct used_atom *atom,
> +                              const char *arg, struct strbuf *err){
> +       int opt = parse_signature_option(arg);
> +       if (opt < 0)
> +               return err_bad_arg(err, "signature", arg);
> +       atom->u.signature.option = opt;
> +       return 0;
> +}
> +
>  static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
>                                 const char *arg, struct strbuf *err)
>  {
> @@ -631,6 +664,7 @@ static struct {
>         [ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
>         [ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
>         [ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
> +       [ATOM_SIGNATURE] = { "signature", SOURCE_OBJ, FIELD_STR, signature_atom_parser },
>         [ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
>         [ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
>         [ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
> @@ -1362,6 +1396,72 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
>         }
>  }
>
> +static void grab_signature(struct atom_value *val, int deref, struct object *obj)
> +{
> +       int i;
> +       struct commit *commit = (struct commit *) obj;
> +       struct signature_check sigc = { 0 };
> +
> +       check_commit_signature(commit, &sigc);
> +
> +       for (i = 0; i < used_atom_cnt; i++) {
> +               struct used_atom *atom = &used_atom[i];
> +               const char *name = atom->name;
> +               struct atom_value *v = &val[i];
> +
> +               if (!!deref != (*name == '*'))
> +                       continue;
> +               if (deref)
> +                       name++;
> +
> +               if (!skip_prefix(name, "signature", &name) || (*name &&
> +                       *name != ':'))
> +                       continue;
> +               if (!*name)
> +                       name = NULL;
> +               else
> +                       name++;
> +               if (parse_signature_option(name) < 0)
> +                       continue;
> +
> +               if (atom->u.signature.option == S_BARE)
> +                       v->s = xstrdup(sigc.output ? sigc.output: "");
> +               else if (atom->u.signature.option == S_SIGNER)
> +                       v->s = xstrdup(sigc.signer ? sigc.signer : "");
> +               else if (atom->u.signature.option == S_GRADE) {
> +                       switch (sigc.result) {
> +                       case 'G':
> +                               switch (sigc.trust_level) {
> +                               case TRUST_UNDEFINED:
> +                               case TRUST_NEVER:
> +                                       v->s = xstrfmt("%c", (char)'U');
> +                                       break;
> +                               default:
> +                                       v->s = xstrfmt("%c", (char)'G');
> +                                       break;
> +                               }
> +                               break;
> +                       case 'B':
> +                       case 'E':
> +                       case 'N':
> +                       case 'X':
> +                       case 'Y':
> +                       case 'R':
> +                               v->s = xstrfmt("%c", (char)sigc.result);
> +                       }
> +               }
> +               else if (atom->u.signature.option == S_KEY)
> +                       v->s = xstrdup(sigc.key ? sigc.key : "");
> +               else if (atom->u.signature.option == S_FINGERPRINT)
> +                       v->s = xstrdup(sigc.fingerprint ? sigc.fingerprint : "");
> +               else if (atom->u.signature.option == S_PRI_KEY_FP)
> +                       v->s = xstrdup(sigc.primary_key_fingerprint ? sigc.primary_key_fingerprint : "");
> +               else if (atom->u.signature.option == S_TRUST_LEVEL)
> +                       v->s = xstrdup(gpg_trust_level_to_str(sigc.trust_level));
> +       }
> +       signature_check_clear(&sigc);
> +}
> +
>  static void find_subpos(const char *buf,
>                         const char **sub, size_t *sublen,
>                         const char **body, size_t *bodylen,
> @@ -1555,6 +1655,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
>                 grab_sub_body_contents(val, deref, data);
>                 grab_person("author", val, deref, buf);
>                 grab_person("committer", val, deref, buf);
> +               grab_signature(val, deref, obj);
>                 break;
>         case OBJ_TREE:
>                 /* grab_tree_values(val, deref, obj, buf, sz); */
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2ae1fc721b1..a8efe6f58ec 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -6,6 +6,7 @@
>  test_description='for-each-ref test'
>
>  . ./test-lib.sh
> +GNUPGHOME_NOT_USED=$GNUPGHOME
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
> @@ -1464,4 +1465,130 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
>  sig_crlf=${sig_crlf%dummy}
>  test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
>
> +GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
> +TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
> +
> +test_expect_success GPG 'test bare signature atom' '
> +       git checkout -b signed &&
> +       echo 1 >file && git add file &&
> +       test_tick && git commit -S -m initial &&
> +       git verify-commit signed 2>out &&
> +       head -3 out >expected &&
> +       tail -1 out >>expected &&
> +       echo >>expected &&
> +       git for-each-ref refs/heads/signed --format="%(signature)" >actual &&
> +       test_cmp actual expected
> +'

(I already commented about this test in a previous email related to
how it fails on GitHub CI.)
