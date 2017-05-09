Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B242F1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdEIMxr (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:53:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:54844 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753105AbdEIMxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:53:46 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McEDD-1dR7Kd1yUR-00JaRk; Tue, 09
 May 2017 14:53:40 +0200
Date:   Tue, 9 May 2017 14:53:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 2/6] git-new-workdir: mark script as LF-only
In-Reply-To: <cover.1494334366.git.johannes.schindelin@gmx.de>
Message-ID: <8f7119839285970b14f1bcc36567d9093e3d73d1.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sT6m+LGcuJmvEa4UDCN0TkQyRFO+3LqDV/wMtJGhG3ZZtyHsGBr
 6y4AHPpjRs0jBF87d+hBVzlMu6n1Cu8RngcxWRRbaOwn2YKIXK/1X2TEq/qQb46wpTmspEG
 e+yILa6h8Rr3p4cFerwl9aioejSijc5u0kAMGBCYiXrtfqhZOXrVFQ2yV99KdcE8F9O1gPQ
 5UJDIXmnQnuL/nK6lAVbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mY7F0XL/Zng=:9P+m36NdrV+KQo55DvwzES
 lChgJw/gIK48Om4a6T55X18PXMBUqWxmNphZK0YL7knxE3p7+vyauf8Em38wN7wuNyZsfySmq
 H0hc1U6jMHk3MqxWj0wMrOxstjKaiuwhyUnXZboLCW1KyrLWetDzUpsYJFwff8n41hF9zFANg
 SpleXeRATOmMIVzUUDvdBssc9ITrzC5FibxyWxzZ+0izW/cSnOhIPQ24AqrOJsQx0AC0q04e6
 sSnQBfxeV2pOrRUg+Is6aqsB1Fghcrsyy1teRgJbGYxA57//tD7gEFzZ3uaiHPMvCng4fuJv0
 pP90JmCFpSsZnAtLkz/O+3ypLuVW7XbVIxufzUCcfPAKPbCG5KchsAdBBcOQtefE3Z+WOYJNs
 LHvqWP5zXyD3IQAexbWx3RpzUIP9lhc52cavQ9OK038KzH+4CODjqrCBOcxEY2HZHr3cHBUAo
 +Q48ePzPOzHGJTP/ZPfPdXTLjULlxr6Ip0AKx3LA7780uZvO/lV775FXHy4ckRtTSVxBh6mnh
 FEqN/Z0GBcnvXIP/y4RDSio+BQSA/TqCM8jOHnngqt5dgbidRK2TDM2txzwfetK1Lxfl9wdV9
 CVsc/HOnX3sRoCui1l0AxLf+nOo4J0AE2+tLkLrhnImsPRxrlWKJTV2Sav8AToba8Iz0HtDni
 IoNkiw/UnxJbZrWcEod3OkhpZY1cocSkCaTckLkEi6Hu7HbsYYGGQ+TyXHjiy4nyFY4t+l1/R
 dqLg99eTZZ4tgQgsmqswTinZBAWT5iCO3DWGUISQkDb4zdLpufLEHv5OhikmsnYZWeqGr+mCJ
 ETDnc36
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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


