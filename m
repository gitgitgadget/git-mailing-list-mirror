Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45346C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiGZNBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiGZNBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:01:36 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 06:01:34 PDT
Received: from forward102p.mail.yandex.net (forward102p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509713E94
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:01:34 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id BDB8839409BE
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 15:54:48 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net (vla3-23c3b031fed5.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2582:0:640:23c3:b031])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id BBB3F13E80002
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 15:54:48 +0300 (MSK)
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id RBZ9awRsTl-smhmXAxO;
        Tue, 26 Jul 2022 15:54:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1658840088;
        bh=YYn/K4q2uwegvptmrid7+WJP1/skH2fOO5lAB573OBk=;
        h=Message-ID:Subject:To:From:Date;
        b=kYrZYvFNpdTM+ninIf/mSSRbI7uMg5yhDIJ3F2pdMpfVNmBH/L7WUBpeX+gsvI3ng
         mJjXHdQAd3QJN5are8bFp1Q1/1In3YOHcV1dDeZsVZFTjubN9ynq9nRrcAAMwxF+vG
         a4cNKE6BSFe1G/xdKFyJ+wkye7yYEX0wWgLf4bg0=
Authentication-Results: vla3-23c3b031fed5.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Date:   Tue, 26 Jul 2022 14:54:47 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1196830250.20220726145447@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: --creation-factor=100 does not show code
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git range-diff --creation-factor=100 branch...origin/branch
1:  a87daecd47 < -:  ---------- Add mocked exchanges for ...::AutoRenew::General test
-:  ---------- > 1:  36eaeb56a9 Add mocked exchanges for ...::AutoRenew::General test
2:  9594ccf145 = 2:  70681dd13b Remove a call to DB::state
3:  740903e01c = 3:  5745ae5702 Run cpanm without tests
4:  e8e6cac09c < -:  ---------- Do not use 'require'

--creation-factor=101 does =)

but maximum value for percentage is 100. So expected behaviour is to display range-diff when value 100 was provided
-- 
Best regards,
Eugen Konkov

