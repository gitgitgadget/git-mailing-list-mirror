From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Sat, 8 May 2010 01:43:16 +0200
Message-ID: <201005080143.21172.jnareb@gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com> <m3k4rfe90n.fsf@localhost.localdomain> <AANLkTinCaPrThtuQd7tUFxNNn9KUx9v3_PXnH_6C8yco@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 01:43:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAXD5-0005jt-4H
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 01:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0EGXnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 19:43:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:47561 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab0EGXnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 19:43:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so86099fgg.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4Fnft2+Ff7VMK5aSJcv8fXY69Aw7Fe+35br/VzhjcL4=;
        b=Hw/ShA3T25BogjoUObmvF0JSXbFe0WrF+KZ0J8rrRAPEh8DMFuXIxHYp4i8TrlK/r9
         ZuYi8fLLGSOHhdI4YM7POlp7qamM3f6RDWs1v+53jHqERD78ktxBwxDIdFjgCGLyFXvU
         vn2nAPF94F6LNUXnny4LuqqKTXfT+UiSyqAa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ipevdw64tKPNVQhVfWdHJCh5e9VnQBLRfTiQKca7m/8h2DAID/ZFVMpXSIeLaDVkyx
         AOGpihnJ4jTQ11vSFY8GmvlsUbUtH3PX39oKWuEtykYuShsYP+a470gcB9N0xaerP2R+
         iRr7+YnkjOagxm7f7yb6dyuF2y3RS8Ua01lqk=
Received: by 10.87.1.2 with SMTP id d2mr4892114fgi.34.1273275813103;
        Fri, 07 May 2010 16:43:33 -0700 (PDT)
Received: from [192.168.1.13] (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 3sm221255fge.20.2010.05.07.16.43.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 16:43:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinCaPrThtuQd7tUFxNNn9KUx9v3_PXnH_6C8yco@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146619>

On Sat, 8 May 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, May 7, 2010 at 20:46, Jakub Narebski <jnareb@gmail.com> wrote=
:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> wri=
tes:

> > > Known bugs:
> > >
> > > =C2=A0 * Breaks the model of being able to *set* config values. T=
hat
> > > =C2=A0 =C2=A0 doesn't work for the included files. Maybe not a bu=
g.
> >
> > Errr... do I understand correctly that it simply means that you are
> > not able to set config values that came from included files, in
> > included files?
> >
> > This is quite serious limitation.

I was wrong there; this is not even a problem.

> It is. And recap, you can now you can set Git's config in either
> places .git/config, ~/.gitconfig and $prefix/etc/gitconfig.
>=20
> With inclusion this is a bit more complex. If my ~/.gitconfig include=
s
> a seekrt.key=3Dfoobar via an include in ~/.gitconfig/seekrt, what sho=
uld
> `git config --global seekrt.key newkey` do? How about `git config
> --global seekrt.some_new_value blah`?
>=20
> I think it's best to not try to get into that mess and just let the
> user manage included files manually, or with `git config --file`.

This is not a problem: while "git config --get foo.bar" would search
through $GIT_DIR/config, ~/.gitconfig and /etc/gitconfig (and with
your addition also included files), "git config foo.bar baz" would set
foo.bar to baz always in per-repository config file (in absence of
--global / --system / --file=3D<file> option).

So this would be simply an extension of existing situation.  Not a bug.

> > > =C2=A0 * The whole bit with saving/restoring global state for con=
fig
> > > =C2=A0 =C2=A0 inclusion is evil, but then again so is the global =
state.
> >
> > Why not encapsulate those global variables in a struct, passed to
> > appropriate functions, with a global variable holding an instance o=
f
> > such struct (IIRC similarly to what is done for "the_index").
>=20
> That's indeed the sane way to go. I'll do that (and look at
> the_index).

Note that variable might not be called the_index...

[...]
> > > +cat > .git/config << EOF
> > > +[some]
> > > + =C2=A0 =C2=A0 variable =3D blah
> > > +[voodoo]
> > > + =C2=A0 =C2=A0 include =3D .git/more_config_*
> > > +EOF
> >
> > I don't like this syntax.
>=20
> Me neither.
>=20
> > First, it forces git-config to hide all 'include' keys. =C2=A0I thi=
nk
> > there might be some legitimate <section>.include config variables
> > (perhaps outside git-core); with this patch they are impossible.

Here I didn't notice that it has to be voodoo.include, and not any othe=
r
fully qualified variable name, i.e. section name must be voodoo.

> It's only hiding the full 'voodoo.include' key currently, you can
> still have e.g. 'bleh.include'.

voodoo.include shows that black magic voodoo; include.file could be
a bit better.

> > I would propose
> >
> > =C2=A0include .git/more_config_*
> >
> > if not for the fast that it would trip older git. =C2=A0Perhaps
> >
> > =C2=A0## include ".git/more_config_*"

Or perhaps

  #include ".git/more_config_*"

:-)

>=20
> Probably not a good idea to mix up comments & configuration like
> that. Some (semi-broken) parsers of .gitconfig also use INI parsers t=
o
> parse it, which breaks on # comments. Those are already broken, but i=
t
> would be nice if a feature didn't require them.

BTW IIRC ini-files format (at least one of them) allows for ';'-prefixe=
d
line comments (comment must be on its own line); I wonder how it is wit=
h=20
ini-like git config format.

But in some ini-formats definition we have that both the hash mark (#)=20
and the semicolon (;) are comment characters.

>=20
> > =C2=A0[include .git/more_config_*]
>=20
> Syntax error on older Gits.
>=20
> > =C2=A0[include ".git/more_config_*"]
>=20
> I like this one the best. It's also easy to modify the parser (so it
> doesn't think it's a section) to handle it. And it doesn't incur the
> confusion of looking like a normal configuration variable.

What I don't like with this proposal is that one could write

  [include ".git/more_config_*"]
  	foo =3D bar

Which is confusing.

But perhaps we can break backwards compatibility here.  I don't know...

  <include .git/more_config_*>
  [[.git/more_config_*]]
  {{.git/more_config_*}}
  [=3D.git/more_config_*=3D]
  [@.git/more_config_*]
  %include ".git/more_config_*"
  @INCLUDE =3D .git/more_config_*=20

--=20
Jakub Narebski
Poland
