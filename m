Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F117B1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbdCXXZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:25:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:50994 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754629AbdCXXZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:25:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1bwa8w307v-00wH5W; Sat, 25
 Mar 2017 00:24:57 +0100
Date:   Sat, 25 Mar 2017 00:24:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] config: add the core.enablesha1dc setting
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <7505e660d461f2a000bdb4d540346345186f42a8.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dVS1Ktz2fRB8q9RMYsvilMXCcZFBlzVeFgS9UTewesmys+edNRA
 W46nR+OEtZolTzytm9zxLjYzbQrNLd2Gvkvt81f6IWVWPUnG6pjlUk8BlIbKEvmZmU9nPkl
 /7Z6d+7MgKp8M8mIgdyqi9hscqBUSp+hRTcAt5xrnIgT6A9rmwNRQ8UUkU9wyn/g7+eEObc
 wz16VaZII8O7KGSG4xbYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fs0MPS/SzrQ=:OqRnSjlYk/wwKb7hrLtbw/
 DhG8765Rz+ysQbiKP1aPuuRPCTc2RbSPMJ5q9aFEmrJJ36xsJjZ0AQXYY6jV/T394CGQamaIC
 6O1Od2+X9CC+9PjsZbWMXVvEaktnKZ15ND/9Deh9kuv9LJ676ewkY4e3VQeKInNJoypyXNvKR
 YyE1VT57xBFmOzeAJ8RcuCTsCnSi3/wDabdH/6xXhpwie5E+xC6shSrpnqCFQjkvLlMnRu2NZ
 MBi+p7yT/NHdpf7iyZvXEdc99R2tM9NFCVToMni8/AWCLyulVhpIjwnBF5vDXOd11MR0ErJqA
 x7J+NH54MWVrZzW17u+8q4dEEEiEskQ4v5HRi1UuG5EjyTXSC3Q0ri0vQUhkT9CwSTNZEBByk
 tt5TfmPb4TN0QY2pARC028ZdYa2FRk5zcdPBtP3WB9k3Ji27KS2jgJYo7B5Ys1NNezQgzFjLh
 8MTM6xbMZnHBVwc73pQhoHksUcyAOuHcBBOnwq7BEV3yp812vvK/VeEq4PaefwTU6aInmfRPQ
 7jgUIzY/S8fFP+ATew97kaN4jnVOzPWRlVBBDSCCy+4S7HEkOYE6Vixn/uj+8kjViLZjpt+h5
 I/mYPzkMJKcqt2Wr4k5KDiERkafcfq1F+rY5vub9qTEXVYEYsasi+wgAZhxKz8Us2dN7kNrGc
 t0720FYPGqAUqtt+w/HgLvvnWOcwiny5ZWaFONsi1leLYRQN/mHKH5Ad5wNwRRJ40kT6xJixj
 7gg/8EYLWXtlsC6ry8TrkbTfY95H635tmr3aq/CTzYEfYkBq9TvQQsccw9yKJJUmi/SBypupL
 cOcdqAbpAH5i+1j4jqyevun6jzbHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiled with DC_AND_OPENSSL_SHA1, this new config setting allows to
switch from the collision-detecting SHA-1 routines (SHA1DC) to the
noticeably faster OpenSSL ones.

The default is still to detect collisions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/config.c b/config.c
index 1a4d85537b3..f94e2963e57 100644
--- a/config.c
+++ b/config.c
@@ -1205,6 +1205,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.enablesha1dc")) {
+#ifdef DC_AND_OPENSSL_SHA1
+		toggle_sha1dc(git_config_bool(var, value));
+#else
+		warning("Ignoring core.enablesha1dc='%s'", value);
+#endif
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
-- 
2.12.1.windows.1


