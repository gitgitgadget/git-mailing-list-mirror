Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FDE2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcGEL67 (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:58:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:58249 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbcGEL67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:58:59 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIuSH-1bHw9s0kLx-002VJs; Tue, 05 Jul 2016 13:58:53
 +0200
Date:	Tue, 5 Jul 2016 13:58:51 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revert: clarify seemingly bogus OPT_END repetition
Message-ID: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FV/HGtaHTjnmuzvB0vWBa0R4vtxC4PFvVG2HmTPR73UJ9+lPwiP
 EMd0geJ3bwOOz4jti57iGEyuZtIcJ5ylnZgx9LET0aGCzFb9w7W0qq5suHovb7HmRGtVO9Z
 i/5GESv+yRtFE5CIVBpjY6osQdBu+UNnzqQLR93oQAJq/qtD8CPziNvB620ul8DTkiXLFFq
 ISiRY5MiyyUeMS/VlYCcg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fMJWgU7lOCw=:5qf2USpYE3bu2QdNjzjTdB
 Vy0tW861VQTpj9GTDu1/+9Ct4W4d3QYFVNPtlgiH8uCqn/7eIF/dyCWsm92GP7BG5F+yPi1hi
 +mkPbCTuMxtaisnvC3xRowAt2EhSV0dfJ+GvyNLSoYARpJtIMezPErrq+9srMtWxGYYkOEIl0
 1gIjYLogbNOXHGoM0kmDqVm7dVirQjwk2GZlWBTchV6p4ci8smTv6jKHS+zUZi4qmiSZhSsiz
 H3yI6hbc8pn63sjoR4MsMmGUTM8hrDC03ADZMyVi7LOPo5Rcr4UK7X2ne2gnaLuAIt0sNRwBf
 PJQal/UAKJ3icumskXRlbjt/F+IaQHXlm1fFSXc1UacBTHUWJg7FnrFVu8ug+sEPlDZA4eIGb
 i637l+iu4xrMuY0BMEClCZI0hG1qv3ovIquWWE41JfT++0tPQuzSHKir4R35d8qGUUDE+lbAH
 3MXEl10PIolG7qRERA3k79UvqpAtxdvJk9OkpDvpwRQ/BgJh0QAGWDiAsi2XhSZu82nokvtXb
 4yRFxsGi2rXAGrVXOT/qibxv/Gp6cS7F8N4D93mS23PCIBbGvrckHSqJw0nNbUeEieeOPdunh
 f2Pou2ZJm/o5/Oh5kO0DRQYQfzIORggIRLOHJIaDCw7SNmWsxsSyzomWC3UypKWRdiQQERkgQ
 3HIQxtKu0MSM0PLlg+eYRE++i5eInaCBKldDqr6Emnqesl417U61GCjirvyPScwzIgPd5kE6S
 E8A33VZI4zmnjeeEQug3q54zZQsw2P7nOtmspbgG4BVMal/H6oNT25xugLQCF9AjegzK3mHnZ
 jMMF/r8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This developer stumbled over repeated OPT_END entries and was *so
close* (almost touches his thumb with his index finger) to collapse
them into a single one. Only inspecting the file's history with
`git log -p -SOPT_END` clarified why they are there.

This confusion can be easily prevented by inserting a simple and
clear comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Another patch from the rebase--helper queue.

Published-As: https://github.com/dscho/git/releases/tag/clarify-opt-end-v1
 builtin/revert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..b4da1f6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -92,6 +92,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END(),
+		/* place-holders for REPLAY_PICK's extra options, see below */
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
-- 
2.9.0.280.g32e2a70

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
