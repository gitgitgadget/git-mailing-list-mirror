Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E20388873
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236882; cv=pass; b=R8KditjE57X+P9rHphW35zawss9v8KXOxmTeEb0s3SxVgWpwUn8ZrGs88pP/7bCDEUVyGqJCdRNzjQF7pF1HieDWZFkMkxZJjPCK8IEgOWb6vQVHg/Enc2ZBhjJ+4+Kpxqf4DUozPVb2D3OuLOyfEvYNR+nHFMWe8zIeblr7iY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236882; c=relaxed/simple;
	bh=fSTvYzWGi4ArIn5P+tO646HfeIaYHYEdOIfW7jGrzKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6yyulpDzB7ogtZMYMW+ilCJt+N+r6CC/7sFqq8vjnZjySBZegIeYUbkgj8rMdCbb4wptHA8QDChH/IWXL1bcF++KFaiHh6omYdrx+70HP3camdgo1wtEkOhU00zSE+mOLDWyXSJFFNETUBhDUymAoXt8X246jMdBxjvwvkPhds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTlNLqtn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTlNLqtn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso126957a12.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 10:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782236878; cv=none;
        d=google.com; s=arc-20240605;
        b=e+u9gRHjRBx7s/cKtRef9O5YL3RJ4HalltjwRADievGn7XAemrM/TQQ84mP6kkwYso
         4p7BESamoSlibhpfw4wgV0goXHEVz6gJ6bbAzwnJNu3rMFW+IJxoXX8i53FEJpiwkvVr
         aEN6pISQ6kq+GHhZVLDamJ1u6HWfnffk7NcLczJXlSTkqcjugDButqn7zPf1Ns7YPXjf
         Gg2hCxzeYf78PLtmU6i6KBalwJGObAM8FfhPxRp76/t7dSvvdaMf/bxwY2H4XUZpVZc3
         DRZXHUCIdf7HyeII7rotUP4fJYCo/tpmz81ggsq572Eq4zQyaBQDmn1PW/4yZ87PnbH2
         4Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tf0jF1ovNoJ/v8ADFHWsvO5HIYkIjFP/cLcSOnVFW3A=;
        fh=uOxQ+Evj88BKoQHyotmmUPEFUYX7y1Rz4fAyv/aVWpU=;
        b=PHvuLdGgIRHPfbmtB1fugpKrvEDJe4HGipyJ+OkbxqweIvVSDev1GqWQQbIkpDU4v+
         xdcKD9SRtCx+HyOtnA5Eet+I3a+PVX6lyBXMmLX94qIMrLAi397dlwqMrrVQGI2YpKd5
         ym5UwTyFAHbS5tKpF/U4QukkltZPTwxOueh8cvncRtsY8897X9r6kBrH0UDZ41rGHM25
         9YWQBOZ+i+HZipCjLFnysuP0d1YkIddc+RtbMzgbLrzx1aMPCnHA2y5g9U6Gy330HrHd
         ZXXDXoqvxefHPJgGmA33qOypnX9KrcY6kH0GESjtk9O84Zjc7hNVtlwwI4wr23wwp8ON
         ayrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236878; x=1782841678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf0jF1ovNoJ/v8ADFHWsvO5HIYkIjFP/cLcSOnVFW3A=;
        b=QTlNLqtnvB+pyYtqrqB9C4S/zcK5F5+4WwLGiw1xnC0GBmpRw4BAWokz2soMGZlAgV
         FLbZTbd2dcwgyBkMqAAPz2qodxiwrRt17Iib71Z2UNExhDERQjPnSRCtZaUQU7lld//i
         90TRGQhsiyWqRz3aPjD9us9A/x/+IrXQS+IltUrtklf6rHqxxoO9XH0wn2ZRfC/Fr3AK
         k3AScP3Vmy34+wxYBljDPGR9lIQsrWbSSuIE6AickiVa5NHlTHVQ2wOn60Gc4kSla4Ja
         96m6DsKo6btyhqvDh6hyz+x2eTkbS4ba+xuyGlzYDjgHXgnQL8NaSwj5D859rPLt0obq
         Tjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236878; x=1782841678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tf0jF1ovNoJ/v8ADFHWsvO5HIYkIjFP/cLcSOnVFW3A=;
        b=ITx1M5Muvk0aX2Gqk5bah8hfG4FyIVVgEEVO4zxYTEo61ZJ1811vKsSRqKk6D0tnPE
         /SZYcu9ZIyuLy/mOuDS7fpPovLDlDxPj01X/CRCMbTKGlMOmuuWt/xmsoqtdh/6b4GDz
         udyXyFeZW8T79rg6QZbUC1dFCFP7OrWNZfPqszHSS8KlcuWd5LzV8O/AJQueAM/SBGek
         yn2dCpq1ObI5B+PvILlapgQEUUpadCxocDDnbCiEiEiVJ3PzMLaknBMF+bi5D9CW2gwC
         OxUja12CiAFhckWQpKNkasX8WmLf8zDdla+FYVU/66sxbvJ1HTT6eRMlU6L4wkc0gzxr
         dLow==
X-Forwarded-Encrypted: i=1; AFNElJ9kfcCOVCU3q0rT6dDDqa/EhAcI7AK79zj9r7QsPhpfOCpDKspr5xcFWYpHbp3K/THG5+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMreJoF1zqEj3mz7ThOZ7do66HVlnT44MdUTa2rYZ+f+ebT2UO
	qwcBuK4LeTMpeKWL5Ri5KMYjNXXka3vERZzvE/owUY4TOKR6Bp4o6YuJ4oKjqWln9ugBObshdld
	oKsC+AGI2qPd7rZM2oS1qNgJwvnmqy2o=
X-Gm-Gg: AfdE7cmiEpsE9EfyMao24Jp9u0/vibzSSJhx9+7cRMKJsx8chzvDPThI9/mEA6oVT8x
	c2bxh5bamYhI0I0ETO722r/+T1cXrBYWu8jwjdma7TcTek2WyP+il9CBc/dkCNFw0Kzxq4Hhwn/
	EyPxdl+WBN0d/T3LDY5KOVo8MhWOc3qPLJe71iHxu3INb049ja9UH0um3K4IVyBSirVDVVTaxVX
	XD+WrNdwbKox+nLWVTeOscMjIqw1Xe45nPkuWJToneIUohke0Hk+H8IsFYDKMKSiB9WfdqQ
X-Received: by 2002:a05:6402:3487:b0:693:2a2:9e41 with SMTP id
 4fb4d7f45d1cf-69711df46a6mr11195019a12.19.1782236877642; Tue, 23 Jun 2026
 10:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
 <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com> <8518f090b1069a02d40c710975528ad118776b67.1781786652.git.gitgitgadget@gmail.com>
 <12998c3a-ff69-4a98-9ed6-18aa0224e75e@gmail.com>
In-Reply-To: <12998c3a-ff69-4a98-9ed6-18aa0224e75e@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 23 Jun 2026 19:47:19 +0200
X-Gm-Features: AVVi8CdQAWMUKAcLGwmANoWL0J1u3Zak1uXJVJRlSaZ5ktnRS3HqD7nR7hAjD_Y
Message-ID: <CAHwyqnWwyPHiaOW+rz-Z9ZvRf=OjXWw2T+rB3cSsxXWXkeRm=Q@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, let's focus on the need for the feature before talking code:

In an active project, forking from "origin/master" without refreshing
first often has consequences: you start work that has already been
done, or you build on an old version of the code which causes big
conflicts only later when you pull. The fix is simple ("git fetch
origin master && git checkout -b topic origin/master"), but it is
still a mouthful. Other tools exist because this is annoying enough
that people automate it.

Consider instead that the cost of a fetch is nothing.

When a new user types "git checkout -b topic origin/master", I assume
their mental model is already "start from the LATEST origin/master".
The fetch is implicit, automating it matches what they probably
already meant.


Harald

On Tue, Jun 23, 2026 at 3:49=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Harald
>
> On 18/06/2026 13:44, Harald Nordgren via GitGitGadget wrote:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Add a "fetch" mode to the "--track" option of "git checkout" / "git
> > switch" that refreshes <start-point> before checking it out:
> >
> >      git checkout -b new_branch --track=3Dfetch origin/some-branch
> >
> > is shorthand for
> >
> >      git fetch origin some-branch
> >      git checkout -b new_branch --track origin/some-branch
> >
> > Identify the remote whose configured fetch refspec maps to
> > <start-point> using find_tracking_remote_for_ref() (the same lookup
> > "--track" uses to pick which remote to record in
> > branch.<name>.remote), then run "git fetch <remote> <src-ref>" for
> > just that ref so other remote-tracking branches are left untouched.
> > When <start-point> is a bare <remote> (e.g. "origin"), follow
> > refs/remotes/<remote>/HEAD to learn which branch to refresh. If
> > "git fetch" fails but the remote-tracking ref already exists locally,
> > warn and proceed from the existing tip; otherwise abort.
>
> This describes the feature well, but does not really explain why it is
> convenient to have a shorthand for "git fetch ... && git checkout -b
> ...". For example if the reason is that in a fast-moving project you
> want to start your new work off the latest upstream changes to minimize
> the chance of merge conflicts or duplicated work it would be useful to
> say that. As Junio has said the implementation looks pretty solid I've
> left a few comments below, but the important thing to do first is to
> convince others that this is a useful feature and why it is worth
> blurring the separation between fetch and checkout. You can do that
> without sending a new version.
>
> > diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checko=
ut.adoc
> > index a8b3b8c2e2..20b6cae60e 100644
> > --- a/Documentation/git-checkout.adoc
> > +++ b/Documentation/git-checkout.adoc
> > @@ -158,11 +158,26 @@ of it").
> >       resets _<branch>_ to the start point instead of failing.
> >
> >   `-t`::
> > -`--track[=3D(direct|inherit)]`::
> > +`--track[=3D(direct|inherit|fetch)[,...]]`::
> >       When creating a new branch, set up "upstream" configuration. See
> >       `--track` in linkgit:git-branch[1] for details. As a convenience,
> >       --track without -b implies branch creation.
> >   +
> > +The argument is a comma-separated list. `direct` (the default) and
> > +`inherit` select the tracking mode and are mutually exclusive. Adding
> > +`fetch` requests that the remote be fetched before _<start-point>_ is
> > +resolved, so the new branch starts from a fresh tip: when
> > +_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
> > +updated; when _<start-point>_ is a bare _<remote>_ (e.g. `origin`), th=
e
> > +branch named by _<remote>/HEAD_ is updated, and the checkout fails
> > +with a hint to configure that symref if it is not set. The checkout
> > +also fails if no configured remote's fetch refspec maps to
> > +_<start-point>_, or if more than one does (in which case the `fetch`
> > +cannot be unambiguously routed). If the fetch itself fails and the
> > +corresponding remote-tracking ref already exists, a warning is printed
> > +and the checkout proceeds from the existing tip; otherwise the checkou=
t
> > +is aborted.
>
> Nicely explained
>
> > +static void fetch_remote_for_start_point(const char *arg, int quiet)
> > +{
> > +     struct strbuf dst =3D STRBUF_INIT;
> > +     struct tracking tracking;
> > +     struct string_list tracking_srcs =3D STRING_LIST_INIT_DUP;
> > +     struct string_list ambiguous_remotes =3D STRING_LIST_INIT_DUP;
> > +     struct child_process cmd =3D CHILD_PROCESS_INIT;
> > +     struct object_id oid;
> > +     struct remote *named_remote;
> > +     int bare_ns;
> > +
> > +     strbuf_addf(&dst, "refs/remotes/%s", arg);
> > +     if (check_refname_format(dst.buf, 0))
> > +             die(_("cannot fetch start-point '%s': not a valid "
> > +                   "remote-tracking name"), arg);
> > +
> > +     named_remote =3D remote_get(arg);
> > +     bare_ns =3D !strchr(arg, '/') ||
> > +             (named_remote && remote_is_configured(named_remote, 1));
> > +     if (bare_ns) {
> > +             char *head_path =3D xstrfmt("refs/remotes/%s/HEAD", arg);
> > +             const char *head_target =3D
> > +                     refs_resolve_ref_unsafe(get_main_ref_store(the_re=
pository),
> > +                                             head_path,
> > +                                             RESOLVE_REF_READING |
> > +                                             RESOLVE_REF_NO_RECURSE,
>
> Why do we use RESOLVE_REF_NO_RECURSE here? This should match whatever
> "git checkout -b <remote>" does.
>
> > +                                             &oid, NULL);
> > +             if (head_target &&
> > +                 starts_with(head_target, dst.buf) &&
> > +                 head_target[dst.len] =3D=3D '/' &&
> > +                 !check_refname_format(head_target, 0)) {
>
> I don't think there is any need to call check_refname_format() here -
> you're using the result of reading a ref, not some untrusted input.
>
> > +                     strbuf_reset(&dst);
> > +                     strbuf_addstr(&dst, head_target);
> > +                     bare_ns =3D 0;
> > +             }
> > +             free(head_path);
> > +     }
> > +
> > +     memset(&tracking, 0, sizeof(tracking));
>
> When you want to zero initialize a stack variable it is easier, clearer
> and less error-prone to initialize it by adding "=3D {0};" where it is
> declared.
>
> > +     tracking.spec.dst =3D dst.buf;
> > +     tracking.srcs =3D &tracking_srcs;
> > +     find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
> > +
> > +     if (tracking.matches > 1) {
> > +             int status =3D die_message(_("cannot fetch start-point '%=
s': "
> > +                                        "fetch refspecs of multiple re=
motes "
> > +                                        "map to '%s'"), arg, dst.buf);
> > +             advise_ambiguous_fetch_refspec(dst.buf, &ambiguous_remote=
s);
> > +             exit(status);
> > +     }
> > +
> > +     if (!tracking.matches) {
> > +             if (bare_ns && named_remote &&
> > +                 remote_is_configured(named_remote, 1))
> > +                     die(_("cannot fetch start-point '%s': "
> > +                           "'refs/remotes/%s/HEAD' is not set; run "
> > +                           "'git remote set-head %s --auto' to set it"=
)
>
> This is quite a long message for a single line - breaking the line and
> putting the suggested command on a separate line would make it clearer.
> Something like
>
> cannot fetch start-point 'origin' because 'refs/remotes/origin/HEAD'
> does not exist. To create it run
>
>      git remote set-head origin --auto
>
> > +                         arg, arg, arg);
> > +             die(_("cannot fetch start-point '%s': no configured remot=
e's "
> > +                   "fetch refspec matches it"), arg);
> > +     }
> > +
> > +     strvec_push(&cmd.args, "fetch");
> > +     if (quiet)
> > +             strvec_push(&cmd.args, "--quiet");
> > +     strvec_pushl(&cmd.args, tracking.remote,
> > +                  tracking_srcs.items[0].string, NULL);
> > +     cmd.git_cmd =3D 1;
> > +     if (run_command(&cmd)) {
> > +             if (!refs_read_ref(get_main_ref_store(the_repository),
> > +                                dst.buf, &oid))
>
> You can use refs_ref_exists() to check a ref exists which avoids
> declaring "oid" which we're not interested in here.
>
> > +                     warning(_("failed to fetch start-point '%s'; "
> > +                               "using existing '%s'"), arg, dst.buf);
> > +             else
> > +                     die(_("failed to fetch start-point '%s'"), arg);
> > +     }
> > +
> > +     string_list_clear(&tracking_srcs, 0);
> > +     string_list_clear(&ambiguous_remotes, 0);
> > +     strbuf_release(&dst);
> > +}
> > +
> > +static int parse_opt_checkout_track(const struct option *opt,
> > +                                 const char *arg, int unset)
> > +{
> > +     struct checkout_opts *opts =3D opt->value;
> > +     struct string_list tokens =3D STRING_LIST_INIT_DUP;
> > +     struct string_list_item *item;
> > +     int saw_direct =3D 0;
> > +     int ret =3D 0;
> > +
> > +     opts->fetch =3D 0;
> > +     if (unset) {
> > +             opts->track =3D BRANCH_TRACK_NEVER;
> > +             return 0;
> > +     }
> > +     opts->track =3D BRANCH_TRACK_EXPLICIT;
> > +     if (!arg)
> > +             return 0;
> > +
> > +     string_list_split(&tokens, arg, ",", -1);
> > +     for_each_string_list_item(item, &tokens) {
> > +             if (!strcmp(item->string, "fetch"))
> > +                     opts->fetch =3D 1;
> > +             else if (!strcmp(item->string, "direct"))
> > +                     saw_direct =3D 1;
> > +             else if (!strcmp(item->string, "inherit"))
> > +                     opts->track =3D BRANCH_TRACK_INHERIT;
> > +             else {
> > +                     ret =3D error(_("option `%s' expects \"%s\", \"%s=
\", "
> > +                                   "or \"%s\""),
> > +                                 "--track", "direct", "inherit", "fetc=
h");
> > +                     goto out;
> > +             }
> > +     }
> > +     if (saw_direct && opts->track =3D=3D BRANCH_TRACK_INHERIT)
> > +             ret =3D error(_("option `%s' cannot combine \"%s\" and \"=
%s\""),
> > +                         "--track", "direct", "inherit");
>
> This parsing looks good
> > diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> > index 7613b1d2a4..1e321b1512 100755
> > --- a/t/t7201-co.sh
> > +++ b/t/t7201-co.sh
> > @@ -870,4 +870,280 @@ test_expect_success 'tracking info copied with au=
toSetupMerge=3Dinherit' '
> >       test_cmp_config "" --default "" branch.main2.merge
> >   '
>
> I've not read the tests in detail but there seem to be an awful lot of
> them. We only need to test each thing once so for example if we test
>
>      git checkout --track=3Dfetch -b <remote-ref>
>
> with a fetch refspec, that maps refs/heads/*:refs/remotes/origin/xxx/*
> then we don't need to test it without that refspec. I notice you use
> "namespace" below with is confusing because it is not referring to the
> feature described in the gitnamespaces(7) man page.
>
> Try and avoid
>
>      test $a =3D $b
>
> as it makes it hard to debug failing tests. Instead I think you can use
> test_cmp_rev in this case.
>
> Thanks
>
> Phillip
>
> > +test_expect_success 'setup upstream for --track=3Dfetch tests' '
> > +     git checkout main &&
> > +     git init fetch_upstream &&
> > +     test_commit -C fetch_upstream u_main &&
> > +     git remote add fetch_upstream fetch_upstream &&
> > +     git fetch fetch_upstream &&
> > +     git -C fetch_upstream checkout -b fetch_new &&
> > +     test_commit -C fetch_upstream u_new
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch -b picks up branch creat=
ed upstream after clone' '
> > +     git checkout main &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_new &&
> > +     git checkout --track=3Dfetch -b local_new fetch_upstream/fetch_ne=
w &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
> > +     test_cmp_config fetch_upstream branch.local_new.remote &&
> > +     test_cmp_config refs/heads/fetch_new branch.local_new.merge
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch <remote>/<branch> leaves=
 other tracking branches untouched' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_target &&
> > +     test_commit -C fetch_upstream u_target_pre &&
> > +     git -C fetch_upstream checkout -b fetch_other &&
> > +     test_commit -C fetch_upstream u_other_pre &&
> > +     git fetch fetch_upstream &&
> > +     other_before=3D$(git rev-parse refs/remotes/fetch_upstream/fetch_=
other) &&
> > +     git -C fetch_upstream checkout fetch_target &&
> > +     test_commit -C fetch_upstream u_target_post &&
> > +     git -C fetch_upstream checkout fetch_other &&
> > +     test_commit -C fetch_upstream u_other_post &&
> > +     git checkout --track=3Dfetch -b local_target fetch_upstream/fetch=
_target &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
> > +     test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" =
=3D "$other_before"
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch with bare remote name fe=
tches only <remote>/HEAD target' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout main &&
> > +     git remote set-head fetch_upstream main &&
> > +     git -C fetch_upstream checkout -b fetch_unrelated &&
> > +     test_commit -C fetch_upstream u_unrelated_pre &&
> > +     git fetch fetch_upstream fetch_unrelated &&
> > +     unrelated_before=3D$(git rev-parse refs/remotes/fetch_upstream/fe=
tch_unrelated) &&
> > +     git -C fetch_upstream checkout main &&
> > +     test_commit -C fetch_upstream u_main_post &&
> > +     git -C fetch_upstream checkout fetch_unrelated &&
> > +     test_commit -C fetch_upstream u_unrelated_post &&
> > +     git checkout --track=3Dfetch -b local_from_remote fetch_upstream =
&&
> > +     test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
> > +     test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated=
)" =3D "$unrelated_before"
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch aborts and does not crea=
te branch when no existing ref' '
> > +     git checkout main &&
> > +     test_might_fail git branch -D bogus &&
> > +     test_must_fail git checkout --track=3Dfetch -b bogus fetch_upstre=
am/does_not_exist &&
> > +     test_must_fail git rev-parse --verify refs/heads/bogus
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch warns and proceeds when =
fetch fails but ref exists' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_offline &&
> > +     test_commit -C fetch_upstream u_offline &&
> > +     git fetch fetch_upstream fetch_offline &&
> > +     saved_url=3D$(git config remote.fetch_upstream.url) &&
> > +     test_when_finished "git config remote.fetch_upstream.url \"$saved=
_url\"" &&
> > +     git config remote.fetch_upstream.url ./does-not-exist &&
> > +     git checkout --track=3Dfetch -b local_offline fetch_upstream/fetc=
h_offline 2>err &&
> > +     test_grep "failed to fetch" err &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch resolves through configu=
red fetch refspec' '
> > +     git checkout main &&
> > +     git remote add fetch_custom ./fetch_upstream &&
> > +     test_when_finished "git remote remove fetch_custom" &&
> > +     git config --replace-all remote.fetch_custom.fetch \
> > +             "+refs/heads/*:refs/remotes/custom-ns/*" &&
> > +     git -C fetch_upstream checkout -b fetch_refspec &&
> > +     test_commit -C fetch_upstream u_refspec &&
> > +     test_must_fail git rev-parse --verify refs/remotes/custom-ns/fetc=
h_refspec &&
> > +     git checkout --track=3Dfetch -b local_refspec custom-ns/fetch_ref=
spec &&
> > +     test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch on namespace bare name f=
ollows <ns>/HEAD' '
> > +     git checkout main &&
> > +     git remote add fetch_ns ./fetch_upstream &&
> > +     test_when_finished "git remote remove fetch_ns" &&
> > +     test_when_finished "git update-ref -d refs/remotes/ns_alias/HEAD"=
 &&
> > +     git config --replace-all remote.fetch_ns.fetch \
> > +             "+refs/heads/*:refs/remotes/ns_alias/*" &&
> > +     git fetch fetch_ns &&
> > +     git symbolic-ref refs/remotes/ns_alias/HEAD refs/remotes/ns_alias=
/main &&
> > +     git -C fetch_upstream checkout main &&
> > +     test_commit -C fetch_upstream u_ns_post &&
> > +     git checkout --track=3Dfetch -b local_ns ns_alias &&
> > +     test_cmp_rev refs/remotes/ns_alias/main HEAD &&
> > +     test_cmp_config fetch_ns branch.local_ns.remote &&
> > +     test_cmp_config refs/heads/main branch.local_ns.merge
> > +'
> > +
> > +test_expect_success '--track=3Dfetch on bare hierarchical remote name =
follows <ns>/HEAD' '
> > +     git checkout main &&
> > +     git remote add nested/bare ./fetch_upstream &&
> > +     test_when_finished "git remote remove nested/bare" &&
> > +     test_when_finished "git update-ref -d refs/remotes/nested/bare/HE=
AD" &&
> > +     git fetch nested/bare &&
> > +     git symbolic-ref refs/remotes/nested/bare/HEAD \
> > +             refs/remotes/nested/bare/main &&
> > +     git -C fetch_upstream checkout main &&
> > +     test_commit -C fetch_upstream u_nested_bare_post &&
> > +     git checkout --track=3Dfetch -b local_nested_bare nested/bare &&
> > +     test_cmp_rev refs/remotes/nested/bare/main HEAD
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch handles hierarchical rem=
ote name' '
> > +     git checkout main &&
> > +     git remote add nested/remote ./fetch_upstream &&
> > +     test_when_finished "git remote remove nested/remote" &&
> > +     git -C fetch_upstream checkout -b fetch_hier &&
> > +     test_commit -C fetch_upstream u_hier &&
> > +     test_must_fail git rev-parse --verify refs/remotes/nested/remote/=
fetch_hier &&
> > +     git checkout --track=3Dfetch -b local_hier nested/remote/fetch_hi=
er &&
> > +     test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch dies on bare remote name=
 with no <ns>/HEAD' '
> > +     git checkout main &&
> > +     git remote add fetch_nohead ./fetch_upstream &&
> > +     test_when_finished "git remote remove fetch_nohead" &&
> > +     test_might_fail git symbolic-ref -d refs/remotes/fetch_nohead/HEA=
D &&
> > +     test_must_fail git checkout --track=3Dfetch -b local_nohead fetch=
_nohead 2>err &&
> > +     test_grep "refs/remotes/fetch_nohead/HEAD" err &&
> > +     test_grep "git remote set-head fetch_nohead --auto" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_nohead
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch on bare unknown name doe=
s not suggest set-head' '
> > +     git checkout main &&
> > +     test_must_fail git rev-parse --verify refs/remotes/no_such_ns/HEA=
D &&
> > +     test_must_fail git config --get remote.no_such_ns.url &&
> > +     test_must_fail git checkout --track=3Dfetch -b local_unknown no_s=
uch_ns 2>err &&
> > +     test_grep "no configured remote" err &&
> > +     test_grep ! "set-head" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_unknown
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch rejects <ns>/HEAD pointi=
ng outside namespace' '
> > +     git checkout main &&
> > +     git remote add fetch_crossns ./fetch_upstream &&
> > +     test_when_finished "git remote remove fetch_crossns" &&
> > +     test_when_finished "git update-ref -d refs/remotes/fetch_crossns/=
HEAD" &&
> > +     git fetch fetch_crossns &&
> > +     git symbolic-ref refs/remotes/fetch_crossns/HEAD \
> > +             refs/remotes/fetch_upstream/u_main &&
> > +     test_must_fail git checkout --track=3Dfetch -b local_crossns fetc=
h_crossns 2>err &&
> > +     test_grep "refs/remotes/fetch_crossns/HEAD" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_crossns
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch dies on ambiguous fetch =
refspec match' '
> > +     git checkout main &&
> > +     git remote add fetch_ambig_a ./fetch_upstream &&
> > +     git remote add fetch_ambig_b ./fetch_upstream &&
> > +     test_when_finished "git remote remove fetch_ambig_a" &&
> > +     test_when_finished "git remote remove fetch_ambig_b" &&
> > +     git config --replace-all remote.fetch_ambig_a.fetch \
> > +             "+refs/heads/*:refs/remotes/ambig_ns/*" &&
> > +     git config --replace-all remote.fetch_ambig_b.fetch \
> > +             "+refs/heads/*:refs/remotes/ambig_ns/*" &&
> > +     git -C fetch_upstream checkout -b fetch_ambig &&
> > +     test_commit -C fetch_upstream u_ambig &&
> > +     test_must_fail git checkout --track=3Dfetch -b local_ambig ambig_=
ns/fetch_ambig 2>err &&
> > +     test_grep "fetch_ambig_a" err &&
> > +     test_grep "fetch_ambig_b" err &&
> > +     test_grep "tracking namespaces" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_ambig
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch rejects invalid refname =
components' '
> > +     git checkout main &&
> > +     test_must_fail git checkout --track=3Dfetch -b local_invalid "foo=
..bar" 2>err &&
> > +     test_grep "valid" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_invalid
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch,inherit rejects invalid =
refname components' '
> > +     git checkout main &&
> > +     test_must_fail git checkout --track=3Dfetch,inherit -b local_inva=
lid \
> > +             "foo..bar" 2>err &&
> > +     test_grep "valid" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/local_invalid
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dinherit,direct is rejected' '
> > +     test_must_fail git checkout --track=3Dinherit,direct -b bad fetch=
_upstream/fetch_new 2>err &&
> > +     test_grep "cannot combine" err
> > +'
> > +
> > +test_expect_success 'checkout --track=3Ddirect,inherit is rejected' '
> > +     test_must_fail git checkout --track=3Ddirect,inherit -b bad fetch=
_upstream/fetch_new 2>err &&
> > +     test_grep "cannot combine" err
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch then --track=3Ddirect dr=
ops fetch (last-one-wins)' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_lastwin &&
> > +     test_commit -C fetch_upstream u_lastwin &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_lastwin &&
> > +     test_must_fail git checkout --track=3Dfetch --track=3Ddirect \
> > +             -b local_lastwin fetch_upstream/fetch_lastwin &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_lastwin
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch then --no-track drops fe=
tch' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_notrack &&
> > +     test_commit -C fetch_upstream u_notrack &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_notrack &&
> > +     test_must_fail git checkout --track=3Dfetch --no-track \
> > +             -b local_notrack fetch_upstream/fetch_notrack &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_notrack
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch,inherit fetches remote-t=
racking start-point' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_inherit &&
> > +     test_commit -C fetch_upstream u_inherit &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_inherit &&
> > +     git checkout --track=3Dfetch,inherit -b local_inherit \
> > +             fetch_upstream/fetch_inherit &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch,inherit errors when star=
t-point does not map to a remote' '
> > +     git checkout main &&
> > +     test_must_fail git checkout --track=3Dfetch,inherit -b bad main 2=
>err &&
> > +     test_grep "no configured remote" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/bad
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dfetch on local start-point err=
ors' '
> > +     git checkout main &&
> > +     test_must_fail git checkout --track=3Dfetch -b bad main 2>err &&
> > +     test_grep "no configured remote" err &&
> > +     test_must_fail git rev-parse --verify refs/heads/bad
> > +'
> > +
> > +test_expect_success 'checkout --track=3Dbogus reports an error' '
> > +     git checkout main &&
> > +     test_must_fail git checkout --track=3Dbogus -b bogus_branch fetch=
_upstream/fetch_new 2>err &&
> > +     test_grep "expects" err
> > +'
> > +
> > +test_expect_success 'checkout -q --track=3Dfetch silences the fetch ou=
tput' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_quiet &&
> > +     test_commit -C fetch_upstream u_quiet &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_quiet &&
> > +     git checkout -q --track=3Dfetch -b local_quiet \
> > +             fetch_upstream/fetch_quiet 2>err &&
> > +     test_grep ! "-> fetch_upstream/fetch_quiet" err &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_quiet HEAD
> > +'
> > +
> > +test_expect_success 'switch --track=3Dfetch -c picks up branch created=
 upstream after clone' '
> > +     git checkout main &&
> > +     git -C fetch_upstream checkout -b fetch_switch &&
> > +     test_commit -C fetch_upstream u_switch &&
> > +     test_must_fail git rev-parse --verify refs/remotes/fetch_upstream=
/fetch_switch &&
> > +     git switch --track=3Dfetch -c local_switch fetch_upstream/fetch_s=
witch &&
> > +     test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
> > +'
> > +
> >   test_done
>
