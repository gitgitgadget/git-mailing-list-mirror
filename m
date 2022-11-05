Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE074C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKEPyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEPyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 11:54:13 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Nov 2022 08:54:11 PDT
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9AE0DC
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 08:54:11 -0700 (PDT)
Received: from desktop (unknown [211.86.152.151])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id D21028000A3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 23:46:01 +0800 (CST)
Date:   Sat, 5 Nov 2022 23:46:00 +0800
From:   Wu Zhenyu <wuzhenyu@ustc.edu>
To:     git@vger.kernel.org
Subject: Can git send-email support neomutt?
Message-ID: <20221105154600.hbrqs74inmvpebie@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxlIVk0ZGEtKQ0NJTENPHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVDTVVKTklVSk5KWVdZFhoPEhUdFFlBWU9LSFVKSk5IQkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46LBw5CT0oVlEwLjEsET81
        PFYaCy5VSlVKTU1MTU1ISk1JSE9MVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
        VUNNVUpOSVVKTkpZV1kIAVlBSktJSjcG
X-HM-Tid: 0a8448786a13b03akuuud21028000a3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excuse me.

I want to use neomutt as git send-email's cmd:

```
[sendemail]
	sendmailCmd = neomutt
```

However, I notice

```
my @sendmail_parameters = ('-i', @recipients);
...
exec ("sh", "-c", "$sendmail_cmd \"\$@\"", "-", @sendmail_parameters)
```

It call `neomutt -i to@email from@email`, which is an incorrect cmd for neomutt.

Can we customize sendmail-cmd more flexible? Like

```
[sendemail]
	sendmailCmd = neomutt %{to}
```

call `neomutt to@email.com`.

Thanks!

-- 
Best Regards
Wu Zhenyu
