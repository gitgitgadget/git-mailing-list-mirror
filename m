Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85E7205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbdABP1o (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:64519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756288AbdABP1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:40 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpfas-1d2LXt3rmw-00fOE5; Mon, 02
 Jan 2017 16:27:28 +0100
Date:   Mon, 2 Jan 2017 16:27:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 14/38] sequencer (rebase -i): remove CHERRY_PICK_HEAD when
 no longer needed
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <0712fcd8a1489ec2cd67855d7940c1a167a04aa4.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M5HtJhSrRvnmZNkwVhiVejCv/jOSb5t9OJpMOx82ikMUpFfdJsK
 JCmyO/USDxk4QJx3xhdDeGLRk60qOO69UxehVg3Q2JOlvJPjJwcLCuOvkyD40UfrsxEu7VZ
 Me/LrgUFpWacCIL4/oKMpgw/2iRNEH+QJ7ZwxZT7JpZZHrRgMWZGSBW6LGx4n4bqfwbWo/0
 WiJoLUdxAljk+vXI19o5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f3Icnq+W8Qw=:am6WQkEBrIYkLPAGx6ZY/P
 KUYI462I0cZioswSIA1uaxmZskm5kN0mkyDssgb9YxGKBDnsmsz5ZIsDkCcBUjlycBDLfHtgk
 mGoCbl1z7dtNyi6RhbPINWB6+gsYdkruMPHLuzHnKdNBX7veI4hk5qsrzeF6dZxe3sUU2HL+h
 OfGiVf6kZKxjH/4qUNWSZfMWyH5/gJabalSnbiol43SmHIrHfTP2AbrE1CxDUjnaAqlhO0LKa
 /0C9+vbnZyTcqkBQ0Wk/DEUaaO0VDMulEf4nOtHACrDuIrKIp55uoGgfWzwbSgK2xY81wjBy2
 9fCpcl6hhaXmHQqIScPdqPtkLjbUxwpvnTS+xlV1NBRPmaXHHtGN5lDRgTWV2NGppMF4ObvEA
 /Su8U7TPuSFnD6xf2bmsYArjvjj0mqeOV29F/M6M6W3EZeRm/sI5OyB09iIWCmGYByf416nvH
 rjDjxv29vBR3QPvfI0NHwyO9+VCCqcqBrDvuo6rzBxHxTX4Rhr8aWAh6Vc2fZuoYajkRHpI9h
 ktGHVen0m/VD94MBov2vPR2beiu9eNj865h4JzE6RpyRu6WFSwrF9x1piw8bgFB2WnGcV+Rws
 j03vsxEaxQIBG3WuU9wIhdpRcGRVh9Xy7sBOYzJiDYggvra3xElEXm7Y4F7aDiy9yZ7kMcFpa
 yK7Djpf9U/JiQFT9aLDLJ0K1M3Vd5Yn2gXczW8e/plFo1q2OZgAuFZ62T/+tw5pts0phzMWRT
 Ymu8nQ8IklT6b3RbgqvvBMuV5lWJt9sbiT4b03X84V6znKa8wPtNY/39m/BOogmq7XEbv46Cg
 W/eTFl1+KWb/0uFAG2mHLQMQA99P68j33wQj/w/gorrCFUED7Gp5tlq+f+HWsyXP4OCBAv/l+
 2U3b1RcNLmmkUV2ttJtfikcq9SoQj23c9J5fy9HoAimS14Eq9NQZ1MtPl/S9bpdNi4YtNKeRf
 GddxmRtrC6/P6cs3CqANamdQyJhRSP3tW9QYspdUozx+mqnMidSZj7EzvI5lGeQYBKMVFxbCi
 3okx81QXA1+XAufmIvrxrao=
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
index 69301fecc6..52e17c8887 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1832,8 +1832,13 @@ static int commit_staged_changes(struct replay_opts *opts)
 
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


