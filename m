Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5279320248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDLJ22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:28:28 -0400
Received: from tschil.ethgen.ch ([5.9.7.51]:52268 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfDLJ21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:28:27 -0400
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEsTy-0007SW-Dp; Fri, 12 Apr 2019 11:28:26 +0200
Received: from klaus by ikki.ket with local (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEsTy-0001pB-6v; Fri, 12 Apr 2019 11:28:26 +0200
Date:   Fri, 12 Apr 2019 10:28:26 +0100
From:   Klaus Ethgen <Klaus@ethgen.ch>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: fatal: unable to read after commit
Message-ID: <20190412092825.GG12669@ikki.ethgen.ch>
References: <20190411164440.GC12669@ikki.ethgen.ch>
 <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I seems to have found the bug.

My last debugging gave the hint. pending.data is a concept of
taskwarrior and have the .task directory on git control. And I also use
a vim addon for it[0].

It seems that it introduces that troubles. As the last commit is from
2016, it is very strange. Especially as I had that troubles not before.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlywWjkACgkQpnwKsYAZ
9qwZDgv+Pcg834UWtW5VJ9gwEz7Won8Vdt9/yPUEKb8h8hoD0goI/5J4LlTNVyn0
mKcfvPr1QCZTy08fltrSJPtJwyhvkcJpzxZ8+1XtQsRea6V3IXEN6D8HTpzfPSfm
wAIyTqX31F66Almk2sxxit9aRqCbio+KhyN50twDAOq60SwVtw/1Yex/VqP1WxHb
8245u9bg88hgdpJROZsiPA320XOBrQqykDTwvWyKsLewAhhx5qmxsm3SXcmzp7NC
kjIsqtiFNB68uzcAdwq2RLe7OEexoNHNHpktzWhL25CdPIIeQJIYHKiLXgj/dl3J
G4RrbXHAw6GAoB3ce5IboDpU2jm2JpgXtKIhbJItV4Tt/ju2pmP3caTc/JMZF4Vz
jLfcg8KyD+pe/mI9h0Tj71lz6Q3FvVY9HNW6t38v/5KM2n8gjYqfwkuXIT5xy/Dk
42D1WDoN+9qo8reLlrA4yK37DG2ze2q/+kf8mf2Vp2gJZB0/wfcFsr8xYiVHr14O
zH+WboKx
=y0cC
-----END PGP SIGNATURE-----
