Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCCD207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbdEDN41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:49226 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755337AbdEDN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikE1-1deFbu1A5t-00cy0q; Thu, 04
 May 2017 15:56:07 +0200
Date:   Thu, 4 May 2017 15:55:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 08/25] status: close file descriptor after reading
 git-rebase-todo
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <57f66d1a001329bac1ea4aa0c471ad5a359a632f.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0DDJBDwSwTypFTPLahLg/AmR8QMZq0gWo/CjgbT7fPQSnyvCRfc
 /IFW5iBEQI24Vx/tBeAkGxbhbtYzA+6KZdoMT1sUgTgLFH+BWKqxKQOGB06CdvKcisavtz5
 IIiS7DQvVv+ilSHWlrstsKl3K8jH3RVYs9s9oY7iSbD2h0I+shGKKMpgwjN7GGPnucVJSPX
 KYPBSsII6SJoqRXbjr1sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L7vex2hGJHA=:oB2WLHNubwXeWtMPR45+j5
 CvCGUS+AwdGuyFuX8RK3rcOhYcFKDhndt7s5Wtx3po1ot46spOBwJ4mIOlZbwREAGKXTTzO/K
 B0ntYr1a0BaSBYy2BZF5Pf807ffhAIS1FYe2NfF/EpBdRBQN+oTVg/e53IMHs/MlD88iXtI8c
 TTwC4MK9czec3V0GOLMVRt43MRbjiQ2uP8aYVpd13FdZfeGfmyLqaAhB2XhqTdRCnetwVeAJm
 jrxJxTrbbw9aAR+fii3zvPvPA4F7iL+KYjGuoy75T85pLJO413gA8xY9TD4/JR87kabzi7APC
 LnDsIBFStzQSMfHj/M8jFYnDjdQmSRJiknkAqCyHmtcKz90JG8HO5FUe5lEh13vallcPJtb1H
 p355lxIkuC+qBlYWNfmJ+lIC8k89rWPoBA0ePLaiRUnATA99uyAaY4HkkNnYaTsE2kLwMprnn
 T9GOY2oyvB3Qpg3+5THxtoHka1OgJhwfBxjNOvlbgFiYfncXlNoOQRf3huzu+ZyOjpbN4o7lQ
 7ONdzqBc9HaGc2RQ0s+71RcQicjpI0NYsV8OfhtpHoaOrNK2zZb91yvPxZK2/QiPtuAq3gvLd
 mQmD+5gAp/jbic9JFBEpKVPUgA6j6ysrkJlWmIPkUNRMq0oV71TGhJRncDw+jj9gukkRkwmbF
 ngEENZrg5Ucn0r+L44WTJWT+P7WmX5wlDoSuQ7cU231JohhhjsRKRBbU0hGeo2E+tge+prBoE
 cAmTLDPilGmwSzZpvjJePWkOVODF+y5sCz17ghZV7PxEAOkz9a+Jto4YAWGk84TOt1Wsvar2e
 lbNb1i3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 03754849626..0a6e16dbe0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1168,6 +1168,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	fclose(f);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


