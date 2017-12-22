Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECB61F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756947AbdLVXz6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:55:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:51498 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756548AbdLVXz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:55:57 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC7em-1eJlk20CSe-008q3c; Sat, 23
 Dec 2017 00:55:54 +0100
Date:   Sat, 23 Dec 2017 00:55:53 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 3/5] sequencer: remove superfluous conditional
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de>
Message-ID: <2e30f42e0bbe6d1f86f46e6461d3218adb2ede5b.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:miI8a/RRGH1lO2tlPjEGDy87ie5Y6WhLS0KzEh72qH9Taf4gkNA
 th3RIkIHnInQoRP4Qo5do/hvCtT6CSEp4VArcYh8VbKTtVW1BsUsx7flmwLYRpvGDe9O5fS
 U9VbSGzRm+aJ9JI3a30GnqIVv7baViFy3GgUw3Rwgqjyfs1eo4ci9iM/u/NGMhbyI2UdPQe
 8pHF37A5ycBo9RxKy/lLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4uoaJ+Vax5A=:InJZ7B3vuxveHoQaAooX36
 Mx7jpR5lHAGI9FEQnp+vpMXVIWeHPbPuxIwWuVW8bnCLfMB6DpVz+mpI8onGvF6TXIWsNJ9NA
 8nbSRVLTygm8UPqjECs9meDJSNk8J8VsDg/TTu5gxPosNCgKyJHxMa/jNpDbUAlZO6QoP0ajI
 WBOg+qHFSopRVz9L7SOVYTyi6gfZMrhUI5HngOKFqX8u1Irx5eoyg3Zp1748BZwvjo8Bt/PaY
 C10hNWPYAokMfeOZuBJYEE64Kx5PMXO9JbE4aC73NMo+xeNXhTv/GCFtTKHxmgGE0KBjUYL70
 V/r2aJv8Rc8ovdCOnQBWupmMIFdsY4XHzyWEfZnqcYpwpGh0klx+kkcfJ7Jg2Lqr1MDT141Wb
 hRW560JgohjNQsTkBnb1PnZNceXGMgD+H7AnB5sS0KjzqMi8mpHx/tlYa9XCpmWhVCuraDEtB
 3eVyubGzJ1E8htPnNy8C6rlV+CqXQKROFx1BijFEMYHRQEKBPShW5suDU+dK01hSuOawfpqFe
 FntX6XK32WiYBhb7N1kG+zVn/6Ap8Hq5g0Uq5GJzJPm/RX7F+XUtsSECAHDqqdFUxIXtcTdOV
 dz0Dt+I8w4reHTUSjPAj1nt3G7xBa4rstOABeKeWqFQTkBiqixdrQAnqW2q7uPdCO85n6Ycxl
 aPlM5FD0z7GzlD1Yrcl2bw30ROo9tXU13Ce7FPwso3Mswyqar+h8Qj+RmjZ3WLjTpaDQ8gHLl
 d233qV3iI+bvxxEA63IvvyRoY6iJE1nKYknDLlzDe0+I/BJTRTKVEZuNc6mOaf4oZjhtDVqfz
 PscmCexDAyPkY1XJresAHnzF0OtqQpR9zRD+VMhgYLOYN6TDjQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a conditional block that is only reached when handling a TODO_REWORD
(as seen even from a 3-line context), there is absolutely no need to
nest another block under the identical condition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8e6b6289be6..38266c3c228 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1011,9 +1011,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
-		flags |= EDIT_MSG | AMEND_MSG;
-		if (command == TODO_REWORD)
-			flags |= VERIFY_MSG;
+		flags |= EDIT_MSG | AMEND_MSG | VERIFY_MSG;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
-- 
2.15.1.windows.2


