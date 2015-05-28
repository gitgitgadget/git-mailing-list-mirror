From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 3/3] git-am: add am.threeWay config variable
Date: Thu, 28 May 2015 21:47:47 +0800
Message-ID: <CACRoPnSnwA5GcYZjHHTepz4WzXYuJ+9nJqGsL92r_vnsNrN_-w@mail.gmail.com>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432675975-11020-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 15:47:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxyA6-00065t-BO
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 15:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbE1Nru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 09:47:50 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:34118 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbbE1Nrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 09:47:49 -0400
Received: by laat2 with SMTP id t2so32242073laa.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I6K9yi+SLsuntKWcPU1Wsx3mzb5F8qN4dGggRMoSXNA=;
        b=mys30M+JaAwEgyFoSVb5MWTgyZGggud+VIJAb46BTcIoVzSCZKAUH1hCTXZJVJ3Xzx
         lI3BufvjnLPvryk/vPbuy6nErObd6jF5dIFKDu3X5wWc7/XBkdzXkrJ42a1UMw2QU0GI
         jCDqjQSZHsv1hgl+XFHmPj44pGaweWyESf1lkJJ4G51uwtZQKwn+PWMitc96KiAfGhEu
         klRj83ZdqFr7ETmfr8DnEb/POnry3BlV6pgA3OrqfM0/qQDE2nrccsZIMUavInrdEpsY
         qIg+d9w3ybZhGEoZ8nLg/AfzTySM7kwocLWJ5cygiByxXeqa/OrVkSg5jnStcyX1K5dE
         xoCA==
X-Received: by 10.152.37.9 with SMTP id u9mr2910536laj.65.1432820867738; Thu,
 28 May 2015 06:47:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 28 May 2015 06:47:47 -0700 (PDT)
In-Reply-To: <1432675975-11020-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270150>

Hi,

On Wed, May 27, 2015 at 5:32 AM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Add the am.threeWay configuration variable to use the -3 or --3way
> option of git am by default. When am.threeway is set and not desired
> for a specific git am command, the --no-3way option can be used to
> override it.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  Even if git am will be rewritten soon, the code that will have to be
>  ported is not the most important part of the patch and the tests and
>  documentation parts can be reused.

Yup, there's no problem on my side.

>  Documentation/config.txt |  7 +++++++
>  Documentation/git-am.txt |  6 ++++--
>  git-am.sh                |  7 +++++++
>  t/t4150-am.sh            | 15 +++++++++++++++
>  4 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d44bc85..8e42752 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -769,6 +769,13 @@ am.keepcr::
>         by giving '--no-keep-cr' from the command line.
>         See linkgit:git-am[1], linkgit:git-mailsplit[1].
>
> +am.threeWay::
> +       If true, git-am will fall back on 3-way merge when the patch
> +       cannot be applied cleanly, in the same way as the '-3' or
> +       '--3-way' option. Can be overridden by giving '--no-3-way'
> +       from the command line.
> +       See linkgit:git-am[1].
> +

Maybe we should start by mentioning the default behavior for git-am.
Something like,

By default, git-am will fail if the patch does not apply cleanly. When
set to true, this setting tells git-am to fall back on 3-way merge if
the patch records the identity of blobs it is supposed to apply to and
we have those blobs available locally (equivalent to giving the --3way
option from the command line).

(I stole most of the text from the git-am and git-config documentation)

>  apply.ignoreWhitespace::
>         When set to 'change', tells 'git apply' to ignore changes in
>         whitespace, in the same way as the '--ignore-space-change'
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0d8ba48..3190c05 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -89,11 +89,13 @@ default.   You can use `--no-utf8` to override this.
>         linkgit:git-mailinfo[1]).
>
>  -3::
> ---3way::
> +--[no-]3way::

There's no need to mention --no-3way, it's assumed that most of the
options have the equivalent --no-option because it is implemented
automatically by the option parser.

>         When the patch does not apply cleanly, fall back on
>         3-way merge if the patch records the identity of blobs
>         it is supposed to apply to and we have those blobs
> -       available locally.
> +       available locally.  `am.threeWay` configuration variable
> +       can be used to specify the default behaviour.  `--no-3way`
> +       is useful to override `am.threeWay`.

Usually configuration settings are mentioned in a separate section in
the documentation "CONFIGURATION" (or not mentioned at all). Also,
there's no need to mention that --no-3way can be used to mention the
configuration, as its usual (and expected) that the configuration
value sets the default behavior, and the command-line switch can
override i.

>  --ignore-space-change::
>  --ignore-whitespace::
> diff --git a/git-am.sh b/git-am.sh
> index 761befb..781507c 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -389,6 +389,11 @@ then
>      keepcr=t
>  fi
>
> +if test "$(git config --bool --get am.threeWay)" = true
> +then
> +    threeway=t
> +fi
> +
>  while test $# != 0
>  do
>         case "$1" in
> @@ -400,6 +405,8 @@ it will be removed. Please do not use it anymore."
>                 ;;
>         -3|--3way)
>                 threeway=t ;;
> +       --no-3way)
> +               threeway=f ;;

Okay.

This patch on its own, though, does not handle the case where:

1. am.threeWay is set to "true"
2. we passed "--no-3way" in the command-line
3. git-am failed to apply a patch and quit
4. We git-am --skip or git-am --continue. When continuing, git-am will
not remember the --no-3way (unless we provide it again on the command
line)

They key is to tweak the following lines where the "threeway" setting is loaded:

    if test "$(cat "$dotest/threeway")" = t
    then
        threeway=t
    fi

To something like

    if test "$(cat "$dotest/threeway")" = t
    then
        threeway=t
    else
        threeway=f
    fi

>         -s|--signoff)
>                 sign=t ;;
>         -u|--utf8)
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 8f85098..e16ef0e 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -288,6 +288,21 @@ test_expect_success 'am -3 falls back to 3-way merge' '
>         git diff --exit-code lorem
>  '
>
> +test_expect_success 'am with config am.threeWay falls back to 3-way merge' '
> +       setup_temporary_branch lorem2 &&
> +       test_config am.threeWay 1 &&
> +       git am lorem-move.patch &&
> +       test_path_is_missing .git/rebase-apply &&
> +       git diff --exit-code lorem
> +'
> +
> +test_expect_success 'am with config am.threeWay overridden by --no-3way' '
> +       setup_temporary_branch lorem2 &&
> +       test_config am.threeWay 1 &&
> +       test_must_fail git am --no-3way lorem-move.patch &&
> +       test_path_is_dir .git/rebase-apply
> +'
> +
>  test_expect_success 'am -3 -p0 can read --no-prefix patch' '
>         setup_temporary_branch lorem2 &&
>         git am -3 -p0 lorem-zero.patch &&

This looks good.

> --
> 1.9.1

To end off, some off-tangent issues that are not related to the patch
series in question, but since I'm looking at git-am.sh....

I've noticed that in the block above that initializes all the variables,

    sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
    messageid= resolvemsg= resume= scissors= no_inbody_headers=
    git_apply_opt=
    committer_date_is_author_date=
    ignore_date=
    allow_rerere_autoupdate=
    gpg_sign_opt=

threeway is not initialized at all, and thus I think running
"threeway=t git am blah" will affect the behavior of git-am.

Also, I noticed that we do not check for --no-interactive,
--no-signoff, --no-keep, --no-whitespace, etc.

Thanks,
Paul
