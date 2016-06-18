Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD76A1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 02:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcFRCbX (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 22:31:23 -0400
Received: from mx-b.polytechnique.fr ([129.104.30.15]:43554 "EHLO
	mx-b.polytechnique.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcFRCbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 22:31:22 -0400
X-Greylist: delayed 1634 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jun 2016 22:31:22 EDT
Received: from zimbra.polytechnique.fr (zimbra.polytechnique.fr [129.104.69.30])
	by mx-b.polytechnique.fr (tbp 5.3.2/2.0.7) with ESMTP id u5I243Cc004675
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 04:04:04 +0200
Received: from localhost (localhost [127.0.0.1])
	by zimbra.polytechnique.fr (Postfix) with ESMTP id 277977207D7
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 04:04:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.polytechnique.fr
Received: from zimbra.polytechnique.fr ([127.0.0.1])
	by localhost (zimbra.polytechnique.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HdbpLYROGc-U for <git@vger.kernel.org>;
	Sat, 18 Jun 2016 04:04:02 +0200 (CEST)
Received: from [10.143.194.50] (webmail.polytechnique.fr [129.104.30.43])
	by zimbra.polytechnique.fr (Postfix) with ESMTPSA id A93A77205AE
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 04:04:02 +0200 (CEST)
To:	git@vger.kernel.org
From:	Leo Gaspard <leo@gaspard.io>
Subject: Re: Migrating away from SHA-1?
Message-ID: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
Date:	Sat, 18 Jun 2016 03:10:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sVArda1ndOkRQHKkdEb4EwW1utIiGgOQb"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sVArda1ndOkRQHKkdEb4EwW1utIiGgOQb
Content-Type: multipart/mixed; boundary="fXsw9b9WAXAIWjWpndBOBcQLc1gP5t5VR"
From: Leo Gaspard <leo@gaspard.io>
To: git@vger.kernel.org
Message-ID: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
Subject: Re: Migrating away from SHA-1?

--fXsw9b9WAXAIWjWpndBOBcQLc1gP5t5VR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

First, sorry for not having this message threaded: I'm not subscribed to
the list and haven't found a way to get a Message-Id from gmane.

I just wanted to ask, as an end-user highly relying on commit
signatures, a few questions as to the migration away from SHA-1.

SHA-1 already suffers from a freestart collision attack. Based on what I
understand of the object model of git, a chosen-prefix collision attack
(perhaps somewhat improved) is enough to make reviewers accept a patch,
sign it, and then swap the innocuous-looking patch for an evil-doing one
-- which *will be signed*.

As for the issue about code checking being an easier entrypoint
(Theodore Ts'o, 2016-04-14 22:40:51 GMT), in a use case of mine there is
a repo with my dotfiles on an untrusted server. Yet I download them and
am able to execute them without fear because each commit is PGP-signed
with my key. The point being that code checking is not even a possible
entrypoint in some cases, so SHA-1 seems to be(come) the weakest link.

So, I don't think it is possible to disagree with Jeff King when he
wrote his 2016-04-12 23:15:19 GMT email.

Peter Anvin (2016-04-14 17:28:50 GMT) gets a point in that there is no
need to hurry (chosen-prefix collisions may be still quite a long way,
even though there is no guesswork in these matters), and quality is
important. Yet Jeff King's proposal (2016-04-12 23:42:52 GMT), amended
by Junio Hamano (2016-04-13 01:03:02 GMT) and himself (2016-04-13
01:36:32 GMT) seem to have met no opposition.

So, my questions to the git team:
 * Is there a consensus, that git should migrate away from SHA-1 before
it gets a collision attack, because it would mean chosen-prefix
collision isn't far away and people wouldn't have the time to upgrade?
 * Is there a consensus, that Peter Anvin's amended transition plan is
the way to go?
 * If the two conditions above are fulfilled, has work started on it
yet? (I guess as Brian Carlson had started his work 9 weeks ago and he
was speaking about working on it on the week-end he should have finished
it now, so excluding this)
 * If the two first conditions are fulfilled, is there anything I could
do to help this transition? (including helping Brian if his work hasn't
actually ended yet)

Sorry for bringing up again a subject that seems to be quite recurrent,
and for this long block of text,
Leo Gaspard


--fXsw9b9WAXAIWjWpndBOBcQLc1gP5t5VR--

--sVArda1ndOkRQHKkdEb4EwW1utIiGgOQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXZK2TAAoJEIpVhItgkPnPIkQL/2zhwlSWRSzDBMHlhPs1WFIB
+6iStSAFtB1lJ5c8rW0rNNMPDxmpswacjPP3JthPsSpWEPWYqpeEoi+/6pJpCLa8
l1TyruWI1uFvCxtnoHLFElyOceCGP2mJyW5nThltLmQPmXYjATsnSWsir/DRQhUw
FGsCi+g+eY6jTzTXbX8AsOrdxyWZZAPbI6H/gabXEkXAi2kfSkvUc9izhxd4zUOl
TNk/OTvzEOYkxfedk5KRQF98UsFVtUPIuHlSc8Noyl2ACgXOuam8zVw7oc1s0RT5
uOKPrPYF92wIzOS2KWX8xrBLwA4TM6GU5q4nuY2X+39gqOeblN7BvKGHbroOzg/j
SJhM9AFOsXH6igSAinSSnddZQ5fwKBi1DYNSN/ZdBkJ17Lz5lV+aKI/rvU4b4XyV
C7mXb4jCFkLsmGIcVtQ+WpxxJ8jF7uyoXeLM2yH2+kNcV06o2PXfrS0H8ubsArnu
86+Ci7qBbauVktyRsH8uKvVzplL+JenA180adxM6sA==
=fr2r
-----END PGP SIGNATURE-----

--sVArda1ndOkRQHKkdEb4EwW1utIiGgOQb--
