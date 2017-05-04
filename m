Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3806207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbdEDJuQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:50:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:61577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbdEDJuN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:50:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqALY-1djess0tua-00dmB1; Thu, 04
 May 2017 11:49:54 +0200
Date:   Thu, 4 May 2017 11:49:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 3/7] completion: mark bash script as LF-only
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <a36f1684d302dc961f91e3ac0651b1aac7e00710.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XcHGByOm9O19OPbD+QfgSzxbLFTAQbkZ4YeKf7GqljgtqPdE8Fp
 PikB9pMfDhUka0h6HdybexbNWXO4DI01w7YWwOIavS9lBK1WjRMzaAlp9BOHEwG60/38y/V
 AKuvG8doE3KRA7Soe1JATaP0n+7jPVEDaxc0Ds6TDrI6OHwiOpX36Sbhq7n1fnDvcEvPE7m
 n//ZITRjy2XPNQIXl7/Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jjoISxFncsg=:FtBkp0Kxqp2EosFaG5Ko6x
 P5Dc6UgUadASuZnTRFtX3WDeU4SmRQOniZOkwcFC9bTo0I5bzrNRo74zx7YGLLJM7fZH++ndj
 3YqyceAXkC8sLoNK8XzdWTEwxrEsOrsJ2XexuDafIOn9M42udyplVlzltnphf9k/w8wksc2xb
 1io0IC8V9EV0OQFdVxEstUZyyNCqaqctfEemFNCaYBwOZgsOwrSZQ+Y9vL44uUKYRZnurQ6DT
 J+XGYD5oMyw65gFKJlTg7pH7p84CMlFgorE+2boBBGu2dlNLMUd95bF0aTS3CsWyL3uZIRIgu
 0m/CCzX8aLAsYkxFlt4xamqd15y+3S+trekqnNIGxRBuOgnDArlQyeubhVbemz72lDwsr0mRA
 KO3yWh0+Uji4xt+q47KPsqHfyzBydnxW3yRxKvGJZ06Zkk7T7O6NFp3OcTixuZU7NBmSgkIcl
 2GZTG/3fanK6B8WcugmMQn1AZ7+6dgDVyX9kTNxhzeV51HNQHbtgXPmdnqFO7YyRLLjbbneO0
 i59715l9rjyRoH0XqIYA/KWs3JdXY3HpdhRd7FzkgmUbf16sP13LE7pYvM4PU5S1xJ7HtmDsR
 Y4VDSn2wmheyQ/O/qRoRo34aetTzTQbLVe7XLlQoBNQ44/eeV50nLgZftKzLlHVdfSp31lvcA
 9uOrbeOVlkq8AX6SQNrwF2Yy/4fsuWLmVkbvGaxa4wjUJI/9jzOanD16mk6of3aywaUakwbM4
 MQHY1wXYfwpjkcNhAzHiogZZIGkgMgSqrz3oVvrDeP+QbRoplQGZq33/Br9SoeDUO8hPTFlf4
 v/yKADc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this change, the completion script does not work, as Bash expects
its scripts to have line feeds as end-of-line markers (this is
particularly prominent in quoted multi-line strings, where carriage
returns would slip into the strings as verbatim characters otherwise).

This change is required to let t9902-completion pass when Git's source
code is checked out with `core.autocrlf = true`.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/completion/.gitattributes

diff --git a/contrib/completion/.gitattributes b/contrib/completion/.gitattributes
new file mode 100644
index 00000000000..19116944c15
--- /dev/null
+++ b/contrib/completion/.gitattributes
@@ -0,0 +1 @@
+*.bash eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


