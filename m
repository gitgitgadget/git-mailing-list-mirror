Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BE218AB9
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007703; cv=none; b=rZTW20L7cEZrPNoZ0P/AYl0KZUHN80FPqK8uU2gc7mTan6igc3OZdQd0mMaAkEFIiZY2NCc3KBtEw0lA0AdNDs3yWserHr3cA/QLDvFHMiccjaiYJuUbwa53ub886bZjzrbQ4YHFq2fMP070phGmcJykDlXRmKQZ5YCIA4tmQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007703; c=relaxed/simple;
	bh=b58HHahbScZ+PyHxMKmwilYrMWbeHBdFdxHaKcvjkuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luGVN8cePZS/DsLwSX21K1Ay/M64UtOQqpJA0ffuo/znKaB+FVv/o5xclvg3Qco/nLAV9B7vbMurV7C4EQXTkpC/Y1E15kEEOVfhir3qZUVLi1pFKZk7erqXAzDOu6j7h0UUDeCrV0q2fVykI7NisjRmZKAwx5ywFa5nxwQOW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJJtv01z; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJJtv01z"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7613db390so2922580a34.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007700; x=1768612500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdmNZZbVobrNgk0DYnK1BMBQKafcrOQsaDdQ2HTyDao=;
        b=NJJtv01zCzidUJV0gFaKExYZ2QZZkEs0M1rywpSr+/VX1FggTAmi9iAZmAHh6GJt+v
         b3M6+f+ZT8tDqmbNdiQV+JOE+mqxEfAFQVEwXZ2h0IsASncRsgQAc37twI0WPjbPZEiH
         ZKNnFWB5iyAusr4Legqg/FZtxKknngMuCNcePDfaNI49vV62yNi32fHGrPfznkX12ZlB
         nFyqNYJ51jmcFXPmSUlPh8/YgyCdwZR7KknoJ9w/yxkmsNibuFDPmTfPNJo4lE0/Mgsv
         ZTJgYMBDx7cR3tU6BdI6Mc/4bTCqesSzUwZ5K5sXyJrjhiJvbE24A323JHDnhkeu6Bew
         MerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007700; x=1768612500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IdmNZZbVobrNgk0DYnK1BMBQKafcrOQsaDdQ2HTyDao=;
        b=I+EuFTmCNLB0f3uaog2BLYk+kQxr8lSH2g9l2ha88NX3cHgZ9x5PoXYk/0zDQkRYy/
         q/49p3S46YIVWzRhsHAIAgawg52vqI8h7XQmxEdyKlt5rA3xv0JsAnqMYrPZD6oL8WDa
         x5vGujrNs0p29xCIk7l48BypzRyy9mYKxWBaqS3Yjt/NrCS38uleddpv0f8uJ+HCxt9G
         92pE+MbmGulgh3sSPF7Y4kZeQsBo69/1/x6e31KXs+xbgTGI7mm9sdvlLKmyYTL3fFhA
         5N0KjRELxvHMf3Bh/g08a9e7rdGZNtSau8Mp487gGES322JFH7kOepa7+93Mm0Fmxs2k
         dccw==
X-Gm-Message-State: AOJu0YzR9jhoDdVsdIN151rAfLgXTo9sVYzuhUNQfkWUylFCKYwiuZZG
	gr7oQwDg/w/YOIL2aFok6xjQlYAab2oZ3aUMhegWhHPQkP5vZr2N7uhhcg+0PjOq5qpxw7BauKw
	ULqLP0ghw653n86RgJ0F+isImzgEqCUI=
X-Gm-Gg: AY/fxX4zJTeWTDeSZi4lDog9bW8cVzaGYovZ1YRpdSuWAEbfCbIY6/9zL/oekQBzbrR
	Hu9Uvquo/bvQ8cmMJkZBQ1SeDQXM3Z1xu58pqFrG7G20fbZCRHGBFPjvFyPZUG5WdZERSgaE9hO
	KpGX+r6fOkH9AYkGHRbLQK1gHgQYj/VWrU84eMvGVAZefzhmzpzisCHcmCqUvmvjKbkzgFmaP2/
	WVGRb8QHYLgChUtVT7/gqU/z3qYhV2WQXNVyOyvZEdjOcEZrpdCP22WERZtUOww1yDzVFfj1u27
	ia87O9y2fmA0Dd25Fy3e/B38IvY6pw6b+XpVGA==
X-Google-Smtp-Source: AGHT+IF22u6dUpMewtcyuDvDUk/3QlwckzDQ5dAiI0Qan+jo1nvgqIClvj7/YBGDD/30clkQqKnE54We3Hso7PtlknY=
X-Received: by 2002:a05:6820:168d:b0:65f:674e:f1ca with SMTP id
 006d021491bc7-65f674ef243mr2897571eaf.35.1768007699860; Fri, 09 Jan 2026
 17:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im> <20260109-b4-pks-history-builtin-v9-1-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-1-8766101814c6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:14:48 -0800
X-Gm-Features: AQt7F2rsz4bGdQoPxsdwef5GTQ9eFJxzm_MDEd7FO-NCvQ65zafOtWlydSYg1BU
Message-ID: <CABPp-BFmQHjyeT0pXYV5eE5cnG5H6XXHeT_RsjWxq83ck3781w@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] builtin/replay: extract core logic to replay revisions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We're about to move the core logic used to replay revisions onto a new
> base into the "libgit.a" library. Prepare for this by pulling out the
> logic into a new function `replay_revisions()` that:
>
>   1. Takes a set of revisions to replay and some options that tell it how
>      it ought to replay the revisions.
>
>   2. Replays the commits.
>
>   3. Records any reference updates that would be caused by replaying the
>      commits in a structure that is owned by the caller.
>
> The logic itself will be moved into a separate file in the next commit.
> This change is not expected to cause user-visible change in behaviour.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/replay.c | 274 +++++++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 165 insertions(+), 109 deletions(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 1960bbbee8..df3b32a52d 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -278,6 +278,137 @@ static enum ref_action_mode get_ref_action_mode(str=
uct repository *repo, const c
>         return REF_ACTION_UPDATE;
>  }
>
> +struct replay_revisions_options {
> +       const char *advance;
> +       const char *onto;
> +       int contained;
> +};
> +
> +struct replay_result {
> +       struct replay_ref_update {
> +               char *refname;
> +               struct object_id old_oid;
> +               struct object_id new_oid;
> +       } *updates;
> +       size_t updates_nr, updates_alloc;
> +
> +       bool merge_conflict;
> +};
> +
> +static void replay_result_release(struct replay_result *result)
> +{
> +       for (size_t i =3D 0; i < result->updates_nr; i++)
> +               free(result->updates[i].refname);
> +       free(result->updates);
> +}
> +
> +static void replay_result_queue_update(struct replay_result *result,
> +                                      const char *refname,
> +                                      const struct object_id *old_oid,
> +                                      const struct object_id *new_oid)
> +{
> +       ALLOC_GROW(result->updates, result->updates_nr + 1, result->updat=
es_alloc);
> +       result->updates[result->updates_nr].refname =3D xstrdup(refname);
> +       result->updates[result->updates_nr].old_oid =3D *old_oid;
> +       result->updates[result->updates_nr].new_oid =3D *new_oid;
> +       result->updates_nr++;
> +}
> +
> +static int replay_revisions(struct repository *repo, struct rev_info *re=
vs,
> +                           struct replay_revisions_options *opts,
> +                           struct replay_result *out)

Why have both repo & revs?  Can't we get repo from revs->repo?

> +{
> +       kh_oid_map_t *replayed_commits =3D NULL;
> +       struct strset *update_refs =3D NULL;
> +       struct commit *last_commit =3D NULL;
> +       struct commit *commit;
> +       struct commit *onto =3D NULL;
> +       struct merge_options merge_opt;
> +       struct merge_result result;
> +       char *advance;
> +       int ret;
> +
> +       advance =3D xstrdup_or_null(opts->advance);
> +       set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
> +                          &onto, &update_refs);
> +
> +       /* FIXME: Should allow replaying commits with the first as a root=
 commit */
> +
> +       if (prepare_revision_walk(revs) < 0) {
> +               ret =3D error(_("error preparing revisions"));
> +               goto out;
> +       }
> +
> +       init_basic_merge_options(&merge_opt, repo);
> +       memset(&result, 0, sizeof(result));
> +       merge_opt.show_rename_progress =3D 0;
> +       last_commit =3D onto;
> +       replayed_commits =3D kh_init_oid_map();
> +       while ((commit =3D get_revision(revs))) {
> +               const struct name_decoration *decoration;
> +               khint_t pos;
> +               int hr;
> +
> +               if (!commit->parents)
> +                       die(_("replaying down from root commit is not sup=
ported yet!"));
> +               if (commit->parents->next)
> +                       die(_("replaying merge commits is not supported y=
et!"));
> +
> +               last_commit =3D pick_regular_commit(repo, commit, replaye=
d_commits,
> +                                                 onto, &merge_opt, &resu=
lt);
> +               if (!last_commit)
> +                       break;
> +
> +               /* Record commit -> last_commit mapping */
> +               pos =3D kh_put_oid_map(replayed_commits, commit->object.o=
id, &hr);
> +               if (hr =3D=3D 0)
> +                       BUG("Duplicate rewritten commit: %s\n",
> +                           oid_to_hex(&commit->object.oid));
> +               kh_value(replayed_commits, pos) =3D last_commit;
> +
> +               /* Update any necessary branches */
> +               if (advance)
> +                       continue;
> +               decoration =3D get_name_decoration(&commit->object);
> +               if (!decoration)
> +                       continue;
> +               while (decoration) {
> +                       if (decoration->type =3D=3D DECORATION_REF_LOCAL =
&&
> +                           (opts->contained || strset_contains(update_re=
fs,
> +                                                               decoratio=
n->name))) {
> +                               replay_result_queue_update(out, decoratio=
n->name,
> +                                                          &commit->objec=
t.oid,
> +                                                          &last_commit->=
object.oid);
> +                       }
> +                       decoration =3D decoration->next;
> +               }
> +       }
> +
> +       if (!result.clean) {
> +               out->merge_conflict =3D true;
> +               ret =3D -1;
> +               goto out;

What?  In the replay code before this series:

        ret =3D result.clean;
        [...]
        /* Return */
        if (ret < 0)
                exit(128);
        return ret ? 0 : 1;

So, !result.clean should result in a return code of 1, not -1.

> +       }
> +
> +       /* In --advance mode, advance the target ref */
> +       if (advance)
> +               replay_result_queue_update(out, advance,
> +                                          &onto->object.oid,
> +                                          &last_commit->object.oid);
> +
> +       ret =3D 0;
> +
> +out:
> +       if (update_refs) {
> +               strset_clear(update_refs);
> +               free(update_refs);
> +       }
> +       kh_destroy_oid_map(replayed_commits);
> +       merge_finalize(&merge_opt, &result);
> +       free(advance);
> +       return ret;
> +}
> +
>  static int handle_ref_update(enum ref_action_mode mode,
>                              struct ref_transaction *transaction,
>                              const char *refname,
> @@ -306,21 +437,11 @@ int cmd_replay(int argc,
>                const char *prefix,
>                struct repository *repo)
>  {
> -       const char *advance_name_opt =3D NULL;
> -       char *advance_name =3D NULL;
> -       struct commit *onto =3D NULL;
> -       const char *onto_name =3D NULL;
> -       int contained =3D 0;
> +       struct replay_revisions_options opts =3D { 0 };
> +       struct replay_result result =3D { 0 };
>         const char *ref_action =3D NULL;
>         enum ref_action_mode ref_mode;
> -
>         struct rev_info revs;
> -       struct commit *last_commit =3D NULL;
> -       struct commit *commit;
> -       struct merge_options merge_opt;
> -       struct merge_result result;
> -       struct strset *update_refs =3D NULL;
> -       kh_oid_map_t *replayed_commits;
>         struct ref_transaction *transaction =3D NULL;
>         struct strbuf transaction_err =3D STRBUF_INIT;
>         struct strbuf reflog_msg =3D STRBUF_INIT;
> @@ -333,13 +454,13 @@ int cmd_replay(int argc,
>                 NULL
>         };
>         struct option replay_options[] =3D {
> -               OPT_STRING(0, "advance", &advance_name_opt,
> +               OPT_STRING(0, "advance", &opts.advance,
>                            N_("branch"),
>                            N_("make replay advance given branch")),
> -               OPT_STRING(0, "onto", &onto_name,
> +               OPT_STRING(0, "onto", &opts.onto,
>                            N_("revision"),
>                            N_("replay onto given commit")),
> -               OPT_BOOL(0, "contained", &contained,
> +               OPT_BOOL(0, "contained", &opts.contained,
>                          N_("update all branches that point at commits in=
 <revision-range>")),
>                 OPT_STRING(0, "ref-action", &ref_action,
>                            N_("mode"),
> @@ -350,19 +471,17 @@ int cmd_replay(int argc,
>         argc =3D parse_options(argc, argv, prefix, replay_options, replay=
_usage,
>                              PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOW=
N_OPT);
>
> -       if (!onto_name && !advance_name_opt) {
> +       if (!opts.onto && !opts.advance) {
>                 error(_("option --onto or --advance is mandatory"));
>                 usage_with_options(replay_usage, replay_options);
>         }
>
> -       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> -                                 contained, "--contained");
> +       die_for_incompatible_opt2(!!opts.advance, "--advance",
> +                                 opts.contained, "--contained");
>
>         /* Parse ref action mode from command line or config */
>         ref_mode =3D get_ref_action_mode(repo, ref_action);
>
> -       advance_name =3D xstrdup_or_null(advance_name_opt);
> -
>         repo_init_revisions(repo, &revs, prefix);
>
>         /*
> @@ -414,18 +533,19 @@ int cmd_replay(int argc,
>                 revs.simplify_history =3D 0;
>         }
>
> -       set_up_replay_mode(repo, &revs.cmdline,
> -                          onto_name, &advance_name,
> -                          &onto, &update_refs);
> -
> -       /* FIXME: Should allow replaying commits with the first as a root=
 commit */
> +       ret =3D replay_revisions(repo, &revs, &opts, &result);
> +       if (ret)
> +               goto cleanup;
>
>         /* Build reflog message */
> -       if (advance_name_opt)
> -               strbuf_addf(&reflog_msg, "replay --advance %s", advance_n=
ame_opt);
> -       else
> -               strbuf_addf(&reflog_msg, "replay --onto %s",
> -                           oid_to_hex(&onto->object.oid));
> +       if (opts.advance) {
> +               strbuf_addf(&reflog_msg, "replay --advance %s", opts.adva=
nce);
> +       } else {
> +               struct object_id oid;
> +               if (repo_get_oid_committish(repo, opts.onto, &oid))
> +                       BUG("--onto commit should have been resolved befo=
rehand already");
> +               strbuf_addf(&reflog_msg, "replay --onto %s", oid_to_hex(&=
oid));
> +       }
>
>         /* Initialize ref transaction if using update mode */
>         if (ref_mode =3D=3D REF_ACTION_UPDATE) {
> @@ -438,78 +558,19 @@ int cmd_replay(int argc,
>                 }
>         }
>
> -       if (prepare_revision_walk(&revs) < 0) {
> -               ret =3D error(_("error preparing revisions"));
> -               goto cleanup;
> -       }
> -
> -       init_basic_merge_options(&merge_opt, repo);
> -       memset(&result, 0, sizeof(result));
> -       merge_opt.show_rename_progress =3D 0;
> -       last_commit =3D onto;
> -       replayed_commits =3D kh_init_oid_map();
> -       while ((commit =3D get_revision(&revs))) {
> -               const struct name_decoration *decoration;
> -               khint_t pos;
> -               int hr;
> -
> -               if (!commit->parents)
> -                       die(_("replaying down from root commit is not sup=
ported yet!"));
> -               if (commit->parents->next)
> -                       die(_("replaying merge commits is not supported y=
et!"));
> -
> -               last_commit =3D pick_regular_commit(repo, commit, replaye=
d_commits,
> -                                                 onto, &merge_opt, &resu=
lt);
> -               if (!last_commit)
> -                       break;
> -
> -               /* Record commit -> last_commit mapping */
> -               pos =3D kh_put_oid_map(replayed_commits, commit->object.o=
id, &hr);
> -               if (hr =3D=3D 0)
> -                       BUG("Duplicate rewritten commit: %s\n",
> -                           oid_to_hex(&commit->object.oid));
> -               kh_value(replayed_commits, pos) =3D last_commit;
> -
> -               /* Update any necessary branches */
> -               if (advance_name)
> -                       continue;
> -               decoration =3D get_name_decoration(&commit->object);
> -               if (!decoration)
> -                       continue;
> -               while (decoration) {
> -                       if (decoration->type =3D=3D DECORATION_REF_LOCAL =
&&
> -                           (contained || strset_contains(update_refs,
> -                                                         decoration->nam=
e))) {
> -                               if (handle_ref_update(ref_mode, transacti=
on,
> -                                                     decoration->name,
> -                                                     &last_commit->objec=
t.oid,
> -                                                     &commit->object.oid=
,
> -                                                     reflog_msg.buf,
> -                                                     &transaction_err) <=
 0) {
> -                                       ret =3D error(_("failed to update=
 ref '%s': %s"),
> -                                                   decoration->name, tra=
nsaction_err.buf);
> -                                       goto cleanup;
> -                               }
> -                       }
> -                       decoration =3D decoration->next;
> -               }
> -       }
> -
> -       /* In --advance mode, advance the target ref */
> -       if (result.clean =3D=3D 1 && advance_name) {
> -               if (handle_ref_update(ref_mode, transaction, advance_name=
,
> -                                     &last_commit->object.oid,
> -                                     &onto->object.oid,
> -                                     reflog_msg.buf,
> -                                     &transaction_err) < 0) {
> +       for (size_t i =3D 0; i < result.updates_nr; i++) {
> +               ret =3D handle_ref_update(ref_mode, transaction, result.u=
pdates[i].refname,
> +                                       &result.updates[i].new_oid, &resu=
lt.updates[i].old_oid,
> +                                       reflog_msg.buf, &transaction_err)=
;
> +               if (ret) {
>                         ret =3D error(_("failed to update ref '%s': %s"),
> -                                   advance_name, transaction_err.buf);
> +                                   result.updates[i].refname, transactio=
n_err.buf);
>                         goto cleanup;
>                 }
>         }
>
>         /* Commit the ref transaction if we have one */
> -       if (transaction && result.clean =3D=3D 1) {
> +       if (transaction) {
>                 if (ref_transaction_commit(transaction, &transaction_err)=
) {
>                         ret =3D error(_("failed to commit ref transaction=
: %s"),
>                                     transaction_err.buf);
> @@ -517,24 +578,19 @@ int cmd_replay(int argc,
>                 }
>         }
>
> -       merge_finalize(&merge_opt, &result);
> -       kh_destroy_oid_map(replayed_commits);
> -       if (update_refs) {
> -               strset_clear(update_refs);
> -               free(update_refs);
> -       }
> -       ret =3D result.clean;
> -
>  cleanup:
>         if (transaction)
>                 ref_transaction_free(transaction);
> +       replay_result_release(&result);
>         strbuf_release(&transaction_err);
>         strbuf_release(&reflog_msg);
>         release_revisions(&revs);
> -       free(advance_name);
>
> -       /* Return */
> -       if (ret < 0)
> -               exit(128);
> -       return ret ? 0 : 1;
> +       if (ret) {
> +               if (result.merge_conflict)
> +                       return 1;

This feels like a rather Rube-Goldberg way to get this.  Above where I
highlighted where you set ret to -1 incorrectly, can we just set it to
1 there and then lose all this special logic in favor of "return ret;"
here?  Or am I overlooking something?


> +               return 128;
> +       }
> +
> +       return 0;
>  }
>
> --
> 2.52.0.542.g9473a8513b.dirty
