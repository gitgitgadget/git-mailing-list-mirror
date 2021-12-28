Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A611BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhL1Xlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhL1Xli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:41:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD1C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:41:38 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v15so33223458ljc.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=cR3brSuZSlbHYNpGk5Z2pL3OGSndPBPV/pTt7OQ18l4=;
        b=PtUedBW2JnPppTKeif5Zye1szPbL8mrlE/OfguOXt82qWy4SlLYM9i/Am7ki2659Du
         u7JE8EIh/ZY9PUX+p69Q5H4en1PTdD5/ei+sQvgC/18dEmr4+esjuKVPGYB9z6xNLt/g
         G2PAsm5kv0m4xzTEUAOVots4qndhoqVN8S3ZcceL58ufEWY89WpDkMzcP6k2ckUHs04O
         WNkjbrF/VIYtb+AvmhGMA76/kL1H4RSBRAAy5dURmcMuFP1FQFXa7kAQAAiVAXHC7wAx
         p0XMHCU87LGuRKNDFf70+xv35PFrSI0KYEYZ/rswuGOOGNXBWkj/A8/vovQ7cr1IkGYZ
         k0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cR3brSuZSlbHYNpGk5Z2pL3OGSndPBPV/pTt7OQ18l4=;
        b=BBsXfVk1PvlsPoo07A2OFECQ7Q3j5cNFagMx0kDSc1ewzv4kUA8JFT/K56c/x2kzp8
         o/E6C9yoOYttlSfk6l/BeMDL3T2QoZCemFpqS5UvqNzQHji5bDE9nub/AUii8Q2HJIDY
         /sFz9Pf5zPzIQXh57vYSyVbWt9M3LefNFAG7nQSUX6sK/vVk4FcYiG31P7lmSPlc9lJ8
         lnbf9AYDRPCm15FDo8y2URMh6nEB4TOnanypf0Bo3Yq/3tjUiV8XroJxeQ92qlJSZ63i
         4YZLjJDe2t+w3QfMaokHH3DJYb4Gb49yuK8bDIgzdhvnDLwRErHzbeSyauV3M7Y6dq73
         8vgQ==
X-Gm-Message-State: AOAM532ExlvR12Cqza3WxJdQ+NrYXbxwL95byElC4RfizMCeef6pblky
        KMre1manS2caJHfFMNrgnH3KVMxDaenlTM1YRPx3pnpr
X-Google-Smtp-Source: ABdhPJy+HdahvlcCHjZ4f0gl/X0A4lbIF6zAjfbNLBAd3/LN5BjwCZSpz9lu3hS65RwsbcyCKvoyI0RPhFCsD+nJ/Og=
X-Received: by 2002:a2e:900a:: with SMTP id h10mr10377998ljg.409.1640734896193;
 Tue, 28 Dec 2021 15:41:36 -0800 (PST)
MIME-Version: 1.0
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Tue, 28 Dec 2021 14:41:24 -0900
Message-ID: <CAC4O8c-2sxHyAjtd4jZQcjzX4d9+19AUx-h13nttjwP=pd1Ukw@mail.gmail.com>
Subject: something like git-check-ignore but considering only patterns?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to query if a file e.g. symLinkToDir/foo.o would be ignored
if it were in a real dir instead (don't ask) but in a general way and
hopefully without parsing and matching all the .gitignore entries
myself.  Is it possible?

Thanks,
Britton
