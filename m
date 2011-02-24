From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: new behaviour in git merge
Date: Thu, 24 Feb 2011 20:24:54 +1100
Message-ID: <20110224202454.d3b8668e.sfr@canb.auug.org.au>
References: <20110224143353.ddaa316a.sfr@canb.auug.org.au>
	<20110224081553.GD25595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Feb_2011_20_24_54_+1100_H+zF6s1in//I4K6m"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 10:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsXRl-0007kA-5G
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 10:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab1BXJZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 04:25:11 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:39353 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966Ab1BXJZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 04:25:09 -0500
Received: from canb.auug.org.au (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id 4A14B144BA5;
	Thu, 24 Feb 2011 20:25:06 +1100 (EST)
In-Reply-To: <20110224081553.GD25595@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167786>

--Signature=_Thu__24_Feb_2011_20_24_54_+1100_H+zF6s1in//I4K6m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Thu, 24 Feb 2011 03:15:53 -0500 Jeff King <peff@peff.net> wrote:
>
> I don't think any such change was intentional.  I couldn't reproduce

I was hoping that it was not intentional :-)

> with a trivial example. Can you give the commit IDs of the two heads in

I also tried a trivial example but failed to reproduce it.

> your example merge? I'd like to try bisecting if I can reproduce the
> issue.

In today's linux-next tree (available at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git),
commit ad11c1e8abca18872c2993b09b1abde418955b6c is just before the merge
and commit a2c06ee2fe5b48a71e697bae00c6e7195fc016b6 is what was merged.

I just did this in a copy of my tree:

	git reset --hard ad11c1e8abca18872c2993b09b1abde418955b6c
	sleep 90
	git merge a2c06ee2fe5b48a71e697bae00c6e7195fc016b6

A comparison of the ls -lR ouput before and after showed a lot of changed
modification times.

Several other merges showed the same problem.

Thanks for looking at this.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Feb_2011_20_24_54_+1100_H+zF6s1in//I4K6m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNZiPmAAoJEDMEi1NhKgbsbtEH/0lATuPuf6NJ48EYkvqYP3xf
ZGMeNWIgmGSDl/vSEmOXFGsbdXbXXwCc6/rOLUb8j8jg++hAad40LJG77YLfsMuu
29Jt9ujyuHw6S5pcrUEiG9lmcJWIAJFBl5X8bXX7FQA5B6N/JhKzvuR2n5lZSrEr
MX36PIHvMgju5pKNKUTenBBjN6PrqdWqfFpOfxUBSEVa0zazAz9mg6/VxhvStMON
Yg3k3wl+1SzzfwkxRjmU0S7sWnLXQyo8/kyDshVzYcALLECjcGRaRikyS1mpqYNt
bdtXaFCRlxKpKr3NuSZE6MKd7lsLW0rPVcGZfTxGDSKWUu7wwj02uqKJDyjf1z0=
=avva
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Feb_2011_20_24_54_+1100_H+zF6s1in//I4K6m--
