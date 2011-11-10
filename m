From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [fyi] patches used by git distributors
Date: Thu, 10 Nov 2011 11:12:48 -0500
Message-ID: <20111110161248.GE28719@inocybe.localdomain>
References: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 17:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROXSq-00061P-JT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 17:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab1KJQ0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 11:26:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([74.115.168.62]:52507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab1KJQ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 11:26:51 -0500
X-Greylist: delayed 840 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Nov 2011 11:26:51 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C27D6A07;
	Thu, 10 Nov 2011 11:12:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=0AqvU+90QieX1ytI6Tmuhds4q24=; b=T62uDEs
	bz6RYW+zqaV0L8NotrUwx58zFXRGzeUIQkhd3PWM91sa2he0irMekL5N5OY8arcw
	Cka+36cDThZIx/ZhnnVo3AiKkPxdIdmHSmDTsaiG83qr+NJvb21ujD5qoyDWwlWM
	OvMzEJE/AfkNIh/QP3pxA6ZAF3UTefJO6YjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=PzRczs/EwW/TMj6v5P5RKdKqMWPoeHn3A
	sDpZLT5YQtnnZdaPXcmFXXKnR/UxK3QuXO8fp1tmYdKflokE8xcD2valZVj6SH2F
	MWWIy9QcadE0OyCV13U4jgMT4fFJXWV3FbIGwI/zwucbcTpLGOnGSWoGe0dQNw1C
	pUPzyIgh0A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74EF16A06;
	Thu, 10 Nov 2011 11:12:50 -0500 (EST)
Received: from inocybe.localdomain (unknown [74.99.162.88]) (using TLSv1 with
 cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested)
 by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2AF36A05; Thu, 10 Nov
 2011 11:12:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: D5F12A0A-0BB6-11E1-837D-65B1DE995924-09356542!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185237>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for putting this together.

Jonathan Nieder wrote:
> In an ideal world, each patch applied by downstream distributors would
> fall into one of two categories: (a) adapting the package to some
> esoteric distro-specific requirement (i.e., special-interest patches)
> or (b) in the process of being generalized and reviewed for eventual
> application upstream, so everyone can benefit from it.  Unfortunately
> that takes time.  I should do better --- sorry about that.

> A few other packaging projects:
>
>  - git://pkgs.fedoraproject.org/git.git master --- 3 patches (using
>    SERVER_NAME for home link, reviving vc-git.el, compatibility with
>    newer cvsps)

To review the patches we have in Fedora/EPEL:

- git-1.5-gitweb-home-link.patch=C2=B9

This predates my involvement in git packaging.  The default for
++GITWEB_HOME_LINK_STR++ is projects.  The patch just uses
git://$SERVER_NAME if SERVER_NAME is available, falling back to
projects if it is not.

I'm not sure exactly why that's an improvement over using projects, to
be honest.  It's only a text string and it links to the gitweb home,
not to the contents of the string, so whether it reads projects or
git://$SERVER_NAME it takes the user to the same place.  Definitely
doesn't seem like something we'd want to push into gitweb and I'm
wondering why we even want to carry it in Fedora/EPEL at this point in
the morning. :)

- git-1.7-el5-emacs-support.patch=C2=B2

This is only applied to builds for EL-5, where emacs is too old for
the current emacs git support.  From the commit message:

    This is the vc-git.el from 1.6.4.1, the last version to include
    it.  Most uses will be better served by the vc-git.el which is
    provided by emacs >=3D 22.2, but on EL-5 we don't have the luxury of
    a modern emacs.

Basically, to not break emacs support for folks who were using
git-1.5.x from EPEL, we had to provide something to allow us to push
git-1.7.x.  It seems there are relatively few emacs-git users running
EL-5, as getting testers for this was difficult.  At the same time,
we've gotten 0 bug reports.  So it either works about as well as it
did with git-1.5.x or no one uses it to notice that it doesn't work.

- git-cvsimport-Ignore-cvsps-2.2b1-Branches-output.patch=C2=B3

This one became necessary when Fedora moved to cvsps 2.2b1 and git
cvsimport got noisy=E2=81=B4.  As cvsps is pretty much dead upstream, it di=
dn't
seem like this patch was worthy of inclusion in git.

If any of these seem like candidates for inclusion, I'm happy to
properly submit them.

=C2=B9 http://pkgs.fedoraproject.org/gitweb/?p=3Dgit.git;a=3Dblob;f=3Dgit-1=
=2E5-gitweb-home-link.patch;hb=3DHEAD
=C2=B2 http://pkgs.fedoraproject.org/gitweb/?p=3Dgit.git;a=3Dblob;f=3Dgit-1=
=2E7-el5-emacs-support.patch;hb=3DHEAD
=C2=B3 http://pkgs.fedoraproject.org/gitweb/?p=3Dgit.git;a=3Dblob;f=3Dgit-c=
vsimport-Ignore-cvsps-2.2b1-Branches-output.patch;hb=3DHEAD
=E2=81=B4 https://bugzilla.redhat.com/490602

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Dope will get you through times of no money better than money will get
you through times of no dope.
    -- Freewheelin' Franklin


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEVAwUBTrv3+kMlk4u+rwzjAQiVZwgAqz+EW142n1p+NoTA+/4LLRV3+JAaZXvw
gZD6fjp0+/vYLq9Mc1MwZyR+L/dQ0PAg37XEuZc1NcPB4EjtbKhLt3MV0VobIK2G
SDYaol0gVno5lcQOrsq//RukuYOD9AIA8WxtonZb35nJYDAK7+S8mZw2slonoEdo
0QOHdtAT2rFKEAKnjZI2UiYnbDm4pp8+C3nEUKMQS1HZFiP2HA1i80kdmqdpTBrl
ljauqlwCA0q6oeXe2qnENf4IODtTh15Xs9/PtY2noXH2xjSKtZtQ7sDLfe/R8nzC
6dMqIjipVMa3TBNv7Uah4eGJrp1xwDiIIiVBxmno2RfPhIDTSiXHqQ==
=eU4B
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
