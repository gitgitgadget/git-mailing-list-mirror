From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 28 Oct 2010 10:07:39 +0200
Message-ID: <20101028080739.GA3953@localhost>
References: <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123923.GC21146@sigill.intra.peff.net>
 <20101014185945.GA14634@burratino>
 <20101016143226.GA20515@localhost>
 <20101027171145.GA6921@sigill.intra.peff.net>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: Jonathan Nieder <jrnieder@gmail.com>, tytso@mit.edu,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 10:07:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBNVo-0003XZ-VP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 10:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184Ab0J1IG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 04:06:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63225 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065Ab0J1IGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 04:06:52 -0400
Received: by bwz11 with SMTP id 11so1313615bwz.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=XQUuN+8Ae/zNgdF17w3606lnJXsKolSbVaRklFhmfLg=;
        b=RzTMoxRoaF6jdbUwMd8LKAjkbVSiYZaV6EhVlgCYcwcyeWjLTJEMO62UDoCYqwMn3W
         TSGtTwBtsCmfps94xi5q7IWGWlaBKBo2hXHOMClCtx16Y/qStrssE3vtwu4Np9nvFASm
         7Zbyd6CpxbAu1Az7nAfhEo6fZ/qAZjVaMwLlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=TGxWmQRPp+rrYscpJaI45d9TG0xENJGXe4Zg9zKmJ55G1wM4hVQWDMf3eU4qUxPUEz
         l2eWfw7c8s/Ad9UaQ030KLGQ7B02MhNbPFnp11bk53ZN2NxWH7ZJ3Lu6O+5KUlgy9bjt
         hm2ntDp4UfzgGLJI80RoWkRjUZqEQ0+nfIxH0=
Received: by 10.204.54.68 with SMTP id p4mr1221627bkg.184.1288253211016;
        Thu, 28 Oct 2010 01:06:51 -0700 (PDT)
Received: from darc.lan (p549A6777.dip.t-dialin.net [84.154.103.119])
        by mx.google.com with ESMTPS id r21sm7751075bkj.10.2010.10.28.01.06.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 01:06:49 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PBNWN-0001iQ-7q; Thu, 28 Oct 2010 10:07:39 +0200
Content-Disposition: inline
In-Reply-To: <20101027171145.GA6921@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160163>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, Oct 27, 2010 at 10:11:45AM -0700, Jeff King wrote:
>=20
> Thanks both of you for the extra data points. If you don't mind, would
> you consider running my updated git-skew below on your test cases (or
> tweaking your skew detectors, since you both seem to be getting a '#
> skewed' column that mine didn't output).

I think this works well for small skews and for positive skews,
i.e., if the date goes back to the future. But if the date goes
into the past, that time is used as the new reference, and all
subsequently traversed commits are considered skewed. So for
example, if I add the following commit to git.git's current master,
the longest run becomes 1092 commits.

$ GIT_COMMITTER_DATE=3D$(date -d "now-1 year") git commit --allow-empty -m =
add-skew

To solve this, we could keep track of a window of the last n
commits traversed and take as a new time reference the largest date
within that window which is smaller than the previous reference.
That way we would fail to detect skew only if all of the commits in
that window are skewed into the past or into the future.

This particular scenario does not seem to occur in any of the repos
I tested, except maybe for the mesa repo. But manual inspection
shows that that repo has very long runs of skewed commits anyways.

linux                           99 days         80
wine                    1       14 days         1
mesa                    4930    150 days        1520
                                                                           =
    =20
xf86-video-ati          13      ~2.5 hrs        4
xf86-video-intel        26      8 hrs           4
xf86-video-nouveau      12       10 hrs         9
                                                                           =
    =20
fluxbox                 0       0               0
metacity                0       0               0
openbox                 8       4 hrs           4                          =
    =20
                                                                           =
    =20
giggle                  2       21 min          2                          =
    =20
glibc                   2       931 days        1

Clemens

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMyS9LAAoJELKdZexG8uqMCqcIAJeaZT7E8o83i7nEwC2eHbBa
WQ33yplfHkE4oQKdTw2S9KsgjR179uNb0mIsDjmc5aOOSsI4L3c/rPSqxsMVlJcI
2N9UzN7HhI9WCnh96FHsCoMS3OX7mTJtElmzl0PRfV3jBuUPCkRHlCdlkzhEypkX
BCPkU8ne6V6c3DziyhUzdjub6l8vVvSJXotunooffiYnbb0A3cXCIeqJPBKMD4OR
MWoIsjdgdxOnf1xe24CeDRs9sp3rgDmedOJRJTWlvhGeAKhFOJ3oC4hXaSWxdJs1
ZETFx61DLooQJ3vCz3qGqQ54BWNySRXo2aPqf6DmF1CDEfSpCBZSYX1t9/tUh1g=
=tIqd
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
