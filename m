Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D6C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC16161077
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhEDPUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 11:20:53 -0400
Received: from mout.web.de ([212.227.17.11]:53773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230254AbhEDPUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 11:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1620141595;
        bh=KjSm7+FnMURcyERlM0nBeP9D80+3//SVizN1Bnwuas4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=P7JOXtK2j6k0NXiE+XStos/cCGAUBukJPd95YH3qwaas+rdvvqMMD3s/TdBsDININ
         7YCPNllF4l/piaikAEzKvPhdTpusStlMkX7BPTIGwa+IunMPe5WpTHP52BI7xqLAHM
         vh0VyKV2q7Tp2O5HcwEmzUBzgltsZDa0I4ypwPLs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyRS-1lXwLh1RMo-012U7j; Tue, 04
 May 2021 17:19:55 +0200
Date:   Tue, 4 May 2021 17:19:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Mark Amery <markrobertamery@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:JtIP3KSAhx4MEpARV/DXZH4jcxcsUQQtEiDvTa1WoyYO1U6Uxlr
 VldL9Q/AKo/4c9D/aPfiaUJ8E8NRDikUVWyZyFfi+SS6yI2CIOvNDJt+Xhjv1svV72Pn0fF
 wyNTYCCHtR3U+6DwisY9tti5M+YaOGueghXZSV9i1pe4SGEcqroeWik8y5lHjzZeJ6f7T68
 LEDldyH6RkONVxIHarrVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fzLBV6ICf80=:jlPWwWOnrFvyfi2X238Q1N
 037cUYQlTPYY2uHp2LuFydrTRu2vdCgXgs8PVDbfTCvJ6B9HrtaxdCl/BFH9PnXYVdgR1DIEv
 fszZgMsVPfTcv7+gY3p4egVXV05qp+o8t0P1ArYMvRe21JkyDFgtxePZJ1N5rzgVO1lF9JJMR
 W9JvLSgaEvquGxB97ouQ6M9pkbkloPj7zAVQPoel3bDIzlcu0IGtsXU86zwU90GiCVOvlwkR9
 6ylcjlqCN3kEqM2FL096gS1EWALHBxewaRK44tGPZopPSqWDODJE1oulo21C5DjuGOA6S6ASd
 P8gK8lltaybzo3d/7s8KQFyVcK+JjePrUEyO4VdoAzSdYlZSxI4Y8qhsbvY7eo1F2REvfPT/g
 VLfwedn/QK/mvHJQ43Cv5apMlKzZDao+NcZCO+JlEjTmiSFtYyVCL6lPN9+dzpL22KTLngdBC
 AgKcA8NX2uaN3cHZf6A+bbB2TvrCFGy1zq+GWHW+lRbP8l8xMN+lka81I+O2hEaZfhB4hzd3r
 5RZeV0RZn5S0G6ggxdvj+N6z7aqrslB/4ii/aiqk06QLiRIjrLAWO3an6bnvR+2OogSmWdVUy
 KNE1F7kf7GOQsP9mXSlaaimnYXNm/1sLW/+HSzwjH8utJx9QUz+/fCMQLkw6PZ5Qww75t2v+n
 7U5yMkivuFDzNglUBUBo5gjGr6f0LW4jvNaK8dCb07WAWqikA3/dobzRIZFOJgkiEYdZmkJqv
 BsxM+w22ZvpSRvZoTdWEH6B0kaQWHfUTgYI8I680U/LM/OwQahBr6OIjrxf2Wod1pJUPr7L9A
 sxFpEjMK+i3y4mfnbyTZWCAZKYHFYZgL9LBcSSesFDIzj7QQnMCWonXHmtzkyadq6j4GDZ+s0
 ZczichUJ/IvT116d6Ax78G810Yc4TpODJ6iz+rjhhF4E+/ts856Ee/eYRJvvLCiGth/Fy4LH7
 1SdStaED9hFILUMgLILJvY/LqaG8J3Ig5k7Bf5FAwuHUC08WQpNhwDvJ+2UYWbZ4q3i6Jz2y6
 LkA0O6LTet4R0vd1Wm89GShvR9f4V6aSVFre+zFx9r2WuHswcwI5Hr/SHRhE7hkYxIcX9Sw4y
 /P9+p4meJKNF22CuejDtnQWUUvz7kYm48DHuj2ioG6v9jegMQfPiW2OGry5cHX/sq9PE/+mqn
 +aO+tL/jbqfGa3NoLzORdUrkhpHwOUtN77SLysqEHfwvj2NmUoEKm3yhac1ga6m141Qi4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 06:25:43PM +0100, Mark Amery wrote:
> Attempting to change the case of a folder's name using a command like
> `git mv foo FOO` crashes on case-insensitive file systems, like the
> default APFS used on Apple Macs.
>
> Here are simple steps to repro this:
>
>     $ mkdir testrepo && cd testrepo && git init
>     Initialized empty Git repository in /Users/markamery/testrepo/.git/
>     $ mkdir foo && touch foo/bar && git add foo && git commit -m bla
>     [master (root-commit) a7e9f5f] bla
>     1 file changed, 0 insertions(+), 0 deletions(-)
>     create mode 100644 foo/bar
>     $ git mv foo FOO
>     fatal: renaming 'foo' failed: Invalid argument
>     $ echo $?
>     128
>     $ git status
>     On branch master
>     nothing to commit, working tree clean
>
> If I create a case-sensitive APFS volume using Disk Utility and try
> the commands above on that volume, `git mv foo FOO` works correctly:
> it emits no output, exits with a 0 status code, and stages a change
> renaming `foo/bar` to `FOO/bar`. However, on my main case-insensitive
> volume, `git mv` behaves as shown above: it exits with code 128,
> prints an "Invalid argument" error message, and does not stage any
> changes.
>
> The command still fails in the same way if you use `git mv --force`
> instead of just `git mv`.
>
> Note that previously, `git mv` could not change the case of *file*
> names on case-insensitive file systems, until that was fixed in commit
> https://github.com/git/git/commit/baa37bff9a845471754d3f47957d58a6ccc300=
58.
> I'm guessing there's a different code path that needs fixing for
> changing the case of *folders*.
>
> As far as I can tell, this error has never been reported to the Git
> mailing list, but it seems to be encountered frequently;
> https://stackoverflow.com/questions/3011625/git-mv-and-only-change-case-=
of-directory
> mentions this bug and has 86000 views.
>
> In case it's relevant, here's my system info as output by `git bugreport=
`:
>
>     [System Info]
>     git version:
>     git version 2.31.1
>     cpu: x86_64
>     no commit associated with this build
>     sizeof-long: 8
>     sizeof-size_t: 8
>     shell-path: /bin/sh
>     uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Apr 27
> 20:09:39 PDT 2020; root:xnu-4903.278.35~1/RELEASE_X86_64 x86_64
>     compiler info: clang: 11.0.0 (clang-1100.0.33.17)
>     libc info: no libc information available
>     $SHELL (typically, interactive shell): /bin/bash


Thanks for reporting - that's always good.

To my undestanding we try to rename
foo/ into FOO/.
But because FOO/ already "exists" as directory,
Git tries to move foo/ into FOO/foo, which fails.

And no, the problem is probably not restricted to MacOs,
Windows and all case-insenstive file systems should show
the same, but I haven't tested yet, so it's more a suspicion.

The following diff allows to move foo/ into FOO/
If someone wants to make a patch out if, that would be good.



diff --git a/builtin/mv.c b/builtin/mv.c
index 3fccdcb6452..fbf184bcfa9 100644
=2D-- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -163,8 +163,10 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 		destination =3D internal_prefix_pathspec(dest_path[0], argv, argc, DUP_=
BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
-		dest_path[0] =3D add_slash(dest_path[0]);
-		destination =3D internal_prefix_pathspec(dest_path[0], argv, argc, DUP_=
BASENAME);
+		if (!ignore_case || strcasecmp(source[0], dest_path[0])) {
+			dest_path[0] =3D add_slash(dest_path[0]);
+			destination =3D internal_prefix_pathspec(dest_path[0], argv, argc, DUP=
_BASENAME);
+		}
 	} else {
 		if (argc !=3D 1)
 			die(_("destination '%s' is not a directory"), dest_path[0]);
@@ -187,9 +189,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 				(dst[length] =3D=3D 0 || dst[length] =3D=3D '/')) {
 			bad =3D _("can not move directory into itself");
 		} else if ((src_is_dir =3D S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) =3D=3D 0)
-			bad =3D _("cannot move directory over file");
-		else if (src_is_dir) {
+			   && lstat(dst, &st) =3D=3D 0) {
+			if (!ignore_case || strcasecmp(src, dst)){
+				bad =3D _("cannot move directory over file");
+			}
+		}
+		if (!bad && src_is_dir) {
 			int first =3D cache_name_pos(src, length), last;

 			if (first >=3D 0)
@@ -277,7 +282,7 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 		if (mode !=3D INDEX && rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
-			die_errno(_("renaming '%s' failed"), src);
+			die_errno(_("renaming '%s' into '%s' failed"), src, dst);
 		}
 		if (submodule_gitfile[i]) {
 			if (!update_path_in_gitmodules(src, dst))
