Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA38C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64DC20637
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="Z1suy6nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLHKzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:55:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:21418 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLHKzc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 05:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575802527;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=a0pxhpvtihBU90mw+17QwKjrxeC0b2BqLzgfy3jnksg=;
        b=Z1suy6nrCiEcqbFc7o6VrspkhjowZUFbVPtGvj5q8q6lQcVi+DXdUOG7EBNX8fwBXV
        zYuCPFACPyFZ0DV2hSfRAjtZdLHRXhzmvTbCseQBRyP133s21DbKVbsbPp2p7BuGxC4z
        xCEosawBJ+5BN26ZwRqvmZBe4Kt9wvZmf+JdyeIqMqjWVzTRYcsrmxk+qZa+JhyYtLS2
        v4cwFRfHadQb8x8tsUvYDiN7oJwPqAxcLwAZnnKiVCSgnXYhjqfiHfuj12MIxc0epRff
        bxiLOG9VwGjCaZ5UKwxFTv7Cu8OcCVFGIetkh41R2wBTXwUCZy5o8pyDdntKGOCQ7oiJ
        1/Ag==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMNiSA=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.0.2 SBL|AUTH)
        with ESMTPSA id V01289vB8AtRBMb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Sun, 8 Dec 2019 11:55:27 +0100 (CET)
Date:   Sun, 8 Dec 2019 11:55:17 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: How to detect if a tree is in status "merge"?
Message-ID: <20191208115517.6b319a44.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HTv6FdPYFD0_PPCJ_qhzTg1"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/HTv6FdPYFD0_PPCJ_qhzTg1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Is there a way to detect (from a script) if the current working tree is in =
state 'merge'?

Right now I had the case that a conflict resolution resulted in 'no pending=
 changes'. As a result my "git --no-pager status --porcelain --untracked-fi=
les=3Dno | tee $t" showed nothing, which skipped the required 'git commit' =
in my script.

Thanks,
Olaf

--Sig_/HTv6FdPYFD0_PPCJ_qhzTg1
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3s1pUACgkQ86SN7mm1
DoDcURAAouRaOWBcw9Mialf2FYHZXeWODg6hZnTplLA1l4pPZZQdY0H7jrpuViWz
bhVGeioM/OCKvpYaBJ+pXJ/fZ2MjVBJxUVovwDWzYuGMllRCHNeL7Bn3PCY7nTYo
bH4JgPLsDmpU0f9JtlSvBp4cT1ijOZ6P9JuFYyi7jIwXD7Eh6Euc57fSnVOXJLiM
uU+ZPQPlU2iJ4/s8S9TwXj7bSKMjJGqsPCF7g3toZlZKltSTv/IGjPazJmvFHnO5
k+nCgDLAKURIixJrxqadyKgl3eRCec/P3zz+ul2jI6gsksfZIPjNnz286PnUAMeF
c1gDv9j1Wa1qgcPD4UmIT4vk+KkrTd2Wmhb8ERTej5fzHTc3ZmORAUs0OlfcV59R
i7wz/U+pKd5YzloRUv+22GOrCnaaNnmYKxLgCE3wIOEfaSPUBY0sVjjyKF28NIb8
bKhFSMqGT3hfZ6v/QZpyBnPwHXPUaPRIb6N+xMzCSILMcAvAR3KW1mqVRmJ2GClv
aTNCIGpwxYyh0KjsBa/ytdRA9baAmzYKD8gc3tZz490f+DNtDv9ded4B+/ShSIfm
4xF/GYsq38NZejVwhpmojIPwUgOeRq/6x9210wC/MZOVQG9UiFFOr1QVT/2bZQUx
/w1BwB78VJhY2MlreJhSInYWEoeC8HkrbTeZARAL4JYcnYlojk8=
=YLrM
-----END PGP SIGNATURE-----

--Sig_/HTv6FdPYFD0_PPCJ_qhzTg1--
