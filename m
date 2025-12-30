Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2E24DCE2
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135141; cv=none; b=cHY10TnVZ2Z2vgfcCBnkR+nsZ2CfBL1R2lT4Mu4njXrpLvRwM2g39RsArTGOg3nX/hf+kSotF9/4JwqCpoSWaijUABf0bptTBwOaGuT/q1M2EmdryQLsH4GOV8YquUaqGZ4ANR5Ok5h35/kTYRVWEWqs4JctwKbkua9kfaiaRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135141; c=relaxed/simple;
	bh=IEuAvdCsq8CGyG0XPdB9hTCirRHBJcNOUxQ0k2moQJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De0QPpur7l/cfDclJtb4UFhSPXaGGWNxPXcf2RgpajBPjCAt/cGLdDZvd8UP/zZE5riU5KoSXWR0kVs+Ze2QbvzpLTwUfO16VE4ge6P4RSLNp6Joyo1lJjM2mZrlFR3tkusFxqlgR/s+jlImiJ3n+rhbMxN4OEvdaO7tqtuixnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Ud2GOR; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Ud2GOR"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6598413b604so6394817eaf.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135138; x=1767739938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ekzc8QNImRgS9/uLoQalR/kWrefV6PYU5mFblkPmSU=;
        b=g6Ud2GORN7y3gRksZ9zrtV/Ai9cRKaoqm0fMrP/hocLfcHKFKfzvQ5+4OhjJYikjUo
         m+NEe4UOKln/6L8sqPDdETLof5Bll0x8nN7xoqxG9n/q2iQ4VoZgQ4DnoS1sCkIxkyKB
         6IifwpSN5HM4R3APK29gRmOaaBY6jYMEUOz9y4romPt+jfsCIUpQsiseqU5yUdhxsePM
         EtvUePwGb/01DA3OaKQhrIfceGK/wb4GDxKUYcVT1VNjlsboeqW9HsWpIcmM7tJlfmCx
         ARNrtDOCP1rEEuzXbByOPm/Vg1ktDSRkWEYfHdcphCiA3Jqe1hGKvFMJgfgOAbRxJ3M3
         knmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135138; x=1767739938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Ekzc8QNImRgS9/uLoQalR/kWrefV6PYU5mFblkPmSU=;
        b=f8hUVq8W3FV4OpwHFMdAPv3U7cNW6rB8gHJHXqSM1dWHmBQY70sp/q4Vbl/PQPokiI
         fZ1eXR4fEWTvPzDIIKyeRc39UPFk/Yk0xeM6XZGIRnioixm0T2Zrbdr4RJu4b5io56Dt
         C7J0zylcMVmNBiyT1uf70duUh8tM3sltxoLOM0cSSnqZGrvXdD1rMNfemGV/M7Aincl9
         tdWPprDqtRmavEAg9AChltrMP4mHFGwdZOPVwqP7/AxAhpZ1mmXvr4qmw0Uw7hBzt0cn
         dAaPpdOzpDKPTJYgnFT6tgheRYGqU41ae87h2Xx0pW7ChK9CrJeoG7wslTUfuHHIxhjx
         D0Kw==
X-Gm-Message-State: AOJu0YyK/zWhjPfPsJbLAnz5RGAGyYBR2umEgdGR8coExdJyvlsvuT4z
	ljpX6TrORz2MkrX0YQLwgRNaOrGyaKHboxPcRh9LfWhG3Yvp9hWPF3mnyDSyyzXNXRYiMTiC/ek
	WaNYI2veHz9ORKyrgMGdgf3n9w+03miw=
X-Gm-Gg: AY/fxX6fjiahyImJmTkKbO7fUpEjOpElaDWz/MbLb4mrAfme9OHg4N3NQcddUD8Hy2O
	OF25OS2BjHcoC/ahhAh3ChtJu4hZ+Z0F55/wOpdqMxanArur3yomOTAwhmXw2F7lhaZhZpstYvv
	zDbmcCD+N2lSOg/g+5Su4+r/VipVev8sHfUAgl79HbESaaoMjsWNOa4nmYNyzwSR14TtNY9iBDW
	ho/UL13vodAIy5XhEJxU++mQsFqZm+mkqSmduGTnnHPPdzJ5Zu4/2jCpS2or6BPzfLeTK/lVA3v
	N9qRsAHHSw4r4IMb8RdixsYr3jrm
X-Google-Smtp-Source: AGHT+IFDD3QSHUcqWqQ8vWxoPtXs5iUSaf3vonQ9mFsVizF+1/YwK9wXO5aUqZ8qwJKywcPbcpCJvPOSCMkwgrY8v+U=
X-Received: by 2002:a05:6820:438c:b0:65b:33a3:7c8 with SMTP id
 006d021491bc7-65d0e9c2953mr9723068eaf.30.1767135138508; Tue, 30 Dec 2025
 14:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
 <V2_replay_die_descr.17e@msgid.xyz>
In-Reply-To: <V2_replay_die_descr.17e@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 30 Dec 2025 14:52:07 -0800
X-Gm-Features: AQt7F2rsM0bcGzO298DD-YxnQRqUk3drcXF4-tNNdAmAtnyQqxpJU1zucZF6yuM
Message-ID: <CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] replay: die descriptively when invalid commit-ish
 is given
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:03=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Giving an invalid commit-ish to `--onto` makes git-replay(1) fail with:
>
>     fatal: Replaying down to root commit is not supported yet!
>
> Going backwards from this point:
>
> 1. `onto` is `NULL` from `determine_replay_mode`;

`determine_replay_mode` no longer exists due to your new patch 1.

> 2. that function in turn calls `peel_committish`; and
> 3. here we return `NULL` if `repo_get_oid` fails.
>
> Let=E2=80=99s die immediately with a descriptive error message instead.
>
> Doing this also provides us with a descriptive error if we =E2=80=9Cforge=
t=E2=80=9D to
> provide an argument to `--onto` (but we really do unintentionally):[1]
>
>     $ git replay --onto ^main topic1
>     fatal: '^main' is not a valid commit-ish
>
> Note that the `--advance` case won=E2=80=99t be triggered in practice bec=
ause
> of the =E2=80=9Cargument to --advance must be a reference=E2=80=9D check =
(see the
> previous test, and commit).
>
> =E2=80=A0 1: The argument to `--onto` is mandatory and the option parser =
accepts
>      both `--onto=3D<name>` (stuck form) and `--onto name`. The latter
>      form makes it easy to unintentionally pass something to the option
>      when you really meant to pass a positional argument.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2:
>
>     Let=E2=80=99s use a slightly longer subject line in the commit messag=
e so that it
>     looks more like a full sentence (no dropped/implied words).[1]
>
>     Also remove the test for `--advance` which is now wrong because of th=
e
>     previous commit/patch. And reword the commit message now that only `-=
-onto`
>     is relevant in practice.
>
>     There was also feedback about *where* to give this error:[2]
>
>     > How many callers use this function?  I am wondering if it is better
>     > to give a better message at the caller(s), rather than here, where
>     > we lack context to tell something like "You gave string 'ource' as
>     > the argument to the '--onto' option, but 'ource' does not name any
>     > commit" (in other words, "for what our caller is trying to peel
>     > <name> to a commit").
>
>     But I opted to keep the check here by using the new `mode` parameter =
to
>     provide the context; it is either `--onto` or `--advance`.
>
>     Also remove the =E2=80=9Cnot supported yet=E2=80=9D now that `*onto` =
cannot be `NULL` at
>     this point. I wasn=E2=80=99t confident enough to pull the trigger on =
that in the
>     first round. But after Elijah=E2=80=99s comment[3] I feel like I unde=
rstand the code
>     well enough.
>
>     Also change the test to use printf since it=E2=80=99s only one line. =
That will be
>     in line with the later commits/patches here.
>
>     =F0=9F=94=97 1: https://lore.kernel.org/git/xmqqecolrip7.fsf@gitster.=
g/
>     =F0=9F=94=97 2: https://lore.kernel.org/git/xmqqikdxriw3.fsf@gitster.=
g/
>     =F0=9F=94=97 3: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgW=
T5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com/
>
>  builtin/replay.c         | 15 +++++++--------
>  t/t3650-replay-basics.sh |  7 +++++++
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 35813140e99..07a6767ade1 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -25,17 +25,19 @@ static const char *short_commit_name(struct repositor=
y *repo,
>  {
>         return repo_find_unique_abbrev(repo, &commit->object.oid,
>                                        DEFAULT_ABBREV);
>  }
>
> -static struct commit *peel_committish(struct repository *repo, const cha=
r *name)
> +static struct commit *peel_committish(struct repository *repo,
> +                                     const char *name,
> +                                     const char *mode)
>  {
>         struct object *obj;
>         struct object_id oid;
>
>         if (repo_get_oid(repo, name, &oid))
> -               return NULL;
> +               die(_("'%s' is not a valid commit-ish for %s"), name, mod=
e);
>         obj =3D parse_object(repo, &oid);
>         return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
>                                                   OBJ_COMMIT);
>  }
>
> @@ -170,11 +172,11 @@ static void populate_for_onto_or_advance_mode(struc=
t repository *repo,
>                 die(_("need some commits to replay"));
>
>         die_for_incompatible_opt2(!!onto_name, "--onto",
>                                   !!*advance_name, "--advance");
>         if (onto_name) {
> -               *onto =3D peel_committish(repo, onto_name);
> +               *onto =3D peel_committish(repo, onto_name, "--onto");
>                 if (rinfo.positive_refexprs <
>                     strset_get_size(&rinfo.positive_refs))
>                         die(_("all positive revisions given must be refer=
ences"));
>                 *update_refs =3D xcalloc(1, sizeof(**update_refs));
>                 **update_refs =3D rinfo.positive_refs;
> @@ -191,11 +193,11 @@ static void populate_for_onto_or_advance_mode(struc=
t repository *repo,
>                         free(*advance_name);
>                         *advance_name =3D fullname;
>                 } else {
>                         die(_("argument to --advance must be a reference"=
));
>                 }
> -               *onto =3D peel_committish(repo, *advance_name);
> +               *onto =3D peel_committish(repo, *advance_name, "--advance=
");
>                 if (rinfo.positive_refexprs > 1)
>                         die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));
>         }
>         strset_clear(&rinfo.negative_refs);
>         strset_clear(&rinfo.positive_refs);
> @@ -349,13 +351,10 @@ int cmd_replay(int argc,
>
>         populate_for_onto_or_advance_mode(repo, &revs.cmdline,
>                                           onto_name, &advance_name,
>                                           &onto, &update_refs);
>
> -       if (!onto) /* FIXME: Should handle replaying down to root commit =
*/
> -               die("Replaying down to root commit is not supported yet!"=
);
> -

Removing the `if` makes sense given the current code, but I wonder if
we should keep a corrected FIXME here:
    /* FIXME: Should allow replaying commits with the first as a root commi=
t */

This is out-of-scope for this series, but behind that FIXME...

 I'm guessing the user would specify to cherry-pick onto NULL via something=
 like
   git replay --root A..B
which would translate into making `onto` be NULL, and mean that the
first commit after A would be a root commit.

Similarly the user could be allowed to do something like
  git replay --advance new-empty-branch A..B
where new-empty-branch doesn't yet point to a commit, this would also
result in `onto` being NULL, and start new-empty-branch by
cherry-picking some commits into it.

>         if (prepare_revision_walk(&revs) < 0) {
>                 ret =3D error(_("error preparing revisions"));
>                 goto cleanup;
>         }
>
> @@ -367,11 +366,11 @@ int cmd_replay(int argc,
>         while ((commit =3D get_revision(&revs))) {
>                 const struct name_decoration *decoration;
>                 khint_t pos;
>                 int hr;
>
> -               if (!commit->parents)
> +               if (!commit->parents) /* FIXME: Should handle replaying d=
own to root commit */
>                         die(_("replaying down to root commit is not suppo=
rted yet!"));

I wonder if I should have written s/to/from/ here ?


>                 if (commit->parents->next)
>                         die(_("replaying merge commits is not supported y=
et!"));
>
>                 last_commit =3D pick_regular_commit(repo, commit, replaye=
d_commits,
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 7dea62f064f..d4399aa1662 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -56,10 +56,17 @@ test_expect_success 'argument to --advance must be a =
reference' '
>         oid=3D$(git rev-parse main) &&
>         test_must_fail git replay --advance=3D$oid topic1..topic2 2>actua=
l &&
>         test_cmp expect actual
>  '
>
> +test_expect_success '--onto with invalid commit-ish' '
> +       printf "fatal: ${SQ}refs/not-valid${SQ} is not " >expect &&
> +       printf "a valid commit-ish for --onto\n" >>expect &&
> +       test_must_fail git replay --onto=3Drefs/not-valid topic1..topic2 =
2>actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'using replay to rebase two branches, one on top of =
other' '
>         git replay --onto main topic1..topic2 >result &&
>
>         test_line_count =3D 1 result &&
>
> --
> 2.52.0.10.g08704017180
