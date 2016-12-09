Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1941FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbcLIOiG (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:38:06 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:39516 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932595AbcLIOiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:38:05 -0500
X-Greylist: delayed 2145 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Dec 2016 09:38:04 EST
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFLke-0003lx-7n
        for git@vger.kernel.org; Fri, 09 Dec 2016 15:02:16 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFLkd-0007Ql-NH
        for git@vger.kernel.org; Fri, 09 Dec 2016 15:02:15 +0100
Date:   Fri, 9 Dec 2016 15:02:15 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: [BUG] Colon in remote urls
Message-ID: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello,

I have some repositories where I have a colon in the (local) url for a
remote. That was no problem until now but with 2.11.0, I see the
following problem:
   ~> git push
   Counting objects: 11, done.
   Delta compression using up to 8 threads.
   Compressing objects: 100% (10/10), done.
   Writing objects: 100% (11/11), 1.26 KiB | 0 bytes/s, done.
   Total 11 (delta 7), reused 0 (delta 0)
   remote: error: object directory /home/xxx does not exist; check .git/objects/info/alternates.
   remote: error: object directory yyy.git/objects does not exist; check .git/objects/info/alternates.
   remote: fatal: unresolved deltas left after unpacking
   error: unpack failed: unpack-objects abnormal exit
   To /home/xxx:yyy.git
    ! [remote rejected] master -> master (unpacker error)
   error: failed to push some refs to '/home/xxx:yyy.git'

Prepending the path with "file://" does not help.

It seems that the new git version splits the url at ":" which ends in
two incorrect paths.

Pull seems tho work well currently.

Regards
   Klaus

Ps. I am not subscribet to the mailing list, so please keep me in Cc.
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhKuV4ACgkQpnwKsYAZ
9qz81Qv6AsgZHlaEHEybERAvGikjZgUvjyC7dzQ2zCmc8iv0eb8kGLiBtVtInsWr
eo/CiMSdX2emoCD5LQq/sxcRIgIoWpF8m2NEXiBMl94d6YLOpvWV1yC1kQ8qK6bt
Pyeo9/LofAnpLcQRn1am8tFwrcCMLZxSM7cxMxjtP6i+RU0MHc/rS1HqhdzptpsH
jvB0x41X7LNoeRLqG5n8lVlyHP1PiGyP0Dl4Aa9rFBHn+hydiJEmLEwdn9w4wgIz
vo2DZmqGm0r4vTaTP1gQRPxoW6fsBZ1uUWKRMjd947R1eaELpyROj4SFt0bWNqwW
cx9izYUuTg+xSe1KTaSgPlmZn1817DlG2yJ/YduKH8v61ZJ2r6B1awO2tz32g7cA
QdjsnzAyz6eVLrrsJ5OrJPRF2Fl7gM22jo9gs3BJrHeJdC9dU6kVIAR3eryoFvUg
fG/Vl2zvfbMRQAaUDGMyxNk5TGVFB6ANw0KS/NczRvmbPA9kukBz012+8ZY8MHzD
aEvmk/yz
=tDwn
-----END PGP SIGNATURE-----
