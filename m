From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 12:47:45 -0500
Message-ID: <20140613174745.GA88614@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
 <20140613065942.GB7908@sigill.intra.peff.net>
 <20140613163644.GB85151@sirius.local>
 <539B3205.5010208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:47:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVa0-0002l6-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbaFMRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:47:52 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40355 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616AbaFMRrw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 13:47:52 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51968634;
	Fri, 13 Jun 2014 13:47:47 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 13 Jun 2014 13:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=5Vk5bjGug5y/N8UpWmN5gu5s
	ZxE=; b=kYoFJOdVxFiYLwFfjUBrEQNS0t6cQ/ZAysQ1p3TDAT6Ahhqn3JPf6o8K
	vB6dtDF4je9VjFs1IBRptbhTKjp4ab0p0SIvS1Atc2fHjM2r0HNHso1kyxS9aSko
	jgy8IAo3wxUSrC66RIQAGz525KRK7dHA09G6gAEDWpbpuKxFV74=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=5Vk5bjGug5y/N8UpWmN5gu5sZxE=; b=jdNgVwIBn6KFe1yPneTZgaCglPvn
	MBdS58bltycBri3409wnEfWoZj0Ki4yiD6OqXH7uaNz829NujNWs8/AHq7M7+CZ6
	WaiBZ04VmrZfK19APOYJ5+rZ1hQbYz6F92fuIrZbr3X+cb2QilvoNdEP7VZJnAcf
	8nK7YmMpyBPhwOo=
X-Sasl-enc: PQ4pil0tYHxfsKMIq2PIWSQ6XCWt6jnSuZKV5YDGktam 1402681666
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 27D4368016B;
	Fri, 13 Jun 2014 13:47:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <539B3205.5010208@gmail.com>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251621>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2014 at 07:16:53PM +0200, Jakub Nar=C4=99bski wrote:
> W dniu 2014-06-13 18:36, Caleb Thompson pisze:
> >On Fri, Jun 13, 2014 at 02:59:42AM -0400, Jeff King wrote:
>
> >>[1] It might make sense for test_set_editor, when run from within a
> >>     test, to behave more like test_config, and do:
> >>
> >>       test_when_finished '
> >>         sane_unset FAKE_EDITOR &&
> >>         sane_unset EDITOR
> >>       '
> >
> >It might, but it's a little out of scope in addition to your concern
> >about other test scripts.
> >
> >>
> >>     I don't know if there would be fallouts with other test scripts,
> >>     though.
> >
> >How is this for a reword of that commit description:
> >
> >     t/t7507-commit-verbose.sh was using a global test_set_editor call to
> >     build its environment. The $EDITOR being used was not necessary for
> >     all tests, and was in fact circumvented using subshells in some
> >     cases.
> >
> >     To improve robustness against global state changes and avoid the
> >     use of subshells to temporarily switch the editor, set the editor
> >     explicitly wherever it will be important.
> >
> >     Specifically, in tests that need to check for the presence of a dif=
f in the
> >     editor, make calls to set_test_editor to set $EDITOR to check-for-d=
iff
> >     rather than relying on that editor being configured globally. This =
also
> >     helps readers grok the tests as the setup is closer to the verifica=
tion.
>
> This also allows to run only specified subset of tests
> with TEST_SKIP without requiring to remember which tests
> are setup tests and have to be not skipped, isn't it?

I don't see any references to TEST_SKIP in the code. Do you mean
test_skip() from t/test_lib.sh? If so, it isn't clear to me what the use
case would be for that, so I'd have to take your word.

Caleb Thompson

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmzlBAAoJEBYhrcKgrOcKjgYH/ROrG+8rlGh8hH6Ke93goHsO
d2I1mJNXfZdO6KYLA9zlvUxavLD6gA8mBorpjSuNcSDb6KhD8wp5dnzUMUQeDLll
nEnupoG79CIn7BzfAE2riJoR/w1MVK1H2+pNgzqIMNyksjD4zY6mhlKd9iQuRuVY
GsuhCwspGDAB44884wDFb7WYHOAasHfK+KkjDU85Njh9g3o84QdoTU2SLmJp84kQ
ZqE9fyLQYWH9eaC6SjR3wrMUjJ+W3pzT4MQmoihM//KVQjeJOrvoeVJKZEt3l8BX
hHeWJ2ktPu9C71+wHpeTSkMfKDaAHI2xLnryrDu0rk2Mz62QtkRrEQkplZtl+s8=
=ikCc
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
