From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v6 0/4] commit: Add commit.verbose configuration
Date: Mon, 2 Mar 2015 13:02:33 -0600
Message-ID: <20150302190233.GB46909@sirius.attlocal.net>
References: <cover.1403033723.git.caleb@calebthompson.io>
 <20150227091333.GA32617@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSVbx-0000Pp-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbbCBTCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 14:02:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56669 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753960AbbCBTCa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 14:02:30 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 904D62091E;
	Mon,  2 Mar 2015 14:02:28 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 02 Mar 2015 14:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=x-sasl-enc:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:in-reply-to; s=mesmtp; bh=bcfCTsVLy3x
	WwrskG9wP07pmiRM=; b=R+HoqjsYVR5ur9Tw2gVJZJkajBaK4u6j8kxr2OapVEy
	btYEsfjttNB/e/IWhgo215lmuMjFOQBzM+/V0IbaerVrC3zagyAR7FL4l+8bb08A
	B9WLV+zm6H/UzmYW1jcji1hu7wR9WAylMLN9S8FBSBWUTo8+QzJdCQ/h6cHsIILw
	=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
	:message-id:references:mime-version:content-type:in-reply-to; s=
	smtpout; bh=bcfCTsVLy3xWwrskG9wP07pmiRM=; b=rNZ6Sao7Ct7Uv1Gvqacj
	T/oZvEu4Kk4an1lg9DpUGNcKEKWx6Hg/kjsJuU4oSp6a3uM2eBgAyet9WtRu4GW0
	76GOWw20sgpoCQZS+EQkaifrzCDktnLsWaqSbjH+o4iOyMT0KMXKh97ozEcIi6Pg
	oEP5dzmfNiF2X03d/RRRWVg=
X-Sasl-enc: C7njJKCvx/NRXlCdnUh9Wge4+q1yhb0bkZaRQ/Go82LV 1425322949
Received: from localhost (unknown [104.14.153.231])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5EC9BC002A7;
	Mon,  2 Mar 2015 14:02:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20150227091333.GA32617@pvv.ntnu.no>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264608>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Torstein.

I'd planned to come back with a heavily simplified version of this that
didn't include any of the related changes, just the feature and the new
test, since a lot of that seemed controversial.

That said, I haven't done so and you're welcome to take a whack at this
feedback if you'd like.

Caleb Thompson

On Fri, Feb 27, 2015 at 10:13:36AM +0100, Torstein Hegge wrote:
> On Tue, Jun 17, 2014 at 14:38:56 -0500, Caleb Thompson wrote:
> > This patch allows people to set commit.verbose to implicitly send
> > --verbose to git-commit.
> >
> > It introduces several cleanup patches to t/t7505-commit-verbose.sh to
> > bring it closer to the current state of the tests as they have been
> > explained to me, then adds the verbose config and --no-verbose flag.
> >
> > Since the last version of this patch
> > (http://thread.gmane.org/gmane.comp.version-control.git/251486), there
> > have been a couple of commit message clarifications and the body of the
> > check-for-no-diff script in the last patch was changed to simply negate
> > check-for-diff.
>
> Hi Caleb,
>
> Do you intend to work further on this topic? I have been using a similar
> (but less polished) patch, and would like to see this included in Git.
>
> If you don't have time to work on it, I can incorporate the comments on
> this version and submit a v7.
>
>
> Torstein

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU9LPJAAoJEBYhrcKgrOcKLOsIAIIUmiCP/ZpYM3g/7lXNihFg
QkcrO07PimCfbq6XRHJIIfO8rUiNQJPweHH3+c5G6GhC4BtdUxqRKRe3VikPgJC4
Ex8FSvHcTUYNHsNQc3gJ6Tu6taEwUgLtKTr7thdL/A3eHFoR6t7wAPtIFWPlUaQF
3rc6PsCn/V+CvqnzZpBvxC4OrgbWjTjnlVkCZGuugIdo77XQghRQ3qT84sAdYkon
svyC9+4ePx30AIJQgaV1f5jGQxP0bLYWfuIqc7jEZfiMswD/iCGb+xzsSKtk1yZq
RLbgN23zkxFaKwzyTLzvd8yIfH6kQ7FxhAXwr0gMtvwnCdK4a3WcD6BGVsYJDjk=
=HI57
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
