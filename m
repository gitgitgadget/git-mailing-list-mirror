Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE9F200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEDPey (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:60917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDPev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:51 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MLvGW-1fFh3g2VmG-007iFx; Fri, 04 May 2018 17:34:44 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/18] branch-diff: right-trim commit messages
Date:   Fri,  4 May 2018 17:34:43 +0200
Message-Id: <53ee6ba3873013956c6d6067c5a911688014cef7.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/HitRuDY2hnTizw9OhBvdZ1v/CewXZmWmH4wMN1hiOJ6ZnVfqmB
 h9p7lLiSEnVs/4YLOT//mJqGY6oKpqHiYr+vtneJfZVAa/8glF5CP/aSHTlUNR28IA+tq2V
 qVPIZSRmSKSuV6+PdYtdib+peNkx15YpYfs6QIopqyvMX7R8kCO/tv0xnjteg47ca/Bab7c
 yQ//J6Db9pcpqFHNtQdCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qQNWFOhoLj8=:PlKq2/6Gp8cglqAXEjlsTi
 l0bTZFbFQbuVNdJWfbaadUgIYuFIHUyWZUYbc+5oz1POXCa7xCtHvi1J77Mo4GeqgHl9JqvER
 S99+0HcWn0r5g9LPJcgXBdwrttnTu/j7nk4MX4tU/O7iwyXlvsX6PnV9yaPA17LGkdBDRF2Lr
 BWrxmV+8jjp3Hb9Jr0yud6SCel0Wfw2EAbsVuIfQXnl+X0iosxmsQfnu2bgATMgJgBig3Ow8U
 05QfYEpnorh7PooEZNDp+kzNoxi+NPrkuZvV49mRWHR1k1dbBgCuaEkq4e/Xe9lUmWZtahjNq
 ytTdHv56jVREqiSH4vvL4VZaTKzKtpLQlSPmYNqNcEZjKseVvwpRZtqc9d9j9H8/T4RQAI4f3
 +mRZGrGrwhLFlTEOHXltvHFIyXH2rm2dx2t+sp8b188IlyDpASOFyVM0kKV/a8ZAIvWVp5fWF
 CdcL3m36fgjwX8dU0LY0WniWGRzFYlQpl1Bti5hhLqXt1kSQFN2QfgvNDcuaCGw9j4UQzNtot
 7FmhNYWfDLHb+iNudkvjdal6tfDSq7cBptFXX2nv1a8bOKqnPJ+olW56N7tttWkflZwsWxh8m
 4BL1esTNtf2AGCm1oNaSY4IlbjDBb8zMCE7D6qBEimUJNwV9gcfe41GSD2xjhvZm/w4VC0YtC
 PIpIHXNWM40gHmauguDEuaoCEP2J7dDCgWq8ArsnT45rfBY3ZOuKapgqvSbpNqcNEnYubHDBc
 WfiCWoajzjxgEeT3vhU62Bei6/vCQZYIQql7QIkE4R4NfyrUR792Es5n82ikdnpbfgzzQW8k8
 rPUSOr4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing commit messages, we need to keep in mind that they are
indented by four spaces. That is, empty lines are no longer empty, but
have "trailing whitespace". When displaying them in color, that results
in those nagging red lines.

Let's just right-trim the lines in the commit message, it's not like
trailing white-space in the commit messages are important enough to care
about in branch-diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index b23d66a3b1c..e2337b905b1 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -105,6 +105,7 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addbuf(&buf, &line);
 				strbuf_addstr(&buf, "\n\n");
 			} else if (starts_with(line.buf, "    ")) {
+				strbuf_rtrim(&line);
 				strbuf_addbuf(&buf, &line);
 				strbuf_addch(&buf, '\n');
 			}
-- 
2.17.0.409.g71698f11835


