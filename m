Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF9CC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiITIA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiITIAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:00:17 -0400
X-Greylist: delayed 1473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 00:59:56 PDT
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D925EB
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 00:59:53 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc10b.ko.seznam.cz (email-smtpc10b.ko.seznam.cz [10.53.14.45])
        id 430e4ea9064747da426600c5;
        Tue, 20 Sep 2022 09:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=beta;
        t=1663660782; bh=1pw86rodjswi/JZBqfMPVztYtFKYmbneLW/t/r0274U=;
        h=Received:From:To:References:In-Reply-To:Subject:Date:Message-ID:
         MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
         Content-Language:Thread-Index;
        b=GlhvE+KB1QuVoyhVFOxvZk9ryrxnWRM7uczrbsRZOia5xxBI+nPk/6N+WN7FdxND3
         l0xjh4cRLVjqg+riz3CIO0AIEVdq7dacSfoxL58u0/9kv5Mp3dI5VSOobf/HcUC/1p
         ATEbuQtMrIF8uGc+usyz/AKaVrPnmPoha30YS/4w=
Received: from DESKTOPA7EP53H (tlapnet-195-106.cust.tlapnet.cz [45.153.195.106])
        by email-relay19.ko.seznam.cz (Seznam SMTPD 1.3.137) with ESMTP;
        Tue, 20 Sep 2022 09:59:39 +0200 (CEST)  
From:   "Jan Tosovsky" <j.tosovsky@email.cz>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Preserving credentials on authentication failures
Date:   Tue, 20 Sep 2022 09:59:38 +0200
Message-ID: <007401d8ccc6$ef8ebe50$ceac3af0$@email.cz>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: cs
Thread-Index: AdjMwGQQ8CDtJBNhRY+DXQWT9PD2HwABmVcw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my local Windows machine I maintain a credential store in the form of a
text file. But from time to time one of the entries disappears. I run
regularly some background jobs, cloning some stuff, and I suspect this
happens when the external authentication service is down temporarily. When
it is later resumed, I can't clone the repo anymore because of that deleted
entry.

Is there any option to keep entries on authentication failures? Or is this
simply a bug? Or is there another reason why this happens?

Git 2.35.1.windows.2

Thanks, Jan

