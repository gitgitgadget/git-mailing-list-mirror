From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 17:15:42 -0400
Message-ID: <CAPig+cQ3mAAAVUZ=8mMb_siZ20Nw1J-LgkTkF_1FzttKk334NQ@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:15:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMxY-0000u8-0u
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 23:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992482AbbEOVPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 17:15:46 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33717 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbbEOVPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 17:15:43 -0400
Received: by iebgx4 with SMTP id gx4so130746992ieb.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Ai7mjdlkr1zvfAxIY0U6O8JJkdFZI78AwyC70lAqdtk=;
        b=bpjI0gDAS3JuyglxqiWNWQWCXE1Ca35gh8vg9mf+jKYeu5O92HiRuWUAwGWXrulCek
         DZrvcWOm4FmkOjElPhwjwsI0Y/mn4BpfOMx2XaBr8dWFdosPp0rfIlgbF4vzuqqrC39e
         lpgbWWJSGpF34wkeOrqGynwWgWUyZdVhdVlGCrg31b9MQK9buzqmsqHkpcZdzzUTZdq/
         xn4fPMNoMVHTnhUk3SEH/eo9k9dgtaggvIC3G0vq7IpuqCZhaYJUwCQIbNUUDErOsL3j
         31Zvh/uE5RFfi3ChwwZ32a+r4xMaDQEE98/PENApRgcvbUENTsDbkcpH5KlYezYj5zZQ
         dn7A==
X-Received: by 10.107.31.134 with SMTP id f128mr15815338iof.19.1431724542227;
 Fri, 15 May 2015 14:15:42 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 14:15:42 -0700 (PDT)
In-Reply-To: <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: knlmqqAa3W7gGT6rDvZTtS3qKc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269185>

On Fri, May 15, 2015 at 2:35 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> command-list.txt: prepare with [commands] header
>
> Add a [commands] header before the actual command list, then make the
> following files ignore this header in their parsing:
>
>         * cmd-list.perl
>         * Makefile (check-docks target)

When these patches are ultimately applied, they won't have the benefit
of the cover letter to explain the purpose of this change and,
unfortunately, this commit message is lacking in that respect. The
commit message should explain the reason you're making this change
("prepare machinery to deal with upcoming new common group
specification" or such). With a proper explanation, it's not necessary
to state (as you do above) precisely which bits of machinery you are
changing. The patch itself already does that well enough.

More below.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Documentation/howto/new-command.txt b/Documentation/howt=
o/new-command.txt
> index d7de5a3..6d772bd 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>  that categorizes commands by type, so they can be listed in appropri=
ate
>  subsections in the documentation's summary command list.  Add an ent=
ry
>  for yours.  To understand the categories, look at git-commands.txt
> -in the main directory.
> +in the main directory.  If the new command is part of the typical Gi=
t
> +workflow and you believe it common enough to be mentioned in 'git he=
lp',
> +map this command to a common group in the column [common].

I think you meant to fold this change into patch 2/5 where the
[common] block is actually added. It doesn't make much sense to talk
about it here before exists.

>  7. Give the maintainer one paragraph to include in the RelNotes file
>  to describe the new feature; a good place to do so is in the cover
> diff --git a/Makefile b/Makefile
> index 25a453b..0cb2045 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2454,7 +2454,7 @@ check-docs::
>                 esac ; \
>                 test -f "Documentation/$$v.txt" || \
>                 echo "no doc: $$v"; \
> -               sed -e '/^#/d' command-list.txt | \
> +               sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.=
txt | \

This is partly my fault since my original suggestion for how to skip
[common] and [commands] sections[1] was typed on-the-spot when
composing the mail message, without the context of looking at this
Makefile, but changing this invocation to use redirection
(<command-list.txt) rather than a simple argument (command-list.txt)
seems unwarranted. Worse, it may confuse readers into thinking that
there is some important but obscure reason for the change which they
cannot fathom. Also, the invocation in the hunk just below this one
does not bother with redirection, so use of redirection here seems
doubly mysterious.

[1]: http://article.gmane.org/gmane.comp.version-control.git/268598

>                 grep -q "^$$v[  ]" || \
>                 case "$$v" in \
>                 git) ;; \
> @@ -2463,6 +2463,7 @@ check-docs::
>         done; \
>         ( \
>                 sed -e '/^#/d' \
> +                   -e '1,/^\[commands\]/d' \

This won't work as expected. If you invoke 'check-docs', you'll see
this (undesired) output:

    % make check-docs
    removed but listed: [commands]
    removed but listed: [common]
    removed but listed: history
    removed but listed: info
    removed but listed: init
    removed but listed: remote
    removed but listed: worktree
    %

which is the two [headers] you added plus all the new common group
tags. To fix, re-order the sed expressions so that 1,/^\[commands\]/d
comes first:

    sed -e '1,/^\[commands\]/d' \
        -e '/^#/d' \
        ...

>                     -e 's/[     ].*//' \
>                     -e 's/^/listed /' command-list.txt; \
>                 $(MAKE) -C Documentation print-man1 | \
> diff --git a/command-list.txt b/command-list.txt
> index 54d8d21..caed872 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,5 +1,6 @@
>  # List of known git commands.
>  # command name                          category [deprecated] [commo=
n]
> +[commands]
>  git-add                                 mainporcelain common
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
> --
> 2.4.0
