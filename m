Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84779208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbdHOME2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51109 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751654AbdHOME1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6050AEAB;
        Tue, 15 Aug 2017 12:04:25 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Andreas Stieger <astieger@suse.com>
Subject: [PATCH v2 0/2] Allow building with the external sha1dc library
Date:   Tue, 15 Aug 2017 14:04:15 +0200
Message-Id: <20170815120417.31616-1-tiwai@suse.de>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is the second attempt to allow linking with the external sha1dc
shlib.  Now I split to two patches: one for cleaning up of sha1dc
plumbing codes, and another for adding the option to link with the
external sha1dc lib.

Other changes from v1:
- Plumbing codes for external lib are also merged commonly in
  sha1dc_git.[ch]
- Check the conflict of extlib vs submodule
- Drop DC_SHA1_LINK, hoping that everyone is well-mannered
- Minor rephrasing / corrections of texts


thanks,

Takashi

===

Takashi Iwai (2):
  sha1dc: Build git plumbing code more explicitly
  sha1dc: Allow building with the external sha1dc library

 Makefile     | 18 +++++++++++++++---
 hash.h       |  6 +-----
 sha1dc_git.c | 18 ++++++++++++++++--
 sha1dc_git.h | 28 ++++++++++++++++------------
 4 files changed, 48 insertions(+), 22 deletions(-)

-- 
2.14.1

