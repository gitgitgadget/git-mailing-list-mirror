Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B6C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiLVR4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLVRz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:55:57 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8527B0C
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:55:56 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id o127so2844255yba.5
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PN6UU2AMwwevlzYkTX80A0GpWhVmWZzy4EFvwIyWRn0=;
        b=HSQ+Nrg1sRK196Ork2LpJgEvOghxowv0OzQ8uY0oBo3iD//FBrVJnIoLlydmfp27i/
         /oVAdx3zCwlOJsT4PvVCRrv2/VGWPUJsNTslTSmFf4Sl+N9qKy1wLbGOAavv6SXSLlVs
         My3nc7dwhDzXKKfKqbRs/fD3s9SIe34uHY7YNkO2QTJP+Qx73hIOQ8Fycsk+FuYxMgvR
         a7wmCblIEtZ8IFxsLlV3O7aFQM2tmapBzDXliAUDeD19uUMrmYVQwnnDcHBZX+erV/FH
         55+X1xe2snE3TLGhEm06XA2lBEXd8NDAb64lyJ8bt6qop4HJZ6UxE7Ptm6xp+qoNPvvp
         JAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PN6UU2AMwwevlzYkTX80A0GpWhVmWZzy4EFvwIyWRn0=;
        b=R6khBKwxfI4sFAFXkFeAVbmVfoUmFX6Bvf4wUOcXNDlCdfB43uRTfKqkHoeRwDAP90
         j953WaP+vMc12eSvJe65vBR/6ceEmDW77JZ8j9cLjxDKPyMtXpA2qIxB89R5cLmOB4jn
         sl8AcarljeCZU+SJKbC+fm46STLWU4ntTwOwIE8OGuP3b7Dnk68Plm6ObxbVHX9+3up6
         bx7eUJevR1WP3O0W+D5kCeZpSr0YnUqqr5/9/SY/SbzsJECoZ/hY8Rdbgq/uLeBieYcZ
         DrPkRvQkbRpComy4fVipO4Cru+ysG0QfFgrITJ/BRZGvGU71lYd7de+m4OsLVg610gNn
         6hPg==
X-Gm-Message-State: AFqh2krBQdTtiU9PCWpp610waekr61gQ60ESReVEPb0Cy/BwjE91dLXQ
        MP/anT/UbTfUc64TQGHG/uZX46FZTAstGwRRmeG205akRh5frA==
X-Google-Smtp-Source: AMrXdXumXJhOsbDjmpV48qxf2gsIixsfNOiKAmXRp0jMfEwofxLf+BJdrCDsyYy3OS84vJnqATdFr1xT7uVVyoGb9J4=
X-Received: by 2002:a25:6d02:0:b0:6f7:9002:d8f9 with SMTP id
 i2-20020a256d02000000b006f79002d8f9mr602028ybc.203.1671731755269; Thu, 22 Dec
 2022 09:55:55 -0800 (PST)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Thu, 22 Dec 2022 20:55:43 +0300
Message-ID: <CA+PPyiHtPsRwqMmr6annuuqzeUEf+7pFUSbnXdThjNNVtxFCGw@mail.gmail.com>
Subject: GitHub actions are failing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi
So I have been working in the signature atom patches. I have been
testing my commits on my fork. However, the actions are failing.
One of the errors is

-------------
E: Package 'gcc-8' has no installation candidate
+ end_group
+ test -n ''
+ return 0
Error: Process completed with exit code 100.
-------------

I would like to have any help, my branch is
https://github.com/nsengiyumva-wilberforce/git/commits/signature5

Best Regards
Wilberforce
