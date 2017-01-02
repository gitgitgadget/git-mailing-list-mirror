Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A9C205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933174AbdABPgo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:36:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:60716 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932966AbdABPgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:36:43 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5LJv-1cil8O30jH-00zXWP; Mon, 02
 Jan 2017 16:36:27 +0100
Date:   Mon, 2 Jan 2017 16:36:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 38/38] sequencer (rebase -i): write out the final
 message
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <a033bf2ea3ab4d0b77d720d73564a052ed0f2b8b.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4yaTjwjYgMmVVDeNYP3BbANfx7t3NOZ3KeiXzRYm+FYIcMCvxzK
 B21fDUnb7bLbER4hR9fBU8+6udee+ZVeejqqN1Zj0917RbxZ9GKuW/YfsdoY9Jgn/Kv7lb9
 zywgfViMnzCld/uFidsp/qyOIjI7n3PlMlc5V5fU7ltlMM7alycgIZqicK7LkW/j2MEVLTE
 rOCs5T0xv6n4AdrW0Gm0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AKTQLK9lnfI=:No7wjWspfOFx69W7xI4Eve
 TPVB0dSSXG4Uh/VPwbnHvnQ+02iMv3kbglHxNTY5P9m/4L8UIAxRuqEJt9RlFMWn5vYsRFezl
 J5Ewnl/4zyxHHsDqgOPQMssWcA292JMnvKfohm3BJ0Idcn0RSTeD9Kr8UKj5t2CXNTyRxs7ly
 gFKXyhdhevV/oJ/P2wmstm9Oi8R/J0T6i9U2sTsDIDc0+GeAZNbl+L6RtNpkUyLm1pvwTdUVZ
 nZBju6rC0n3faqwamHQ6qRASGuSu7xUh/JuUn5V0Fc5ivwpVxfOfJm7Apsz8nX90YdumLvGHG
 N6SNWJP1cJx7UvFoLO6YYJvDqwXuDNS5IFFtr7TJJz335W6GCUH75NhPPhrpCgv/IPTKBaqHq
 oAuQ1p6d6I5GjyZ0dNHvQXwhIqiPxl2RZp87CWSJT/w2O/zkJFLMPiqOv6XJUj+XF+WrA5poz
 EwvyW22Cg8xArepElhgBkZfe7L5cRUOM/TJdKPBYVuLcnNWL7IMIQXdGC0OrL6Vit+uU7JsJC
 f1T3MtgK1XDfgqJ3DI2mVttObWMLYMQWliCSqzH4Qhh6vHsimn3OaRN6irv4idEJAvQ52D0yi
 bLd1Ek2qR7eoqDspMK5gHpUX9vojvLhkXPhf55Tn+nDtu027XmUdzmblK9KEQd1zvXX5e6Gdx
 N8/WimuWKraSyn/nIYlH+4/HE0n1dY0YLjnRJlAoIyCdX9p2FsIO7ivQSSoZQVIjHM9W3HuUs
 85c0hYE00dBbTSqdOy4Y8apVxa3/V5qtIaDtTe0Is38dcN0uzmyHR3i2hi5frvOX2TKy23U/S
 TN2BAjh
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
index b39cd21e03..0e7d2ca5c8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2127,6 +2127,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
