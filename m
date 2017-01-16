Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF4920441
	for <e@80x24.org>; Mon, 16 Jan 2017 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdAPUCK (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 15:02:10 -0500
Received: from mout.gmx.com ([74.208.4.200]:53517 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdAPUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 15:02:07 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jan 2017 15:02:07 EST
Received: from fli4l.lan.fli4l ([84.191.194.209]) by mail.gmx.com (mrgmxus002
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0M7HJw-1cg5Lj1FAs-00x3Um; Mon, 16
 Jan 2017 20:57:05 +0100
Received: from mahler.lan.fli4l ([192.168.1.1]:53692 helo=kuhls.lan.fli4l)
        by fli4l.lan.fli4l with esmtp (Exim 4.88)
        (envelope-from <bernd.kuhls@writeme.com>)
        id 1cTDOo-0006jn-1c; Mon, 16 Jan 2017 20:57:02 +0100
From:   Bernd Kuhls <bernd.kuhls@writeme.com>
To:     git@vger.kernel.org
Cc:     Bernd Kuhls <bernd.kuhls@writeme.com>
Subject: [PATCH 2/2] configure.ac: Fix --without-iconv
Date:   Mon, 16 Jan 2017 20:56:38 +0100
Message-Id: <20170116195638.3713-2-bernd.kuhls@writeme.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170116195638.3713-1-bernd.kuhls@writeme.com>
References: <20170116195638.3713-1-bernd.kuhls@writeme.com>
X-Provags-ID: V03:K0:cRwRYQBlOKMRXoZu4StNBxEu2GQ8zAlq5C2/mLcmwqr6x2W07Wi
 N4iethjRRKa8+IMtf70fSS/ipdfXJjX60j6fcs6MKpiTOQJjfzvG8E1PqUQarXdxOgxMjoU
 Qbn+EvxJoAfhSPDkzcEPuYcAm/1NYm05utgawnvSk6RJ35MKqdBH7Tm+lK4LluTNqQR7Cm0
 on/aGuAIxNV9Rff0fhjAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JSRAjsgS4dQ=:/23DrOUFBsAAqUC1fiL/xl
 FcaWBkpeop6KbHfffLjdCPmr1Kt3j8/zCa0EQXwi20limYhc2ybFIRcyabkFZJr3atlVyTDm4
 us9D/3xB9PNCgXeP9JNa4GHHyVBitUuObV6ADjb4HhfFrtqJvn9Xs2d6+WTpIzae0tMPi8ALt
 gRFFuu0+eRG4e3va45Ugr1DAaJylUMm/3XdT5lgVfvL3gycRXZjRwNLUA43K+LakuZNV/G2Ri
 8gJA+03qdfOr7l3UUc7Ylb1TFakbSsuItx35uZvVjURctaLlcVe3/6XUt8wKLV/ByYwmx6sZV
 Le1NSIpXlzuZ5/EYMC6IUMk/w/xuZGMU/YnY1BYJ3ihXk9UUo7wJWcTFB5wDS74ciCNswBAcQ
 PTetBSK2iHwbosot7IR2HuPfHIOayMdIIthShOk5z/blI27lEpla3D6dVSBTvLuOtg2zmIfdv
 8sJFi31+fOSLTGDlCqX0dQJFbkXyOrdE2/yAJn9ZK3AZkszra0oPxMdt+QUpCbYo+evXKIyfx
 dt4m/utpD8/GModIB242Z2N59UEBWJ0llFlI0RZvT4yzOh8NXIH/D5ucPFFLB2H49zss7SpYF
 EAjsA0k3xAsbebNSSVy13LxpMioySFKs4cvDQ3aFpHHwPvpz1zfYow0v2CbJDGaz7hMrBw/Qm
 2jUaz3MThXvJml9YuyCvUuoggTG9fx6IvQ8bBslmUrYGkwA0dfDGx0JOvAj7w+BFFI40jFZxG
 QJuOpjVTzMDa1QlvUOkhblRetGT8Zjulo7JwFEx+3F2EX1tKh/+96m/QuJc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_PARSE_WITH(iconv)) sets NO_ICONV=YesPlease in
https://github.com/git/git/blob/maint/configure.ac#L327

But the command GIT_CONF_SUBST([NO_ICONV]) in
https://github.com/git/git/blob/maint/configure.ac#L618

is only executed when NO_ICONV is an empty variable
https://github.com/git/git/blob/maint/configure.ac#L578

which has the effect that NO_ICONV=YesPlease is not written to
config.mak.autogen which breaks compilation in systems without iconv.

Signed-off-by: Bernd Kuhls <bernd.kuhls@writeme.com>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 63e71a472..419469315 100644
--- a/configure.ac
+++ b/configure.ac
@@ -614,15 +614,15 @@ LIBS="$old_LIBS"
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
-GIT_CONF_SUBST([NEEDS_LIBICONV])
-GIT_CONF_SUBST([NO_ICONV])
-
 if test -n "$NO_ICONV"; then
     NEEDS_LIBICONV=
 fi
 
 fi
 
+GIT_CONF_SUBST([NEEDS_LIBICONV])
+GIT_CONF_SUBST([NO_ICONV])
+
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
 
-- 
2.11.0

