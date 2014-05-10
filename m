From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 20:04:59 +0000
Message-ID: <20140510200459.GC45511@vauxhall.crustytoothpaste.net>
References: <536E2C19.3000202@gmail.com>
 <20140510172338.GB45511@vauxhall.crustytoothpaste.net>
 <20140510173226.GA27483@hal.rescomp.berkeley.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: milki <milki@rescomp.berkeley.edu>
X-From: git-owner@vger.kernel.org Sat May 10 22:05:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjDWO-0006Wk-NA
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 22:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbaEJUFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 16:05:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47675 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756273AbaEJUFI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 16:05:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a04c:bcbd:f5ef:c7f5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ADF7228087;
	Sat, 10 May 2014 20:05:06 +0000 (UTC)
Mail-Followup-To: milki <milki@rescomp.berkeley.edu>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140510173226.GA27483@hal.rescomp.berkeley.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248664>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2014 at 10:32:26AM -0700, milki wrote:
> On 17:23 Sat 10 May     , brian m. carlson wrote:
> > I don't believe this is possible.  There has been some discussion on
> > related matters at least fairly recently, though.
> >=20
> > Part of the reason nobody has implemented this is because it exposes
> > additional security concerns.  If I create a commit that references an
> > object I don't own, but is in someone else's repository, this feature
> > could allow me to gain access to objects which I shouldn't have access
> > to unless the authentication and permissions layer is very, very
> > careful.  This would make many very simple HTTPS and SSH setups much
> > more complex.  Alternates don't have this problem because they're done
> > server-side.
>=20
> If this were implemented service side and specified with, say, a config
> option, would this security concern go away?

It would probably be fine if it were a config option.  I'd prefer it be
off by default, though, to prevent surprises.

The attack scenario I'm thinking of is where you have several different
users, but the web server runs as one system user.  So /git/bmc/foo.git
is owned by bmc, and /git/alice/bar.git is owned by alice.  The web
server will check authentication based on the path, and approve or deny
it.  If it's approved, it will invoke the git daemon as a CGI script.

But the git daemon itself only knows that it was authenticated as a
given user, and knows nothing about what the permissions scheme is.  So
it will blithely let me refer to any other repository and import its
data if the option is enabled.  The web server only considered the path
it was fed, so it couldn't have blocked this.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTboZrAAoJEL9TXYEfUvaLBL4P/jPe7IpCUSW3ydlot42fFR37
LBjEcENP/s7E2gafnCi76k5/KQq8tOyjAiAfEDTRlkSKpmmFceGA9K3qHlqQn7IC
pooF+1s4HKX/zuQj7Abd08ANRMCJnzuqqEktBx+0i/mgpeaST28V1UY9Q+5/BLwI
qH/z65SFARkT+IryKvKWnD/0WO9KnCPQNn2R2PzKLJXVCiLwe2pQBlMBkxRWpyb0
53GNk8bFwT/rVvm0Mrl0N8WmjdKF81Hn53m3dt3E5GfRwvuJUdyUl0K4iNPfnwE2
60zGPgDEkP0zVGjLxIpPe2RQc8r3iarj2UobEXWozJE1yhXGiUDevpfvZf27oUu1
BegBdpmO8xufEvyQkEOBcZPzjW3IdXyXlknQTE0o7fVYBqRW7O67DKEOFZ9Lb+Mh
CFcd5eMZgG9JRZ7EVpyhBSDhUknZMLtPmzjkwXLxiUkAJQIWLhkFOTTYWBFhZPGx
QlxktDgvackE/jljzTcv8VDM30rasySAwf4WLGYSFHOeCZ6KC/KBYAYL3K5rEqzu
FQUXWpBqCaj6sLDHL0xZhdtwM0MNgywIaD4euuLCfUiN/6HVo1shaQZA3WySevR+
vVXLqFINT0LsV8k4L/pINNqd1dk+XrXMSR4TYOVOJmB7RB5PfxuB2BtchLphtFt6
l45YFwD8ogwwMdGRRC1t
=/gHf
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
