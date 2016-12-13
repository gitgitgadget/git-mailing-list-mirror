Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E860C2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcLMPhR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:37:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:50653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933224AbcLMPhR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:37:17 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6ilI-1cVJ5046OC-00wWCh; Tue, 13
 Dec 2016 16:30:39 +0100
Date:   Tue, 13 Dec 2016 16:30:38 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 11/34] sequencer (rebase -i): remove CHERRY_PICK_HEAD when
 no longer needed
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <81ba5f7ddb3a1a66e878b955094b7ae00f2cd781.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:asxXuwQn7hF2cxp7Ej5QDPmJRizBmyHMjnSbxVuy0QkgfcM4vR6
 HcpWF1rAxFRL4m2qhjeW/UhVmP0YbFhDw6/GEmlo3oXYY4Le00rd3MxPv+TczQb3BBu+H5W
 TQSfxiGJo/fZCvJ1/NYQeTxm1dNRzUO2hyp7BmM6mVYLf7wlxdX6fLAsw8W6onLY9P7DYjc
 tpm5vNp9mlKAUMYqUVJQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xuTjvqim0xE=:V9qk3MBzdUGldmJjOAQf5P
 wrpDN18HfkkR1WLKEZWTkLIoZ6YQ5tQmAmZcXvuJbzSt20l22P3gchE6ubWaxWkK4oxZI1k0K
 BggBjwhG90+MEuowQpCtFPlRunEkOC0wMdHGp+12ZNESj+k72sdZnkVVujMaxhoWdaJw9K2bG
 VOsZ2xGHwZXJ7T992KQVAC33PYFAaRCVsWiysBv85Nvx8+E5UoebtK4nJsyUPlG4nKRRWw6Ze
 OfhdpmEoC8mnA+Uh1ifCmmIcHMlykAO70RlpAewxYSRuD6hknZ+NiMPLdS3kU0egvoYsv2ZfB
 DTF1/+TuCVxY9naQcyghtNt2OlV/r4ywi/4dQc8bpOf9VP0qjA9B2pb9pES6PRGP7f3eLkP+R
 s4UytELqnCylGb3WOvXvL0fjx90sDxh5BfxynXX9n64TZ0Xi8c8/71VYpMtkPz87i0PRm9iXy
 s36zCMjNv9d2zoTrjV2TPqqsOvArevuGDV+Y1F7Z0alGNR5Td5hVrCWGAxNCjJQQN2ygAZD/F
 IldBJynLny3AsIlleaWCQ0tKBjAFLApnZYmOrUxpb3p0B8yalGulCOK2az80FxPdGyAC30oAd
 KpbwtkWa6TdeXyV+DuMf9pPk8C9SWlFfRRLVieYqU3qEc1XwIfZB4ADWzaxkqZu8U5W5bvgfl
 9OIlRR9wHjMySLbA2Lizdn2zhc/rnp06c7SqbfTZYA2f3ZXC2srnVKi0MndjDwrL0w2vpUraF
 I4gMnVRdzKNFrok4PLgHY2rWe5lMliWqMSHCqklnpqsLtZgsAGyUQHYXwUx5+6Zw9NOQYqRGO
 u47NmMa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scripted version of the interactive rebase already does that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 855d3ba503..abffaf3b40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1835,8 +1835,13 @@ static int commit_staged_changes(struct replay_opts *opts)
 
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
-	if (!has_uncommitted_changes(0))
+	if (!has_uncommitted_changes(0)) {
+		const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
+
+		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
+			return error(_("could not remove CHERRY_PICK_HEAD"));
 		return 0;
+	}
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
-- 
2.11.0.rc3.windows.1


