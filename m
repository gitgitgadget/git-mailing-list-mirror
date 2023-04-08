Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEFFC7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 18:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDHSAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHSAb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 14:00:31 -0400
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9FC976B
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 11:00:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
        by forward206c.mail.yandex.net (Yandex) with ESMTP id 84C2F600FA
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 21:00:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Q0XliphWkW20-zgAc5ttD;
        Sat, 08 Apr 2023 21:00:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680976828;
        bh=yOnfKD4cYJZy1qPWKs9SNa3hsLdlU9YXo55bbY6ls50=;
        h=Message-ID:Subject:To:From:Date;
        b=Y1LfUorW9jOOfRZ0Q4E4NuWGKvrB2mCQurrhJXOx+0g9/UXhwdm+R6PnkTtrgEHi+
         umZtgdqWDqgwBWkUMPV3xBxQIgmgXqpAQu4SBYDOxQS4v2D5CCX9vvncmFUGQVdvpV
         MU0Ge+mXmPgm7deF1jwbW3vSaqveedY5nHMlVs1U=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date:   Sat, 8 Apr 2023 14:00:25 -0400
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1895713690.20230408140025@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git rebase does not rebase commits
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git team,

If I am trying to rebase commits from one unrelated history to another but this does not work.
Example:
* Merge
|\
| *x1 (test)
| *x2
*y1 (upstream)
*y2

git rebase --onto upstream upstream test

The TODO
label onto

# Branch openapi3-exception-handling
reset [new root]
pick x1
pick x2

I think problem is here because 'test' branch does not have fork point with 'upstream'

Expected:
label onto

# Branch openapi3-exception-handling
reset upstream
pick x1
pick x2

Is this a bug or I did something wrong or missed some options?



-- 
Best regards,
Eugen Konkov

