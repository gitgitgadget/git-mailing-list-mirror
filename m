From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 07 May 2010 13:46:17 -0700 (PDT)
Message-ID: <m3k4rfe90n.fsf@localhost.localdomain>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	<1273180440-8641-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:46:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAURG-00067M-Cb
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab0EGUqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:46:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49308 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0EGUqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:46:20 -0400
Received: by bwz19 with SMTP id 19so804745bwz.21
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UGCZ6B880PI3O3ibXkPt0OMj08lCYm8BgosTK2VaU/A=;
        b=oN1cdDjUKBX+uzR4ZoDgEdS9gS4rZQ3bY537CfjXmEypAeuOVPfhnlhrAlNhyZaXAF
         vD+6mW4HQm4SY5JFs28ZMir8ZeB/THgyju8n3WEvtz9+g8BptDFoIXVMixs9qr/j9Ki7
         BOQq0+mKMmdJDItetQRh1wu6LKcaineXTdi7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=eXqtBNaHt6cA5sLlpnexhGftRQhQ5E4KIvypJT0NXFDQst/J1TPH+YYkjbsdcfGOBx
         TF+/ud4rfGXZ7UKvIpaMPB1U5LJR+IvnHFOHQzPpi1G4/zXhDWlrJ4n8A6KkexzlOLKn
         F2jHM6/EDPosz+viyb+D84FNYvQXZ0m8RvY0I=
Received: by 10.204.131.153 with SMTP id x25mr445187bks.159.1273265178419;
        Fri, 07 May 2010 13:46:18 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 15sm818386bwz.0.2010.05.07.13.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:46:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KjeRP012943;
	Fri, 7 May 2010 22:45:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KjENi012938;
	Fri, 7 May 2010 22:45:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273180440-8641-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146593>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> This is not ready for inclusion in anything. Commiting for RFC on
> whether this way of doing it is sane in theory.

I think this is a good idea at least in theory.
=20
> Known bugs:
>=20
>   * Breaks the model of being able to *set* config values. That
>     doesn't work for the included files. Maybe not a bug.

Errr... do I understand correctly that it simply means that you are
not able to set config values that came from included files, in
included files?

This is quite serious limitation.

>=20
>   * Errors in the git_config_from_file() call in glob_include_config(=
)
>     aren't passed upwards.

Hmmm...

>=20
>   * It relies on the GNU GLOB_TILDE extension with no
>     alternative. That can be done by calling getenv("HOME") and
>     s/~/$home/.

"git config --path <variable>" expands leading '~' to $HOME, and ~user
to home directory of given user.  Why not use this?

>=20
>   * The whole bit with saving/restoring global state for config
>     inclusion is evil, but then again so is the global state.

Why not encapsulate those global variables in a struct, passed to
appropriate functions, with a global variable holding an instance of
such struct (IIRC similarly to what is done for "the_index").

>=20
>   * We don't check for recursion. But Git gives up eventually after
>     after spewing a *lot* of duplicate entry errors. Not sure how to
>     do this sanely w/symlinks.

The alternates mechanism has some depth limit; why not use it also for
config file inclusion?  The machanism is quite similar...

>=20
> Not-signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>

You can simply do not add Signed-off-by for an RFC patch...

> ---
>=20
> > On Sun, Apr 4, 2010 at 07:50, Eli Barzilay <eli@barzilay.org> wrote=
:
> > > Isn't it better to have a way to include files instead?
> >
> > Probably yes. Programs like Apache HTTPD, rsyslog and others just u=
se
> > ${foo}conf.d by convention by supporting config inclusion.
>=20
> Here's an evil implementation of this. I know the code is horrid &
> buggy (see above). But is the general idea sane. I thought it would b=
e
> better to submit this for comments before I went further with it.
>=20
>  config.c               |   55 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  t/t1300-repo-config.sh |   43 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 1 deletions(-)

No documentation.
=20
[...]
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index f11f98c..4df6658 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -824,4 +824,47 @@ test_expect_success 'check split_cmdline return'=
 "
>  	test_must_fail git merge master
>  	"
> =20
> +cat > .git/config << EOF
> +[some]
> +	variable =3D blah
> +[voodoo]
> +	include =3D .git/more_config_*
> +EOF

I don't like this syntax.

=46irst, it forces git-config to hide all 'include' keys.  I think ther=
e
might be some legitimate <section>.include config variables (perhaps
outside git-core); with this patch they are impossible.


Second, I guess that the section name has absolutely no meaning here.
If included config file has section.key config variable, i.e.:

  [section]
        key =3D value

the variable in master config file (visible by git-config) would not
be voodoo.section.key.


Third, what happens with the sections in master config file?  If I
have the following in .git/config

  [voodoo]
        var1 =3D val1
        include =3D .git/more_config
        var2 =3D val2

and the .git/more_config has

  [foo]
        bar =3D baz

would "git config --list" see 'voodoo.var2' (i.e. sections in included
file does not change parsing of master file), or would it see
'foo.var2'?


I would propose

  include .git/more_config_*

if not for the fast that it would trip older git.  Perhaps

  [include ".git/more_config_*"]

or

  [include .git/more_config_*]

or

  ## include ".git/more_config_*"

--=20
Jakub Narebski
Poland
ShadeHawk on #git
