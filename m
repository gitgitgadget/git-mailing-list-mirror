Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B079C7618D
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjDEXVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDEXVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 19:21:33 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 16:21:32 PDT
Received: from forward102j.mail.yandex.net (forward102j.mail.yandex.net [5.45.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B55251
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 16:21:32 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 159FB4BE5ECC
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 02:16:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:8212:0:640:cefe:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id E6493600E0
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 02:16:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2GZL5JEWu8c0-BbuRO9Jo;
        Thu, 06 Apr 2023 02:16:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680736564;
        bh=KiYkbE46zpoyMxJpCgiNbBJCyDwYkrEhTubDrRAhdRg=;
        h=Message-ID:Subject:To:From:Date;
        b=rOdUNES3UHZzOHnR0FZShZtH/WNGcHCEoSMs4p7MGLeecTssoQWhOGoy61xUxOa8q
         g7QIm5uNyEQ4alHQzJS3G0f0N8k2Trud0kr6Dj9cHgPkG9pxLX0TJguUBprgYFACop
         qRyIVA1Pt0nLvgyzeq3nHIwt7jxrEs3wEjOmy51Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date:   Wed, 5 Apr 2023 19:16:02 -0400
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <909508822.20230405191602@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Can see log for a renamed file
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, folks.

```
git log 9ce3e165f284d55503eff9b627ef3723854c53bb^ -- lib/Invoice/Schema/Result/Company.pm
fatal: ambiguous argument 'lib/Invoice/Schema/Result/Company.pm': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
```

But if I checkout to the commit before renaming then this command works:

git log 9ce3e165f284d55503eff9b627ef3723854c53bb^ -- lib/Invoice/Schema/Result/Company.pm

I beleive it would be much handy if git checks the file after analizing of the commit 9ce3e165f284d55503eff9b627ef3723854c53bb^

Thanks
-- 
Best regards,
Eugen Konkov

