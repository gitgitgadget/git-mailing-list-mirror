Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D6C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 12:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhLPMGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:06:12 -0500
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:59814 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234285AbhLPMGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 07:06:08 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 07:06:08 EST
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:69ff:d346:3fb6:6239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id B00FC5754BC;
        Thu, 16 Dec 2021 12:57:08 +0100 (CET)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1639655828; bh=rgVPMu5LbXmiby0lKZC4QLpLBhS6n5bDg5sHcGYyO8o=;
        h=From:To:Cc:Subject:Date;
        b=VzeMR+uOWcn7g9gAO0o+/81vEmsHsqmqEtziYh2jzuwEWJ70GdxPfQsCNbP/0xFd1
         7EwmAEgVvUCc+ufKGTils3oogVIGqxVX/AtxE3iCV/QnxjthkkxgAU+H8VZEuzFc59
         R6ZmTWQcYmqlDdEKUGhwtn68vxS3Zsnm9S95CqEI=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH 0/1] grep: align default colors with GNU grep ones
Date:   Thu, 16 Dec 2021 12:56:21 +0100
Message-Id: <20211216115622.85506-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep shares a lot of options with the standard grep tool.
Like GNU grep, it has coloring options to highlight the matching text.
And like it, it has options to customize the various colored parts.

This patch updates the default git-grep colors to make them match the
GNU grep default ones [1].

It was possible to get the same result by setting the various `color.grep.<slot>`
options, but this patch makes `git grep --color` share the same color scheme as
`grep --color` by default without any user configuration.

[1] https://www.man7.org/linux/man-pages/man1/grep.1.html#ENVIRONMENT

Lénaïc Huard (1):
  grep: align default colors with GNU grep ones

 grep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

