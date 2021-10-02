Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F0C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286D461B1C
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhJBUfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:35:19 -0400
Received: from mout.web.de ([212.227.15.4]:57737 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJBUfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633206799;
        bh=r3/0ZpSEsX+2aaM9C3ew1qQht/VqQi0/upA+0gXfBfk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Q0+L57Tzbhivq+8jJkvBl4AZIGEi5KcqDQ9lsfqJ/dBt5bbdFXmKLlOqofqyXRvpU
         SfQumhxV9cqOOM9YR6rWudFf6pS82/NFYxkJ/Qg0D5arlc9+58/r19xA6Q6Z71vPsq
         b+OBsSpBVflCV0mAvxifO57CPm/YZhtrN+lCBBmQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lg3bv-1n8ufs18hv-00pb7m; Sat, 02 Oct 2021 22:33:19 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p5311: handle spaces in wc(1) output
Message-ID: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
Date:   Sat, 2 Oct 2021 22:33:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgqE5lEWAZG+f1CHcHoD0Ar4VHQ69EQWX5BxEMid9JMZJqVz+eY
 6DMNotlIy4Yi+s3SYwSrj2T4y4O4Jrfwq4MdXo8737r6BIQ3T4eb3VQj7E4TYGEfwb+Lz4q
 8AP9KSCaCMZQfnohULkv/zypQi9mLhXBb7mSyHP3aLXlcFiEmUknuvSMda7wXBxqUDEPeL2
 M/LSuq2liIbBvj4AiUoqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rg23ZTaGZ78=:vWF/4EYKSExcRdwJ4rA/wK
 voVX0vxCd97Lq4Ba6VoICI+ul0k9Jp3dOEoltQ99pld90mCF1KpLO+cJjUnyfAqt0v5BG3pc/
 azLnJXRBHgu5UGsQHnaB3FGZe1e4PgRruAn8k06xcZFQSj6qGQcuHra6cukISiNjN0aso+oRG
 il/AvsVQ3yA2hzNDYlPZTeNHxENhfuBZ98cLy7JXgeylYOFi+PWnkMWRlihNLNmE4ld2Uj+pC
 J286UhEs4txEkPlkF4jafUSrnCuhzar86M1DfujgwyA5Sz8lM0u25atG88AI2qFefkowuXFVf
 oNTFM/5QyRWGED1RaoisUc3FSOo1uCdqWbKmCXbJdDT7Sh7QuzoNNTQ+Ujv6WRDGZzs6kr/XY
 84XV9H6frqYDWGLifZZyjPKW//5N0JgYHCoLlmeTRvIll5VAqY3O1f/WPJ6ZWefqkUSSP6rFG
 0dQ6tHUQxd28P2vIArIlfpPqxyuHQ87iiobctD24zqQIL1rcUT8adPS7a7qS89+mBYUbUBI1h
 eYtlVPJVvNjy4sNCVlzXxFKWx6ZZ7NBVbtFtl8G4YeGoEKWHhUQTzeT3PPu2q/ita8u4JB141
 mMQ22xZemPanxW/+bV7Dybk8/O+e3P92a1FlNQNPq7lqwU9U/JU0ZwXKH8pBNTU2p8Oy2Nq0Y
 0awaFOChxmFsyloiUOYr9PvQk3oqcWO1zIgm7OISjrBEcrSbpbQFI2KHJO/vVSL0GgLE4Bruj
 kkcizDUSHeog75EAV67hJhp4PVDreNKn65Y1ExdIOiT2wWVq2B/Yn0XEsKcvMGNKbaJPdZAoV
 0EIrI86PXEZGrBl/3VpJcu57qsQnKA8b3ny5XwwQjRvHK8KTqLeCw5TV8Xkaj8RImwV4Tv7Mn
 PWEzeUdK7yBqKdtksr8z7hDoaGF96vthhwArR4zPqBtnjACHFxkCAoDLFjQrJegnrNJiCZ1vh
 kb/HsNf4mHHHWuAZ5WN7on14g4S24Ru3xYpJobTP3eHcvHxjjhBmadff7ztGjSe4VT33KFxA7
 pwC9BTiukU7ur4ClVr73QbOT+MXweZkCsDGcg6XrHS/fI35nEYjsTTzPqo+o3WaUYa4eBvTBS
 cebzV4WuScsFmw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some implementations of wc(1) align their output with leading spaces,
even when just a single number is requested, e.g. with "wc -c".  p5311
runs all tests successfully on such a platform, but fails to aggregate
their results and reports:

   # passed all 33 test(s)
   1..33
   bad input line:    57144

Use the helper function test_file_size to get the number without any
spaces in a portable way to avoid the issue.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/README                      | 2 +-
 t/perf/p5311-pack-bitmaps-fetch.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index fb9127a66f..802402d738 100644
=2D-- a/t/perf/README
+++ b/t/perf/README
@@ -190,7 +190,7 @@ shown in the aggregated output. For example:
 	'

 	test_size 'output size'
-		wc -c <foo.out
+		test_file_size foo.out
 	'

 might produce output like:
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmap=
s-fetch.sh
index 47c3fd7581..ed0c7570d7 100755
=2D-- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -33,7 +33,7 @@ for days in 1 2 4 8 16 32 64 128; do
 	'

 	test_size "size   $title" '
-		wc -c <tmp.pack
+		test_file_size tmp.pack
 	'

 	test_perf "client $title" '
=2D-
2.33.0
