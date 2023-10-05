Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3244EE92FCB
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 22:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJEWVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWVd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 18:21:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF095
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 15:21:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1763490276.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544491; x=1697149291; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JPZH0KWmVOAuw1zYCQQJ1g4qlJduGAoPKposQs/zGMM=;
        b=O7ST6zhVRteZcR2TOryDG0uD2dqEt6wWALWU2rzd3Ya0Hgr4eaHndkRdJ46xBpkPQ2
         beYTbxnW4U9c0KCfroLsZhYdMJetiY31dyIhc9cYiKfO/MuarCqJBFT7ujYrYBtAHl+y
         NQV7imdUhSSSLZG7wr3id9bFevY8FdZb6Or2Lj827FffnCawLRuza0PdLX5e6G5Q27TU
         E+z0mgI448bLp/fDJUB9QtWPXIbdIuiXgOyBntx0WfEXV6mhfDq8abam8oSO0SdLKn/L
         pI2Dy62Gbd53xtwEptTqV9UXLskSlzYQGz3K1R603xw/EgoJkHQj6FqOfCzm95a5kxbG
         /VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544491; x=1697149291;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPZH0KWmVOAuw1zYCQQJ1g4qlJduGAoPKposQs/zGMM=;
        b=DqgrbrPEGoYd/qjLs75SJyAnAIU4kIwT70mtZiAXxc/r9popTlIQtYhtuV2bLxzDGM
         LZDBsPqqgOhdF12A3DABRyOBUoOaAIFjy3/qk/wFA9PrHAa9d0FUSK1UoqLPwKhxlHTP
         j3ubmHJ4nR+ME6uf0S8OFOBRv5PRB/R8se2RVzB6+mjozANSkbNySRjNjEO6VmseKair
         u1fSn7DBc7BFbwlh7hQMf+3/RHv55m/GTU95khv8EAy/66fsxx1HudxUO7FUcrXv7/K1
         ip8reIhfxSBOytOESa51f3KVVrz7OPs/7rpRYkq997byp4T1fjaiOr7aYDxotIa8TMCR
         Omnw==
X-Gm-Message-State: AOJu0Yx5JKOdN4iixws+kvrsuL2NNnubp1uuLJyd282ksWMTDkQAV61z
        cKJPqrEUh9eHDopmS9aXY0W35C0yRqH0mU4VJxikUr6cUAl8diw=
X-Google-Smtp-Source: AGHT+IFHhmCeBrPv8W0vSFaV3BK0wOWJLZNfVy5zxyfcxPXyoV0KlTko74Z4W+qmX/wLCHYOFJi0sCtzEHL2nt7LJe4=
X-Received: by 2002:a5b:94d:0:b0:d0d:102c:78a8 with SMTP id
 x13-20020a5b094d000000b00d0d102c78a8mr6224962ybq.31.1696544491405; Thu, 05
 Oct 2023 15:21:31 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Thu, 5 Oct 2023 23:17:56 +0100
Message-ID: <CACS=G2z24ws_HA68Ev=rssjCCorn=R4fU8LuzMsMw+8Q-PXBcQ@mail.gmail.com>
Subject: [OUTREACHY] How To Pick And Work On A Microproject
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have gone through this link
https://git.github.io/General-Microproject-Information/  and I am not
really clear with it especially this line
"Select a microproject and check that it has not yet been taken or
discussed by searching the mailing list. Public Inbox is your friend."
 On the mailing list I see messages with the [PATCH] keyword in front
of them, am I expected to pick one and reply to it? How do I reply
directly under the thread which contains the issue? Please, how do I
find the issue on the Git repository? I checked the repo and could not
find the "issues" section also .
Please HELP!!! Any explanations would be very much appreciated, as I
would prefer to start working on it as early as possible.
Thank you
