From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Mon, 26 Mar 2012 07:09:46 -0400
Message-ID: <20120326110943.GA2951@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <m3sjh2ay6j.fsf@localhost.localdomain>
 <7v1uol3m5m.fsf@alter.siamese.dyndns.org> <201203221346.35295.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:10:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC7oP-0002kz-4p
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab2CZLKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 07:10:02 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:43914 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab2CZLKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 07:10:00 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1H00MF5OCAXL20@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Mar 2012 06:09:47 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 8560D42DBFF; Mon,
 26 Mar 2012 07:09:46 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203221346.35295.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193902>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the delay since my last message, it's been a busy week ;).

On Thu, Mar 22, 2012 at 01:46:34PM +0100, Jakub Narebski wrote:
> ...if not for the fact that control flow changes from using conditional
> and early return to [longjump] "exception" based one.  That is why
> I think it would be better to put tests and refactoring in a commit
> separate from adding If-Modified-Since handling to 'snapshot' action.

I'll be sending along three patches.  The second and third are the
ones you discuss above.  The first is a teensy patch to add `Status`
output to non-304 calls to git_feed().  Without it you'd have to get a
bit more creative in the test suite.  If the status lines were left
out intentionally, let me know, and I'll come up with another
condition for those tests.

The second patch refactors and tests git_feed(), and the third patch
adds i-m-s support to git_snapshot() with associated tests.

Changes since v3:
* Patch 1/3 is completely new.
* Split previous patch into 2/3 and 3/3.
* Conditionals in 3/3 to avoid 404-ing on non-commits like v1.7.6^{tree}.
* Added testing to both 2/3 and 3/3.
* Reworked commit messages.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcE5zAAoJEPe7CdOcrcTZBXgH/1wEdyuNpI/8OhDNxwyU11to
1f6nW9xnghZoVDCsh3x3Ymd7ltIDxhuqSoBgVTBjcmMiFGNk8bu0WeSOlBIW9Zqq
SXNMlCME8kUSo4zPmzJnjW9GcQ44CXJIn3yPZZEAVtRCbifnUqyqFyqOP1b+PXeL
A/U8RzpBt6SwjvOARR8OlVA+7EaXedzWtJm/OtKKtHiE3qJJO1Vf4iRTQty9rFYl
m3ggJjrYXhN56T+0dr3jBeIo9i+AR0nUasl5L2F0t+fdD1vleGgWnzWpWOcFD9vm
lQRW3Sxb+8LbcvBRZnOPnyVZyD1WS8cByAV5E9d+WACGhAi+nhaE18xpFKFLMyw=
=XwWT
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
