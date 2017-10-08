Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F3E1FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 12:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbdJHMTj (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 08:19:39 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:8688 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbdJHMTi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 08:19:38 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:580d:40ec:c1e:d5b3])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 07FE3B0056B;
        Sun,  8 Oct 2017 14:19:20 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     Git List <git@vger.kernel.org>
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] i18n: add a missing space in message
Date:   Sun,  8 Oct 2017 14:18:39 +0200
Message-Id: <20171008121839.30067-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message spans over 2 lines but the C conconcatenation does not add
the needed space between the two lines.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is a single change discovered while doing the localization task.

Moreover, what's the status of the options in '--<option>' in the
messages?  Must they be single-quoted or not? This may sound a bit
picky, but there has been some shifts from one form to the other in
the latest batch of strings, leading to fuzzy matchings. Settling on a
given "standard" would probably reduce translators'work.

diff --git a/sequencer.c b/sequencer.c
index 7886e2269..e258bb646 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2558,7 +2558,7 @@ static enum check_level get_missing_commit_check_level(void)
 		return CHECK_WARN;
 	if (!strcasecmp("error", value))
 		return CHECK_ERROR;
-	warning(_("unrecognized setting %s for option"
+	warning(_("unrecognized setting %s for option "
 		  "rebase.missingCommitsCheck. Ignoring."), value);
 	return CHECK_IGNORE;
 }
-- 
2.14.0

