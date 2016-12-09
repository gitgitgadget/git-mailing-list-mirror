Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BAF1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbcLITBr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:01:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:59038 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752814AbcLITBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:01:45 -0500
Received: from fermat.fritz.box ([88.70.156.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQUP-1cRjZN3OSj-00GoSi; Fri, 09
 Dec 2016 20:01:36 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/5] sequencer: Remove useless get_dir() function
Date:   Fri,  9 Dec 2016 20:01:11 +0100
Message-Id: <20161209190111.9571-5-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g74d6bea
In-Reply-To: <20161209190111.9571-1-s-beyer@gmx.net>
References: <20161209190111.9571-1-s-beyer@gmx.net>
In-Reply-To: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Qjq7RjOMTsT2kayFL0qXYew/LQ+JmT6zWcH78X+dzjuduDaSbyE
 InDdK8E4u34B1f0kimnzOjrLOaYajiHZjbNdvTy95kKirV9f71ad6sNMG2FXssWsdg1U7OO
 tBBPnxaQdP/DoIXbWS4qVmlG+lzn9aqk4kyl3RIbKBdpD4XW5pruT/8mHa65BTIC6myR4nh
 lKI+/YKvUbgdC6qYdA0Ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oSGTTQSYd0w=:wgjcGEvjFnCCPxqX2ZYW8X
 3MUTTO+ikn8FyA2QlwUABBH3c+MKvDAfn3oMft0g4mryQMPcEU3umPHiUqA7KsWgd/pa8cFJe
 vmQEw7xpNxorHXAg4ObVIeQtCKci4gRf++TI9511OjHOpwNDtnfziR8LzT5YUad90AM1enEvC
 wGoAErCTx92vzN437tgFLinZpzYdvpOANrcz0pGX20hJRze2L104kPzPdROSq27aGm7y53Z5M
 yKMoMDtcrqrWO6Sk0OGV6cYC/Zw+KKRv7GTCamQ+Ug10k3SQrUV1VW5+F/6y0JQ2ZDWUHyUGz
 XH8no5IYoSWt9c4jgCmM2lB39IR0jULyk5NBcboQMrwBW63LGRmNQHzWbF6pZkDVcOePiyIWN
 YEYP5Tw3H7Nna95G98ZSjKo6U9mPXGii45a/3y45HTksj42PajbRVme3rq3lGlr2zKGSkOnXi
 n6+1DjPTEMtkaTVu33hWeq3NgAUdG3x2ZWIbh8ECd14oagtMhJpCdC0YAHL1uLbMep0x5mAUF
 ICdRmQS1Yhd6tTSsmIUmhu3mqIAnBlchLyzOr6n/a/Cn1z6d/9au/6Je3TFF00c61EryN25AB
 SOPztyrRRZE8SGrF8H2yQ5l2ri+AaMJ5hrg8vf3+x4+Rqx301RGNtoEuON1VUPLBxNKb35tLw
 NdlE30n7EqpxaeivopI4OMiqKkLxqNK1/7NMsDVdZAnhPGLlswQ56DydAJhFbxvnOxIqcb+8f
 kofyfQ98AkG7f8UETkd7M3+BraNGF6YDNm5TMHAidwNQ9N9NNasOzXDmP7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used only once, for the removal of the
directory. It is not used for the creation of the directory
nor anywhere else.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 sequencer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 35c158471..aba096a0a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -47,11 +47,6 @@ static inline int is_rebase_i(const struct replay_opts *opts)
 	return 0;
 }
 
-static const char *get_dir(const struct replay_opts *opts)
-{
-	return git_path_seq_dir();
-}
-
 static const char *get_todo_path(const struct replay_opts *opts)
 {
 	return git_path_todo_file();
@@ -160,7 +155,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 
-	strbuf_addf(&dir, "%s", get_dir(opts));
+	strbuf_addf(&dir, "%s", git_path_seq_dir());
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
 
-- 
2.11.0.27.g74d6bea

