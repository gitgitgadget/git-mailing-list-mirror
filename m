Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6F203710
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686682; cv=none; b=rS2tAaJPoNBaqpo+qcuhoSlYQ/Z+Q30aybn+uSRZ7cKZE+TqEZsoVQuKjcoMWmzBlkK82o36/GUp6D9glLiwEo/kC7p+1jBv1B2QmhvotvLPfjKXefYcJndF9sSyK/xSpUGnOpGaagyuHESxbpv5y4a0B2dunkmamr3hT4lXiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686682; c=relaxed/simple;
	bh=7b78SBG7Op7q0ByVjuSQteBqGOGR9uivrG3YSJIJp68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ES+zzCq4LBsnamPgdv1bDnRuBVHuOI5Zn17O706kReeUCYMrMxGS4jdGWRclX4nTACMTP7qW+lpwncNZ/pESSh5h3q+BY4SkyarWzH3ciijnTdd3gP4ib67OFMIxemEJX0K7GGWz2WiipeBtXa1l7mXLHfloatkDTyuXrm3jJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu7OWzXh; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu7OWzXh"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85e15dc8035so162277939f.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744686679; x=1745291479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp8zHizbmOHjw0ksQcnJxntc2Iv0P2Jih++MFgF3kms=;
        b=cu7OWzXh7yToMpNrVofm/820CQS7Uiloo2r9Q0czk4PHeBG4yjEIDpBnDsLbOaD8gn
         pp3Gi+gbwoF73RkVx0SCMKCK071R9SFuc4n1iXCdrD+mMYi+NdYx45RvdhTNCrxO76Lg
         uQmWogmSoyxruyQWkiiwm0K3Pgo2dYuGr8rJAQ5z5vFfPs0EY3JpsZt3QsXnd6iMByjV
         tRDO3SJBMS2Pgjm20illmacMXkIGs/gQ0qc3CgQA6DNnKekag8iK4z/VLpVqqrwt+d0F
         L8IdWnGuZBWrN6YSkXYgFCyIbKSHjIHZpSDYKJljRxKQ5omEz3SfpoTAsQBI9u7xgif4
         q5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686679; x=1745291479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp8zHizbmOHjw0ksQcnJxntc2Iv0P2Jih++MFgF3kms=;
        b=eXlK+ZCie0myc/eRo7YoQmPUsvr14GLqj5vdjghr+7yuI5KdcYwq/+q9Cjju7boBmJ
         FRusQaRIXoftNd6SVnmuBwvpVEPRIf+hFz/iw2xaoIzpN8wrg5BA5Jf6BnwkBd2Pf+rS
         WM0lKAlCGT2GBsbSLBBKZrHMhAn48pDrsILYaLMxjPqMPuR6ldtkqhFURvNzcmxYANY9
         9rkeU5z2cM6O13UmJTRWkI142jsZusyFd65G7GD+IunV17HRglxiuVggh+k71R/DKrYg
         aaxiM4drWrq/KnN+vT0yGxgu7njoRJi6GAPVld8nNxG17ZUfUPN/A4aodh49DZhH6LOs
         E7HQ==
X-Gm-Message-State: AOJu0Yz/zLerwgDpUAlQ+m0vCcZSinelFxznrt7A7Ed+IMbbRMxmWlLp
	vOHnca509pmLdKhLBQh51eJFc953CAgLyIZ5wcmrOSeUUEfhugEPr95DwHG9uveNiFY0MvL5swX
	45I4fijcHudqx8AXVkPOadwvGgWY=
X-Gm-Gg: ASbGncs8HH71mpDngZ0aW/j9mJs4mvI2lxKyiS6zUbNshSUeFNkLo6mvy/1B+fdZ3p4
	9nB5SqrcUNU3v7dMnwlXnxdRv+VPyEewUXcS8nQjrhOBO+2opJDPlstMVV8XJ3jloeNc4kWxxJK
	TyxaQ8tqY/4wDX1kjb1Mv71BVXFMeBZkj7Fibe+i2qB0AHZb93IIITv14=
X-Google-Smtp-Source: AGHT+IGP/9MLz6c15e5rH8yVmwm6nWL453lZQ1DY80sz+0lekIOWDDKVOuFPbPa0AEPHDX+EgF+/CuxsG+/S3eb+PrQ=
X-Received: by 2002:a05:6602:3a17:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-8617cc5f3e2mr1665014439f.12.1744686679426; Mon, 14 Apr 2025
 20:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <697a337cb147ed638884cf9b8605fef8b572e1c6.1744661167.git.me@ttaylorr.com>
In-Reply-To: <697a337cb147ed638884cf9b8605fef8b572e1c6.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 20:11:08 -0700
X-Gm-Features: ATxdqUG97eAHg4RoZKm3En1OM_oqZMzqlzauzjPkCxzZim-3FhXmmdAARXGoxTM
Message-ID: <CABPp-BFBJP15g=4M90161=KCDei-hEFdnGs7_oY8ERtqgn9s-g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] pack-objects: introduce '--stdin-packs=follow'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> When invoked with '--stdin-packs', pack-objects will generate a pack
> which contains the objects found in the "included" packs, less any
> objects from "excluded" packs.
>
> Packs that exist in the repository but weren't specified as either
> included or excluded are in practice treated like the latter, at least
> in the sense that pack-objects won't include objects from those packs.
> This behavior forces us to include any cruft pack(s) in a repository's
> multi-pack index for the reasons described in ddee3703b3
> (builtin/repack.c: add cruft packs to MIDX during geometric repack,
> 2022-05-20).
>
> The full details are in ddee3703b3, but the gist is if you
> have a once-unreachable object in a cruft pack which later becomes
> reachable via one or more commits in a pack generated with
> '--stdin-packs', you *have* to include that object in the MIDX via the
> copy in the cruft pack, otherwise we cannot generate reachability
> bitmaps for any commits which reach that object.
>
> This prepares us for new repacking behavior which will "resurrect"
> objects found in cruft or otherwise unspecified packs when generating
> new packs. In the context of geometric repacking, this may be used to
> maintain a sequence of geometrically-repacked packs, the union of which
> is closed under reachability, even in the case described earlier.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-pack-objects.adoc |   8 ++-
>  builtin/pack-objects.c              |  89 +++++++++++++++++-------
>  t/t5331-pack-objects-stdin.sh       | 101 ++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack=
-objects.adoc
> index 7f69ae4855..c894582799 100644
> --- a/Documentation/git-pack-objects.adoc
> +++ b/Documentation/git-pack-objects.adoc
> @@ -87,13 +87,19 @@ base-name::
>         reference was included in the resulting packfile.  This
>         can be useful to send new tags to native Git clients.
>
> ---stdin-packs::
> +--stdin-packs[=3D<mode>]::
>         Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
>         from the standard input, instead of object names or revision
>         arguments. The resulting pack contains all objects listed in the
>         included packs (those not beginning with `^`), excluding any
>         objects listed in the excluded packs (beginning with `^`).
>  +
> +When `mode` is "follow", pack objects which are reachable from objects
> +in the included packs, but appear in packs that are not listed.
> +Reachable objects which appear in excluded packs are not packed. Useful
> +for resurrecting once-cruft objects to generate packs which are closed
> +under reachability up to the excluded packs.

Maybe:

When `mode` is "follow", objects from packs not listed on stdin
receive special treatment.  Objects within unlisted packs will be
included if those objects (1) are reachable from the included packs,
and (2) are not also found in any of the excluded packs.  This mode is
useful for resurrecting once-cruft objects to generate packs which are
closed under reachability up to the boundary set by the excluded
packs.

> ++
>  Incompatible with `--revs`, or options that imply `--revs` (such as
>  `--all`), with the exception of `--unpacked`, which is compatible.
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2aa12da4af..6406f4a5b1 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -272,6 +272,12 @@ static struct oidmap configured_exclusions;
>  static struct oidset excluded_by_config;
>  static int name_hash_version =3D -1;
>
> +enum stdin_packs_mode {
> +       STDIN_PACKS_MODE_NONE,
> +       STDIN_PACKS_MODE_STANDARD,
> +       STDIN_PACKS_MODE_FOLLOW,
> +};
> +
>  /**
>   * Check whether the name_hash_version chosen by user input is appropria=
te,
>   * and also validate whether it is compatible with other features.
> @@ -3511,32 +3517,43 @@ static int add_object_entry_from_pack(const struc=
t object_id *oid,
>         return 0;
>  }
>
> -static void show_commit_pack_hint(struct commit *commit UNUSED,
> -                                 void *data UNUSED)
> -{
> -       /* nothing to do; commits don't have a namehash */
> -}
> -
>  static void show_object_pack_hint(struct object *object, const char *nam=
e,
> -                                 void *data UNUSED)
> +                                 void *data)
>  {
> -       struct object_entry *oe =3D packlist_find(&to_pack, &object->oid)=
;
> -       if (!oe)
> +       enum stdin_packs_mode mode =3D *(enum stdin_packs_mode *)data;
> +       if (mode =3D=3D STDIN_PACKS_MODE_FOLLOW) {
> +               add_object_entry(&object->oid, object->type, name, 0);
> +       } else {
> +               struct object_entry *oe =3D packlist_find(&to_pack, &obje=
ct->oid);
> +               if (!oe)
> +                       return;
> +
> +               /*
> +                * Our 'to_pack' list was constructed by iterating all
> +                * objects packed in included packs, and so doesn't
> +                * have a non-zero hash field that you would typically
> +                * pick up during a reachability traversal.
> +                *
> +                * Make a best-effort attempt to fill in the ->hash
> +                * and ->no_try_delta here using a now in order to
> +                * perhaps improve the delta selection process.
> +                */

I know you just moved this paragraph from below...but it doesn't parse
for me.  "using a now in order to perhaps"?  What does that mean?

> +               oe->hash =3D pack_name_hash_fn(name);
> +               oe->no_try_delta =3D name && no_try_delta(name);
> +
> +               stdin_packs_hints_nr++;
> +       }
> +}
> +
> +static void show_commit_pack_hint(struct commit *commit, void *data)
> +{
> +       enum stdin_packs_mode mode =3D *(enum stdin_packs_mode *)data;
> +       if (mode =3D=3D STDIN_PACKS_MODE_FOLLOW) {
> +               show_object_pack_hint((struct object *)commit, "", data);
>                 return;
> +       }
> +       /* nothing to do; commits don't have a namehash */
>
> -       /*
> -        * Our 'to_pack' list was constructed by iterating all objects pa=
cked in
> -        * included packs, and so doesn't have a non-zero hash field that=
 you
> -        * would typically pick up during a reachability traversal.
> -        *
> -        * Make a best-effort attempt to fill in the ->hash and ->no_try_=
delta
> -        * here using a now in order to perhaps improve the delta selecti=
on
> -        * process.
> -        */
> -       oe->hash =3D pack_name_hash_fn(name);
> -       oe->no_try_delta =3D name && no_try_delta(name);
> -
> -       stdin_packs_hints_nr++;
>  }

It might be worth swapping the order of functions as a preparatory
patch (both here and when you've done it elsewhere in this series),
just because it'll make the diff so much easier to read when we can
see the changes to the function without have to also deal with the
order swapping (since order swapping looks like a large deletion and
large addition of one of the two functions).

>  static int pack_mtime_cmp(const void *_a, const void *_b)
> @@ -3644,7 +3661,7 @@ static void read_packs_list_from_stdin(struct rev_i=
nfo *revs)
>
>  static void add_unreachable_loose_objects(struct rev_info *revs);
>
> -static void read_stdin_packs(int rev_list_unpacked)
> +static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_un=
packed)
>  {
>         struct rev_info revs;
>
> @@ -3676,7 +3693,7 @@ static void read_stdin_packs(int rev_list_unpacked)
>         traverse_commit_list(&revs,
>                              show_commit_pack_hint,
>                              show_object_pack_hint,
> -                            NULL);
> +                            &mode);
>
>         trace2_data_intmax("pack-objects", the_repository, "stdin_packs_f=
ound",
>                            stdin_packs_found_nr);
> @@ -4467,6 +4484,23 @@ static int is_not_in_promisor_pack(struct commit *=
commit, void *data) {
>         return is_not_in_promisor_pack_obj((struct object *) commit, data=
);
>  }
>
> +static int parse_stdin_packs_mode(const struct option *opt, const char *=
arg,
> +                                 int unset)
> +{
> +       enum stdin_packs_mode *mode =3D opt->value;
> +
> +       if (unset)
> +               *mode =3D STDIN_PACKS_MODE_NONE;
> +       else if (!arg || !*arg)
> +               *mode =3D STDIN_PACKS_MODE_STANDARD;

I don't understand why you have both a None mode and a Standard mode,
especially since the implementation seems to only care about whether
or not the Follow mode has been set.  Shouldn't these both be setting
mode to the same value?

> +       else if (!strcmp(arg, "follow"))
> +               *mode =3D STDIN_PACKS_MODE_FOLLOW;
> +       else
> +               die(_("invalid value for '%s': '%s'"), opt->long_name, ar=
g);
> +
> +       return 0;
> +}
> +
>  int cmd_pack_objects(int argc,
>                      const char **argv,
>                      const char *prefix,
> @@ -4478,7 +4512,7 @@ int cmd_pack_objects(int argc,
>         struct strvec rp =3D STRVEC_INIT;
>         int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =
=3D 0;
>         int rev_list_index =3D 0;
> -       int stdin_packs =3D 0;
> +       enum stdin_packs_mode stdin_packs =3D STDIN_PACKS_MODE_NONE;
>         struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
>         struct list_objects_filter_options filter_options =3D
>                 LIST_OBJECTS_FILTER_INIT;
> @@ -4533,6 +4567,9 @@ int cmd_pack_objects(int argc,
>                 OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
>                               N_("include objects referred to by the inde=
x"),
>                               1, PARSE_OPT_NONEG),
> +               OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode")=
,
> +                            N_("read packs from stdin"),
> +                            PARSE_OPT_OPTARG, parse_stdin_packs_mode),
>                 OPT_BOOL(0, "stdin-packs", &stdin_packs,
>                          N_("read packs from stdin")),
>                 OPT_BOOL(0, "stdout", &pack_to_stdout,
> @@ -4788,7 +4825,7 @@ int cmd_pack_objects(int argc,
>                 progress_state =3D start_progress(the_repository,
>                                                 _("Enumerating objects"),=
 0);
>         if (stdin_packs) {
> -               read_stdin_packs(rev_list_unpacked);
> +               read_stdin_packs(stdin_packs, rev_list_unpacked);
>         } else if (cruft) {
>                 read_cruft_objects();
>         } else if (!use_internal_rev_list) {
> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.s=
h
> index 4f5e2733a2..f97d2d1b71 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -236,4 +236,105 @@ test_expect_success 'pack-objects --stdin with pack=
files from main and alternate
>         test_cmp expected-objects actual-objects
>  '
>
> +packdir=3D.git/objects/pack
> +
> +objects_in_packs () {
> +       for p in "$@"
> +       do
> +               git show-index <"$packdir/pack-$p.idx" || return 1
> +       done >objects.raw &&
> +
> +       cut -d' ' -f2 objects.raw | sort &&
> +       rm -f objects.raw
> +}
> +
> +test_expect_success 'setup for --stdin-packs=3Dfollow' '
> +       git init stdin-packs--follow &&
> +       (
> +               cd stdin-packs--follow &&
> +
> +               for c in A B C D
> +               do
> +                       test_commit "$c" || return 1
> +               done &&
> +
> +               A=3D"$(echo A | git pack-objects --revs $packdir/pack)" &=
&
> +               B=3D"$(echo A..B | git pack-objects --revs $packdir/pack)=
" &&
> +               C=3D"$(echo B..C | git pack-objects --revs $packdir/pack)=
" &&
> +               D=3D"$(echo C..D | git pack-objects --revs $packdir/pack)=
" &&
> +
> +               git prune-packed
> +       )
> +'
> +
> +test_expect_success '--stdin-packs=3Dfollow walks into unknown packs' '
> +       test_when_finished "rm -fr repo" &&
> +
> +       git init repo &&
> +       (
> +               cd repo &&
> +
> +               for c in A B C D
> +               do
> +                       test_commit "$c" || return 1
> +               done &&
> +
> +               A=3D"$(echo A | git pack-objects --revs $packdir/pack)" &=
&
> +               B=3D"$(echo A..B | git pack-objects --revs $packdir/pack)=
" &&
> +               C=3D"$(echo B..C | git pack-objects --revs $packdir/pack)=
" &&
> +               D=3D"$(echo C..D | git pack-objects --revs $packdir/pack)=
" &&
> +
> +               git prune-packed &&
> +
> +               cat >in <<-EOF &&
> +               pack-$B.pack
> +               ^pack-$C.pack
> +               pack-$D.pack
> +               EOF
> +
> +               # With just --stdin-packs, pack "A" is unknown to us, so
> +               # only objects from packs "B" and "D" are included in
> +               # the output pack.
> +               P=3D$(git pack-objects --stdin-packs $packdir/pack <in) &=
&
> +               objects_in_packs $B $D >expect &&
> +               objects_in_packs $P >actual &&
> +               test_cmp expect actual &&
> +
> +               # But with --stdin-packs=3Dfollow, objects from both
> +               # included packs reach objects from the unknown pack, so
> +               # objects from pack "A" is included in the output pack
> +               # in addition to the above.
> +               P=3D$(git pack-objects --stdin-packs=3Dfollow $packdir/pa=
ck <in) &&
> +               objects_in_packs $A $B $D >expect &&
> +               objects_in_packs $P >actual &&
> +               test_cmp expect actual &&
> +
> +               test_commit E &&
> +               # And with --unpacked, we will pick up objects from unkno=
wn
> +               # packs that are reachable from loose objects. Loose obje=
ct E
> +               # reaches objects in pack A, but there are three excluded=
 packs
> +               # in between.
> +               #
> +               # The resulting pack should include objects reachable fro=
m E
> +               # that are not present in packs B, C, or D, along with th=
ose
> +               # present in pack A.
> +               cat >in <<-EOF &&
> +               ^pack-$B.pack
> +               ^pack-$C.pack
> +               ^pack-$D.pack
> +               EOF
> +
> +               P=3D$(git pack-objects --stdin-packs=3Dfollow --unpacked =
\
> +                       $packdir/pack <in) &&
> +
> +               {
> +                       objects_in_packs $A &&
> +                       git rev-list --objects --no-object-names D..E
> +               }>expect.raw &&
> +               sort expect.raw >expect &&
> +               objects_in_packs $P >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
> --
> 2.49.0.229.gc267761125.dirty

I like the tests -- normal --stdin-packs, then --stdin-packs=3Dfollow,
then --stdin-packs=3Dfollow + --unpacked.

However, would it be worthwhile to create commit E immediately after
creating the packs?

Currently, the third test shows us that unpacked objects are included
when --unpacked is passed.  But the tests don't let us know whether
that flag is necessary, i.e. whether unpacked objects will just be
included anyway.  If you move the creation of commit E as a loose
object immediately after the pack creation and before all the tests,
then these same tests demonstrate this additional bit of information.
