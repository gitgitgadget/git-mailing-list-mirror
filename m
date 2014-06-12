From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 13:23:41 -0500
Message-ID: <20140612182341.GA42013@sirius.local>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
 <20140612084152.GA6095@hudson.localdomain>
 <20140612135051.GA35824@sirius.local>
 <20140612180459.GA15556@hudson.localdomain>
 <20140612180830.GB15556@hudson.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 20:23:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9fA-0003OD-6u
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbaFLSXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:23:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38823 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbaFLSXn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 14:23:43 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 07988632;
	Thu, 12 Jun 2014 14:23:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 12 Jun 2014 14:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=KDFwXgUO/zDYUSt2FCl/Q5MI
	e6U=; b=SMrtIdgoUYmS7kPordtS3AKYS891v+3K4jZIT5IEj1i9TuPUHnE9CCEm
	QP6s3OgZ5p8+XArawYfOeWqItzKc3UHarSVwCA16VRiKY7dn3uavKLAou9HEEsPf
	t7CaEAJZNnpGpQGWk78F+8pQZp28pmWeelVAmafLphu4xlbMrtw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=KDFwXgUO/zDYUSt2FCl/Q5MIe6U=; b=OOy6G/TdcOTe1IGYf5CWpPQi49S4
	KJsKmD46uSK08jQmtbHrq4cm0ZkpAgd2zwyVkdWx6HpAc8XkglA/5w63oGmXg+R0
	7yE48pVsmFH9Kh0E/vpq44sr6M3ukPNS4rcZd5mPBt4aSGd/QCvLStG8v7tXPUBs
	2/rgfpUoykAcIuI=
X-Sasl-enc: xZ02NyichFUkeEBr0GY+PvWpyZLpcn9Df8c1ZeiSNjdY 1402597422
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7E75568011C;
	Thu, 12 Jun 2014 14:23:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140612180830.GB15556@hudson.localdomain>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251473>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeremiah,

On Thu, Jun 12, 2014 at 11:04:59AM -0700, Jeremiah Mahler wrote:
>
> Thanks for checking.  Unfortunately the problem persists for me.
>
> It seems to be related to there not being a space at the left most part
> of the patch.  It is just a tab with no space.  So 'git am' has a
> problem because it is expecting to remove a space and there isn't one.
> See the attached screenshots with tabs highlighted.
>
> How are you preparing your patches.  'git format-patch' with a 'git
> send-email'?

I'm so glad you asked, because I've just been muddling through this.

I've been generating the cover page variously with request-pull or diff
--stat, then running a command like this, with --cc arguments added from
a list I've been keeping of people who respond to the threads:

    git send-email --compose --to=git@vger.kernel.org --thread \
        [--cc ...] --no-chain-reply origin/master...

Then I manually edit the subjects to add the version to the [PATCH N/M]
portions. I haven't been using format-patch.

It's interesting that only the first patch isn't applying. I'd love to
hear a better way.

Caleb

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmfAtAAoJEBYhrcKgrOcKvd0H/2KHkE4AubC16WGF7eq/OHcH
EW7ET27Me0PmbF+MAPtVRaYeXYWLVwdUi8vYVF0wC1Pimz1/fUnKlEDIVN/wSBr3
WvHD8lvEqJUFJJSgqL378nV3brHSvAInlSzo9BerovznTpv/zfl6/mJoTKMKQE48
1ZaXNOVecZY1ePC9MFr1f0+5CHUnn1O9hIOMSQ3TE++fXYP8Zmyx2jYyth2ODc9o
Botu2JDCqEPEUpyvBxXp9fLqOBbby+5OSUSnVrH5hF6qpOFnkfzaK23SXNdEcI/O
UbGSW+98VsumZ+7Wfe/YNM0mZzGFlSiEqm/YihSiW0r4b5NH9DZXbYDkLnKHqak=
=Uj6M
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
