From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] reduce progress updates in background
Date: Tue, 14 Apr 2015 03:12:28 +0000
Message-ID: <20150414031227.GB591600@vauxhall.crustytoothpaste.net>
References: <20150413134850.GC23475@mewburn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 05:12:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhrHL-0001FF-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 05:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbbDNDMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 23:12:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:35520 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750894AbbDNDMf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 23:12:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e1c6:301d:8c3f:979b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3F9AC2808D;
	Tue, 14 Apr 2015 03:12:33 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
Content-Disposition: inline
In-Reply-To: <20150413134850.GC23475@mewburn.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267110>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 11:48:50PM +1000, Luke Mewburn wrote:
> Hi,
>=20
> I've noticed that when a long-running git operation that generates
> progress output is suspended and converted to a background process,
> the terminal still gets spammed with progress updates (to stderr).
>=20
> I've explicitly separated the in_progress_fd() function
> so that it's easier to (a) reuse elsewhere where appropriate,
> and (b) make any portability changes to the test if necessary.
> I also used getpgid(0) versus getpgrp() to avoid portability
> issues with the signature in the latter with pre-POSIX.

I like this patch.  It's simple and seems like a sensible change, and I
appreciated the opportunity to learn about tcgetpgrp(3).  The Windows
folks will probably need to stub that function out, but they're no worse
off than they were before.

I do agree with Nicolas that optimizing the code to avoid calling
in_progress_fd as much as possible is a good idea, since system calls
can be expensive on some systems.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVLIWbAAoJEL9TXYEfUvaLIhQP/08Kph91EFFnflWyN3G8mouy
Yx8fT3yDJlh/8r4y6EUPy1jFTOg+48qP9gUNfNLZadC+uF55PdHF32sJnqa6djc/
+TyFRSmMsce0OIr+a9oiYy4it402SrOHSoQGrPF1pRfYG/10j2SXv8q6fLHyPP5b
RsQzU669gveA8jP/2LzfrUDsMl5gvaI+7k6B/B/YNv2WTrReP2RpVqwflSmbxJqA
3CC0j2xaNNBzzM2W7v8FJaz4Zwtv+v1Y7sJrrefPTtMAvBUnGNdZMHlRyOURS70P
X4krVBpL99oGDy+c2zcbbqlZydFt7WCO72/g7GYQN9i/rFyjIJPH3E2Tw+FlHtkB
Agk+pZuzcOwYv5zaVLz7NaYS97N7C9mSXnt8dPAyim9WUcJL485l2rY1oY2Dk1lb
V7RIgrX0NtlYIxsl4kJp72pd/CFEWsWd2DsYOI74wXcQxBPyn7YSC9hUJL+mkB26
oddvRoMOQ5fzv1GKDkOS8GKZUt6kNcOy/kGRClZzMZBtyBI2meb5Mq5WcPJjM4/u
sNHzoSje4v/LrOdQqVfHUgfQ7P1ycyZ04jd08QLV/r9ciqngu+zaXrV+rp2L0AJu
Nf8KLKiMpCiZwu388ZUeM/9b9JysWP/WgL6+hOLnBZ7bV7ZIikP5Dwbpxp4pWx62
xuzgr7CstQmjZ7azE7Hr
=Unrh
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
