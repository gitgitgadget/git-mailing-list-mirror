Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF6C28D13
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 00:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiHTAl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiHTAl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 20:41:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C0114196
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:41:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so11618882ejc.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=fQe/6+sG2cXb4VEwiBGkbi+n5AAqCwoP9tyRMPdksTo=;
        b=mcDtEe4sob2BG4jllwQS0nia1oYEIDh/VOTwaSgSrJ0oo0cV9ZoTcRZGgSUJLO1iFm
         d/cyu9r0Hdi+OZQIO1qmef4NW5EmbeeKVrnTxsq7CbXJLmmR69pK1REteXRMtaxplj0y
         DXfovS1r2FEV2VkOi4iKpchjitdMpohUi5b3Tl2vLxn+tCX0/f7vIw2ODFjTrXeigOt0
         H3PnXIQ/ACunsFMEIcFiQbooQEhXnpUj1hYpo2HbvM3bV1AU0NFgyhyFQ8txhPtMfguc
         Q9XX1590abIXHSBGU7ou2CJaXviI1YH3ItHYLDGd5SMO4/+qh9HYtc0KKKMjKzSFVD7s
         PgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=fQe/6+sG2cXb4VEwiBGkbi+n5AAqCwoP9tyRMPdksTo=;
        b=RKEK8dx+zv4GgGXt066B38xIjeSks6jFkIvHsBK7C3ttIAMa/Sr1GS1RdUKM2qODfT
         ZUaSLmik1zY6KU3tT1ebCN9wCuSgu1oQaS4gv6Svn6pUE5cZoBV2V5RmCUm8YnywZj5s
         5KWXlFiRH26PHicU9b6Kn3xZ6YPjGDnigC7jSDUwad+HPeyMQUya/bCZy9dT1qqjTd2E
         kE7hRSQKf7ctDlYWc4SrzqE08f4pskKbUcvUM0THbuzSqHA9EMgdTP62NlYIc7/qQpyR
         JZ8O5yXF9nksLXnSOcTz4opniIzbQwQ5WulFpkBnaStUAhqz6ktqWL1ylVxQYxmE2/HY
         DZ+g==
X-Gm-Message-State: ACgBeo3vcp8p9BCaNyQ7h0dqA1Kp7WepQRBW/TjnzSMjIu2TEbT7nNVq
        +QQnDj8PS8oA+Ap8xzL4VXG9HcT3U/CpTJzB1cmj1KD4cV0=
X-Google-Smtp-Source: AA6agR6UZpP+f0M4UHNtlg67jGsUmXOSL8i6BUo38auR+zAHYLiDf9xhYEhMpqxqaGhKQ7IqV/9S42/DwLymHANTVxU=
X-Received: by 2002:a17:907:94c7:b0:730:d5bc:14c with SMTP id
 dn7-20020a17090794c700b00730d5bc014cmr6529159ejc.68.1660956083104; Fri, 19
 Aug 2022 17:41:23 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 19 Aug 2022 19:41:12 -0500
Message-ID: <CAMP44s0sLdyuv1XxAu=TYMmAZgAqOQOzkRctXUsSA9NF9GY=RA@mail.gmail.com>
Subject: [ANNOUNCE] git-remote-hg 0.6
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-remote-hg is a bidirectional bridge between Git and Mercurial. It
is production-ready, has been widely tested, and was previously part
of git.git.

The big update in v0.6 is support for Python 3 since support for
Python 2 has been removed in Mercurial 6.2. Other than that there's no
difference from v0.5 which includes some minor features, bugfixes, and
performance improvements.

I've tested as far back as Mercurial 2.4 up to 6.2, all versions work
correctly, but Python 3 support seems to work only from around
Mercurial 5.3. The testing framework has been updated to test all
these versions.

https://github.com/felipec/git-remote-hg

Cheers.

-- 
Felipe Contreras
