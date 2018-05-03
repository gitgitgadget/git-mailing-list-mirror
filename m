Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B303200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeECPbO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:53017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeECPbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:03 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LpwZn-1ejtS81mad-00fhZG; Thu, 03 May 2018 17:30:59 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/18] color: provide inverted colors, too
Date:   Thu,  3 May 2018 17:30:58 +0200
Message-Id: <a94e94edf652244f52f921522922cfdf89a762c7.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PQxIEGDpM7dBB6GWfRICm04HrPbDGElvF0zSKn+jkGGkcKTDRHI
 45xaatwXAORfHrqz8fZ9zROFIvS6TA1rfqb93/SgissSJRzOpxxT8yoAzz9RZl3nNhPLWU6
 WlofqXRnEHkgN37LYwAXhTUiuvGWw9fdWDhX+/NfaeZ2b7ZbjzmnHTNYHQ9kndVPLWm9DH8
 6vxcbaqtaDqmrJe7W4x5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/YVdiZLoHs=:qgHJlUS2qwQXB/mWzecb2a
 GvFE57GQ4sZwzrCR2qXeyIEY+I3EW+67AyXgonwRKqNrLO02g2UhQ08WlrSlYPCy4CW8GhFuc
 5Xcsa00nH38cuHGQlBehuBGU2fcYWOelb7cUv8GnWXcKYIwSY7ylIaf6PaISDGekUIM8IJE81
 KbiTYiRBJ0evGtmg1JrBgyRF5MsxbPnB+ntA4FNoudf+X4HuuyvimZhDeZRGddtAFVy9SLhny
 8rcxDs4uXH4ZjKyQYvkHaD3vxXpqxO1yt93farSU4EPWsMonI4p4dako++k8hrm7lpjPV6nHd
 FzqQuWDNhYtk3+5/cUiHWQ8eoTtiwcof24LOexELLjHInvC2NBh6d0MHQyUcifVcNlI7+LzjY
 latN9Jf7Ta/Yk/uEIAQUJc//p40d91AIwZlEvThQWIHxYRHLRf9hcOebyzTBt1rloWVg6rO1K
 kxRzG5IeKY7wmwicpRy88yXdmXdvvXIve18uuUwlSnNDx3yye/dhUr4Z57IuFf1OgZWClb5/y
 WNTXag6VJ058sJIC80r0kEWQ4QtH8Y28TA8QQ3K5h+MrvWPZlfOSMpFd2y8jhCJeLdphk6ohz
 YJEC3RQyVotNZ4GWsqPw9fnR2YsMlK3kmes6A6Cvnp3BcQxtFNtvIQjGY2Zy643Z8tObmYVmj
 YKJ0Vw33aUcsjkhaW7J6wkjg9Iupj88lANTjoJUk3vDTwtBdeScC1sGkCHA/s2/Zv8hy7Ifay
 sMZ2Eycg2KbgBZ8FgqDFKOP0PknKXf9GuepPwvqijbh3rJoeWoSdeTNYCzz+wKyhI7fejJocS
 5S03GeV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For every regular color, there exists the inverted equivalent where
background and foreground colors are exchanged.

We will use this in the next commit to allow inverting *just* the +/-
signs in a diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/color.h b/color.h
index cd0bcedd084..f0984b09583 100644
--- a/color.h
+++ b/color.h
@@ -36,6 +36,12 @@ struct strbuf;
 #define GIT_COLOR_BOLD_BLUE	"\033[1;34m"
 #define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
 #define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
+#define GIT_COLOR_INV_RED	"\033[7;31m"
+#define GIT_COLOR_INV_GREEN	"\033[7;32m"
+#define GIT_COLOR_INV_YELLOW	"\033[7;33m"
+#define GIT_COLOR_INV_BLUE	"\033[7;34m"
+#define GIT_COLOR_INV_MAGENTA	"\033[7;35m"
+#define GIT_COLOR_INV_CYAN	"\033[7;36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
 #define GIT_COLOR_BG_YELLOW	"\033[43m"
-- 
2.17.0.395.g6a618d6010f.dirty


