From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 2/8] gitweb: Pass esc_html_hl_regions() options to
 esc_html()
Date: Sun, 25 Mar 2012 00:31:34 +0100
Message-ID: <20120325003134.69378c2d@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-3-git-send-email-michal.kiedrowicz@gmail.com>
	<201203242015.50421.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 00:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBaRT-0007PX-JX
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 00:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab2CXXbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 19:31:39 -0400
Received: from mail-wg0-f66.google.com ([74.125.82.66]:33212 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2CXXbi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 19:31:38 -0400
Received: by wgbdy1 with SMTP id dy1so532135wgb.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=T5twGhrZldcG8qd+lsLndkjIChlcCLLz/nYyyG3CQ8o=;
        b=hksJlhSsEZrrwM5vMmEDAWq8V9Kbo+356i/nAl5VAnAWom3LvqDl49OUGQ0+k6n+7l
         AVOE7CLz3B09lqWzrAmPu1bpMdQErl0S1aeiBZtC6m/KKMp4RUFIfcgEU2+wo+wKctmD
         sNGIBIvnxIHwFtaP5sgY8/Ie8jmws2rwVdMsjOhEIaNxsJ5pI2o3YX4xZBtd+KrOV76y
         r4z0BGNxR4mhbvCvMWoXtsKTgneK6jt3pyIh89NBtc94cU2INnh2Yhf87Xsd1P7QwTeG
         OpGeYfN1ztDMc7JvzDMnP3Lu8r41cYunZ1bc76y5HFX352XDV86rPgC45DPfdUsc7hlS
         NSbg==
Received: by 10.180.95.1 with SMTP id dg1mr7529583wib.21.1332631896962;
        Sat, 24 Mar 2012 16:31:36 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id k6sm26905106wie.9.2012.03.24.16.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 16:31:36 -0700 (PDT)
In-Reply-To: <201203242015.50421.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193850>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > With this change, esc_html_hl_regions() accepts options and passes =
them
> > down to esc_html().  This may be needed if a caller wants to pass
> > -nbsp=3D>1 to esc_html().
> >=20
> > The idea and implementation example of this change was described in
> > 337da8d2 (gitweb: Introduce esc_html_match_hl and esc_html_hl_regio=
ns,
> > 2012-02-27).  While other suggestions may be more useful in some ca=
ses,
> > there is no need to implement them at the moment.  The
> > esc_html_hl_regions() interface may be changed later if it's needed=
=2E
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >=20
> > Jakub, The code was in fact stolen from a yours patch posted to the
> > list (gitweb: Use esc_html_match_hl() in 'grep' search) that wasn't
> > merged so maybe I should pass the authorship to you?
>=20
> Either passing authorship, with double signoff (mine and yours), and
> note explaining modification, e.g.
>=20
>   [mk: extracted from larger patch and wrote commit message]
>=20
> or courtesy contribution in the form of signoff-like annotation just
> before signoff, e.g.
>=20
>   Based-on-patch-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> is fine by me.

OK, will do.

> =20
> >  gitweb/gitweb.perl |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index af645e5..1744c40 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1732,7 +1732,9 @@ sub chop_and_escape_str {
> >  # '<span class=3D"mark">foo</span>bar'
> >  sub esc_html_hl_regions {
> >  	my ($str, $css_class, @sel) =3D @_;
> > -	return esc_html($str) unless @sel;
> > +	my %opts =3D grep { ref($_) ne 'ARRAY' } @sel;
> > +	@sel     =3D grep { ref($_) eq 'ARRAY' } @sel;
> > +	return esc_html($str, %opts) unless @sel;
> > =20
> >  	my $out =3D '';
> >  	my $pos =3D 0;
> > @@ -1741,14 +1743,14 @@ sub esc_html_hl_regions {
> >  		# Don't craete empty <span> elements.
> >  		next if $s->[1] <=3D $s->[0];
> > =20
> > -		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
> > +		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos), %opts)
> >  			if ($s->[0] - $pos > 0);
> >  		$out .=3D $cgi->span({-class =3D> $css_class},
> > -		                   esc_html(substr($str, $s->[0], $s->[1] - $s->=
[0])));
> > +		                   esc_html(substr($str, $s->[0], $s->[1] - $s->=
[0]), %opts));
> > =20
> >  		$pos =3D $s->[1];
> >  	}
> > -	$out .=3D esc_html(substr($str, $pos))
> > +	$out .=3D esc_html(substr($str, $pos), %opts)
> >  		if ($pos < length($str));
> > =20
> >  	return $out;
> > --=20
> > 1.7.8.4
