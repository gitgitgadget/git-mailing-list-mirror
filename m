Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DEFC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240CC20716
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jtobin.io header.i=@jtobin.io header.b="eVm/RAnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLQLLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:11:01 -0500
Received: from box.jtobin.io ([45.118.135.65]:58255 "EHLO box.jtobin.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLLB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:11:01 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 06:10:59 EST
Received: from authenticated-user (box.jtobin.io [45.118.135.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jtobin.io (Postfix) with ESMTPSA id B3EC71F4D8
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 19:02:34 +0800 (+08)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=jtobin.io; s=mail;
        t=1576580555; bh=pixPVsfuF8c95+1cPZMXHbGOXFqEm2KwvVTZPW2GmhM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=eVm/RAnfAL2lgRHPp70OWerGOrDjXj5FsoB7Fo+bicul5pkQ1tR/olLOU/dyJYp7Z
         8dCeGzgK9fLa9bpZsHevpFf6/mCDMAiS4K4k6qd5sfqn7XoxNiZ0J4fa69h5otuIDB
         RKPZG8VC1gKgOhtZLhosc26q3gHPUsQGT2o9dNVhG5k7M2g/58blxSnLOq/Zq5MJXy
         dKFP0nges2qKPVrApjCXaVRnWxL85o59o0Z7W85oS6ab20jNX0fN62YS+l7qyjBhRY
         r1IDS6j1xtyxklliuY3FBT32tcZBzEF12SS4hXveFagmcOLjbihLBjBcpxb+KGoqkt
         iv1JaqZSTpMdA==
Date:   Tue, 17 Dec 2019 19:03:54 +0800
From:   Jared Tobin <jared@jtobin.io>
To:     git@vger.kernel.org
Subject: Re: Merging two Git-Repositories
Message-ID: <20191217110354.GA82154@castor>
Mail-Followup-To: git@vger.kernel.org
References: <trinity-c6dbf360-5abe-43df-8428-85514195a7a6-1576574916643@3c-app-gmx-bs62>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <trinity-c6dbf360-5abe-43df-8428-85514195a7a6-1576574916643@3c-app-gmx-bs62>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2019 at 10:28:36AM +0100, Steve Keller wrote:
> Is it possible to merge one Git-Repository into another?  I have
> developed two independent repositories A and B, and now I find that B
> should be part of A in new sub-directory, e.g. A/B.  I want to move B
> into A while keeping the whole development history of B.

You can accomplish this with git-subtree(1), for which IMO the intuition
of "exotic merge commit" more or less suffices.

An example (from A):

  git remote add B B_REMOTE_ADDRESS
  git subtree add --prefix B B master

-- jared

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRzY/gvQ7EyThsHYTEORkfVj4pp5AUCXfi2GgAKCRAORkfVj4pp
5PxOAQD0GAlU60Wf4/fX5usVC1zZ5vi/BP2QVRK52JBjsxENmwD/fJ79ocU6V4Wy
Df8OPc47ghB4f3H59ipHN+HsEMc8EgQ=
=He9D
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
