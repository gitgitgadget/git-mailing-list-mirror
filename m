Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E6C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352EF2074B
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbgJBLHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:07:36 -0400
Received: from elnath.uberspace.de ([185.26.156.42]:56184 "EHLO
        elnath.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBLHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 07:07:35 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 07:07:33 EDT
Received: (qmail 27970 invoked from network); 2 Oct 2020 11:00:50 -0000
Received: from localhost (HELO ?10.8.0.109?) (127.0.0.1)
  by elnath.uberspace.de with SMTP; 2 Oct 2020 11:00:50 -0000
To:     git@vger.kernel.org
From:   LuKaRo <lists@lrose.de>
Subject: Allow git submodule add in subdirectory of the working tree
Autocrypt: addr=lists@lrose.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b56306ea-f302-a660-7d4a-a0ec096d7073@lrose.de>
Date:   Fri, 2 Oct 2020 13:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ztwQCbtVH5LLO01AQZQUre4D5NEUDtlw"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ztwQCbtVH5LLO01AQZQUre4D5NEUDtlw
Content-Type: multipart/mixed; boundary="uuRHScQdWaBBiDG4lxexpw0s1H5KbTZVM";
 protected-headers="v1"
From: LuKaRo <lists@lrose.de>
To: git@vger.kernel.org
Message-ID: <b56306ea-f302-a660-7d4a-a0ec096d7073@lrose.de>
Subject: Allow git submodule add in subdirectory of the working tree

--uuRHScQdWaBBiDG4lxexpw0s1H5KbTZVM
Content-Type: multipart/mixed;
 boundary="------------70A18512F2207C618831E813"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------70A18512F2207C618831E813
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I just stumbled upon a weird limitation that I think doesn't make sense.
Submodules with relative remote paths are allowed when added from the
root of the working tree, but not allowed when added within a
subdirectory. Always having to cd to the root directory first and then
having to specify the full path where the submodule should reside, is
not a huge limitation but I don't think it's neccessary. Or am I missing
something? See my bug report created with git bugreport.

Please include me in CC in replies to this message, as this is the first
time I'm posting to this list and I haven't subscribed yet.

What did you do before the bug happened? (Steps to reproduce your issue)
Run `git submodule add ../foo` with a relative remote path (`../foo`) in
a subdirectory (`bar/`) of the current git tree.

What did you expect to happen? (Expected behavior)
The submodule `foo` gets added under `bar/foo` with remote `../foo`.

What happened instead? (Actual behavior)
An error message occured: `Relative path can only be used from the
toplevel of the working tree`

What's different between what you expected and what actually happened?
The git cli didn't allow to use the relative remote path for the
submodule in a subdirectory of the current git tree, although running
`git submodule add ../foo` under `/bar` is equal to running `git
submodule add ../foo bar/foo` from the root level directory of the
current git tree. The second version is allowed, the first one isn't,
although both are equivalent.

Anything else you want to add:
I think that it doesn't make sense to forbid a relative remote path on a
subdirectory of the git tree. Relative remotes are a crucial feature if
you don't want to specify the protocol to use to fetch the submodule
(some people working on the same repository use HTTPS, others use SSH,
in both cases the preferred method should be used to fetch the
submodule). Having to add all submodules from the top level directory is
a limitation that I think isn't neccessary.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.8.12-arch1-1 #1 SMP PREEMPT Sat, 26 Sep 2020 21:42:58
+0000 x86_64
compiler info: gnuc: 10.1
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Thanks,
LuKaRo


--------------70A18512F2207C618831E813
Content-Type: application/pgp-keys;
 name="0xB0030EE50DD3C616.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xB0030EE50DD3C616.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DgVlY
-----END PGP PUBLIC KEY BLOCK-----

--------------70A18512F2207C618831E813--

--uuRHScQdWaBBiDG4lxexpw0s1H5KbTZVM--

--7ztwQCbtVH5LLO01AQZQUre4D5NEUDtlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECWLBsXhd+/DoP4RYsAMO5Q3TxhYFAl93CGEACgkQsAMO5Q3T
xhZttA/+KWshd2E2kg+3HgJmhQkvgs1RfD0BtB64aqsMFr7dljM3DqAUt3dsZocW
IWcAev+Vvg3syz/CUmQh38CkiZbtFCttGZh7C1adc6Zpf7qsoQAPOi05G2qn0+HP
NBlUWZBy59XAPaYxdCsFvFZPiHuhRItX4UJj0nrvx898gZDWS8D+MaIF+yktf/T1
RUT6qVlTiBdaBhOR7TrmUlQPastTy4K2aXl/RAdoQEvyc+/cs84ZSYrrqqq8UNE1
Kj8dLLvvOi1YjLPYbA1zgq3gOyHWDBCUN4EpeA4o/X3Gpz7ICNCwCO6O6BbzlLZ4
s5w0WnpacLL4Bsv4Z+Fs1oKducG/O1RPN7Iedjo/AMhtD/1kCAoj2swaYuSNmn4z
/cvoBg9TV8cp676blXy9eYdlHs+H5X0RKfofEperu1W7rJKS2A9BVWavFNKOuEe/
4qpsJxnEXxRD6ESEAda+boekJ6R0DszSh3DiA26bakJochizN3eCkhqY92KjjIMr
KpAyEZhhDYjQaTqw5S+1QFLd1LW9MU67f/++fjWRuv+PJ2LPgUSgpsFWpAlL7ITv
XbaaDQefT/0Xj105g4bTYnqmvL5tibmVoSpFbz5Oy+7IOLDcksS/9nzwSOrRhdLv
tgDdUz+RHFBoVa3j6zjwqkwlLOiNWvuYSuVG6bQBUWhPNYVnkQs=
=OarE
-----END PGP SIGNATURE-----

--7ztwQCbtVH5LLO01AQZQUre4D5NEUDtlw--
