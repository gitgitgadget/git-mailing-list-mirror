From: Charles Strahan <charles@cstrahan.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 04 Mar 2016 01:12:37 -0500
Message-ID: <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abiyi-0002zF-2A
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 07:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcCDGMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 01:12:40 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43322 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751024AbcCDGMj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 01:12:39 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D78A723093
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 01:12:37 -0500 (EST)
Received: from web5 ([10.202.2.215])
  by compute2.internal (MEProxy); Fri, 04 Mar 2016 01:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=cstrahan.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=bvkLPmEZTE1LUUYMrQ9a7Kmk6vw=; b=DwcHLX
	nD0MTsHa40fQw5jzd7BQwaAIAzXO6Kw2Xnm94aN/3vd+5z51lewUtI9JlXxhl1Yw
	DPoeLgFKU4xByvvooFWf/rzdzXaT3eSqgZhVzPliFQXSxJFoJxh31UCI3ntdmxrq
	f1LQBfxxozn4Ye3KLoxWMCPD1fTZWqQ6rcmoc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bvkLPmEZTE1LUUY
	MrQ9a7Kmk6vw=; b=KQQqKW+UDNrdE4Xi9p5iJPHLyrUPj3/xyo/bFJD6BfHU3A2
	wdGrV5yi8KzKf2Q+lShNVE2qWfOrr5QJuLfe/oilcdgtz4DZzpliRa7IwHVMFU1m
	WVPilC1nzrBjJdNk6SMdHGgZNUA5OY5VwLPO0iVR9rJkHG2U/JWTJf9m68sg=
Received: by web5.nyi.internal (Postfix, from userid 99)
	id 84BFAAC40E5; Fri,  4 Mar 2016 01:12:37 -0500 (EST)
X-Sasl-Enc: I6C+J38Omemuqk2UT0VRNaa0qLBNZJfIiPrelN3gHLd/ 1457071957
X-Mailer: MessagingEngine.com Webmail Interface - ajax-f86c47c0
In-Reply-To: <20160304055117.GB26609@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288234>

I'm on 2.7.0.

Here's a quick sanity check:

=E2=94=9C=E2=94=80=E2=94=80 baz
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quux
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 corge
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 wibble.txt
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 grault.txt
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 waldo.txt
=E2=94=94=E2=94=80=E2=94=80 foo
    =E2=94=9C=E2=94=80=E2=94=80 bar.txt
    =E2=94=94=E2=94=80=E2=94=80 garply.txt

$ git --version
git version 2.7.0

$ git status -sb -uall
## Initial commit on master
?? baz/quux/corge/wibble.txt
?? baz/quux/grault.txt
?? baz/waldo.txt
?? foo/bar.txt
?? foo/garply.txt


=46or the lazy (such as myself), this will set up an identical tree:

mkdir -p foo
mkdir -p baz/quux/corge
touch foo/bar.txt
touch foo/garply.txt
touch baz/waldo.txt
touch baz/quux/grault.txt
touch baz/quux/corge/wibble.txt
cat <<"EOF" > .gitignore
*
!/foo
!/foo/bar.txt
!/baz
!/baz/quux
!/baz/quux/**/*
EOF


I just checked https://git-scm.com/docs/gitignore and the example at th=
e
bottom
suggests that this behavior may be expected:

    $ cat .gitignore
    # exclude everything except directory foo/bar
    /*
    !/foo
    /foo/*
    !/foo/bar

Note the /foo/*, explicitly ignoring the entries below /foo.

This wasn't always the case, though, so I'd love to hear if it was
intentional
(or if I've lost my mind, which is quite possible).

-Charles



On Fri, Mar 4, 2016, at 12:51 AM, Kevin Daudt wrote:
> On Thu, Mar 03, 2016 at 09:11:56PM -0500, Charles Strahan wrote:
> > Hello,
> >=20
> > I've found a change in the way .gitignore works, and I'm not sure i=
f
> > it's a bug
> > or intended.
> >=20
> > Previously, one could use the following .gitignore:
> >=20
> >     *
> >     !/foo
> >     !/foo/bar.txt
> >     !/baz
> >     !/baz/quux
> >     !/baz/quux/**/*
> >=20
> > And these files would be seen by git:
> >=20
> >     foo/bar.txt
> >     baz/quux/grault.txt
> >     baz/quux/corge/wibble.txt
> >=20
> > And these files would be ignored:
> >=20
> >     foo/garply.txt
> >     baz/waldo.txt
> >=20
> > At some point (between git 2.6.0 and 2.7.0, I think), the behavior
> > changed such
> > that _none_ of the files above would be ignored. Previously, git wo=
uld
> > treat
> > !/foo as an indication that it should not prune /foo, but that
> > _wouldn't_ be
> > sufficient to un-ignore the contents thereof. Now, it seems the new
> > scheme
> > treats !/foo as functionally equivalent to !/foo followed by !/foo/=
**/*
> > in the
> > old scheme.
> >=20
> > I manage my home directory by making it a git repo, and using
> > ~/.gitignore to
> > selectively permit certain files or subdirectories to be seen by gi=
t.
> > The recent
> > change in behavior has resulted in sensitive directories like ~/.gp=
g
> > being
> > un-ignored. For reference, I've appended my .gitignore to the end o=
f
> > this email.
> >=20
> > So, is this behavior intended, or is this a bug? If the former, is =
there
> > an
> > announcement explaining this change?
> >=20
> > -Charles
> >=20
> > [snip]
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> Works as intended for me:
>=20
> =E2=94=9C=E2=94=80=E2=94=80 baz
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quux
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 corge
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=
=94=94=E2=94=80=E2=94=80 wibble.txt
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 grault.txt
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 waldo.txt
> =E2=94=94=E2=94=80=E2=94=80 foo
>     =E2=94=9C=E2=94=80=E2=94=80 bar.txt
>     =E2=94=94=E2=94=80=E2=94=80 garply.txt
>=20
> $ git status -s -uall
> ?? baz/quux/corge/wibble.txt
> ?? baz/quux/grault.txt
> ?? foo/bar.txt
>=20
> garply.txt and waldo.txt are ignore, but the rest is still tracked.
>=20
> I'm on 2.7.2.
