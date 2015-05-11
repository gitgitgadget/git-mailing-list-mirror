From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/6] command-list.txt: group common commands by theme
Date: Mon, 11 May 2015 02:20:19 -0400
Message-ID: <CAPig+cSjdJ6Yhbvyw-m4E+Y9wEk71y0Cw2NO6c=f_cFy--YTGA@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431191856-10949-4-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrh4k-0007d8-2x
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbbEKGUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 02:20:22 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33344 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbEKGUU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:20:20 -0400
Received: by iepj10 with SMTP id j10so97375676iep.0
        for <git@vger.kernel.org>; Sun, 10 May 2015 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oQq91KnNXVf+HZfUsoRWSN1TZ/93FiAufD36Q8f5rh4=;
        b=iJXMFvoF8FT09y5G6RAmKM3F5Poo/4P5mPkRkSD+sZ3cRaNM2sSzUK+jdQ2/xMdLuq
         ZI7YopWPE0IogI54wBNBBXkzsxhRE9CJF98Vit3ymDwSyiElWUbi+A3uXAI7iZjo5UYO
         be9MhCB6//XHmT52R7XcQf9kMDfExbjhsD47WXIUP7TKiz/z3FBaIhl2Md8vncTPd9f/
         rRprwaGN/brDRP7qWrqxiAh1qbGuh8j7ZE6WfEcK4zRfXoJaqun44QCWN+wGqD7CHR1/
         DT9gfGm9MU3BK2xxID6OGQ4R7PReUewQe4+cc+hZZDAwAoGVyB2EdrG9HrNIj6yd1yIb
         mJTQ==
X-Received: by 10.50.85.43 with SMTP id e11mr12198573igz.15.1431325219226;
 Sun, 10 May 2015 23:20:19 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 23:20:19 -0700 (PDT)
In-Reply-To: <1431191856-10949-4-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: Qp45nuimo-y_cWXJNFZKCKC2aPY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268758>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Declare groups for common commands in the [common] block,
> followed by group names and descriptions:
>
>     [common]
>     init         start a working area (see also: git help tutorial)
>     worktree     work on the current change (see also: git [...]
>     info         examine the history and state (see also: git [...]
>     history      grow, mark and tweak your history
>     remote       collaborate (see also: git help workflows)
>
> Some descriptions include a 'see also' to redirect user to more
> detailed documentation.

The example nicely shows the "see also", so this trailing sentence is
somewhat redundant.

More below.

> Then, in the [commands] block, map all common commands with a group:
>
>     [commands]
>     git-add        mainporcelain     worktree
>     git-branch     mainporcelain     history
>     git-checkout   mainporcelain     history
>     [...]
>
> So that 'git help' outputs those commands in headered groups.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/command-list.txt b/command-list.txt
> index f1eae08..7e7ce53 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,29 +1,41 @@
> +# common commands are grouped by themes
> +# this order is the same that output by 'git help'
> +# map each common commands in the [commands] list to one of the grou=
ps.

Grammar: "map each common command"

Maybe also "one of these groups".

> +# a command should not be marked both [deprecated] and [common]

I wonder if it is really necessary to state this, as there is no
technical reason for the restriction, and it should be common sense
(one would hope).

> +[common]
> +init         start a working area (see also: git help tutorial)
> +worktree     work on the current change (see also: git help everyday=
)
> +info         examine the history and state (see also: git help revis=
ions)
> +history      grow, mark and tweak your history
> +remote       collaborate (see also: git help workflows)
> +
>  # List of known git commands.
> -# command name                         category [deprecated] [common=
]
> -git-add                                 mainporcelain common
> +# command name         [deprecated]     category                [com=
mon]

Why did [deprecated] move from following "category" to preceding it?

Also, I wonder if [common] should be spelled [<common>] or something
to distinguish it from [deprecated] which is a literal token. (I don't
care strongly; I'm just wondering.)

> +[commands]
> +git-add                                 mainporcelain           work=
tree
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
>  git-apply                               plumbingmanipulators
>  git-archimport                          foreignscminterface
>  git-archive                             mainporcelain
> -git-bisect                              mainporcelain common
> +git-bisect                              mainporcelain           info
>  git-blame                               ancillaryinterrogators
> -git-branch                              mainporcelain common
> +git-branch                              mainporcelain           hist=
ory
>  git-bundle                              mainporcelain
>  git-cat-file                            plumbinginterrogators
>  git-check-attr                          purehelpers
>  git-check-ignore                        purehelpers
>  git-check-mailmap                       purehelpers
> -git-checkout                            mainporcelain common
> +git-checkout                            mainporcelain           hist=
ory
>  git-checkout-index                      plumbingmanipulators
>  git-check-ref-format                    purehelpers
>  git-cherry                              ancillaryinterrogators
>  git-cherry-pick                         mainporcelain
>  git-citool                              mainporcelain
>  git-clean                               mainporcelain
> -git-clone                               mainporcelain common
> +git-clone                               mainporcelain           init
>  git-column                              purehelpers
> -git-commit                              mainporcelain common
> +git-commit                              mainporcelain           hist=
ory
>  git-commit-tree                         plumbingmanipulators
>  git-config                              ancillarymanipulators
>  git-count-objects                       ancillaryinterrogators
> @@ -35,14 +47,14 @@ git-cvsimport                           foreignsc=
minterface
>  git-cvsserver                           foreignscminterface
>  git-daemon                              synchingrepositories
>  git-describe                            mainporcelain
> -git-diff                                mainporcelain common
> +git-diff                                mainporcelain           hist=
ory
>  git-diff-files                          plumbinginterrogators
>  git-diff-index                          plumbinginterrogators
>  git-diff-tree                           plumbinginterrogators
>  git-difftool                            ancillaryinterrogators
>  git-fast-export                                ancillarymanipulators
>  git-fast-import                                ancillarymanipulators
> -git-fetch                               mainporcelain common
> +git-fetch                               mainporcelain           remo=
te
>  git-fetch-pack                          synchingrepositories
>  git-filter-branch                       ancillarymanipulators
>  git-fmt-merge-msg                       purehelpers
> @@ -51,7 +63,7 @@ git-format-patch                        mainporcela=
in
>  git-fsck                               ancillaryinterrogators
>  git-gc                                  mainporcelain
>  git-get-tar-commit-id                   ancillaryinterrogators
> -git-grep                                mainporcelain common
> +git-grep                                mainporcelain           info
>  git-gui                                 mainporcelain
>  git-hash-object                         plumbingmanipulators
>  git-help                               ancillaryinterrogators
> @@ -60,17 +72,17 @@ git-http-fetch                          synchelpe=
rs
>  git-http-push                           synchelpers
>  git-imap-send                           foreignscminterface
>  git-index-pack                          plumbingmanipulators
> -git-init                                mainporcelain common
> +git-init                                mainporcelain           init
>  git-instaweb                            ancillaryinterrogators
>  git-interpret-trailers                  purehelpers
>  gitk                                    mainporcelain
> -git-log                                 mainporcelain common
> +git-log                                 mainporcelain           info
>  git-ls-files                            plumbinginterrogators
>  git-ls-remote                           plumbinginterrogators
>  git-ls-tree                             plumbinginterrogators
>  git-mailinfo                            purehelpers
>  git-mailsplit                           purehelpers
> -git-merge                               mainporcelain common
> +git-merge                               mainporcelain           hist=
ory
>  git-merge-base                          plumbinginterrogators
>  git-merge-file                          plumbingmanipulators
>  git-merge-index                         plumbingmanipulators
> @@ -79,7 +91,7 @@ git-mergetool                           ancillaryma=
nipulators
>  git-merge-tree                          ancillaryinterrogators
>  git-mktag                               plumbingmanipulators
>  git-mktree                              plumbingmanipulators
> -git-mv                                  mainporcelain common
> +git-mv                                  mainporcelain           work=
tree
>  git-name-rev                            plumbinginterrogators
>  git-notes                               mainporcelain
>  git-p4                                  foreignscminterface
> @@ -90,11 +102,11 @@ git-parse-remote                        synchelp=
ers
>  git-patch-id                            purehelpers
>  git-prune                               ancillarymanipulators
>  git-prune-packed                        plumbingmanipulators
> -git-pull                                mainporcelain common
> -git-push                                mainporcelain common
> +git-pull                                mainporcelain           remo=
te
> +git-push                                mainporcelain           remo=
te
>  git-quiltimport                         foreignscminterface
>  git-read-tree                           plumbingmanipulators
> -git-rebase                              mainporcelain common
> +git-rebase                              mainporcelain           hist=
ory
>  git-receive-pack                        synchelpers
>  git-reflog                              ancillarymanipulators
>  git-relink                              ancillarymanipulators
> @@ -103,28 +115,28 @@ git-repack                              ancilla=
rymanipulators
>  git-replace                             ancillarymanipulators
>  git-request-pull                        foreignscminterface
>  git-rerere                              ancillaryinterrogators
> -git-reset                               mainporcelain common
> +git-reset                               mainporcelain           work=
tree
>  git-revert                              mainporcelain
>  git-rev-list                            plumbinginterrogators
>  git-rev-parse                           ancillaryinterrogators
> -git-rm                                  mainporcelain common
> +git-rm                                  mainporcelain           work=
tree
>  git-send-email                          foreignscminterface
>  git-send-pack                           synchingrepositories
>  git-shell                               synchelpers
>  git-shortlog                            mainporcelain
> -git-show                                mainporcelain common
> +git-show                                mainporcelain           info
>  git-show-branch                         ancillaryinterrogators
>  git-show-index                          plumbinginterrogators
>  git-show-ref                            plumbinginterrogators
>  git-sh-i18n                             purehelpers
>  git-sh-setup                            purehelpers
>  git-stash                               mainporcelain
> -git-status                              mainporcelain common
> +git-status                              mainporcelain           info
>  git-stripspace                          purehelpers
>  git-submodule                           mainporcelain
>  git-svn                                 foreignscminterface
>  git-symbolic-ref                        plumbingmanipulators
> -git-tag                                 mainporcelain common
> +git-tag                                 mainporcelain           hist=
ory
>  git-unpack-file                         plumbinginterrogators
>  git-unpack-objects                      plumbingmanipulators
>  git-update-index                        plumbingmanipulators
> --
> 2.4.0
