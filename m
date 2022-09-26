Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C372EC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiIZJG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiIZJGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:06:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47CA1B7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:05:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84369220D8
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664183158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=LNtAwaeIoAtnWhAiZ1SZpwaWO0uOIPR640FhKBoOWM0=;
        b=QkM3dEsewlk6wk1jQXSZWXaeEwuHhyneaHyyTqbJPzIRbJyHPi3LRs/HSS8/iZlD5aUsH1
        db5tysALSHyBoEdyCtjBaRBZLt5ETLeGxmRD7TkhG+hKSGGYbJmPd7Onq8UmQEzUUsiTOe
        czmYw77PiDaE87l1wP+z2eI92ENCd74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664183158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=LNtAwaeIoAtnWhAiZ1SZpwaWO0uOIPR640FhKBoOWM0=;
        b=Q2FC1rjO1PADKJ+9WDrIsCjbGmI32Nf9KHreQ4S8olBSgH6sXK3qGsQELci+F6nkovPHKt
        XIYMAa3BgSU6dvBw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 7EAD12C186
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:05:58 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 46C65440202; Mon, 26 Sep 2022 11:05:58 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     git@vger.kernel.org
Subject: [PATCH] receive.txt: Describe effect of denyDeleteCurrent on bare
 repositories
X-Yow:  Okay, BARBRA STREISAND, I recognize you now!!  Also EFREM ZIMBALIST,
 JUNIOR!!  And BEAUMONT NEWHALL!!  Everybody into th' BATHROOM!
Date:   Mon, 26 Sep 2022 11:05:58 +0200
Message-ID: <mvmmtammrnt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The receive.denyDeleteCurrent config option not only affects non-bare
repositories, but also the default branch of a bare repository.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 Documentation/config/receive.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 85d5b5a3d2..07db745cd4 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -80,7 +80,8 @@ receive.denyDeletes::
 
 receive.denyDeleteCurrent::
 	If set to true, git-receive-pack will deny a ref update that
-	deletes the currently checked out branch of a non-bare repository.
+	deletes the currently checked out branch of a non-bare repository,
+	or the default branch of a bare repository.
 
 receive.denyCurrentBranch::
 	If set to true or "refuse", git-receive-pack will deny a ref update
-- 
2.37.3


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
