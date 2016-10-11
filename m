Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681741F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbcJKQQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:16:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:59721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753492AbcJKQQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:16:24 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MJjOu-1bst9L2DG0-001DJt; Tue, 11 Oct 2016 18:09:00
 +0200
Date:   Tue, 11 Oct 2016 18:08:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Support `git reset --stdin`
Message-ID: <cover.1476202100.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bmwXZtKGWySM3v6WOh9r6FK2jdVeUA6YUrXhpFyWBA1VOK3Lm7y
 XmYXZ0Yk4YHCQHNY0XWhLM1i0YV5NEiIfRatndYGs4bQRAporEqit97EYt9Y5WDRoLPmZDv
 igUny3zdTfNpseesOXr+cDlc7FqlYN4eYyHqXt4Aza3BLqIt3XhqWrEuWfC7V7hIdduDLlv
 ZFLZtaNUZ6t0Yllxxa44g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JwMXkO2Cgl0=:Py8BlpAGpzJ9dzhJ9Y2bJP
 6vmPdUCz6dOiUX2C4ohpua6gEmepO73OUHt6Lt1YP/OUnlcwsPQUDNqFlD2qbcjmCe+F3CSSK
 Kf+a9ZcDHi1X+mNi3nW5UtFsmaca8M4QkqrejrlCUidNpL1keQgHn0MIWB7Caz/AQD5pLwCf3
 H7DJouw0OpMnTCu/M8ud9LaOf8OjjVtYh2TCkEH6KuvaLvM7kRh95Am3tWgpGC2NNJkSbdIsn
 3OksYujNLWBOB09rRyv1ifKacT12fsKjbjjug/2oyPoiocwEcJCN/iv5PXHKNoOss1SwUTv2z
 HiEoEG0t27nNeGKdKMKunDH+b4E8HBqwYI1w/kkZ6p7jsJIPsuHHLvTLSBHjrPsmIl73nX3tP
 G2AE3gMj+ehxwUp3sNbYjOa5SXMbuzQEVodXBFYkfCAzJUId7k07A2ZTM/qSx2eWQZxTcLr8e
 tUjGDGXtpIMRcp08eKm2l71X6UyqrYDvPSYHmAMdwtFxmffd5zZM2SzUdUke1wzdEEP+5/3PV
 +KMSzptXjQfCbO9F82exKtTuHLkgbAqWcNo/WEeyUHlQvnETTdt5gLRRKgDn/XhOXitQvGc0+
 oWJJ4aYeTTflDtwYlHqWwkxALbE+pGaUmOHc+UiRy/SHNdTOizclnfsFL/boQdaI0aZ53oVX2
 iK98dLZwuSXqKzkdWRXJ+zZknqpG8MYnJNXqG8BlnZ4Mr+6SaDttcunzGom1/hAmkRWdLnV7K
 mpEHPAx5F4YyBOTw6amlgikyVNa7/l7BOw53InsRwFfzqTP0syOfw7TEHmW9tb8vOy1sHmvS6
 73MOYEn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was missing, and made it cumbersome for third-party
tools to reset a lot of paths in one go.

Support for --stdin has been added, following builtin/checkout-index.c's
example.


Johannes Schindelin (2):
  reset: fix usage
  reset: support the --stdin option

 Documentation/git-reset.txt | 10 +++++++-
 builtin/reset.c             | 56 +++++++++++++++++++++++++++++++++++++++++++--
 t/t7107-reset-stdin.sh      | 33 ++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100755 t/t7107-reset-stdin.sh


base-commit: 8a36cd87b7c85a651ab388d403629865ffa3ba0d
Published-As: https://github.com/dscho/git/releases/tag/reset-stdin-v1
Fetch-It-Via: git fetch https://github.com/dscho/git reset-stdin-v1

-- 
2.10.1.513.g00ef6dd

