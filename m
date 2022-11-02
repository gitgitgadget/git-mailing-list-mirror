Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9DC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 23:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBXyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKBXym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 19:54:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CF26F7
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 16:54:39 -0700 (PDT)
Received: (Authenticated sender: amy@amyspark.me)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F8F0C0005;
        Wed,  2 Nov 2022 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
        t=1667433278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3GEniI8VzfRN9YGPvvIcZMoLZ2BhEMuzIiuBiwh9zrE=;
        b=K/OJ6b6svEZZZgRjFKQQjenomf0bIbIYTNOrNrfT2WapEpTA1Hfl3m780a25PmUMd0Eaw8
        OxLTsXUE3hm0mOuFWk/5UUk9TZ9HVCOeWoNGktakTx0lMtEo7a8evlnt2n8FtI94ahkeiH
        h7stwFTN7T/Q40zZjnjyQI0AK/jbAkgOjKEmMTlDGw3gLIS1pytI+pffIUzBqXsoyDthrs
        CkapwlJ9Fev+rXvYqKHR6h484cGRD6MHMbCpKDMEYcGD20kPs7dWq6g5uEzZcdQnz1CN5F
        HQL+7Vr0Gc1gK1NBBLtI2C2Wwehgle6kNQqDalTj395Ru6+cSMZsA/yU9CRZWw==
Message-ID: <cb90779b-edb0-1911-c8bd-a6c56203a201@amyspark.me>
Date:   Wed, 2 Nov 2022 20:54:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   "L. E. Segovia" <amy@amyspark.me>
Subject: [BUG] git format-patch incorrectly follows the mailmap when used with
 --cover-letter
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Issued git format-patch -M master -o patches/ --cover-letter inside a
given repository (hereafter "current repository").

What did you expect to happen? (Expected behavior)

The cover letter should have tallied my commits and associate them with
the current repository's user.name value.

What happened instead? (Actual behavior)

The cover letter follows my active mailmap and applies it when tallying
the commits. There is no way to tell it not to.

What's different between what you expected and what actually happened?

git format-patch is not consistent in applying authorship values. The
cover letter uses user.* to construct the From: line, which is correct;
but the authorship stats instead follow the mailmap.

Anything else you want to add:

To reproduce, set in your global .mailmap an entry remapping the
current repository's user.email value to a different author name than what is
stored in the repository's user.name. Then issue the git format-patch
line as described above.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Thu Sep 29 20:15:11 PDT 2022; root:xnu-7195.141.42~1/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.30)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/fish


[Enabled Hooks]

-- 
amyspark 🌸 https://www.amyspark.me
