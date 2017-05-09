Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E80B1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbdEIMyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:54:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:60725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbdEIMyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:54:35 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfBsk-1dO4Jb03cQ-00OpPC; Tue, 09
 May 2017 14:54:29 +0200
Date:   Tue, 9 May 2017 14:54:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 5/6] Fix the remaining tests that failed with
 core.autocrlf=true
In-Reply-To: <cover.1494334366.git.johannes.schindelin@gmx.de>
Message-ID: <aa7ebfea3bb72cc1fba8cbb988705e52e7dd5551.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:raQInPPRLm2s4L8LCMO+nxKLnDP9jDcF1pzaCZVezbTRqoZ0gr4
 3QGQgvsjYec1vKLcV/f0lmxDCmSGAKXHZSL2EmpvCmqTcK6b3LchK1Z6vGiwS64mwx7LOc/
 dV+E2ubpbEDfPJT67Bo8IHFdGXaNmjLKgeBWDt/V6+qN7rH2mfvcnWJ7FSqJbi8s8k2PT25
 QdEgAvqVAmEMfLwsBXlxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VzLxkLUsTd8=:sSSIeoNJWOtDYFcONGPPih
 3L3nLV2j5z1guvSzdPQ5q3XEylsk3XrEHJ1tdvbvgsgNt3o3joC3rODbMbCeOdsGrK1CumT/2
 iHjGyEFryKpHJryQ4r7uQbec0jS9HOaFqNGGLIirJbx8ZZK6hsitkR0i6vzvunyUGWOm9u+FM
 k0y+jX4CMYlJyRsK0MPzJ/SZLSNtukkQJ/mh5xC/lnFJQs24ntwa+s+1WGws16hG/LUcdaptH
 8uJ9ZQl4PkfMnNJHT4hMOiWlYepV77wa/YBa6vK+0DtQqMDncguna6MCeEnNI6g/GGQ0NDAXQ
 Vwx9t3we69c75H4Qst/1+tPNWuKjYkLSX6R9sAEEvzt9z3RLfTFrpMIZgdwRxINu1tnar/MgE
 GeuqXU+W3jA056IWxzyOfToZJfTFiXYzSJ/djhX9wU6k51e+GyH5fUwRQ+Gk+J+oom6L/nfpA
 quBYGVgqrWK+m+EXOM6pbcxQckSiL1x+jImHdX6rk0pRhil7B5/2oVNPAijrohl6gDPJnPM7t
 QEESXYrwHlPU5LlQMLqt/vyKd2E72y5WdLx24maeh7zT3lPQLV5dorGoDt89clHovwGMdjx7s
 tkZkLotigGbm+nbPwvAt7xkpP+JX6vRW1miu1xuqBvaEHMsG5uEQLqtWzIxd+irzDuoCy8FDc
 WnX86c2ciCN44a9bjwHRZ6RCtaRCz+Km3Pi8Y0twCzYfxIlW7/5REwgRsNio3/io/xZIT92TU
 WmZwBrFk74qKmRzl9+2WlPDxNnSDAKLaDjUtPGOvKar/Nbla6P92H5GdzTN2OVwFoZz4EQHgt
 xMZpOHL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite is mainly developed on Linux and MacOSX, which is the
reason that nobody thought to mark files as LF-only as needed.

The symptom is a test suite that fails left and right when being checked
out using Git for Windows (which defaults to core.autocrlf=true).

Mostly, the problems stem from Git's (LF-only) output being compared to
hard-coded files that are checked out with line endings according to
core.autocrlf (which is of course incorrect). This includes the two test
files in t/diff-lib/, README and COPYING.

This patch can be validated even on Linux by using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make -j15 DEVELOPER=1 test

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/.gitattributes | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index 2d44088f56e..11e5fe37281 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,2 +1,21 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
-t0110/url-* binary
+/diff-lib/* eol=lf
+/t0110/url-* binary
+/t3900/*.txt eol=lf
+/t3901/*.txt eol=lf
+/t4034/*/* eol=lf
+/t4013/* eol=lf
+/t4018/* eol=lf
+/t4100/* eol=lf
+/t4101/* eol=lf
+/t4109/* eol=lf
+/t4110/* eol=lf
+/t4135/* eol=lf
+/t4211/* eol=lf
+/t4252/* eol=lf
+/t5100/* eol=lf
+/t5515/* eol=lf
+/t556x_common eol=lf
+/t7500/* eol=lf
+/t8005/*.txt eol=lf
+/t9*/*.dump eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


