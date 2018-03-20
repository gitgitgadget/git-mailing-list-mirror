Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFF51F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeCTKL0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:11:26 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22017 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeCTKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:11:23 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yEEeeoX3nwheayEEjepmVY; Tue, 20 Mar 2018 10:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540682;
        bh=K0bW1/gNxdE/v3+8LAgNwgFKGt4xjJgzYpx2UIPtZX0=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=gM6V/CAvDpSuCdMdJ5lu2TDdiE4ht8314JZTMFxTl/ba0WRBReFF4ebHbyPMg2cid
         uF0iKY/5rvz3q3jsbKzyMoI09SHUy3CzeG8/cpCt0GhDcry99YZljf4Ee1ddzFHW1o
         Jmz2f/Te5udILQDD87FfAanxR6RwBVEYfd6i/uH0=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=A625GWZJ1HBYL4ZXTewA:9 a=u09W0hvIdLUA:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune empty
Date:   Tue, 20 Mar 2018 10:11:12 +0000
Message-Id: <20180320101114.17663-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKvGpbgyEarOy+Bcue6/LLyNpdFoFJw7bQmnqjXkOLN7p+3/4vZB5yjRIQ+NMuEdT2b44m6L0dkKe6YXRsuGoWE7SMpxu+03lVDmZ/a0xz/1cRK5Dd7+
 duFQ7szCreUQdWZMaLYzmnBFL9DklhFZJYnmKrQJUlSP0BkoJ/01B+tlpXzcRUwcB7OM7un7gc9B7FoUZuynIVSskTBhTMjbmft1VFfLlQlx8y9Nuf7syhaD
 cXL/JuAQ6R9pDLDopWMSGvL4cuxJcg0wE5QOBHFxikQ3mQY+fqbpcwraFvbBFit8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches apply on top of js/rebase-recreate-merge. They extend
the --keep-empty fix from maint [1] to work with --recreate-merges.

[1] https://public-inbox.org/git/20180320100315.15261-3-phillip.wood@talktalk.net/T/#u

Phillip Wood (2):
  add failing test for rebase --recreate-merges --keep-empty
  rebase --recreate-merges --keep-empty: don't prune empty commits

 sequencer.c                       | 30 ++++++++++++++++--------------
 t/t3421-rebase-topology-linear.sh |  3 ++-
 2 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.16.2

