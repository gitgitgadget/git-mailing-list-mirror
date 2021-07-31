Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A06C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFF160FE7
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhGaIxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:53:46 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:53985 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232211AbhGaIxq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 31 Jul 2021 04:53:46 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 04:53:46 EDT
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 935843C003E1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 11:46:17 +0300 (MSK)
Received: from vla1-4e4ee944ff6b.qloud-c.yandex.net (vla1-4e4ee944ff6b.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3192:0:640:4e4e:e944])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 8E961CF40002
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 11:46:17 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla1-4e4ee944ff6b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id hwOxVcr9al-kHIimnwi;
        Sat, 31 Jul 2021 11:46:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1627721177;
        bh=iSCSXTE77Eajb3frAEeAUq7AhP+32JzJYjXWKST+fKM=;
        h=Subject:To:Message-ID:From:Date;
        b=GsBLWctEdmLxbgYLPYBsH25YMuNSe/NbdRoE+0OpR6KfmwBhkA4nFsBeidIaENxK+
         6XZLtpC17KmYVgzHgCR1aPjS0cY0VdDDI9Y2ZW2x8MKQwWBT83LSh53OYKKu+loWbK
         jY+6LRjmF50i9ngtL50YKAoirNsuojTfKpBJ39eo=
Authentication-Results: vla1-4e4ee944ff6b.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id FPl2APYqgN-kHYWdBgn;
        Sat, 31 Jul 2021 11:46:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Sat, 31 Jul 2021 11:46:16 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <644619140.20210731114616@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Ambigious messages
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git checkout 51c7d41b82b5b
error: Your local changes to the following files would be overwritten by checkout:
       lib/Mojo/IOLoop/Stream.pm
Please commit your changes or stash them before you switch branches.
Aborting
$ git checkout lib/Mojo/IOLoop/Stream.pm
error: pathspec 'lib/Mojo/IOLoop/Stream.pm' did not match any file(s) known to git

$ git add lib/Mojo/IOLoop/Stream.pm
The following pathspecs didn't match any eligible path, but they do match index
entries outside the current sparse checkout:
lib/Mojo/IOLoop/Stream.pm
hint: Disable or modify the sparsity rules if you intend to update such entries.
hint: Disable this message with "git config advice.updateSparsePath false"

$ git --version
git version 2.32.0

Here I do not understand how to checkout to different commit
or how to commit the subject file

It would be nice to show hint about how to exlude this file from unindex


--
Best regards,
Eugen Konkov

