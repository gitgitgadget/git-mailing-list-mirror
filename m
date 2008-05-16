From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] submodule update: add convenience option --init
Date: Fri, 16 May 2008 16:55:56 +0600
Message-ID: <7bfdc29a0805160355x4120a425qaa947dd75bf60303@mail.gmail.com>
References: <alpine.DEB.1.00.0805161122110.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 12:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwxcN-00051f-8R
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYEPK4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYEPK4E
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:56:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:9354 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYEPK4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:56:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so472046ywe.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kSPfs4Hu/d12Ggy3TqQaPSWkHImFe4hHuHHbpA9UUl0=;
        b=Dd5htxAbDf06yfck+kgIupaOPQN2U04amrUjNUrDebF8WakRndaelDvDJfD/c0XPxib2+Se9dSFC9yp5Vfr2QQnT9LWlVOkvD0MvFaU77YJqDTIgSeWzjm/jf/1HiLXyfpK5UQfbkNPjrgSPsduC9Hw6KY7wYb6jzOvTlYvH0YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AvPonNvHOG7mOHxENm1lV5fXZHgeck3tV94HVVItFwsbT4tQ2PTj6gS3Nmi75/wlpu61DYs2un+8She4uDz1pjKyeu6JsxB+4GcrI2o3uuXgKRkMJIEED6aVXW3uoX+/5h7LjeVRIegyFC4mVYdaNFbVp/0aPqxJycC1CPbuvUM=
Received: by 10.150.202.3 with SMTP id z3mr3314362ybf.224.1210935356710;
        Fri, 16 May 2008 03:55:56 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Fri, 16 May 2008 03:55:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161122110.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82272>

On Fri, May 16, 2008 at 4:23 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>  When a submodule is not initialized and you do not want to change the
>  defaults from .gitmodules anyway, you can now say
>
>         $ git submodule update --init <name>

This seems to be quite useful, I always wanted to do it in one step.

>
>  When "update" is called without --init on an uninitialized submodule,
>  a hint to use --init is printed.
>
>  Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>  ---
>
>         I know this is relatively late in the cycle, but this patch was
>         done on users' requests, and I think it is unobtrusive, yet
>         helpful.
>
>   Documentation/git-submodule.txt |    7 ++++++-
>   git-submodule.sh                |    7 ++++++-
>   t/t7400-submodule-basic.sh      |   13 +++++++++++++
>   3 files changed, 25 insertions(+), 2 deletions(-)
>
>  diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>  index 6ffd896..0668f29 100644
>  --- a/Documentation/git-submodule.txt
>  +++ b/Documentation/git-submodule.txt
>  @@ -11,7 +11,8 @@ SYNOPSIS
>   [verse]
>   'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
>   'git-submodule' [--quiet] status [--cached] [--] [<path>...]
>  -'git-submodule' [--quiet] [init|update] [--] [<path>...]
>  +'git-submodule' [--quiet] init [--] [<path>...]
>  +'git-submodule' [--quiet] update [--init] [--] [<path>...]
>   'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
>
>
>  @@ -47,6 +48,10 @@ update::
>         Update the registered submodules, i.e. clone missing submodules and
>         checkout the commit specified in the index of the containing repository.
>         This will make the submodules HEAD be detached.
>  ++
>  +If the submodule is not yet initialized, and you just want to use the
>  +setting as stored in .gitmodules, you can automatically initialize the
>  +submodule with the --init option.
>
>   summary::
>         Show commit summary between the given commit (defaults to HEAD) and
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index 67f7a28..e681818 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -5,7 +5,7 @@
>   # Copyright (c) 2007 Lars Hjemli
>
>   USAGE="[--quiet] [--cached] \
>  -[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
>  +[add <repo> [-b branch]|status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
>   [--] [<path>...]"
>   OPTIONS_SPEC=
>   . git-sh-setup
>  @@ -272,6 +272,10 @@ cmd_update()
>                 -q|--quiet)
>                         quiet=1
>                         ;;
>  +               -i|--init)
>  +                       shift
>  +                       cmd_init "$@" || return
>  +                       ;;
>                 --)
>                         shift
>                         break
>  @@ -297,6 +301,7 @@ cmd_update()
>                         # path have been specified
>                         test "$#" != "0" &&
>                         say "Submodule path '$path' not initialized"
>  +                       say "Maybe you want to use 'update --init'?"
>                         continue
>                 fi
>
>  diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>  index 2ef85a8..6c7b902 100755
>  --- a/t/t7400-submodule-basic.sh
>  +++ b/t/t7400-submodule-basic.sh
>  @@ -196,4 +196,17 @@ test_expect_success 'apply submodule diff' '
>         test -z "$D"
>   '
>
>  +test_expect_success 'update --init' '
>  +
>  +       mv init init2 &&
>  +       git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
>  +       git config --remove-section submodule.example
>  +       git submodule update init > update.out &&
>  +       grep "not initialized" update.out &&
>  +       test ! -d init/.git &&
>  +       git submodule update --init init &&
>  +       test -d init/.git
>  +
>  +'
>  +
>   test_done
>  --
>  1.5.5.1.425.g5f464.dirty
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
