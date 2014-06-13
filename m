From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 2/4] commit test: Use write_script
Date: Fri, 13 Jun 2014 11:26:07 -0500
Message-ID: <20140613162607.GA85151@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-3-git-send-email-caleb@calebthompson.io>
 <20140613065037.GA7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:26:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUIy-0008Kv-AM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 18:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbaFMQ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 12:26:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50381 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbaFMQ0M (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 12:26:12 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 57D1D5ED;
	Fri, 13 Jun 2014 12:26:09 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 13 Jun 2014 12:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=9UplZay8pdVXQq1BVxzfUsgy
	BoY=; b=SoY1i8zLn/O+eDonDfvosyXM0fBYDrtH4hG3iGWiI7a2yJAAqDhF4xgK
	KtFt1Ddy/OOkI5sc7jNE63UKMhhQuNJBoVs5hkiVlTO0sYrIRJAkhFXn+mGyWZql
	MzPCQ+3BX+JWY0jEnvQkgQLTnDao1Qtl6RN/Kc3lm4BGhSGO1CM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=9UplZay8pdVXQq1BVxzfUsgyBoY=; b=kTnLxR+6LyGTs2AUQvqY/zJjXNtF
	N6M1g/PMXuEHerekwXPgXfy+cUw8u7gb2Kk29FICD0QEIUITqJ8pcBZeZcp7ckJ7
	5CT9anX91tEvpdJ/gvQD1KbO0auYZEE/AS0GS7Nen7GMf5IJMh2WEsaygCOo+aXO
	AJaNh/0DUdKGTr8=
X-Sasl-enc: WVD/nDbJXWiYGBn4HBg93HIX9csjxIWImGWYZwsbHIOP 1402676768
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id BD69C68016B;
	Fri, 13 Jun 2014 12:26:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140613065037.GA7908@sigill.intra.peff.net>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251607>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

You're very right - I may have confused this commit message and the one
to switch to test_set_editor. I'll rewrite this commit message.

What do you think of something like this for the description:

    Use write_script from t/test-lib-functions.sh instead of cat,
    shebang, and chmod. This aids in readability for creating the script
    by using the named function and allows us to turn off interpolation
    in the heredoc of the script body to avoid extra escaping, since
    $SHELL_PATH is handled for us.

On Fri, Jun 13, 2014 at 02:50:37AM -0400, Jeff King wrote:
> On Thu, Jun 12, 2014 at 02:39:00PM -0500, Caleb Thompson wrote:
>
> > Use write_script from t/test-lib-functions.sh instead of cat, shebang,
> > and chmod. This protects us from potential shell meta-characters in the
> > name of our trash directory, which would be interpreted if we set
> > $EDITOR directly.
>
> I'm not sure about this last sentence; isn't that what test_set_editor
> is doing, which was already there? I think the real rationale is
> readability: since $SHELL_PATH is handled for us, you can turn off
> interpolation in the here-doc containing the helper script. That avoids
> an extra layer of quoting.
>
> -Peff

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmyYfAAoJEBYhrcKgrOcKgQ0H/iypNcuesxRv85aeTmuLChZn
N6QaUnKkeftP06mEmuv1G2OKPFHFBCmdtEJHzF8Fpwc0T2trIIwyAYZTP2NHkJgv
60hg0M6J6v4IXgMFVOYnh7vFpC6Hcf/runFyqi68TmyLwt4ZqB8TN/qpauhWZZhe
2DHzg/27QbD1h/DWdTzfro2vFxYL6F8yPWeyeGrA+I0WrftSpuLQVR1B9HcBMeSg
d36BWLXDJCC4RkgI73LOCt1huL9UTmK3dTVG4aqAyShHljRGqGHs3a6ID1u/wwmk
4N7Igko1hHI7epAaBHky+vN+Z7aTOHrShJfa1n66lxw1f7yu9E1jtw1k9PWvPgQ=
=0kE1
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
