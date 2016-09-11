Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FB7207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755999AbcIKK4I (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:56:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:63261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755853AbcIKK4G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:56:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8NBi-1aoaEC3vOs-00vx1h; Sun, 11 Sep 2016 12:56:03
 +0200
Date:   Sun, 11 Sep 2016 12:56:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 25/25] sequencer: remove bogus hint for translators
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <8314699c144c258ca45094beef5953b612eb7f15.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pmyH4vZGIfIXyj8ywWIQFBuiKL6QBwB3S7Y8MonsquXhrBl+zGS
 vJKZLC2vWmDSec7oSRsogyzXNYJvC1jOoF+5xhEv9gY0wTarIEXNVsuyV80yTjfUStVHocx
 Gxw1kMygGSMEiJh5+UinGmAlWg3K+l2KpfMQv6jF2iievaiu8t+yJpKYnXcsZTy/xjiiAuD
 I9VtBdPyfLXA02urb25eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/FkQz01d00g=:1OeLRMHyIOJE3ZHmZRjvmr
 6v4E6zK1G4kBRBuAqJME2iefjxK8vo0Ou48ZN3c6vAFLDZ7jXcOd5gISrUZtrb7l5YjQJR4t6
 hAHweARO+GSC8e0AasDvBMP6cYKpOb2qIQd+7FvGYIje7+1YaeRuVA0kK1cGXKzqQvdXUb3CC
 997QHAaZ3wX0KwyCUG4tlgTp9aG6mLx5ITGcAIOHSbhQDdN8JquOeXIzf0WE6jBKGVYURc0qt
 Z9kqj+wBnAGGOs8ygiYo4IuAX3BHDubG1N6PgrI5hSSRSmmjn3uX02khQXiHdLj4hEmREXF70
 Ypmcbw1da8ef952tUM00AKIJDfQJwjFF9aJn7s/1osaRtweOVvYKH/2hxLX+v8+YUNDktowif
 mar+EibON9VyZnacDhDwQuS4iLT/jzHQiYt6+k+H2YURHROg642uuwpWeBsebccUQjuyAYArR
 cfp2NxvZ2d0LQuvNI2JS2qzjQInD5BmKhac6t8DgY/rJ2UtKcEAgqDojhizzxVqgF6+pippqV
 xArBoqVToiEyV8uCl67oOUCXA3fPN8FiuE99DO0YcU7Aq7OWDXX5WGLD9gSsbSU/R0M+QWdxr
 EVG5MNmDSwOK5X6I00J+80Iubpqb//lD2d0F+2cpL9HKSVuV5amodyHh9fIft7PWCP8alQMEy
 KaoQV98CKTU4znMXW16Qp8q1K2bZuARCMEToeAAFQuykzMy/WgbTCrVEsoWHf4KVWy/LCGVyC
 5z7hIRBB7YDpygLbcdoV3lOPTblosuvl8C9sfcJozYPb+AKEPVJLp7m0gwPfCJKuGBzsHH7s1
 /tz5vX9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When translating error messages, we need to be careful *not* to translate
the todo commands such as "pick", "reword", etc because they are commands,
and Git would not understand translated versions of those commands.

Therefore, translating the commands in the error messages would simply be
misleading.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 465e018..cdff0f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -697,8 +697,6 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
 
 	if (parent && parse_commit(parent) < 0)
-		/* TRANSLATORS: The first %s will be "revert" or
-		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
 			command_to_string(command),
 			oid_to_hex(&parent->object.oid));
-- 
2.10.0.windows.1.10.g803177d
