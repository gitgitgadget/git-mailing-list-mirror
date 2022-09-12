Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFCECAAA1
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 05:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiILFwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILFv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 01:51:58 -0400
Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4C252A0
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 22:51:56 -0700 (PDT)
Received: from localhost (p200300ef4f07e90026418cfffe37d02a.dip0.t-ipconnect.de [IPv6:2003:ef:4f07:e900:2641:8cff:fe37:d02a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkita.de)
        by mailproxy09.manitu.net (Postfix) with ESMTPSA id C459712000BE;
        Mon, 12 Sep 2022 07:45:21 +0200 (CEST)
From:   Rene Kita <mail@rkta.de>
To:     git@vger.kernel.org
Cc:     Rene Kita <mail@rkta.de>
Subject: [PATCH 0/2] blame: Make --show-name negatable
Date:   Mon, 12 Sep 2022 07:45:13 +0200
Message-Id: <20220912054515.29559-1-mail@rkta.de>
X-Mailer: git-send-email 2.37.3.544.g5c9b9c0a4e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With -s git blame does not show author and date, but will show the file name
if the file was renamed some time in the past. With -c git blame will
not show the name, even if the file was renamed, but will show author
and date.

Working with a code base that already uses long lines and has a deep
nested directory structure the output of git blame gets hard to read due
to line wrapping.

While looking for a solution on IRC a user was so nice to gave me a
patch (and permission to submit it) that allows to disable showing of
the file name even if the file was renamed. This allows to show only the
commit id with `git blame -s --no-show-name`.

The second patch only adds this informations to the man page.


Rene Kita (1):
  blame: Document that --show-name is negatable

Øystein Walle (1):
  blame: Make --show-name negatable

 Documentation/git-blame.txt | 2 +-
 builtin/blame.c             | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.37.3.544.g5c9b9c0a4e

