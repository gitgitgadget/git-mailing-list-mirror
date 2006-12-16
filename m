X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Sat, 16 Dec 2006 23:58:10 +0100
Message-ID: <20061216225810.GD12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <20061216203553.GA25274MdfPADPa@greensroom.kotnet.org> <7v64cbeeiv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
NNTP-Posting-Date: Sat, 16 Dec 2006 22:58:28 +0000 (UTC)
Cc: skimo@liacs.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v64cbeeiv.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34650>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GviTz-0007AE-NP for gcvg-git@gmane.org; Sat, 16 Dec
 2006 23:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422754AbWLPW6P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 17:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWLPW6P
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 17:58:15 -0500
Received: from mail.admingilde.org ([213.95.32.147]:54366 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422754AbWLPW6O (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 17:58:14 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GviTq-00059l-QM; Sat, 16 Dec 2006 23:58:10 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

Junio, I'll take a more detailed look at your mail tomorrow, after I
regenerated from all the Guinness I had tonight ;-)

On Sat, Dec 16, 2006 at 01:07:04PM -0800, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > On Sat, Dec 16, 2006 at 10:32:36AM -0800, Junio C Hamano wrote:
> >> I suspect the hardest part is "rev-list --objects" (now most of
> >> it is found in revision.c).  [..]  But I think the updated
> >> code needs to know that "link" needs to be unwrapped and
> >> contained "commit" needs to be injected back to the ancestry
> >> walking machinery.

Well, I already got to the point of using the commit directly,
instead of any link object.  It even worked with rev-list --objects
in all my test cases.  That is, I could correctly clone/pack/pull
the complete project including all modules.

> > Wouldn't we then run into the scalability problems Linus was
> > concerned about ?

This is a real problem.

> If the plumbing layer does not have to (although I haven't
> thought it through, it does feel like it even shouldn't) unwrap
> "link" and let the Porcelain layer to deal with it, that would
> certainly make rev-list/revision.c part simpler.

Yes.  However, it makes other things more complicated.
If the plumbing does not do all the subproject stuff and you don't have
everything in one database it is much more difficult to really get
a consistent database when cloning or fetching (you have to get even old
submodule commits which are not reachable by the current supermodule
tree anymore, perhaps even submodules which do not exist anymore).

I did not have much time to think about these issues in the last day and
am not yet convinced on how to proceed,

--=20
Martin Waitz

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhHoCj/Eaxd/oD7IRAipeAJ9MOpCQ69JP9Fs2V+iQeFvdTqlPyQCeLKN1
UnDASwSYEh8vHnOAx9P2Qrk=
=T135
-----END PGP SIGNATURE-----

