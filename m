From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Tue, 26 May 2015 19:27:32 -0400
Message-ID: <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 01:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxOG3-0005eP-NN
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 01:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbbEZX1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 19:27:34 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33311 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbEZX1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 19:27:33 -0400
Received: by iebgx4 with SMTP id gx4so1309475ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xgVrTBvJGPA8+bAtDvc9lrulpbaoR4YYC+dGw2d2LZ8=;
        b=Vr2Fnt/R/K5gUSY9lVaLDsaenlEv1DyG3ICTWf2PkRksmZDm8GBozLalqLLA+rnSg4
         y0HlZUKX7uRSYdODdSrtALKqBFKPcBvFK5hWXqk5Pzc4ceOSLdNzijYHc3qEURNG/4DJ
         tphF5DPDKcFi7p+CXxriEPryN3/1k4tHq13zsgUFo16qogzHlnz1ybPS+2G4bcOWX2HB
         pS39JA0zmf/JTg27OISE2zneUB8gXh1ecYND6cJ1dX/bqB3m6GxOdQ8pmNhEqShR916t
         fp9iDX6dW4ejqmS1+lZYCCB2oYwcgYcRznfnvu69iIBkzVcT3HMH4u9PhlUold2MeTrz
         aQnw==
X-Received: by 10.42.67.80 with SMTP id s16mr176009ici.25.1432682852558; Tue,
 26 May 2015 16:27:32 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 16:27:32 -0700 (PDT)
In-Reply-To: <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: S_CpuH0kERj8dpXJZTgS3V6nkVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270006>

On Tue, May 26, 2015 at 5:38 PM, Galan R=C3=A9mi
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> git rebase -i: Warn removed or dupplicated commits

s/dupplicated/duplicated/

Also, drop capitalization, and insert "about":

    git rebase -i: warn about removed or duplicated commits

> Check if commits were removed (i.e. a line was deleted) or dupplicate=
d

s/dupplicated/duplicated/

> (e.g. the same commit is picked twice), can print warnings or abort

s/can/and/, I think.

> git rebase according to the value of the configuration variable
> rebase.checkLevel.
>
> Add the configuration variable rebase.checkLevel.
>     - When unset or set to "IGNORED", no checking is done.

s/IGNORED/IGNORE/

>     - When set to "WARN", the commits are checked, warnings are
>       displayed but git rebase still proceeds.
>     - When set to "ERROR", the commits are checked, warnings are
>       displayed and the rebase is aborted.

Why uppercase for these names? Is there precedence for that? I think
lowercase is more common.

> Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-i=
np.fr>
> ---
>  This part of the patch has no test yet, it is more for rfc.
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d44bc85..2152e27 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2204,6 +2204,14 @@ rebase.autoStash::
>         successful rebase might result in non-trivial conflicts.
>         Defaults to false.
>
> +rebase.checkLevel::
> +       If set to "warn", git rebase -i will print a warning if some
> +       commits are removed (i.e. a line was deleted) or if some
> +       commits appear more than one time (e.g. the same commit is
> +       picked twice), however the rebase will still proceed. If set
> +       to "error", it will print the previous warnings and abort the
> +       rebase.

The commit message talks about "ignore", but there is no mention here.

Also, what is the default behavior if not specified? That should be doc=
umented.

=46inally, this talks about lowercase "warn" and "error", whereas the
commit message uses upper case "WARN" and "ERROR", as does the code.
Why the inconsistency?

>  receive.advertiseAtomic::
>         By default, git-receive-pack will advertise the atomic push
>         capability to its clients. If you don't want to this capabili=
ty
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 3cd2ef2..cb05cbb 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -213,6 +213,11 @@ rebase.autoSquash::
>  rebase.autoStash::
>         If set to true enable '--autostash' option by default.
>
> +rebase.checkLevel::
> +       If set to "warn" print warnings about removed commits and
> +       duplicated commits in interactive mode. If set to "error"
> +       print the warnings and abort the rebase. No check by default.

Ditto: Fails to mention "ignore".

>  OPTIONS
>  -------
>  --onto <newbase>::
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index cb749e8..8a837ca 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -837,6 +837,80 @@ add_exec_commands () {
>         mv "$1.new" "$1"
>  }
>
> +# Print the list of the sha-1 of the commits
> +# from a todo list in a file.
> +# $1 : todo-file, $2 : outfile
> +todo_list_to_sha_list () {
> +       todo_list=3D$(git stripspace --strip-comments < "$1")
> +       temp_file=3D$(mktemp)
> +       echo "$todo_list" > "$temp_file"
> +       while read -r command sha1 rest < "$temp_file"

On this project it is typical to drop the space after redirection
operators (<, >, >>), however, git-rebase--interactive.sh is filled
with both styles (space and no space after redirection). New code
probably ought to drop the space.

> +       do
> +               case "$command" in
> +               x|"exec")
> +                       ;;
> +               *)
> +                       echo "$sha1" >> "$2"
> +                       ;;
> +               esac
> +               sed -i '1d' "$temp_file"
> +       done
> +       rm "$temp_file"
> +}
> +
> +# Check if the user dropped some commits by mistake
> +# or if there are two identical commits.
> +# Behaviour determined by .gitconfig.
> +check_commits () {
> +       checkLevel=3D$(git config --get rebase.checkLevel)
> +       checkLevel=3D${checkLevel:-"IGNORE"}

Minor aside: Unnecessary quoting increases the noise level, thus
making the code slightly more difficult to read. This could just as
well have been:

    checkLevel=3D${checkLevel:-IGNORE}

There are plenty of other places throughout this patch which exhibit
the same shortcoming, but I won't point them out individually.

> +       # To uppercase
> +       checkLevel=3D$(echo "$checkLevel" | tr '[:lower:]' '[:upper:]=
')

Is there precedence elsewhere for recognizing uppercase and lowercase
variants of config values?

> +       case "$checkLevel" in
> +       "WARN"|"ERROR")
> +               todo_list_to_sha_list "$todo".backup "$todo".oldsha1
> +               todo_list_to_sha_list "$todo" "$todo".newsha1
> +
> +               duplicates=3D$(sort "$todo".newsha1 | uniq -d)
> +
> +               echo "$(sort -u "$todo".oldsha1)" > "$todo".oldsha1
> +               echo "$(sort -u "$todo".newsha1)" > "$todo".newsha1
> +               missing=3D$(comm -2 -3 "$todo".oldsha1 "$todo".newsha=
1)
> +
> +               # check missing commits
> +               if ! test -z "$missing"

Isn't "! test -z" just a verbose way of saying "test -n"?

> +               then
> +                       warn "Warning : some commits may have been dr=
opped accidentally."
> +                       warn "Dropped commits:"
> +                       warn "$missing"
> +                       warn "To avoid this message, use \"drop\" to =
explicitely remove a commit."

s/explicitely/explicitly/

> +                       warn "Use git --config rebase.checkLevel to c=
hange"
> +                       warn "the level of warnings (ignore,warn,erro=
r)."
> +                       warn ""
> +
> +                       if test "$checkLevel" =3D "ERROR"
> +                       then
> +                               die_abort "Rebase aborted due to drop=
ped commits."
> +                       fi
> +               fi
> +
> +               # check duplicate commits
> +               if ! test -z "$duplicates"
> +               then
> +                       warn "Warning : some commits have been used t=
wice:"
> +                       warn "$duplicates"
> +                       warn ""
> +               fi

Shouldn't this case also 'die' when rebase.checkLevel is "error"? And,
why doesn't the user get advice about configuring rebase.checkLevel in
this case?

In fact, the current logic flow seems a bit borked. I would have
expected it to be more like this:

    if test -n "$missing"
    then
        ...warn about accidental drops...
    fi

    if test -n "$duplicates"
    then
        ...warn about accidental duplicates...
    fi

    if test -n "$missing$duplicates"
    then
        ...show advice about configuring rebase.checkLevel...

        if test $checkLevel =3D ERROR
        then
            die_abort "..."
        fi
    fi

> +               ;;
> +       "IGNORE")
> +               ;;
> +       *)
> +               warn "Unrecognized setting for option rebase.checkLev=
el in git rebase -i"

This message might be more useful if it mentioned the actual unrecogniz=
ed value.

> +               ;;
> +       esac
> +}
> +
>  # The whole contents of this file is run by dot-sourcing it from
>  # inside a shell function.  It used to be that "return"s we see
>  # below were not inside any function, and expected to return
> @@ -1082,6 +1156,8 @@ has_action "$todo" ||
>
>  expand_todo_ids
>
> +check_commits
> +
>  test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_=
picks
>
>  GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
> --
> 2.4.1.174.g28bfe8e
