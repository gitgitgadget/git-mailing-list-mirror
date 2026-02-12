Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F6261B92
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934826; cv=pass; b=PGSVCIvwm2LW7QwSAGZdeQDf1PfsviLkhFf/ftRXBW8ovCa8peB59OdVDol/SaIaK39gSrUwNZM1yGH22E5K6/hLrAPoraPQV7yiLlosZgwCmtRHK3Kikb6Ii26NQf5qTlhjwfNxdQ2gC/bi1F29z4qcP7vdnbSDuqHGpl6VkGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934826; c=relaxed/simple;
	bh=BMLYaH1c2DlkogGMYSHYMJF1//mPfCxw7SiF7G7Egkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIJzukB7KeaWoRGt0tCTMwqx0xAMnLNK/NKCYCp3Yf6u4VP2qCR9b5GRYQHNFW6ZHybXzPwuDIVCTFWWtLJcZTro02DvcfvEkuXog3FrrfZecQO9YMFwYma+tWKuVhd9SS0j0oSYyl7k7ErPztY/bHbkDXTXlX1/iq7z9eSqQ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQvWF3vQ; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQvWF3vQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso84114a12.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770934824; cv=none;
        d=google.com; s=arc-20240605;
        b=HZ7LLOkIRpnyk71zPWn46Uts++91YOuA+NZPU0fFNIcuVo1+DTpsuOIR5z4ALdsNzi
         T1ZPER/jeV/3/YyIqhpZ/Yiz1XisxRGFh5ouLf16P2XW9ag6X0wjKxyhmt0IkA64VSWr
         bAH2tqbxG1WZPIe4zXAS/3dxjPseqdFydab7IDXd+15L2+cWDCipiRmPE8i8l7AiFzOm
         +5Te6s1DLwuhf0fT6dsAFR8Oo2IT4wEW5P6xg3jNOpQwu6pHx7ZXQtxfV2IeWIIB2FhJ
         +OUHKLeftrtS2S3tDip7eQp6cvh2TtKvuiViz7lrw7n7YtWQVB2d61JNGlhjavZW30XP
         OhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bHCh26Q8yvuoawjPSIkf4THXgiV6vJne+0w9Zgr/5o=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=a3+Gb9Mfw1YlXBPk9YuZd6n6HpT+sj82Q04YAZPtncExcZnXr/VAr+vBQLsWFPrQK5
         Ni9flfEcdlph1C6J5Yqf0a2n43pwlGiU9GKHTsTmnuT0Hpe2DesdQBVTK4wzuSE7B79e
         JQV6v/DOIEul+PWU8hhtTHzSyLsbteNnAGZBQ8j7dYEGK20rSNKh0taE1PixqZtoGxAp
         VV+0MqY+rcMjdV+h41hiQvawP0u05PJZUryBIKws/jrgmDSX4fYtSlct77aAA3Rgklrp
         VnHA0QyqRyl8bEdbBPj5THK1KkJN3EJnVL2VzUS0Dv/W21qagdJYhJZcNxDDV0o7Ikoa
         25eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770934824; x=1771539624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bHCh26Q8yvuoawjPSIkf4THXgiV6vJne+0w9Zgr/5o=;
        b=SQvWF3vQYdpna1zhX8rVUXaL8XKLM8Gz+DvYsXrFPyGcY70Il01bzM5yO8vgDYY+Pc
         FL5LoRrnYttFAPzfqy47rQwDzEXis6lpz7Zbmuj2wK4W990eeb3zVAFMw7tBa5j+dpto
         YXB3sK1PPfb6vCpE7SKyoh6UaFI7yMJ+BXqFpAOj9KVDnlY/BNIuEAulhE23HyhEUuCX
         2+vpE10UfMIHZgZ/kA/YfqMzvXpfC/drE/Ysr4z80KoqHJwCLGxBbZPNsWjhR0sJrR5E
         R/zfMpXxqPYLAcdFAMgpju24DcRdu8tXcReNPIn3yG2EjP7q0thDsmI/iAWfhqicBYp7
         +uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770934824; x=1771539624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bHCh26Q8yvuoawjPSIkf4THXgiV6vJne+0w9Zgr/5o=;
        b=FUMYilVhszSvcGH2ZKZhUpq76aw0kXeO3dhN8IwcN1cGRkXyU6Ap6qurPEvw+63UYk
         7kPdpgh/n2Chr8veNEXmM3nd0o98k9v2897krDSK0eLOMvM+lnfjFG7Y7MkHIW6Pskme
         bwi8xdCUGg8Y+u+WQt+xFh73DqTWK2o2I9XBa52OWsdre0Sl98k0mRfPSTNYyQbywVVE
         xtejRCUkEAsRAqEk5mjMgMtdw7m2/7VNCwYbRJoLfTk+P3/lorQIlQBozbVA3mLDffjV
         Bm4/BTErxyIuB4N1+BBA03J9X8dnZd33UuF8+TRH6R1AfpRozU4465u1SpUM26ZutPaP
         2lgw==
X-Gm-Message-State: AOJu0YygZhpJfqQlo4Kod3vmokTj1++3r+J2+QHqDQ4aoCWjkl1SLTzV
	jHoDcQDUrlcxDco6+aqeln6WCaF5uIiSOaQA6O1ManxsT1VvGie20hglGsgW4wg5ZoEC8f7ITds
	8KpZcrkWF4jw4DKfBof1OKPmxBVm8El5Hlg==
X-Gm-Gg: AZuq6aKGU4wON1uXxppQXRfQm1/DN8f8ghcc1ifR4y6kDwM0zVwJrRhHFRDisirLLQo
	PpQkYUKa60JwDBfj0R3FmMH+wSJRhwx3kmfYvT+y9v6V4KAzybFW9tnnpQfbu/bziKzLivB7442
	TvXdH6o5qQuPR7aOV2+MlzT4MuhNu0vi9Mr6P1oKxyAUQY7pClUgFrRywmeLXrbROvvLS9ynG0N
	ib/uuCUWCg8xQvZoI7aGWKd4lRPoDvG3Y206tCusT8aLt2HZ3/XXK7B6Sliwv2i1NOxC5JJAq7d
	Rclb4oCtaCNIUSPw4DQ/OOFuk5Trv+dxil+auvHVbH2HQYi2ZbQS1UTRgx5H/MP+aaPOlPfQM4G
	dl3Fm
X-Received: by 2002:a17:902:e74b:b0:2aa:e6c8:2c6e with SMTP id
 d9443c01a7336-2ab4d042c92mr4458355ad.56.1770934824098; Thu, 12 Feb 2026
 14:20:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im> <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 12 Feb 2026 17:20:13 -0500
X-Gm-Features: AZwV_Qgxb-5HkWksaeMOGDHWI1VpSWCeKH7l6f9EoE0g4T29ZJ24Ucf091FiWQ0
Message-ID: <CALnO6CBterXWjecpRG7jTc4PaHDJLuY_FyrA0URC0TXBWSXgHQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] builtin/history: replace "--ref-action=print" with "--dry-run"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The git-history(1) command has the ability to perform a dry-run
> that will not end up modifying any references. Instead, we'll only print
> any ref updates that would happen as a consequence of performing the
> operation.
>
> This mode is somewhat hidden though behind the "--ref-action=3Dprint"
> option. This command line option has its origin in git-replay(1), where
> it's probably an okayish interface as this command is sitting more on
> the plumbing side of tools. But git-history(1) is a user-facing tool,
> and this way of achieving a dry-run is way too technical and thus not
> very discoverable.
>
> Besides usability issues, it also has another issue: the dry-run mode
> will always operate as if the user wanted to rewrite all branches. But
> in fact, the user also has the option to only update the HEAD reference,
> and they might want to perform a dry-run of such an operation, too. We
> could of course introduce "--ref-actoin=3Dprint-head", but that would
> become even less ergonomic.
>
> Replace "--ref-action=3Dprint" with a new "--dry-run" toggle. This new
> toggle works with both "--ref-action=3D{head,branches}" and is way more
> discoverable.
>
> Add a test to verify that both "--ref-action=3D" values behave as
> expected.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  12 ++--
>  builtin/history.c              | 150 ++++++++++++++++++++++-------------=
------
>  t/t3451-history-reword.sh      |  12 +++-
>  3 files changed, 96 insertions(+), 78 deletions(-)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index 154e262b76..33353815cb 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
>  SYNOPSIS
>  --------
>  [synopsis]
> -git history reword <commit> [--ref-action=3D(branches|head|print)]
> +git history reword <commit> [--dry-run] [--ref-action=3D(branches|head)]
>
>  DESCRIPTION
>  -----------
> @@ -60,13 +60,15 @@ The following commands are available to rewrite histo=
ry in different ways:
>  OPTIONS
>  -------
>
> -`--ref-action=3D(branches|head|print)`::
> +`--dry-run`::
> +       Do not update any references, but instead print any ref updates i=
n a
> +       format that can be consumed by linkgit:git-update-ref[1].
> +
> +`--ref-action=3D(branches|head)`::
>         Control which references will be updated by the command, if any. =
With
>         `branches`, all local branches that point to commits which are
>         descendants of the original commit will be rewritten. With `head`=
, only
> -       the current `HEAD` reference will be rewritten. With `print`, all
> -       updates as they would be performed with `branches` are printed in=
 a
> -       format that can be consumed by linkgit:git-update-ref[1].
> +       the current `HEAD` reference will be rewritten.

Unrelated to this series, I've just realized I can't tell from these
docs what the default --ref-action is. The code says "branches."

>
>  GIT
>  ---
> diff --git a/builtin/history.c b/builtin/history.c
> index ca0cdb6a58..40e2925cea 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -18,7 +18,7 @@
>  #include "wt-status.h"
>
>  #define GIT_HISTORY_REWORD_USAGE \
> -       N_("git history reword <commit> [--ref-action=3D(branches|head|pr=
int)]")
> +       N_("git history reword <commit> [--dry-run] [--ref-action=3D(bran=
ches|head)]")
>
>  static void change_data_free(void *util, const char *str UNUSED)
>  {
> @@ -155,7 +155,6 @@ enum ref_action {
>         REF_ACTION_DEFAULT,
>         REF_ACTION_BRANCHES,
>         REF_ACTION_HEAD,
> -       REF_ACTION_PRINT,
>  };
>
>  static int parse_ref_action(const struct option *opt, const char *value,=
 int unset)
> @@ -167,10 +166,8 @@ static int parse_ref_action(const struct option *opt=
, const char *value, int uns
>                 *action =3D REF_ACTION_BRANCHES;
>         } else if (!strcmp(value, "head")) {
>                 *action =3D REF_ACTION_HEAD;
> -       } else if (!strcmp(value, "print")) {
> -               *action =3D REF_ACTION_PRINT;
>         } else {
> -               return error(_("%s expects one of 'branches', 'head' or '=
print'"),
> +               return error(_("%s expects one of 'branches' or 'head'"),
>                              opt->long_name);
>         }
>
> @@ -287,11 +284,29 @@ static int setup_revwalk(struct repository *repo,
>         return ret;
>  }
>
> +static int handle_ref_update(struct ref_transaction *transaction,
> +                            const char *refname,
> +                            const struct object_id *new_oid,
> +                            const struct object_id *old_oid,
> +                            const char *reflog_msg,
> +                            struct strbuf *err)
> +{
> +       if (!transaction) {
> +               printf("update %s %s %s\n",
> +                      refname, oid_to_hex(new_oid), oid_to_hex(old_oid))=
;
> +               return 0;
> +       }
> +
> +       return ref_transaction_update(transaction, refname, new_oid, old_=
oid,
> +                                     NULL, NULL, 0, reflog_msg, err);
> +}
> +
>  static int handle_reference_updates(struct rev_info *revs,
>                                     enum ref_action action,
>                                     struct commit *original,
>                                     struct commit *rewritten,
> -                                   const char *reflog_msg)
> +                                   const char *reflog_msg,
> +                                   int dry_run)
>  {
>         const struct name_decoration *decoration;
>         struct replay_revisions_options opts =3D { 0 };
> @@ -313,82 +328,72 @@ static int handle_reference_updates(struct rev_info=
 *revs,
>         if (ret)
>                 goto out;
>
> -       switch (action) {
> -       case REF_ACTION_BRANCHES:
> -       case REF_ACTION_HEAD:
> +       if (action !=3D REF_ACTION_BRANCHES && action !=3D REF_ACTION_HEA=
D)
> +               BUG("unsupported ref action %d", action);
> +
> +       if (!dry_run) {
>                 transaction =3D ref_store_transaction_begin(get_main_ref_=
store(revs->repo), 0, &err);
>                 if (!transaction) {
>                         ret =3D error(_("failed to begin ref transaction:=
 %s"), err.buf);
>                         goto out;
>                 }
> +       }

It took me longer than I'd like to admit to realize that only
initializing the transaction this way is safe, because we change the
handler below:

>
> -               for (size_t i =3D 0; i < result.updates_nr; i++) {
> -                       ret =3D ref_transaction_update(transaction,
> -                                                    result.updates[i].re=
fname,
> -                                                    &result.updates[i].n=
ew_oid,
> -                                                    &result.updates[i].o=
ld_oid,
> -                                                    NULL, NULL, 0, reflo=
g_msg, &err);
> -                       if (ret) {
> -                               ret =3D error(_("failed to update ref '%s=
': %s"),
> -                                           result.updates[i].refname, er=
r.buf);
> -                               goto out;
> -                       }
> +       for (size_t i =3D 0; i < result.updates_nr; i++) {
> +               ret =3D handle_ref_update(transaction,
> +                                       result.updates[i].refname,
> +                                       &result.updates[i].new_oid,
> +                                       &result.updates[i].old_oid,
> +                                       reflog_msg, &err);
> +               if (ret) {
> +                       ret =3D error(_("failed to update ref '%s': %s"),
> +                                   result.updates[i].refname, err.buf);
> +                       goto out;
>                 }
> +       }

To use our new "NULL-safe transaction update" function. Phew. Using
"-b" with git-diff/show/etc. helps quite a bit.

> +
> +       /*
> +        * `replay_revisions()` only updates references that are
> +        * ancestors of `rewritten`, so we need to manually
> +        * handle updating references that point to `original`.
> +        */
> +       for (decoration =3D get_name_decoration(&original->object);
> +            decoration;
> +            decoration =3D decoration->next)
> +       {
> +               if (decoration->type !=3D DECORATION_REF_LOCAL &&
> +                   decoration->type !=3D DECORATION_REF_HEAD)
> +                       continue;
> +
> +               if (action =3D=3D REF_ACTION_HEAD &&
> +                   decoration->type !=3D DECORATION_REF_HEAD)
> +                       continue;
>
>                 /*
> -                * `replay_revisions()` only updates references that are
> -                * ancestors of `rewritten`, so we need to manually
> -                * handle updating references that point to `original`.
> +                * We only need to update HEAD separately in case it's
> +                * detached. If it's not we'd already update the branch
> +                * it is pointing to.
>                  */
> -               for (decoration =3D get_name_decoration(&original->object=
);
> -                    decoration;
> -                    decoration =3D decoration->next)
> -               {
> -                       if (decoration->type !=3D DECORATION_REF_LOCAL &&
> -                           decoration->type !=3D DECORATION_REF_HEAD)
> -                               continue;
> -
> -                       if (action =3D=3D REF_ACTION_HEAD &&
> -                           decoration->type !=3D DECORATION_REF_HEAD)
> -                               continue;
> -
> -                       /*
> -                        * We only need to update HEAD separately in case=
 it's
> -                        * detached. If it's not we'd already update the =
branch
> -                        * it is pointing to.
> -                        */
> -                       if (action =3D=3D REF_ACTION_BRANCHES &&
> -                           decoration->type =3D=3D DECORATION_REF_HEAD &=
&
> -                           !detached_head)
> -                               continue;
> -
> -                       ret =3D ref_transaction_update(transaction,
> -                                                    decoration->name,
> -                                                    &rewritten->object.o=
id,
> -                                                    &original->object.oi=
d,
> -                                                    NULL, NULL, 0, reflo=
g_msg, &err);
> -                       if (ret) {
> -                               ret =3D error(_("failed to update ref '%s=
': %s"),
> -                                           decoration->name, err.buf);
> -                               goto out;
> -                       }
> -               }
> -
> -               if (ref_transaction_commit(transaction, &err)) {
> -                       ret =3D error(_("failed to commit ref transaction=
: %s"), err.buf);
> +               if (action =3D=3D REF_ACTION_BRANCHES &&
> +                   decoration->type =3D=3D DECORATION_REF_HEAD &&
> +                   !detached_head)
> +                       continue;
> +
> +               ret =3D handle_ref_update(transaction,
> +                                       decoration->name,
> +                                       &rewritten->object.oid,
> +                                       &original->object.oid,
> +                                       reflog_msg, &err);
> +               if (ret) {
> +                       ret =3D error(_("failed to update ref '%s': %s"),
> +                                   decoration->name, err.buf);
>                         goto out;
>                 }
> +       }
>
> -               break;
> -       case REF_ACTION_PRINT:
> -               for (size_t i =3D 0; i < result.updates_nr; i++)
> -                       printf("update %s %s %s\n",
> -                              result.updates[i].refname,
> -                              oid_to_hex(&result.updates[i].new_oid),
> -                              oid_to_hex(&result.updates[i].old_oid));
> -               break;
> -       default:
> -               BUG("unsupported ref action %d", action);
> +       if (transaction && ref_transaction_commit(transaction, &err)) {
> +               ret =3D error(_("failed to commit ref transaction: %s"), =
err.buf);
> +               goto out;
>         }

All effectively whitespace change, except for the new transaction
check, which is sensible.


>
>         ret =3D 0;
> @@ -410,10 +415,13 @@ static int cmd_history_reword(int argc,
>                 NULL,
>         };
>         enum ref_action action =3D REF_ACTION_DEFAULT;
> +       int dry_run =3D 0;
>         struct option options[] =3D {
>                 OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
> -                              N_("control ref update behavior (branches|=
head|print)"),
> +                              N_("control ref update behavior (branches|=
head)"),
>                                PARSE_OPT_NONEG, parse_ref_action),
> +               OPT_BOOL('n', "dry-run", &dry_run,
> +                        N_("perform a dry-run without updating any refs"=
)),
>                 OPT_END(),
>         };
>         struct strbuf reflog_msg =3D STRBUF_INIT;
> @@ -450,7 +458,7 @@ static int cmd_history_reword(int argc,
>         strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
>
>         ret =3D handle_reference_updates(&revs, action, original, rewritt=
en,
> -                                      reflog_msg.buf);
> +                                      reflog_msg.buf, dry_run);
>         if (ret < 0) {
>                 ret =3D error(_("failed replaying descendants"));
>                 goto out;
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 12a9a7d051..702d40dc06 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -221,7 +221,7 @@ test_expect_success 'can reword a merge commit' '
>         )
>  '
>
> -test_expect_success '--ref-action=3Dprint prints ref updates without mod=
ifying repo' '
> +test_expect_success '--dry-run prints ref updates without modifying repo=
' '
>         test_when_finished "rm -rf repo" &&
>         git init repo --initial-branch=3Dmain &&
>         (
> @@ -233,7 +233,15 @@ test_expect_success '--ref-action=3Dprint prints ref=
 updates without modifying rep
>                 test_commit theirs &&
>
>                 git refs list >refs-expect &&
> -               reword_with_message --ref-action=3Dprint base >updates <<=
-\EOF &&
> +               reword_with_message --dry-run --ref-action=3Dhead base >u=
pdates <<-\EOF &&
> +               reworded commit
> +               EOF
> +               git refs list >refs-actual &&
> +               test_cmp refs-expect refs-actual &&
> +               test_grep "update refs/heads/branch" updates &&
> +               test_grep ! "update refs/heads/main" updates &&
> +
> +               reword_with_message --dry-run base >updates <<-\EOF &&
>                 reworded commit
>                 EOF
>                 git refs list >refs-actual &&
>
> --
> 2.53.0.295.g64333814d3.dirty
>
>


--
D. Ben Knoble
