Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12360C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJLVmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJLVmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:42:15 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61FF88E6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:42:14 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1187C5A39C;
        Wed, 12 Oct 2022 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665610934;
        bh=htmaCSbp6m5xIVTu1pOq5L7T3tAPLO+LEXieySiONHY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=a9+LvnaLkpYZo9uPLydDsVLrYnFAPcNAc6fsgsCKejA23LP9n4vxHFB9HDa0wkwq+
         +hgvQA0flYH05tH1z++3WmcTorH+mdNMMrs8IG9vW7yObmLxlDnmqnmRkgjbfXqHa4
         dOPkryV3Su8ZYle/0Oa9UpL3YBEUJhvk1oDUYz4XkzM23fopYBzA/MSXoDOC37DGNL
         BUuJksx2KTalvVvGqhrxrhllc+qG/t7D+VUi6Mk01bjtJ7J3IrXcq9WUFc+y7aCm2g
         7a3HHY6QlM/OQRVXNnTB54+csSFV+nkYRN5eQBBn2DgexhPqL/dcVzdQbXjenW2vjS
         dQvMAAmM8fxjyCn4VD3zPYvJrxWFP7luA5e07SGq9LPPXVthXBertL6TQFySPqqr2V
         lGfP4P8utmV98yWNxBR9cZARLa/WYRMa5lb9wPxWWFcq3swY8gaNDvR21CPg5iROyj
         lIsmcn/961ROoznFhfM/5lL6oJDo6z1CTi9pstOS+ncuwa43xRm
Date:   Wed, 12 Oct 2022 21:42:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Message-ID: <Y0c0tDEDpV8fO6n/@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <Y0cyX8Ggp+dkgAjX@tapette.crustytoothpaste.net>
 <xmqq35bsk9og.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJe3YJ4u7FPOQyMC"
Content-Disposition: inline
In-Reply-To: <xmqq35bsk9og.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wJe3YJ4u7FPOQyMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-12 at 21:34:55, Junio C Hamano wrote:
> Just a fun thought experiment, but I wonder what would happen if a
> user chooses to add .clean and .smudge filter that adds and strips
> a LF at the end ;-)

I don't believe those are invoked on symlinks, since I don't recall us
having to handle symlinks in Git LFS, which works using a smudge and
clean filter.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wJe3YJ4u7FPOQyMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0c0tAAKCRB8DEliiIei
gdyDAP9sp2Ob4Oq6sQjbFBBTOwm4migIwGe2eqB2bkHQJ6my5wD+MvA7Vc0cQ1SA
w0X2R1Qj1uILOKqO4qMkDGr346FxIwg=
=E6Uh
-----END PGP SIGNATURE-----

--wJe3YJ4u7FPOQyMC--
