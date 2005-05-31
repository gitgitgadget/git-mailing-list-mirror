From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 21:27:00 -0500
Message-ID: <20050531022656.GA3355@unpythonic.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <17051.39850.556062.543875@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 04:26:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcwRu-0001ug-W4
	for gcvg-git@gmane.org; Tue, 31 May 2005 04:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEaC1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 22:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEaC1v
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 22:27:51 -0400
Received: from bald.unpythonic.net ([206.222.212.218]:6274 "EHLO
	sofa.unpythonic.net") by vger.kernel.org with ESMTP id S261836AbVEaC1V
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 22:27:21 -0400
Received: from jepler by sofa.unpythonic.net with local (Exim 4.42)
	id 1DcwT6-0002Vy-4R; Mon, 30 May 2005 21:27:00 -0500
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17051.39850.556062.543875@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2005 at 09:03:06AM +1000, Paul Mackerras wrote:
> Tcl/Tk 8.5 will have anti-aliased fonts (8.5a2 is available on
> sourceforge).  There is apparently some support for widget styling in
> 8.4 which I will have to look into.  The Motif look doesn't bother me,
> but it does seem to bother you and Ben H. :)

I have a somewhat stale copy of Tk 8.5 CVS and Tile CVS here.  I tried
gitk on it.  I added the lines
    package require tile; namespace import -force ::ttk::*
    tile::setTheme alt
near the top, which is a simple way to use the new "tile" theme engine
with an included, redmond-style theme.

Here's a screenshot:
    http://emergent.unpy.net/index.cgi-files/sandbox/gitk-tk85+tile.png

I have no idea why the menu is in greek.  The rest of the buttons and
labels were too, before I switched to Tile for rendering them.

I get an odd traceback that I don't get using the same gitk with
tcl-8.4.5:
    number too large to represent as a Posix time
        while executing
    "return -options $opts $retval"
        (procedure "ConvertUTCToLocal" line 20)
        invoked from within
    "ConvertUTCToLocal $date[set date {}] $timezone"
        (procedure "::tcl::clock::format" line 10)
        invoked from within
    "clock format $audate -format "%Y-%m-%d %H:%M:%S""
        (procedure "readcommit" line 37)
        invoked from within
    "readcommit $p"
        (procedure "drawgraph" line 52)
        invoked from within
    "drawgraph"
        ("after" script)
which stops the graph before it's complete.  Laying out the graph seems
much slower than with tk8.4.

Jeff

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCm8twJd01MZaTXX0RAlcqAKCjTtxhqKQME5ifAK7fCqJEJlScCwCaA++I
KrUO6tqwKAC+XbJZ4rfJjAA=
=htNo
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
