Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF9C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EBD61A10
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhJBJlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:41:55 -0400
Received: from mout.web.de ([212.227.15.4]:39087 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhJBJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633167602;
        bh=7zKzgqSjPmcHM+hohLJAEr8o2EJr2Mt5nAlSRoFeF8g=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=PreeaFTFIRMuZhcLz7H/V3/2TStJ7BY297BZOu3Ex5zwqDCKguMPrIJkcBo3ju0+c
         ogN32rPRTAyMZf1nlrES5Q0bT3u6Bj3mvXgHFH2njJnM4v/2fFNfn2UAS8of4/3fsI
         Cs1HUY80qLpAUyVcbLiYWDldusuf2nm8mEhOcHNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M0yvn-1mo8Fh2XYV-00vBCA; Sat, 02 Oct 2021 11:40:02 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] perf: fix test_export with SHELL=zsh
Message-ID: <8b70d04f-0ad1-6e68-f5a2-2d8ec3bb98ea@web.de>
Date:   Sat, 2 Oct 2021 11:40:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EAktrGbn8A6FFx1RGWPlsqHFw/K9iTO/mjEGGdFD/fxxCO1vxoc
 vOERNLZuuej0gD1m5tK6dR6E1i6yQZYz3VsFKmSeMq6/4Hy9PNWEs0dDVfO7COhIPWQktYW
 e1LIEQKtETyXiqAdvqG5D36XAzVysw7XdniqMljJ3szX2x25Wv0V2Pt5tXSy8liyXZwEOdT
 up2caQYcNwcQD9QpK3VTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4L12YPST8dM=:b/fbQWPm/Db5RNBI8wAmnP
 Mss3eeeisqdc8cu7DKqLWvh4W2MeHokjUgFhvWslmRHtEB8sO9Y8ioUOm6ztyBmMLvAT30tJz
 NnVgvZjFkmhARMRViMD8ThStPkOWynfqdyyoIn0PKGh5t6g+CZAvvGfgWZ1/n+HCaN40pCC7Y
 904QSdo6Ua9oxp9X851kT4VKPr7b4k95IQPJrS7ahxIGPqRSTc/L6D+UNmyOE1g+Jj0eNcD0t
 /SWr/1Avf/VKabeXMGlJzeXaT5zaCySAim5sdZ2O2wFqhV7cw56dlNgJDLJdXWa5KibfgCF9R
 ce4lwvvLpbUxpon2WjsMtXmB16nB//EaYhwDCVYJ5LmwI5G8Z7VYWGbDuKW2sYm1LDmxm0zKz
 JtROkvXB3Xw9sRbv+5rVmZ2dcFFn9E26T38WVmkLikfk7Q0+bdqbVBDDFWCOT8L8PawnOdfqj
 Sik4pJnLUadAj+Hz6y1i2AnIcQs422O165Wfx+CzsXtpk/NN3qIJqSoTkWWzcMWbF+co8AocL
 epnWDlKUJQ+1PeWLwH+oFQZlhumIk2GIy4YnoMGpQdxyOAK0ww568UGt0GrxJfATzqvU4CF27
 susFHB71HUxMh4bR3NihnZ3OoDPPO1RItSVRTwNFrNdvtoXsq0dCzXOR4ri6t8rC5YUaCi6Eb
 +OToX2f05zpN7+qr8hmBdpjg94CvkKg1p1H/CeN4YqG8BRx9VynXE9SS0ixYuSUSTeeK3rdh5
 zGmN7BBywLKJg+Jb4NBSqjg/qqKU9S4jHPIgTH406DzGt/OBTe5tnVbRi4k4M9xMDLL/PZi/R
 hyyH3mg7+hfHBa4M96KiQ89FrtMNFMCj4LDWoQBouGG5evclkfLbsMvTjPtQHjeqwqTpstOtk
 QrKEfI+A6m5lglMO7UOYJ6yltBY8N5CH4lsJIjcRAjuQ5ugo0lnTuddaOumKuP9cOJuUeMnbj
 Ly4OPURoTYV0tWdWiSO1g90KbHNBzw8ZpNMahS0PBnz6/IyNnr+YWrxmN3nY+/DChy2CcHdLZ
 P6x7Pe3bUcIFCp3++ISRdn/oMQ4nZ2MM+b7Mpa2ZbDoyz5EWh/+C/jx3rjWO8C5rSAqD+WX4z
 AN8FjiwQk0YIOE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other shells, zsh doesn't do word-splitting on variables.  This
is documented in https://zsh.sourceforge.io/FAQ/zshfaq03.html#31.  That
breaks the perf function test_export because it uses a space-separated
variable as a poor man's array, and as a consequence p0000 fails with
"not ok 3 - test_export works".  Pass the value through an unquoted
command substitution to force word-splitting even in zsh.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f5ed092ee5..f74cfd35d6 100644
=2D-- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -165,7 +165,7 @@ test_export () {
 '"$1"'
 ret=3D$?
 needles=3D
-for v in $test_export_
+for v in $(echo "$test_export_")
 do
 	needles=3D"$needles;s/^$v=3D/export $v=3D/p"
 done
=2D-
2.33.0
