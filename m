Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84C5207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbdEDJtv (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:49:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:56673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdEDJtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:49:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfBX6-1dqDNN1YXw-00ol8b; Thu, 04
 May 2017 11:49:41 +0200
Date:   Thu, 4 May 2017 11:49:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 2/7] git-new-workdir: mark script as LF-only
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <fbba7450f2d4475b6d9a0d740dc43e22c81b104e.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gDIf0wvHNIiG5PsBvmXmmqAn5sS26X7zPfv9F+uuv7botFDYoIX
 YCp9q8bSgFJg7P5gNPRcm4XzaUL90Je2l+92A38cpvzL1lbRy1skWOyqpCZ7nnw3vSne9AI
 rkhUZZjbnr8S//7WGm/zY4MmZ04aqxVRhlRTOxWPwJ0rntzM9qvxYWtF6ZW0QGC9gFBZDAM
 a4A1WnOly0MAfeV2pvNBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:km+EHq68axE=:2YJR6ky0qhpcowB5Yy7bzr
 TxbE1GnzcVcN7Mc8O8melyWZhH7BS9+kTEKum0UXgyhq+EICM/tC1UD9vYCssJXtyVe4qFp1Q
 hP84xw7Z4EOFj82BUHeEr1IYeo7R9B+wkd20SLkmqDl4AxcHYH7QzKn4RhPSf7PBq0a6AMope
 zydx+kNH7BGKHFA91RKh/FLySYca5x3lCBpk8e3ISXeO3olQ72gezaeaq3a2Nf80L704y5HdB
 gD3uf1F/Kwc8uivH002nK/y5GxyqEg/zMx2W9PMA7JWD6xhCKyrV3S7xKshIvxGDpuunsQT8e
 9Vy44P38cg/je5NhV0Ar/q/pUHCaIQrq4ZOvstOC8nRg0b5Pz+ghD83jaj/Ofa6HFSTr7DMXY
 rIer8ARPt8DM9mcxI2QVZbAmWmyb95btTzxHJPQzhoDWvx0DMO2XthFHtDdccYZKSNXubLPY2
 ZM9pTO/vr+4rlgCI54TvQK5VV2jdlNv+/GKCTQtRdWo6TEm29zr/GGCoPz2gflqibsZRIzsjg
 ODevs8/6IM6HTPIYzPI7iHyGB9dyOU+0/WtM1AaU+ZZriRozgPy/v7K3kuw3WRc/CldKlmNHu
 j4GM895plO/ABDYqN6yz0jA7t0YIfvR+yZB3ktF+KUlpdGzVxilBU3nel1MLfisfG5XLRd/3R
 5NyLl8/u3dE9BlfcMxwRg46Or2yZiso7nXleSLuF6iJbZ+U1ZmT9cvBoqVkQjJV+UoalM3yZs
 AHiKWoYmF3l+V1fjx7rTZHxcJfipwLWR6Cwy+4J0CdHyAzPosp6MUuPr8esTWS0YtANMPzz/T
 /JeBg6H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bash does not handle scripts with CR/LF line endings correctly, therefore
they *have* to be forced to LF-only line endings.

Funnily enough, this fixes t3000-ls-files-others and
t1021-rerere-in-workdir when git.git was checked out with
core.autocrlf=true, as these test still use git-new-workdir (once `git
worktree` is no longer marked as experimental, both scripts probably
want to be ported to using that command instead).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/workdir/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/workdir/.gitattributes

diff --git a/contrib/workdir/.gitattributes b/contrib/workdir/.gitattributes
new file mode 100644
index 00000000000..1f78c5d1bd3
--- /dev/null
+++ b/contrib/workdir/.gitattributes
@@ -0,0 +1 @@
+/git-new-workdir eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


