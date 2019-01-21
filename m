Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C011F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfAUWl0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:41:26 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44165 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfAUWl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:41:26 -0500
Received: by mail-lj1-f169.google.com with SMTP id k19-v6so18833497lji.11
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ga8S+QBZstz2B7NGaGCM1qr8UOh7EbAISm8y5L7JlYo=;
        b=fGU1otcWDEsH7a4vp2HwJ41NvY82b8BIok1Hbun9mTszyzjj4UT+zK6iBDnXYjtE0Q
         56TZzaXCHLQDokzhetTvrRTzPTfCv0GL4wmJSN2CI/mUhlg3w1rlJjcw11kppRVQMPpu
         aolpUbvF3p6hKcVY+L286JpJ/GIzOemhStVMFFIWFHIKh1cxP0vGiWY8WK+vBEb1sFjH
         kUq7zY3eIyWxPOhTi17x4ir+4xmB+tVGgXZvUMexYixa+LqSxmBohQ042cA9qYIwcHgr
         yEQPAiSuAxNPafzdHpdAbQfbVTC20PsPzYaiqiIXiYBxKx/BDJjwhDofB5Akv6G7zlF9
         1eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ga8S+QBZstz2B7NGaGCM1qr8UOh7EbAISm8y5L7JlYo=;
        b=jiBnDJ8yNvs67KmQJ8yrodLflAywCk3EgO/wDZR8JO0akuygbSu3BAM4Wc7olgPBJ6
         X5zUDXGPAh8XuwP1yVsnVaMDMN0tPZbfZFKzQOBVnZuimXK3vsN0o5s2R32veVP/nFz+
         NvdPtJmukOaxu4qrGbxHViuLW5LEzq1BhJl/2kMtWUZ1Q10bomoCzKdQRSjJNLwq3Jx2
         ZyDXznomFb86Bc6X+xmNYQE4CtcE3DW34SgQAHMhtGlY1musnRAg9W7DxtKEIUgTnDeB
         og7gTzhGKrFJyeKSS1X8ITgNCaehoJBaniC2ID6XMPyTxoN7lYl+jHQ99gZ/Qr4Fpvto
         2DBg==
X-Gm-Message-State: AJcUukcbdXtDjnp2mG/vp2pNIeP/eHhVYb91j+PX3mIRquBdxjsqS8Fe
        6MWzy2b9dVUmInp9RsXUqC0rnsMvHittuFwdMBolXaYZ0HcAdg==
X-Google-Smtp-Source: ALg8bN59hJv1k4UFUJfVXNB4TcDugXje64HaBrhZswQp2tf/xv7uRUH9nkOIo539bZsOCs0pfNoIULvilkSwSU7bnmQ=
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr20596215lji.90.1548110483565;
 Mon, 21 Jan 2019 14:41:23 -0800 (PST)
MIME-Version: 1.0
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 21 Jan 2019 14:41:12 -0800
Message-ID: <CAPL8ZiuUavduLd9CAhbfavuLesm1_SDhQQjSjqtX8giaurZi+g@mail.gmail.com>
Subject: Evolve status
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just sent my current set of stable patches for the evolve command
to the list.

The code should be stable, but there's follow-up stuff I still want to do:
- Add more tests for the new code.
- Make better use of the memory pool in change-table.c (ideally, all
the memory it uses should come from the memory pool).
- Cosmetic non-functional touch-ups.

I may not have a chance to do more work on evolve for a while, and
since others have expressed an interest in helping with this work,
building on top of it, or just tinkering with metacommits - I thought
it would be good to make the code available to the community.
