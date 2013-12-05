From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Thu, 05 Dec 2013 11:00:35 +0100
Message-ID: <1386237635.2186.22.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
	 <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 11:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoVjj-0002ym-6E
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 11:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab3LEKAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 05:00:42 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:48813 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab3LEKAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 05:00:38 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so7021664bkb.18
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 02:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=gbIE6Y4H+y47D3h1FeeMQa4LvHnhMjFrsAYlAWQcOic=;
        b=XB3aVxzFn2co9+QRWQ6yNhi1/pLpxqwMOIOmDWbT8wlOty3bFkIfpdsJfWxhVFf6Ft
         V5dNeovdIWq3VQhWrVKSQ73YPSypgb8tH+r7FA1FJm2WM8AEtSIUh4vo08S3pzAGGssJ
         0PJITQfQf9u+Tvk/KPeT5qdCV7KF8lrijPqe1MaH8Fs4GKxA2oZMeqQ+Nryq1O9naYLI
         womdLrTs96SUGIOOITZBOxrGQLBJ6XmNjaOd7ov4tHyhs9uCfkgd6eH6WUv9N/EFfOUS
         GmCXKTt4nZdy4CaxOEabbzEysDva0JBAr1rMCy9xfnZzsYFu3PjLiv4RKQH1JeBnMBDO
         yhsw==
X-Gm-Message-State: ALoCoQkO6ZS+yVIZuKKYYEwFjJb+NsKgjD7G/A0unuDLiL9Gg5Gbr6jhDmCIj22a831+qVGF9K7W
X-Received: by 10.205.36.193 with SMTP id tb1mr53951839bkb.28.1386237637419;
        Thu, 05 Dec 2013 02:00:37 -0800 (PST)
Received: from [192.168.178.31] (p57922DC5.dip0.t-ipconnect.de. [87.146.45.197])
        by mx.google.com with ESMTPSA id t2sm84346809bkh.3.2013.12.05.02.00.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 02:00:36 -0800 (PST)
In-Reply-To: <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238852>

On Wed, 2013-12-04 at 19:06 +0100, Jakub Nar=C4=99bski wrote:
> On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
> >
> > Allow extra-branch-refs feature to tell gitweb to show refs from
> > additional hierarchies in addition to branches in the list-of-branc=
hes
> > view.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
> > Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> This version is Helped-by (maybe), but not (yet!) Reviewed-by.
>=20
> > ---
> >  Documentation/gitweb.conf.txt | 37 +++++++++++++++++++
> >  gitweb/gitweb.perl            | 85 +++++++++++++++++++++++++++++++=
++++++------
> >  2 files changed, 110 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.c=
onf.txt
> > index e2113d9..5a77452 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -849,6 +849,43 @@ time zones in the form of "+/-HHMM", such as "=
+0200".
> >  +
> >  Project specific override is not supported.
> >
> > +extra-branch-refs::
> > +       List of additional directories under "refs" which are going=
 to
> > +       be used as branch refs. For example if you have a gerrit se=
tup
> > +       where all branches under refs/heads/ are official,
> > +       push-after-review ones and branches under refs/sandbox/,
> > +       refs/wip and refs/other are user ones where permissions are
> > +       much wider, then you might want to set this variable as
> > +       follows:
> > ++
> > +------------------------------------------------------------------=
--------------
> > +$feature{'extra-branch-refs'}{'default'} =3D
> > +       ['sandbox', 'wip', 'other'];
> > +------------------------------------------------------------------=
--------------
> > ++
> > +If overriding was enabled then this feature can be configured on a
>=20
> s/was/is/;
>=20
> Perhaps it would better read as
>=20
>     This feature can be configured on per-repository basis after sett=
ing
>     $feature{'extra-branch-refs'}{'override'} to true, via repository=
's
>     `gitweb.extraBranchRefs` ...

I see that you also insist on using camelCase for config variables. I
will rephrase it.

>=20
> > +per-repository basis via repository's `gitweb.extrabranchrefs`
> > +configuration variable, which contains a space separated list of
> > +refs. An example:
> > ++
> > +------------------------------------------------------------------=
--------------
> > +[gitweb]
> > +       extrabranchrefs =3D sandbox wip other
> > +------------------------------------------------------------------=
--------------
>=20
> O.K.
>=20
> > ++
> > +The gitweb.extrabranchrefs is actually a multi-valued configuratio=
n
> > +variable, so following example is also correct and the result is t=
he
> > +same as of the snippet above:
> > ++
> > +------------------------------------------------------------------=
--------------
> > +[gitweb]
> > +       extrabranchrefs =3D sandbox
> > +       extrabranchrefs =3D wip other
> > +------------------------------------------------------------------=
--------------
>=20
> I think this part should be better left for a separate patch. There i=
s
> important difference between single-valued and multi-valued configura=
tion
> variable: with single-valued later occurrences override earlier ones,
> which includes settings in more specific config file (e.g. per-reposi=
tory)
> overriding setting in more general one (e.g. per-user or system-wide)=
=2E
>=20
> With multi-valued we won't be able to override earlier / more generic
> settings... well, unless we add support for no-value, or empty-value
> as clearer, i.e.
>=20
>   [gitweb]
>            extrabranchrefs =3D sandbox
>            extrabranchrefs
>  # or    extrabranchrefs =3D
>            extrabranchrefs =3D wip other
>=20
> resulting in ('wip', 'other').

That point in this example is a bit moot IMO - if you don't want sandbo=
x
ref to appear in list of branches view then just delete the offending
line.

I also made a small experiment. In per-instance config I have
$feature{'extra-branch-refs'}{'default'} =3D ['wip'];
$feature{'extra-branch-refs'}{'override'} =3D 1;

In per-repository config I have:
[gitweb]
	extrabranchrefs =3D sandbox
	extrabranchrefs =3D other

List of branches view shows only branches from sandbox and other. So
clearly per-repository config overrides per-instance config.

>=20
> > ++
> > +It is an error to specify a ref that does not pass "git check-ref-=
format"
> > +scrutiny. Duplicated values are filtered.
> > +
>=20
> Hmmm... 'snapshot' feature ignores invalid values, but in this case
> formerly valid compression schemes might get invalid via tightening
> %known_snapshot_formats, and we don't want existing config getting
> suddenly invalid.
>=20

So, should I just ignore the invalid refs or treat them as errors?

> [cut]
>=20
> Nice!
>=20

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
