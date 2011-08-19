From: Ron Panduwana <panduwana@gmail.com>
Subject: Re: [PATCH] bash-completion: Make use of git status
Date: Fri, 19 Aug 2011 16:54:51 +0700
Message-ID: <CAOSnc=g4qYH0m5DKtuN984EOuoFVYhQN26-gOVa+c9O6SMuPcA@mail.gmail.com>
References: <1313474948-13531-1-git-send-email-panduwana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Ron Panduwana <panduwana@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 11:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuLnT-0006Xl-2p
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 11:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab1HSJzP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 05:55:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57289 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1HSJzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 05:55:12 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1831350fxh.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7eUkW2Fl6Dvb4IVUM7gb8oMprsWX9zPpedHWmdV2VM4=;
        b=MYwyC1Sqw2LtzZPT5UujgZIIsh2VODnrc+KVeKLw9oGf5+IEtUfzsxAP6pwRHcarPT
         XbcUUkmd+HOWAWFNoR079xRSJK4edA4keUZ9RxEC1+ZZVhDJUtnhm6ZXUQaA0nQpDH6C
         cJlEZ+I2DCCLQvSsGK2r5EIp/hO/5SgYc5SXY=
Received: by 10.223.87.204 with SMTP id x12mr2619666fal.27.1313747711113; Fri,
 19 Aug 2011 02:55:11 -0700 (PDT)
Received: by 10.223.86.70 with HTTP; Fri, 19 Aug 2011 02:54:51 -0700 (PDT)
In-Reply-To: <1313474948-13531-1-git-send-email-panduwana@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179688>

Sorry,

Bounced for Junio, I put his old address. Fixed now.

Ron Panduwana
--
panduwana@gmail.com


On Tue, Aug 16, 2011 at 1:09 PM, Ron Panduwana <panduwana@gmail.com> wr=
ote:
> When autocompleting git add, rm, checkout --, and reset HEAD; Make it=
 so they use git status to offer suitable files.
>
> Signed-off-by: Ron Panduwana <panduwana@gmail.com>
> ---
> Hello,
>
> I made some little improvements to the bash autocompletion script for=
 git add, rm, checkout --, and reset HEAD.
> It's because sometimes after doing "git status" I need to do one/some=
 of the commands and hope the autocompletion can make use the status in=
fo git already knows.
> For example:
>
> $ git status
> # On branch master
> # Changes to be committed:
> # =A0 (use "git reset HEAD <file>..." to unstage)
> #
> # =A0 =A0 =A0 new file: =A0 path/to/deeply/located/added-file
> # =A0 =A0 =A0 modified: =A0 path/to/deeply/located/old-file
> # =A0 =A0 =A0 deleted: =A0 =A0path/to/deeply/located/removed-file
> #
> # Changed but not updated:
> # =A0 (use "git add/rm <file>..." to update what will be committed)
> # =A0 (use "git checkout -- <file>..." to discard changes in working =
directory)
> #
> # =A0 =A0 =A0 deleted: =A0 =A0path/to/deeply/located/deleted-file
> # =A0 =A0 =A0 modified: =A0 path/to/deeply/located/modified-file
> # =A0 =A0 =A0 deleted: =A0 =A0path/to/deeply/located/old-file
> #
> # Untracked files:
> # =A0 (use "git add <file>..." to include in what will be committed)
> #
> # =A0 =A0 =A0 path/to/deeply/located/new-file
>
>
> If I need to do one of the commands, I'd like my autocompletion to wo=
rk like these:
>
> $ git add [TAB]path/to/deeply/located/[TAB][TAB]
> path/to/deeply/located/modified-file =A0 path/to/deeply/located/new-f=
ile
>
> $ git rm [TAB]path/to/deeply/located/[TAB][TAB]
> path/to/deeply/located/deleted-file =A0 path/to/deeply/located/old-fi=
le
>
> $ git checkout -- [TAB]path/to/deeply/located/[TAB][TAB]
> path/to/deeply/located/deleted-file =A0 =A0path/to/deeply/located/mod=
ified-file =A0 path/to/deeply/located/old-file
>
> $ git reset HEAD [TAB]path/to/deeply/located/[TAB][TAB]
> path/to/deeply/located/added-file =A0 =A0 path/to/deeply/located/old-=
file =A0 =A0 =A0 path/to/deeply/located/removed-file
>
>
> I think it's a good thing to be included as default, so here I send t=
he diff of my modification of the autocompletion script.
>
> PS: for the modification I've taken into account:
> - has_doubledash
> - when we meant to autocomplete the --switches
> - for git rm, whether --cached presents
> - for git checkout, only if it starts with "git checkout -- "
> - for git reset, only if it starts with "git reset HEAD "
> - (ie. when we meant to autocomplete git_refs)
>
> Hope it'd be useful.
>
> =A0contrib/completion/git-completion.bash | =A0 76 ++++++++++++++++++=
++------------
> =A01 files changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 5a83090..233bdbb 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1010,6 +1010,12 @@ __git_has_doubledash ()
> =A0 =A0 =A0 =A0return 1
> =A0}
>
> +# __git_files_having_status requires 1 argument
> +__git_files_having_status ()
> +{
> + =A0 =A0 =A0 echo "$(git status -uall --porcelain . 2>/dev/null | eg=
rep "^$1" | cut -c4-)"
> +}
> +
> =A0__git_whitespacelist=3D"nowarn warn error error-all fix"
>
> =A0_git_am ()
> @@ -1058,17 +1064,17 @@ _git_apply ()
>
> =A0_git_add ()
> =A0{
> - =A0 =A0 =A0 __git_has_doubledash && return
> -
> - =A0 =A0 =A0 case "$cur" in
> - =A0 =A0 =A0 --*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --interactive --refresh=
 --patch --update --dry-run
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --ignore-errors --inten=
t-to-add
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> - =A0 =A0 =A0 esac
> - =A0 =A0 =A0 COMPREPLY=3D()
> + =A0 =A0 =A0 if ! __git_has_doubledash; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$cur" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --inter=
active --refresh --patch --update --dry-run
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --ignor=
e-errors --intent-to-add
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
> + =A0 =A0 =A0 fi
> + =A0 =A0 =A0 __gitcomp "$(__git_files_having_status "(.[MAU]|UD|\?\?=
)")"
> =A0}
>
> =A0_git_archive ()
> @@ -1171,7 +1177,12 @@ _git_bundle ()
>
> =A0_git_checkout ()
> =A0{
> - =A0 =A0 =A0 __git_has_doubledash && return
> + =A0 =A0 =A0 if __git_has_doubledash; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [[ ${words[2]} =3D "--" ]]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "$(__git_file=
s_having_status ".[MD]")"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> + =A0 =A0 =A0 fi
>
> =A0 =A0 =A0 =A0case "$cur" in
> =A0 =A0 =A0 =A0--conflict=3D*)
> @@ -2313,14 +2324,18 @@ _git_replace ()
>
> =A0_git_reset ()
> =A0{
> - =A0 =A0 =A0 __git_has_doubledash && return
> -
> - =A0 =A0 =A0 case "$cur" in
> - =A0 =A0 =A0 --*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "--merge --mixed --hard --sof=
t --patch"
> + =A0 =A0 =A0 if ! __git_has_doubledash; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$cur" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "--merge --mi=
xed --hard --soft --patch"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
> + =A0 =A0 =A0 fi
> + =A0 =A0 =A0 if [[ ${words[2]} =3D "HEAD" ]]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "$(__git_files_having_status =
"[ADM].")"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 esac
> + =A0 =A0 =A0 fi
> =A0 =A0 =A0 =A0__gitcomp "$(__git_refs)"
> =A0}
>
> @@ -2337,15 +2352,20 @@ _git_revert ()
>
> =A0_git_rm ()
> =A0{
> - =A0 =A0 =A0 __git_has_doubledash && return
> -
> - =A0 =A0 =A0 case "$cur" in
> - =A0 =A0 =A0 --*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "--cached --dry-run --ignore-=
unmatch --quiet"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 esac
> - =A0 =A0 =A0 COMPREPLY=3D()
> + =A0 =A0 =A0 if ! __git_has_doubledash; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$cur" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "--cached --d=
ry-run --ignore-unmatch --quiet"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
> + =A0 =A0 =A0 fi
> + =A0 =A0 =A0 # check if --cached was specified
> + =A0 =A0 =A0 if [ "$(__git_find_on_cmdline "--cached")" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 COMPREPLY=3D()
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __gitcomp "$(__git_files_having_status =
"(.D|DU|UA)")"
> + =A0 =A0 =A0 fi
> =A0}
>
> =A0_git_shortlog ()
> --
> 1.7.1
>
>
