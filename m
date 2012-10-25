From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Wed, 24 Oct 2012 21:12:27 -0400
Message-ID: <20121025011227.GH801@odin.tremily.us>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
 <CABURp0pqg7XC6makK2OcundMabV9AtcBNGNK6Q0TMZfJbt3anw@mail.gmail.com>
 <20121022225546.GO23101@odin.tremily.us>
 <CABURp0rpPqeTJMYXmgMG2CmU=SzzvCMeX46rnMVB0EeB_LXPiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=TdkiTnkLhLQllcMS
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 03:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRC0J-0005Fy-J0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 03:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955Ab2JYBMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 21:12:47 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:59894 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758939Ab2JYBMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 21:12:46 -0400
Received: from odin.tremily.us ([unknown] [72.68.84.95])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCF00BI6CORL600@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 24 Oct 2012 20:12:28 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 34E4767F404; Wed,
 24 Oct 2012 21:12:27 -0400 (EDT)
Content-disposition: inline
In-reply-to: <CABURp0rpPqeTJMYXmgMG2CmU=SzzvCMeX46rnMVB0EeB_LXPiA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208333>


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2012 at 02:12:18PM -0400, Phil Hord wrote:
> +                                       VAR_NAME=3D$(printf '%s'
> "$VAR_NAME" | tr A-Z a-z | sed -e 's/^[^a-z]/_/' -e 's/[^a-z0-9]/_/g')

Is there a reason why you use printf instead of echo?

Also, this sort of name cleaning should probably live in a new
function:

  clean_environment_variable()

or some such.  Is there a git-utility-functions.sh library hiding
somewhere in the source? ;)

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQiJHyAAoJEEUbTsx0l5OM/5QP/j9yN3xwU9OHH82iMRwpoYgg
5Jm5LCGlHpalXik5fRouc8JLV+Z1WDP5q4IdE0HufWAxehrgCQaXelXdiOVC/gbD
hfpmQV4DcGo+88/qxwosQsLeK3rEZflE5Y+P3lHCMfbF7jD4iM3COoFvUyvW9R4H
v0RQZQCbfBj0ucNWMwj+geMpGvMHxltqQv5JD8DPCT18nuJOtkfqNqN7gk1mRR6f
WfI3shg7uhpkOP2vZP7Q/v3xV3lXoFgtOzQ6489mHORBnV3HO21yJ1RYzfpKAe1W
8XnBECY466O0GISpR8cUdKj2Szqku3lG5aTBI4VeK/ZaPpJYs6cuMmowBrTa9y0F
cYi+/c7albrH/ZaxU4k9c+AD8EqUX2c2JBHM4VnVgNtRSkCPbWUwdNlO0iwaAPD0
EXEoOWoC1LFLYdV3Dni8ELMZdg5kaH4wDGFz0VMtpjxSFxvMo1ttHzaWrUIBKwcQ
cDeOlcgIEMZ1jnb1ajq/hhds6ReeeusKY4ORRNdeJAjYHiHX9XLl7XcPpNXNjsha
Wb2JZVnM8i24yxqzEPcGP2z5sDwg4KwdWTVol1OGYevh91teop81SpqaPEvgW99o
rES6/3IYCy4iSr5xQlgDLH4njzJbkfx9Tt0XJsk28SC1ku8AlWgKu3/StTDXUlOj
zGUG5rPfayaXYIRRbNkn
=wvGm
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
