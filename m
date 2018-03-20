Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4811F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeCTKD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:03:29 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4734 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeCTKD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:03:26 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yE6xeoWARwheayE72epmB6; Tue, 20 Mar 2018 10:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540205;
        bh=e5VMQioU1UsNsFR7X6lfRa7SrABcUEJ8+m0Xg7zrUFI=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=WcEUyIUMdcWdf3wZtRGRMMgP619UGkExJx0QUdF6bkL/BGoEMeJ/K0hZ0oOf80KWO
         OuiIx5laR2k4aAG/rVJeciB3QCXwMI89Lmixkj7h/8LqpsTZV85dWM7+w5skSmiyuJ
         lc7g+eWeb4J7VUm4FQSO40NqAAXL3BBLtEo0C0Vk=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=NXCXV-Yt3sXCTe_Q5gMA:9 a=u09W0hvIdLUA:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] rebase --keep-empty/--root fixes
Date:   Tue, 20 Mar 2018 10:03:12 +0000
Message-Id: <20180320100315.15261-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKpbV2abLDDUnnR2qMMKfs9GD9A4DfE6+Il3g+p43Fd3/+LouYslK7Rn9jUb1qG3HTxJqui4tjDPGjs8ny0OCmVMjNACZmb+tsAbaT6kxeLtX5Wt4zXb
 LxqHTFXTdulB8E8U92xW0fVMN8u/NDCbWLWJcakTq1pKUjZQba1jZP/x9o/zURFRDJt9+RjN1RO6dAyMmYx2k/jyYZd0QUi+oQrKqE81ZZrA4wUtjcY1TaxO
 7TD2F8KLGbqYp8WrNbX9TJQWg03bjgihED0MuEjK5EHIn/Gf1dRU/ro1iD2aEcr+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches are based on top of maint. The first two are a reworking
of "[PATCH 2/2] rebase --root -k: fix when root commit is empty" [1]

[1] https://public-inbox.org/git/20180314111127.14217-2-phillip.wood@talktalk.net/

Phillip Wood (3):
  rebase --root: stop assuming squash_onto is unset
  rebase -i --keep-empty: don't prune empty commits
  rebase: respect --no-keep-empty

 git-rebase.sh                     |  4 ++++
 sequencer.c                       | 18 +++++++++++-------
 t/t3421-rebase-topology-linear.sh |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.16.2

