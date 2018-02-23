Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2892C1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeBWMgn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:36:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:34247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbeBWMgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:36:42 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC8iq-1ey2IE2cIy-008qtd; Fri, 23
 Feb 2018 13:36:34 +0100
Date:   Fri, 23 Feb 2018 13:36:19 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 02/12] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <a7e01df062d64a2b89c99a4de4a772cfb0c84017.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Yr3HSrKIILH1g5D5ZYN4fMZE0ZnadM0tnBBmjI3J3E3VK0eybxK
 onFffzY6H5v41YD2nHsvsI0h3tqS81ArHWC2NoGkuTG9kzSnjneHUvbdS3xWmMYHxUscP92
 YBsUNGwDtlTzeGwAiJweAnfv5SWV4iaFnTJKEr73nIZbuF3iQAIFVNnTxGj+wTEAaDhcBDa
 h6AfLtiYnvS0Jmfc2Pwdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BIn8doyuEgw=:jm8GuVTgeOWPk4xyfBTOL+
 36vO3Wxq1kQgIQWgCUWP5YTyRKE+3uN7UJ+7EA9HtlRDbVwu0giD7b4gjiDrgROgmfwNoYNgP
 c2CeOCe+2SC6hsUTD19EOT84z6cVE22VdGYhx5wratJcpM5F0/RkZzgFtwniIGOa43DarDjEL
 ZL1quf17Cz7tYMaSAIMkCqYT8A8AReAAOCabhvLaJsPu/DdU6Pea28regWG2UeUPJeDmHIUz0
 Z3UuovnrpBRtdicy63kshxVZ7BwVS8lFZg3F8WsxCkaIgnSdc8TtilKh3vm03CafV3bmGUA3i
 q7WKa2YWVkKDq28ddm+XBLO6MDvh3sdMFJK57y7TmY7WTMtu6KeOhXUhA6m80jhghQFvNAzzZ
 YiPB+VtLEu00kwxZUHHk0+3Iq081JwXongrfEOabqe7IsxkovSZoX1pSYWOus6H97r8qImB52
 wRVqXHcScPjWqkGzRaDASdgjRU5/i8OW7PzoEhRxVS/pQOIJUy4xkAjkjjKb/jhp/nFUBwAFB
 A3xbNKDDO/zt2kujhR6McBRXPk8J99rSHzVET+cNYBXJsqfRB6Cki+NA0IZcjYJYjqNV6PKiY
 YU7TXr3O8mANGm/7SspqjLWBo5Grmr66B8SMAj3lnaZyV5iFEXUkHuAu24GekmJ9vZWPOgSI5
 JDzXJ+YTtptkCiE8mEBELKFPEnTsbB0YKbyVOgO4ym0ux4O4k1qlD0xawsSz4FqFkJt42j9HX
 taBVku5mWAt4mwBtWFfkp0Gtp+afPz+yeLYmKcL70PCtnklpVyCBj1/BCjyeEZ7fuzi0RaqW7
 YuzFY7YnOP5Z7rFCve/qzrTVpWq4rJBfXmLPgMmkwzqAEeXTxc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands that have to be skipped from rearranging by virtue
of not handling any commits.

However, the logic was not quite obvious: it skipped commands based on
their position in the enum todo_command.

Instead, let's make it explicit that we skip all commands that do not
handle any commit. With one exception: the `drop` command, because it,
well, drops the commit and is therefore not eligible to rearranging.

Note: this is a bit academic at the moment because the only time we call
`rearrange_squash()` is directly after generating the todo list, when we
have nothing but `pick` commands anyway.

However, the upcoming `merge` command *will* want to be handled by that
function, and it *can* handle commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 5aa3dc3c95c..cfa01d3bdd2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3412,7 +3412,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.16.1.windows.4


