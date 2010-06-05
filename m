From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with gettext
Date: Sat, 05 Jun 2010 06:57:25 -0700 (PDT)
Message-ID: <m3zkz9pols.fsf@localhost.localdomain>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 15:57:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKtsU-0001Oj-Mc
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 15:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324Ab0FEN5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 09:57:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37728 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933280Ab0FEN52 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 09:57:28 -0400
Received: by fxm8 with SMTP id 8so1291786fxm.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hNnZC4pwkZYrU1R2zeLCWTopcs/KfLZYCFZInrphZww=;
        b=sH9wq3uN2I7qsIvBeYZvhbQiaTGTB3ZzypcfmBydEuJ8OW9Q58vpSpR747CpVNKyYs
         aNvo3VgR88ddh3mgc6Nho6TL7PBY3idIYR86F+61IUh7Dv25XEh8C/jMMeJArJ3GGBW9
         2FM2KxO1RzxERCNFsITcoEDbz3tDd044xSKMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=CltVTcVCBpiRhnWfM70oyOKo6m/OoMdHVTt4gCKcG4uPzvhInahnhGUJ4TZnYFgcmc
         D29xftMcj3u+CIiAaRtrP1lxuA77lYUD7wkeQEdjACOQbDPTXYhVaoykdJetgPobWysU
         TTDz3qeRcl9CTy+342lFd4R4UgNr+YXLRvq7k=
Received: by 10.223.18.67 with SMTP id v3mr13034150faa.93.1275746246813;
        Sat, 05 Jun 2010 06:57:26 -0700 (PDT)
Received: from localhost.localdomain (aehn204.neoplus.adsl.tpnet.pl [79.186.195.204])
        by mx.google.com with ESMTPS id z12sm10467431fah.9.2010.06.05.06.57.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 06:57:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o55DxMWG006324;
	Sat, 5 Jun 2010 15:59:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o55DxCXC006320;
	Sat, 5 Jun 2010 15:59:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275704035-6552-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148470>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> All of the interface messages in Git core are currently hardcoded in
> English. Change that by optionally enabling translation of the core C=
,
> Shell and Perl programs via GNU gettext. If you set the appropriate
> LC_* variables Git will speak your language, provided that someone ha=
s
> submitted a translation.
[...]

> Implementation and usage notes:
[...]
>  * Perl:
>=20
>    Perl code that wants to be localized should use the new Git::I18n
>    module. It imports a __ function into the caller's package by
>    default.
>=20
>    Instead of using the high level Locale::TextDomain interface I've
>    opted to use the low-level (equivalent to the C interface)
>    Locale::Messages module, which Locale::TextDomain itself uses.
>=20
>    Locale::TextDomain does a lot of redundant work we don't need, and
>    some of it would potentially introduce bugs. It tries to set the
>    $TEXTDOMAIN based on package of the caller, and has its own
>    hardcoded paths where it'll search for messages.

Actually both of those can be set using Locale::TextDomain->import()
call.  See e.g. this answer on StackOverflow:
  http://stackoverflow.com/questions/2965626/examples-of-localization-i=
n-perl-using-gettext-and-localetextdomain-with-fallb/2967872#2967872

>    [...] In any case, this is an issue wholly internal
>    Git::I18N. Its guts can be changed later if that's deemed
>    necessary.

Right.
=20
> --- a/INSTALL
> +++ b/INSTALL
> @@ -93,6 +93,14 @@ Issues of note:
>  	  history graphically, and in git-gui.  If you don't want gitk or
>  	  git-gui, you can use NO_TCLTK.
> =20
> +	- The GNU "libintl" library is used by default for localizing
> +	  Git. It needs a gettext.h on the system for C code, gettext.sh
> +	  for shell scripts, and libintl-perl for Perl programs.
> +
> +	  Set NO_GETTEXT to disable localization support and make Git only
> +	  use English. Under autoconf the configure script will do this
> +	  automatically if it can't find libintl on the system.
> +

Shouldn't you also add here that you need also "libintl-perl" to have
those commands that are written in Perl localized?

> diff --git a/Makefile b/Makefile
> index d5d6565..3040000 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -28,6 +28,15 @@ all::
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push=
 is
>  # not built, and you cannot push using http:// and https:// transpor=
ts.
>  #
> +# Define NO_GETTEXT if you don't want to build with Git with gettext
> +# support. Building it requires GNU libintl, and additionally
> +# libintl-perl at runtime.
> +#
> +# Define NEEDS_LIBINTL if you haven't set NO_GETTEXT and your system
> +# needs to be explicitly linked to -lintl. It's defined automaticall=
y
> +# on platforms where we don't expect glibc (Linux, Hurd,
> +# GNU/kFreeBSD), which includes libintl.
[...]

> diff --git a/config.mak.in b/config.mak.in
> index 0d4b64d..a15f3c1 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
>  NO_EXPAT=3D@NO_EXPAT@
>  NO_LIBGEN_H=3D@NO_LIBGEN_H@
>  HAVE_PATHS_H=3D@HAVE_PATHS_H@
> +NO_GETTEXT=3D@NO_GETTEXT@

No

  +NEEDS_LIBINTL=3D@NEEDS_LIBINTL@

(see also below)?

> diff --git a/configure.ac b/configure.ac
> index 71038fc..7bebfd8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
>  [HAVE_PATHS_H=3D])
>  AC_SUBST(HAVE_PATHS_H)
>  #
> +# Define NO_GETTEXT if you don't have libintl.h
> +AC_CHECK_HEADER([libintl.h],
> +[NO_GETTEXT=3D],
> +[NO_GETTEXT=3DYesPlease])
> +AC_SUBST(NO_GETTEXT)
> +#

No check for NEEDS_LIBINTL?  No check that gettext is properly set up
with AM_GNU_GETTEXT (protected with m4_ifdef)?

  +# Define NEEDS_LIBINTL if you haven't set NO_GETTEXT and your system
  +# needs to be explicitly linked to -lintl. It's defined automaticall=
y
  +# on platforms where we don't expect glibc (Linux, Hurd,
  +# GNU/kFreeBSD), which includes libintl.
  +AC_CHECK_LIB([c], [gettext],
  +[NEEDS_LIBINTL=3D],
  +[NEEDS_LIBINTL=3DYesPlease])
  +AC_SUBST(NEEDS_LIBINTL)
  +test -n "$NEEDS_LIBINTL" && LIBS=3D"$LIBS -lintl"

Or something like that (following examples for NEEDS_SOCKET and
NEEDS_RESOLV in configure.ac).

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 454880a..ae63316 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -37,6 +37,7 @@ ORIGINAL_TERM=3D$TERM
>  # For repeatability, reset the environment to known value.
>  LANG=3DC
>  LC_ALL=3DC
> +LANGUAGE=3DC
>  PAGER=3Dcat
>  TZ=3DUTC
>  TERM=3Ddumb

This ensures that testsuite is run without translation.  It is
required because tests often include checking output of git commands
against expected output.

But perhaps, in later commit, we should mark those test that check
porcelain output format with NO_GETTEXT or LANG_C, and add --gettext
or --intl or --localized to run (parts of) testsuite with localized
strings, checking if localization didn't broke some scripted command
(somewhere command parses output of other git command).

What do you think?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
