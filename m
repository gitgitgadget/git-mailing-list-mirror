From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 08:52:08 -0700
Message-ID: <20140327155208.GM4008@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8UbHMnQwI7BF+TB"
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 16:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTChF-0002Ny-Pg
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 16:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbaC0P6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 11:58:17 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:34420
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754422AbaC0P6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 11:58:16 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Mar 2014 11:58:16 EDT
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id ie9e1n0090vyq2s59fsARu; Thu, 27 Mar 2014 15:52:10 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id ifs91n011152l3L3RfsAbH; Thu, 27 Mar 2014 15:52:10 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 0884210DD431; Thu, 27 Mar 2014 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395935529; bh=79Feaz9sGtwG8YQLdO57VyUQfaauJF/EF3vUN6NixAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8pWQLRuFYulcqC+ktE07lZVHhg6dPinE/esagwPpI1Mqo9CTMe17hFS+LP9gf4Ne
	 er8kTq1HdW+iCDy/8I5umrT8TF/ScjhI53/qHCNzcAo+1fdk+FrJV3RNE69FLfz/0x
	 w4h8wxSOmVpmJ/AljRAukm0qkGPhrQq9s8iOqERE=
Content-Disposition: inline
In-Reply-To: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395935530;
	bh=oOo6doU6fPR4eSW+zRAhrccf36NntA1p113RZzJbs4U=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=NwrVVY3qN+vXK2fnGnm/QFtIXGB4dfW1pdtWP8LOCOKx5kpcsg8IjSo1JnxzsSz9b
	 i52PdwOA7rG5GiKn6gSoSJ0eSCg83B4dD3qmEutwk0KKImybRgA46dg+BF0r5WwT64
	 1NUi0J7Zd/eBriItlE/BnDUXCGqU6EFYdPrvqg+gVpOKcgSfAlQJHCzLawRV7t0Wlk
	 1RyIiljdWCYvWv18BCQduWQsW7eaLVenXUUjPo0hWttfOY6NgIocsWoKuzD2PSav6y
	 JsjeJKfdsqjXOaxTiYgE5NlrT4BB0HJLuMFS4hmW+7i1QMJKAKOe9nAIaM6rkrIq/j
	 OPa582apdxX5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245287>


--c8UbHMnQwI7BF+TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 03:21:49PM +0100, Johan Herland wrote:
> I just found a failure to checkout a project with submodules where
> there is no explicit submodule branch configuration, and the
> submodules happen to not have a "master" branch:

The docs say [1]:

  A remote branch name for tracking updates in the upstream submodule.
  If the option is not specified, it defaults to 'master'.

which is what we do now.  Working around that to default to the
upstream submodule's HEAD is possible (you can just use --branch
HEAD), but I think it's easier to just explicitly specify your
preferred branch.

Cheers,
Trevor

[1]: submodule.<name>.branch in gitmodules(5)
     http://git-scm.com/docs/gitmodules.html

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--c8UbHMnQwI7BF+TB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNEknAAoJEKKfehoaNkbtK08P/jc/5HEk1s4g+kolGcYM2luD
jwbQIfbj5nTcPujcs7oYNbTRjhbbD/YSDL4DNkJsNTg/9n+nHeWC9A+7YNqdOpgi
qspceL738NYXd55HblWIV8ifdj4DyLc/w+2tjfPOjBGfmuPADoZSESkBxGwlULwJ
Pk5Q39Zw91CFlHCNtiEo5KKwTcgYgfdntaJNxoBohtLy2RL4FiFecIX1h8keuwp1
zYNvOJ4ckhELh0+iYYZQJhMoIKSd8ckxQR1otR2UEt+v5Su8zfIWXHO2y4ihL01o
WfYI5HUfehvtR3G3HgJR9hGI35lcEpIQUF6iCNMixfRvDK60F9J2KDWxZV2RA8xi
slMFxxlcRjYIdwRzXgLuqvuTapBZgEqNPeKFb6XSZP8H4tbP7h/39K4tkbtb44lJ
eeYrob9R7UBADdGhguSQgFcGNN/a/JW4TwDxmK3T8RmZC9AW3JPr02I7R9Dme4H9
t2ku5olf65umAzBwDEKAlikTuxjZNtjT3h/akBpr7EMSSm4/qlk1FZplm0LQNU6S
e3b1x/xCi+CDjhLFGtKAsKJrWBKl8JUBpoBeMpYipzjZJ2nq972guyF1lTf9YKUF
WmiRWViBBAsHkbvSBtNzeIxkyjYINudmmLZrXjSEtsx+6yOVWq/vq5UOCLqxcGlC
qqW5r08QUFtLL8wmP2O9
=5U1n
-----END PGP SIGNATURE-----

--c8UbHMnQwI7BF+TB--
