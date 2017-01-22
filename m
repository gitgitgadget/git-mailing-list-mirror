Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3EB20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdAVTxK (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:10627 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAVTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VOCIcRFMZHGLwVOCIca3TB; Sun, 22 Jan 2017 19:53:08 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=5rxgeBVgAAAA:8 a=NEAV23lmAAAA:8
 a=ybZZDoGAAAAA:8 a=FP58Ms26AAAA:8 a=BCjA09oAAAAA:8 a=pGLkceISAAAA:8
 a=2hce0ESXTirCVrHDDTAA:9 a=ezPG0ZpnnpEA:10 a=PwKx63F5tFurRwaNxrlG:22
 a=Bn2pgwyD2vrAyMmN8A2t:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6LVbBl2NLSWPyIBDCKCu:22
 a=jYKBPJSq9nmHKCndOPe9:22 a=6kGIvZw6iX1k4Y-7sg4_:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alexey Astakhov <asstv7@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/4] git gui: allow for a long recentrepo list
Date:   Sun, 22 Jan 2017 19:52:57 +0000
Message-Id: <20170122195301.1784-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
X-CMAE-Envelope: MS4wfHcCY32gOz322x4H+mlPFThsn+7IqxU03m1vvwZSOvhgzwQ5t40fP+R3Beh9JRSggt0ZmRB1qGP+XXfl8ZQHMZcsZFp9mNCeMXmA7fg7vFuwxmrZ2HrI
 AGbAZzZ80M5RsXSnVOlnsEu2lcVrdfEGC6Wz7dxvbkrxy/FPti9voggtQnP0qFDs3uFQJEsrhiTnbfTDNS1lossa9lE+uJcdzsGi6+RfSWQlF+IYGEiWrueT
 rfxcsX8J6Dbox4LGNMAcjhH6epHaCkIemdLF+KKa1tCGpaAq9WD0My5rpErB48djSjAkEsnARcrjpIfuAOTYEYmW1WqMntljYdyn8bj1S/xGJzRxaGGEBaBF
 ITcbK4YwloF4T+wIshfkXEEu3A/MwiNczoN08RcBeeWDcSptlQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Way back in December 2015 I made a couple of attempts to patch up
the git-gui's recentrepo list in the face of duplicate entries in
the .gitconfig

The series end at http://public-inbox.org/git/9731888BD4C348F5BFC82FA96D978034@PhilipOakley/

A similar problem was reported recently on the Git for Windows list
https://github.com/git-for-windows/git/issues/1014 were a full
recentrepo list also stopped the gui working.

This series applies to Pat Thoyt's upstream Github repo as a merge
ready Pull Request https://github.com/patthoyts/git-gui/pull/10.
Hence if applied here it should be into the sub-tree git/git-gui.

I believe I've covered the points raised by Junio in the last review
and allowed for cases where the recentrepo list is now longer than the
maximum (which can be configured, both up and down).

I've cc'd just the cover letter to those involved previously, rather
than the series to avoid spamming.

There are various other low hanging fruit that the eager could look at
which are detailed at the end of the GfW/issues/104 referenced above.

Philip Oakley (4):
  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
  git gui: cope with duplicates in _get_recentrepo
  git gui: de-dup selected repo from recentrepo history
  git gui: allow for a long recentrepo list

 lib/choose_repository.tcl | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.9.0.windows.1.323.g0305acf
---
cc: Junio C Hamano <gitster@pobox.com>
cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
cc: Eric Sunshine <sunshine@sunshineco.com>,
cc: Alexey Astakhov <asstv7@gmail.com>
cc: Johannes Schindelin <johannes.schindelin@gmx.de>

