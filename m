Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7525771
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536458; cv=none; b=FqyuicAn2pbbDg6nprq/L1Wi5l7xXU0nzY96noFobj7aIcpYYBJGDETP0Bnlh10EvCMZ6d2gru0nmw1BD8b1KnI9lRYwmekE2TGAADGV7piMDmJ/W7m6VEz2ugYalE+zyfLMaYA9lS9gA5pdWwtIOMOlXEaY0u8/n1LrEdbd8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536458; c=relaxed/simple;
	bh=5ZwR6ZXz5fNYczNivk/OvyXxNPSyL+jwIs4bqgPZI5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I19AUqYNYpX14pZtsbynwEWOik9RD/6ZwOTEMyMB8m1RC5jVUoIDo7UOu6VTzAiHH+BR9LuC6xVfKwQ/uL2e8rpTkjkBBOy9ZAc7w4eRblHtXTHPD6E/Tk28u1HyHDusyQD7NSuAzyrK40pR/m5XrXS6h07wljJ9EK32TFi8/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=czs69133; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=H+tliS9T; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="czs69133";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="H+tliS9T"
DKIM-Signature: a=rsa-sha256; b=czs69133vASYpgh9gjuEssVTKSDyD0xsnomRODBmVwFO3Milmn63NIk9fr/Jr+Fc4B8BlaEYJvw+Ez8kgfwvVWVm4G4m1Kdf2NYyreaPGRe48pxnQZZEJkQ9td6ksrQqMn2lZHV+uRhGNpIhYcp6tzpYABrW08GpTeJ4OIaUTlUxZJQtD6Hd1e94ZTzKvF7TZpgbQFV/kh0090TdgWpiOkDVwHOwHGRL9NRCn5+81uGZHUljgve1OYhmJp+ja8tYWqkUP44Xc+IIpzIzcNmzb9msAy78x4vAtagzboAxAOuvJWW1F39nMUNfXUTtlGAQ/XDMra1Z0JyT0jf4NiCGUA==; s=purelymail1; d=malon.dev; v=1; bh=5ZwR6ZXz5fNYczNivk/OvyXxNPSyL+jwIs4bqgPZI5Q=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=H+tliS9TtIFQrr0JS65tI0zEqKt0Z2+ZgcNL0Rwql3S7yRavZdGVyXzvcpOi/dgHttHcvjag7Mk84342mTzbBewkr6KMP1aiFean9k6+UkxMXZ2Gux/NoSl5pzEHx/jumN2Ge5/smorUeixD+a80MSt8jvuz9WNF1NV7FFeZbz9v9aeCTOB0rUZcmDNQ020Pu+tYUrNrUWz6Npg02AMxK2NSR7wV6OvlC+jXeA/tfSToacAVAFb8eTPyYr6/EdKHtG4k8SeB8d5Y03SB6zSEtBDzrU5gfbN9KeJeetluIGIVeY/DZLnRUnECUyegF5wn7RFRMyMpqtPGZGUENg+OPQ==; s=purelymail1; d=purelymail.com; v=1; bh=5ZwR6ZXz5fNYczNivk/OvyXxNPSyL+jwIs4bqgPZI5Q=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -373694456;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 18 Apr 2026 18:20:45 +0000 (UTC)
Message-ID: <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
Date: Sun, 19 Apr 2026 02:20:41 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Jeff King <peff@peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Mirco,

On 4/19/26 00:47, Mirko Faina wrote:
> In a revision walk `--reverse` can only be applied after any commit
> limiting option. This makes getting a limited amount of commits from the
> tail impossible. E.g.
>=20
>      git log --reverse --max-count=3D3
>=20
> Some would expect this to give back the first 3 commits of the project.
> Instead it returns the last 3 but in reversed order.
>=20
> Teach `get_revision()` to accpet an argument `(after|before)` from the
> CLI, and apply the reversal before or after the commit limiting options
> based on this argument. If no argument is provided default to the
> current behaviour, applying `--reverse` after the commit limiting
> options.

Reasoning looks good to me.

Nit: I think we could gather more feedback on the naming. If I were a=20
user unfamiliar with how Git works, the most natural and intuitive=20
operation for me would be: "Show me the three *oldest* commits" (to be=20
more precise, *oldest* in the sense of topological order, rather than=20
the commit date or author date order. It=E2=80=99s really annoying. ), rath=
er=20
than "reverse the entire list and then select the three most recent=20
ones". I think the confusion arises because users do not (and should=20
not) know that '--max-count' only returns the most recent commits;=20
consequently, they might wonder: "Well, the 'after' and 'before'=20
parameters do make a difference, but why?". I believe it is best not to=20
lead users to this point.


> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>   Documentation/rev-list-options.adoc |  6 ++--
>   revision.c                          | 42 ++++++++++++++++++++++---
>   revision.h                          |  7 ++++-
>   t/t4202-log.sh                      | 49 +++++++++++++++++++++++++++++
>   4 files changed, 97 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list=
-options.adoc
> index 2d195a1474..eed1813a92 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -914,10 +914,12 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 =
1 (or 8 7 4 2 6 5
>   avoid showing the commits from two parallel development track mixed
>   together.
>  =20
> -`--reverse`::
> +`--reverse[=3D(after|before)]`::
>   =09Output the commits chosen to be shown (see 'Commit Limiting'
>   =09section above) in reverse order. Cannot be combined with
> -=09`--walk-reflogs`.
> +=09`--walk-reflogs`. `when` can either be `after` or `before`, if
> +=09omitted it defaults to `after`. If `before` is chosen,
> +=09`--reverse` will be applied before any commit limiting options.
>   endif::git-shortlog[]
>  =20
>   ifndef::git-shortlog[]
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..8338ea7448 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2685,8 +2685,26 @@ static int handle_revision_opt(struct rev_info *re=
vs, int argc, const char **arg
>   =09=09else
>   =09=09=09git_log_output_encoding =3D xstrdup("");
>   =09=09return argcount;
> -=09} else if (!strcmp(arg, "--reverse")) {
> -=09=09revs->reverse ^=3D 1;
> +=09} else if (starts_with(arg, "--reverse")) {
> +=09=09if (!skip_prefix(arg, "--reverse=3D", &optarg)) {
> +=09=09=09if (argc < 2) {
> +=09=09=09=09revs->reverse =3D 1;
> +=09=09=09=09return 1;
> +=09=09=09} else {
> +=09=09=09=09optarg =3D argv[1];
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (!strcmp(optarg, "after")) {
> +=09=09=09revs->reverse =3D 1;
> +=09=09} else if (!strcmp(optarg, "before")) {
> +=09=09=09revs->reverse =3D 2;
> +=09=09} else {
> +=09=09=09revs->reverse =3D 1;
> +=09=09=09return 1;
> +=09=09}
> +
> +=09=09return optarg =3D=3D argv[1] ? 2 : 1;
>   =09} else if (!strcmp(arg, "--children")) {
>   =09=09revs->children.name =3D "children";
>   =09=09revs->limited =3D 1;
> @@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *revs=
)
>   {
>   =09struct commit *c;
>   =09struct commit_list *reversed;
> +=09int max_count =3D revs->max_count;
> +
> +=09if (revs->reverse && !revs->reverse_output_stage) {
> +=09=09if (revs->reverse =3D=3D 3) {
> +=09=09=09BUG("allowed values for reverse are 0, 1 and 2");
> +=09=09=09revs->reverse =3D 1;
> +=09=09}
> +
> +=09=09if (revs->reverse =3D=3D 2)
> +=09=09=09revs->max_count =3D -1;

I think the space complexity here could be reduced a little. After all,=20
since we=E2=80=99re only retrieving a few commits, there=E2=80=99s no need =
to load the=20
entire reversed commit history into memory.

Perhaps we could maintain a window (or perhaps max heap) of finite length?

>  =20
> -=09if (revs->reverse) {
>   =09=09reversed =3D NULL;
>   =09=09while ((c =3D get_revision_internal(revs)))
>   =09=09=09commit_list_insert(c, &reversed);
>   =09=09commit_list_free(revs->commits);
>   =09=09revs->commits =3D reversed;
> -=09=09revs->reverse =3D 0;
>   =09=09revs->reverse_output_stage =3D 1;
> +
> +=09=09if (revs->reverse =3D=3D 2)
> +=09=09=09revs->max_count =3D max_count;
>   =09}
>  =20
>   =09if (revs->reverse_output_stage) {
> +=09=09if (revs->reverse =3D=3D 2 && revs->max_count =3D=3D 0)
> +=09=09=09return NULL;
> +
>   =09=09c =3D pop_commit(&revs->commits);
> +=09=09if (revs->reverse =3D=3D 2)
> +=09=09=09revs->max_count--;
>   =09=09if (revs->track_linear)
>   =09=09=09revs->linear =3D !!(c && c->object.flags & TRACK_LINEAR);
>   =09=09return c;
> diff --git a/revision.h b/revision.h
> index 584f1338b5..5b23343f17 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -196,7 +196,12 @@ struct rev_info {
>   =09=09=09rewrite_parents:1,
>   =09=09=09print_parents:1,
>   =09=09=09show_decorations:1,
> -=09=09=09reverse:1,
> +=09=09=09/*
> +=09=09=09 * 0 no reverse
> +=09=09=09 * 1 after
> +=09=09=09 * 2 before
> +=09=09=09 */
> +=09=09=09reverse:2,
>   =09=09=09reverse_output_stage:1,
>   =09=09=09cherry_pick:1,
>   =09=09=09cherry_mark:1,
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 05cee9e41b..21e9a61994 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1882,6 +1882,55 @@ test_expect_success 'log --graph with --name-statu=
s' '
>   =09test_cmp_graph --name-status tangle..reach
>   '
>  =20
> +cat >expect <<-\EOF
> +c3f451c Merge tag 'reach'
> +046b221 to remove
> +EOF
> +
> +test_expect_success 'log --reverse --oneline --max-count=3D2' '
> +=09test_when_finished git reset --hard HEAD~1 &&
> +=09touch to_remove &&
> +=09git add to_remove &&
> +=09git commit -m "to remove" &&
> +=09git log --reverse --oneline --max-count=3D2 >actual &&
> +=09test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse after --oneline --max-count=3D2' '
> +=09test_when_finished git reset --hard HEAD~1 &&
> +=09touch to_remove &&
> +=09git add to_remove &&
> +=09git commit -m "to remove" &&
> +=09git log --reverse after --oneline --max-count=3D2 >actual &&
> +=09test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse=3Dafter --oneline --max-count=3D2' '
> +=09test_when_finished git reset --hard HEAD~1 &&
> +=09touch to_remove &&
> +=09git add to_remove &&
> +=09git commit -m "to remove" &&
> +=09git log --reverse=3Dafter --oneline --max-count=3D2 >actual &&
> +=09test_cmp expect actual
> +'
> +
> +cat >expect <<-\EOF
> +3a2fdcb initial
> +f7dab8e second
> +EOF
> +
> +test_expect_success 'log --reverse before --oneline --max-count=3D2' '
> +=09test_when_finished rm actual &&
> +=09git log --reverse before --oneline --max-count=3D2 >actual &&
> +=09test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse=3Dbefore --oneline --max-count=3D2' '
> +=09test_when_finished rm actual &&
> +=09git log --reverse=3Dbefore --oneline --max-count=3D2 >actual &&
> +=09test_cmp expect actual
> +'
> +
>   cat >expect <<-\EOF
>   * reach
>   |
>=20
> base-commit: e8955061076952cc5eab0300424fc48b601fe12d

Regards, Yuchen

