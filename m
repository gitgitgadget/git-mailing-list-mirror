From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 17:29:09 -0700
Message-ID: <20090406T002445Z@curie.orbis-terrarum.net>
References: <20090405T230552Z@curie.orbis-terrarum.net> <0015174c150e49b5740466d7d2c2@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 02:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqcjg-0006Qa-JQ
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 02:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbZDFA3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZDFA3R
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 20:29:17 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:50013 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751549AbZDFA3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 20:29:16 -0400
Received: (qmail 27688 invoked from network); 6 Apr 2009 00:29:12 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 06 Apr 2009 00:29:11 +0000
Received: (qmail 11069 invoked by uid 10000); 5 Apr 2009 17:29:09 -0700
Content-Disposition: inline
In-Reply-To: <0015174c150e49b5740466d7d2c2@google.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115745>


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2009 at 12:17:18AM +0000, SRabbelier@gmail.com wrote:
> Heya,
>
> On Mon, Apr 6, 2009 at 01:38, Robin H. Johnson robbat2@gentoo.org> wrote:
>> Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at the=
=20
>> server
>> in this case cut the 200 wallclock minutes before any sending too place=
=20
>> down to
>> 5 minutes.
> I'm curious what kind of hardware changes you made to achieve such an=20
> enormous effect? Was it just added RAM on the same machine?
No, see the paragraph previous to that, showing it was a different machine =
that
just happened to have 6GiB of RAM.

The key difference is that having 6GiB of RAM was enough to stop the
swap/OOM-killing of git-pack-objects/git-upload-pack that happened on the s=
low
server, which I considered to be entirely unwarranted since the pack was
already generated and perfect for use.

"Slow" server:
- deadline scheduler
- AMD Opteron 1210, single socket, 2 cores @ 1.8GHZ
- 2GB Reg ECC RAM
- 2x ST3250620AS, RAID1
- 100Mbit internet feed, co-located in Texas.

"Fast" server:
- deadline scheduler
- Intel Core2 Q6600, single socket, 4 cores @ 2.4GHz
- ~5.7GiB of cheap RAM (6GiB in the box, 256 not usable due to BIOS MTRR br=
okeness)
- 7x ST3320620AS, RAID-5.
- Sitting on my home LAN, with a very crappy upload bandwidth to the Intern=
et.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknZTNUACgkQPpIsIjIzwizcrwCcCNwkCn70p5VLnORDAsikWYtS
DlMAoNjfgtuv5uYrcBXpkVmkRHpgX60a
=mPqu
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
