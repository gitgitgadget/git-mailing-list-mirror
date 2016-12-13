Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33472042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbcLMPdz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:33:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:63920 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933149AbcLMPdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:33:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGSgq-1cLEuy1bhw-00DEhd; Tue, 13
 Dec 2016 16:33:00 +0100
Date:   Tue, 13 Dec 2016 16:32:59 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 34/34] sequencer (rebase -i): write out the final
 message
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <28fc8e98c9a3cd6ee7afc117925ae483d89a90ec.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5EMgFojeyEmpAOjLtiDbBUdl1aDyLa1xtCbiJI2a/KXrXkYLHVq
 JOLyl7q7ED2B1huyduC/3MkC/W9GHc0DWKz3GaEH1HYw8BHzhvXqvZFZ5VmhRE2INIwAprw
 OqfyHcyDYkW/sCR0NDQycx80gCEUa0MpBdd59jy60w+1Q/UaPWvLGiW6RmEIqxpjtAU1BIq
 4eiXX5+E/Dlk7c1aanmAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ussY+/9/8ec=:73AFn0PFeqQ1So97kZBWxY
 F7TBXKbNxzbom1IIxnjA28xKg8I8grHACxdjOVo4b8yeAenN87CgylEWCCK4IvpW5dmZAMlrd
 onCxEtGgc/On6a6I3CCU7KLR1ru3xxRASZG5JLE7qlH9slVdAfGFbQPUagODlr/qfaz8SOTou
 7IM7b95GytLfEd84mbyeS0jxMCa9CbB1jIegujXVvYWbVF5uZ1S1eUcisV0zPhvS6L++V0LO+
 MqzZiaE2DCyAIKTUrNhFrctjAiPgrg2bf2Zwt2BpXKFz8QbDFui+JDjCsqgP1S05pLHuwO7Jk
 kg6FCp7FQphvsWvrU7b+Wp6YRwdSsuJEsZ1P7VUeuNomml+N11YE5YBU60MAsN6z0D3a7ImgQ
 tygbpIDIYUtoNYQ2uDlSrp1w1oJFV/ZHy/TwnuqoZAec+/3CcGxhVItRp0XmH6LA3VyyXJFtx
 NsJPLF39qf2smU/2rc3SdR1U4NzdBf0pb6vs31E+utDZRI4vM4bJni4Tdgv5Xx4bPRbfWPigm
 kZQpTqN44X3Bew+g5FjHQub/3TerNamF8tuLcgSnpvuytHgafp5Umwq7q1ME9TA2tnB/Z8G6i
 BBCvejH6Rn4QHiwzHZN4EmseZi/5yA0U1iWyptq2XgME09CFQYWsAj9NmUwpVD6x9EBRB/7On
 5rzJnjVSP34hgfLs0ewMOwFOtfnCyThtgVwbPE3HjZgAkok5+0zSRr4jrVAcNEBckHosrOQ8V
 ipy9JMbjIL+HoFMVfatvUiCMxd0tXKxAZ3bZ6ovvanpiVLNv1RUBIzml0KlO0ikdawyEJMWqq
 l9e4KrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell script version of the interactive rebase has a very specific
final message. Teach the sequencer to print the same.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index cb5e7f35fc..41be4cde16 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2118,6 +2118,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		}
 		apply_autostash(opts);
 
+		fprintf(stderr, "Successfully rebased and updated %s.\n",
+			head_ref.buf);
+
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
 	}
-- 
2.11.0.rc3.windows.1
