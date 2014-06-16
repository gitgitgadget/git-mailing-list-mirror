From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Mon, 16 Jun 2014 12:46:40 -0500
Message-ID: <20140616174640.GA28126@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
 <20140613065942.GB7908@sigill.intra.peff.net>
 <xmqqtx7o3dvh.fsf@gitster.dls.corp.google.com>
 <20140613234128.GE23078@sigill>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Mike Burns <mike@mike-burns.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:46:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwazd-0007fM-NP
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbaFPRqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:46:49 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51518 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755622AbaFPRqt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 13:46:49 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 02FD1660
	for <git@vger.kernel.org>; Mon, 16 Jun 2014 13:46:42 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 16 Jun 2014 13:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=FisHabQgFGBL6gUDIeC5FnOI
	HH4=; b=ZkHqQvIe4oLUuweBSY9KDiZxpyRntxoe7ex8q6fmBsB5wmFRVLgwoyJp
	aDvG1BJLFqRs1kOviH77+3dgTPCXIDXj4uJvFkACHM+/6UJU1mD7pv8EF3RcfX+e
	pAemrFS/ovB4G2g0cUYoixsztbhFfHz82tWL8+PJmt6dleFpSdI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=FisHabQgFGBL6gUDIeC5FnOIHH4=; b=sbG1dH8W2Y1UPvKbK0zU6aAO0jrK
	090Feman7exWebycQu9rEfXmLTQgughqG96+VCjDyN4zMTi4S7kGqprqmsbFxlzG
	cnFAcZULwsV7+4sv/JROlhX0V1z9mjikI+hjnInHNq2TxCuGKPrn2fyWnWwe9wlv
	2ONxTmf1jMXweFM=
X-Sasl-enc: K5hLPXMrrpUhRAmcrEepnxOFPqI3hjkkZc+h+OBUYnzb 1402940802
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 495ADC007B4;
	Mon, 16 Jun 2014 13:46:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140613234128.GE23078@sigill>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251739>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 07:41:29PM -0400, Jeff King wrote:
> On Fri, Jun 13, 2014 at 10:42:26AM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > [1] It might make sense for test_set_editor, when run from within a
> > >     test, to behave more like test_config, and do:
> > >
> > >       test_when_finished '
> > >         sane_unset FAKE_EDITOR &&
> > >         sane_unset EDITOR
> > >       '
> > >
> > >     I don't know if there would be fallouts with other test scripts,
> > >     though.
> >
> > The default environment for tests is to set EDITOR=: to avoid
> > accidentally triggering interactive cruft and interfering with
> > automated tests, I thought.
>
> Ah, yeah, that would make more sense.
>
> > If the above sane-unset is changed to EDITOR=: then I think that is
> > probably sensible.
>
> I think the trick is that other scripts may be relying on the global
> side-effect, and would need to be fixed up (and it is not always obvious
> which spots will need it; they might fail the tests, or they might start
> silently passing for the wrong reason).

For this reason, and that the scope of this change has already ballooned, I'd
rather not make this change in this patch if that's alright.

Caleb Thompson

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTny2AAAoJEBYhrcKgrOcKHrMIAKk+1t1+nTvGoOesEbuJwP1X
BiO8Mg5zHBYGTUn/X/c+qSOXRcG2n4QZHpXs3SgZPz/cLZ22BuhJof1LKQHaJEuV
KQCe2mSRJe0ixBZMNDxv9jtA/AcPTELoLLLUFETDbwK5NivH3GgUFysaL5PYtf/z
kpmHYI+E9iboPRVAHYD02d9csIRnR+6XbgO/jzbeKCThvZ4tZoOYHP5uOLc16tJI
6Ag5nxpgSRV02woNj5B2Q0z4QQu6V+02ssCoXu1nb2e72j6hGqis5PEAehgYskLy
Z5NVUHhladrpZwexTtMsXFmeEdd6wNMB7hNhGaBrzr+ja7wBK+j+lr/4rAdYckU=
=m4n+
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
