Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85861ECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ3S43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3S42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:56:28 -0400
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B19FC8
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:56:25 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id pDTqo5fqYHeg9pDTqohaAw; Sun, 30 Oct 2022 18:56:23 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=EtysUhUA c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=3nsOOYR-AAAA:8
 a=ybZZDoGAAAAA:8 a=yrdrY3HJwSXUtU4GdPsA:9 a=AjGcO6oz07-iQ99wixmX:22
 a=X8_4EP2Luv2hi8NvPz5g:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH 0/1] extend the truncating pretty formats
Date:   Sun, 30 Oct 2022 18:56:13 +0000
Message-Id: <20221030185614.3842-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE+67jpJg/+O/FgPkOOfpNchzjfXv7Ozpe3KEW2ZokN4TK1xpaCUbVpnbRltvZZL8Bi4E3rraZrDwvdI2IhEgw64jia0pdjUa+j2qM3KOdkUsGYzidYS
 5NCWHhdgFyhI6w7Oi/ZbFcNNE3yQDKsryV7f06DJNrATO//GOSEImMp5USnDhRtLrJYQgNhjsJlzvOgqqe5cLtHA/7mUjSzIiw0FCIJkvQ7U/BhPnF53kZvY
 yXH9PXRup7mbi9mW64Gmkzygn+ZXRbbs8XXj/+1fM8LZqZv01DWFr6fWpwpE8q70et7FEzuErDjNFuBDMKiA3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent enquiry on the Git-Users list asked for horizontal log graphs
similar to those used in the manual ASCII art graphs. These use single
or double character short strings for commits.

The existing pretty pretty-formats are unable to truncate to single or
double characters because of their use of ellipsis `..`. As a starter,
let's add left and right hard truncation options to the existing
options as a preparatory step for potential `--horizontal` graphs.

It is noted that the  truncation options do not have any tests yet.

Also cc'ing Nsengiyumva who has proposed to look at unifying the 
ref-filter and --pretty formats [1]

--
Philip

To: Git List <git@vger.kernel.org>
Cc: NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>


[1] https://lore.kernel.org/git/CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com/

Philip Oakley (1):
  pretty-formats: add hard truncation, without ellipsis, options

 Documentation/pretty-formats.txt |  7 ++++---
 pretty.c                         | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.38.1.281.g83ef3ded8d

