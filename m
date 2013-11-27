From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 17:15:27 +0100
Message-ID: <1385568927.2131.30.camel@localhost.localdomain>
References: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
	 <52961618.1070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 17:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlhm4-0004SY-N3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 17:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab3K0QPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 11:15:32 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:54369 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab3K0QPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 11:15:31 -0500
Received: by mail-bk0-f51.google.com with SMTP id 6so3268032bkj.24
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 08:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=tKhl6AH964fID6jwyNpC0pIbtjyq3uRmTbxkiQ2NZmw=;
        b=BUbTXmpDxI1ygBGq0O0hIASm+05H35krREpJ0Au6zN0+qHaz6UclU6VQCaLbwZ4nTW
         Yr5QW0w3WuTtLK1eDYYttQejjQRLqZPp+Qh8mDwN3WrQodnRK5/T+YpUSuNb6WB+nWe/
         EXygF/Ak7do01rniCMqmGruJ9zo98JJdchMAI9tFQcw7tjNwiTX5GOJUC75I4KztuhYz
         zK4DN7CpvJe9raRcAGTXwKKZqab1z9Xvdoz5KhhWXBY2qTTgLeWn0op+qlxlYiZAXEWF
         S3NswvEm4FYYJy42r5Ek28Gl6EY+U7T2IXQ8dpF9cmKZ6Wpu8XteSsTFExyBIP1Lm3Sa
         MjbQ==
X-Gm-Message-State: ALoCoQk0XfA32AbyVJld32aS2i6QO8i2j2H1xszDOQNzkXP8ABQBKvsddlAaCQEaVjmkuLL+JZNJ
X-Received: by 10.205.78.199 with SMTP id zn7mr670191bkb.59.1385568929577;
        Wed, 27 Nov 2013 08:15:29 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-74-dynip.superkabel.de. [95.91.241.74])
        by mx.google.com with ESMTPSA id pu8sm56160932bkb.9.2013.11.27.08.15.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 08:15:28 -0800 (PST)
In-Reply-To: <52961618.1070603@gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238447>

On Wed, 2013-11-27 at 16:56 +0100, Jakub Nar=C4=99bski wrote:
> Krzesimir Nowak wrote:
>=20
> > Overriding an @additional_branch_refs configuration variable with
> > value ('wip') will make gitweb to show branches that appear in
> > refs/heads and refs/wip (refs/heads is hardcoded). Might be useful =
for
> > gerrit setups where user branches are not stored under refs/heads/.
> >
>=20
> The description of this change starts with technical details,
> instead of starting with intent of this change.
>=20
> Perhaps (this is only a proposal)
>=20
>    Introduce @additional_branch_refs configuration variable, holding
>    names of references to be considered branches; by default empty.
>    For example setting it to ('wip') will make gitweb ...
>=20

I have already posted second version of the patch. But I didn't change
the commit message though. But thanks for proposal - it sounds better.
I'll try to make it better next time I post a patch.

>=20
> BTW. I have thought at first that is something similar to 'remote_hea=
ds'
> feature, which among others adds 'remotes' section to 'summary' view
> displaying refs/remotes/* refs... but no, gitweb still doesn't treat=20
> refs/remotes as branches, even with this feature set.
>=20
> Nb. why new configuration variable, and not new %feature?

I dunno. Hard to tell where it fits. Junio told me about using "normal
gitweb configuration mechanism", so that's the first thing that got my
attention.

http://www.mail-archive.com/git@vger.kernel.org/msg39859.html

>=20
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> >  gitweb/gitweb.perl | 99 ++++++++++++++++++++++++++++++++++++++++--=
------------
> >  1 file changed, 74 insertions(+), 25 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 68c77f6..9bfd38b 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -17,6 +17,7 @@ use Encode;
> >  use Fcntl ':mode';
> >  use File::Find qw();
> >  use File::Basename qw(basename);
> > +use List::Util qw(min);
> >  use Time::HiRes qw(gettimeofday tv_interval);
> >  binmode STDOUT, ':utf8';
> >
> [...]
>  > @@ -3184,24 +3210,43 @@ sub git_get_project_owner {
>  >   	return $owner;
>  >   }
>  >
>  > -sub git_get_last_activity {
>  > -	my ($path) =3D @_;
>  > -	my $fd;
>  > +sub git_get_last_activity_age {
>  > +	my ($refs) =3D @_;
>  > +	my $fd =3D -1;
>  >
>  > -	$git_dir =3D "$projectroot/$path";
>  >   	open($fd, "-|", git_cmd(), 'for-each-ref',
>  >   	     '--format=3D%(committer)',
>  >   	     '--sort=3D-committerdate',
>  >   	     '--count=3D1',
>  > -	     'refs/heads') or return;
>  > +	     $refs) or return undef;
>=20
> git-for-each-ref accepts more than one pattern. Why not simply
>=20
>     	open($fd, "-|", git_cmd(), 'for-each-ref',
>     	     '--format=3D%(committer)',
>     	     '--sort=3D-committerdate',
>     	     '--count=3D1',
>    -	     'refs/heads') or return;
>    +	     get_branch_refs()) or return;
>=20
> Then we won't need List::Util::min.

Yes, Junio pointed that out to me - fixed in second version of the
patch.

>=20
> [...]
>  > +sub git_get_last_activity {
>  > +	my ($path) =3D @_;
>  > +	my @ages =3D ();
>  > +
>  > +	$git_dir =3D "$projectroot/$path";
>  > +	for my $ref (get_branch_refs()) {
>  > +		my $age =3D git_get_last_activity_age('refs/' . $_);
>  > +
>  > +		push @ages, $age if defined $age;
>  > +	}
>  > +	if (@ages) {
>  > +		my $min_age =3D min(@ages);
>  > +
>  > +		return ($min_age, age_string($min_age));
>  > +	}
>  > +
>  >   	return (undef, undef);
>  >   }
>  >
> [...]

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
