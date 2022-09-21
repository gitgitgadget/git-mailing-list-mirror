Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFEECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 19:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiIUTdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIUTdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 15:33:14 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Sep 2022 12:33:13 PDT
Received: from smtp.zlima12.com (unknown [216.52.57.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE609A6A0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 12:33:13 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zlima12.com; s=dkim;
        t=1663788218; bh=gF219/mN1GR0si0E06Fsp6id8DHnHVuPMh5sjkzEZFE=;
        h=Date:From:To:Subject;
        b=mnDe1XfKU7oNb8SEodkFlyZIN9fV3qd81W29LwzJb8ShLfmpkurVDrSXCm/qz0xbr
         /vDx9IO0+Djz7wCAkBHxRcfzZHaCU2DIBB3+2hALALfBuOrjxnLp2bpkoV0Ygiu9HA
         1aSHAKRV4R3ouEZb0Se2i+JOWD+yHe0ndHTcwG+uB8lLZErjrLJ1Qzk5NRzrlKmOQ9
         yAs/nvSvzGXCJqv9Qa9JpSiwyKy27rjzOM+5C/sSuXEs5egbtSz1EfASxhbz96n66M
         e69jkeey3jKjgXuI9dtuIPg2T65bwit/z7Vi+YFpA7Lo3gndzYHiYEM2BtUxIRvFrv
         HVq+8QlggUWIQ==
From:   "John A. Leuenhagen" <john@zlima12.com>
To:     git@vger.kernel.org
Subject: fatal: options '--bare' and '--origin foo' cannot be used together
Message-ID: <20220921192333.yasrvnisccuk3ivg@Lima-X2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I often like to change the name of the remote that I clone repositories
from, as "origin" is too generic for me when I have more than one
remote.

Usually, I only remember after I clone, and wind up doing `git remote
rename origin foo`. I'd like to get in the habit of instead doing
`git clone -o foo https://link.to/foo.git`. However, when I tried doing
this with --bare, I got the error that I've made the subject of this
email. Why can't I do this?

When I try to do `git remote rename origin foo` in the bare repository
(cloned without -o foo), I get a different error:

>fatal: could not unset 'remote.foo.fetch'

However, `git config remote.foo.fetch` indicates that this value is not
set.

Why does this behavior differ from the equivalent commands on a non-bare
repository?
-- 
John
