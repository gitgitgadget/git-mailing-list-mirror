From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 22:00:34 +0200
Message-ID: <CAGHpTBKe4U+or7_hqetu_3o2T0X_50H_Evfgud3XZaAN4ka9-w@mail.gmail.com>
References: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
	<53208836.4050900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpKV-0003fk-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbaCLUAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:00:37 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39418 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaCLUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:00:35 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so10758oag.13
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ij0Js/3I3y0TbQ3iSRHbVw6wYuN1z+4auqo/nVLnUJM=;
        b=gGqLDwhHEi3W8Q/B0FlDCOg1so6ajrmku8MKdTuM2QyjsGECFxy5O1lxLr/Npvp6mc
         NZ3ItLNoPP0Hp+AGO6x8o19KkybJyYypAuztXh/xpG2XFlj0+9j77E5KkjVbaxmuV4Xy
         u64O/14L1MYw6irG29ZQI3iQIYOOF/UW2xaC+GKAeKXL8cLsJiMLSzuNTwHBE3yhfHh5
         pwYCFF4TN5CwyGtNnbUXzCWJzup8muyoehd/vWxN+duACNMTCseuxNaGe3+ixlRYnXcP
         JMXx41aHkjgg5cqU58vPQjVNcCr4rDMp76Fsp236QC3lqTlAg+0azj7iWeL1X59zTcLn
         53/w==
X-Received: by 10.182.34.196 with SMTP id b4mr40005676obj.13.1394654434859;
 Wed, 12 Mar 2014 13:00:34 -0700 (PDT)
Received: by 10.182.135.74 with HTTP; Wed, 12 Mar 2014 13:00:34 -0700 (PDT)
In-Reply-To: <53208836.4050900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243975>

On Wed, Mar 12, 2014 at 6:15 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> Am 12.03.2014 14:42, schrieb Orgad Shaneh:
> > From: Orgad Shaneh <orgads@gmail.com>
>
> You don't need the line above when you are the sender ;-)
>
> > Executes checkout without -q
>
> That's a bit terse. What about:
>
> "Add the verbose flag to add and update which displays the
>  progress of the actual submodule checkout when given. This
>  is useful for checkouts that take a long time, as the user
>  can then see the progress."
>
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > ---
> >  Documentation/git-submodule.txt |  7 +++++--
> >  git-submodule.sh                | 24 +++++++++++++++++++-----
> >  t/t7406-submodule-update.sh     |  9 +++++++++
> >  3 files changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > index 21cb59a..1867e94 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -10,13 +10,13 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> > -           [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
> > +           [--reference <repository>] [--depth <depth>] [-v|--verbose] [--] <repository> [<path>]
> >  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
> >  'git submodule' [--quiet] init [--] [<path>...]
> >  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
> >  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> >             [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
> > -           [--depth <depth>] [--recursive] [--] [<path>...]
> > +           [--depth <depth>] [--recursive] [-v|--verbose] [--] [<path>...]
> >  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
> >             [commit] [--] [<path>...]
> >  'git submodule' [--quiet] foreach [--recursive] <command>
> > @@ -363,6 +363,9 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
> >       clone with a history truncated to the specified number of revisions.
> >       See linkgit:git-clone[1]
> >
> > +--verbose::
> > +  This option is valid for add and update commands. Show output of
> > +  checkout.
>
> The above looks whitespace-damaged, you should use TABs here to
> indent (just like the other options do).
>
> >  <path>...::
> >       Paths to submodule(s). When specified this will restrict the command
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index a33f68d..5c4e057 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -5,11 +5,11 @@
> >  # Copyright (c) 2007 Lars Hjemli
> >
> >  dashless=$(basename "$0" | sed -e 's/-/ /')
> > -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> > +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
> >     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
> >     or: $dashless [--quiet] init [--] [<path>...]
> >     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> > -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> > +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
> >     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> >     or: $dashless [--quiet] foreach [--recursive] <command>
> >     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> > @@ -319,12 +319,16 @@ module_clone()
> >       rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> >       (
> >               clear_local_git_env
> > +             if test -z "$verbose"
> > +             then
> > +                     subquiet=-q
> > +             fi
> >               cd "$sm_path" &&
> >               GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> >               # ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
> >               case "$local_branch" in
> > -             '') git checkout -f -q ${start_point:+"$start_point"} ;;
> > -             ?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
> > +             '') git checkout -f $subquiet ${start_point:+"$start_point"} ;;
> > +             ?*) git checkout -f $subquiet -B "$local_branch" ${start_point:+"$start_point"} ;;
>
> Wouldn't it be better to use the ${subquiet:+"$subquiet"} notation
> here like the other optional arguments do? After all the subquiet
> isn't always set.
>
> >               esac
> >       ) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
> >  }
> > @@ -380,6 +384,9 @@ cmd_add()
> >               --depth=*)
> >                       depth=$1
> >                       ;;
> > +             -v|--verbose)
> > +                     verbose=1
> > +                     ;;
> >               --)
> >                       shift
> >                       break
> > @@ -786,6 +793,9 @@ cmd_update()
> >               --depth=*)
> >                       depth=$1
> >                       ;;
> > +             -v|--verbose)
> > +                     verbose=1
> > +                     ;;
> >               --)
> >                       shift
> >                       break
> > @@ -913,7 +923,11 @@ Maybe you want to use 'update --init'?")"
> >                       must_die_on_failure=
> >                       case "$update_module" in
> >                       checkout)
> > -                             command="git checkout $subforce -q"
> > +                             if test -z "$verbose"
> > +                             then
> > +                                     subquiet=-q
> > +                             fi
> > +                             command="git checkout $subforce $subquiet"
>
> Same as above.
>
> >                               die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> >                               say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> >                               ;;
> > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> > index 28ca763..04a0fcc 100755
> > --- a/t/t7406-submodule-update.sh
> > +++ b/t/t7406-submodule-update.sh
> > @@ -83,6 +83,15 @@ test_expect_success 'submodule update detaching the HEAD ' '
> >       )
> >  '
> >
> > +test_expect_success 'submodule update verbose' '
> > +     (cd super/submodule &&
> > +      git checkout master
> > +     ) &&
> > +     (cd super &&
> > +      git submodule update --verbose submodule 2>&1 | grep -q "HEAD is now at"
>
> This string is translated, so you need to use test_i18ngrep.
> Please see t7201-co.sh for an example of how to pipe the
> output into a file and then compare it.
>
> > +     )
> > +'
> > +
> >  test_expect_success 'submodule update from subdirectory' '
> >       (cd super/submodule &&
> >        git reset --hard HEAD~1
> >
>

Thanks a lot for your review! I'll post a revised patch soon.

- Orgad
