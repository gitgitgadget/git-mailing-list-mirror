Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B298EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 05:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHIFMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 01:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHIFMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 01:12:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103711BCE
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 22:12:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3c78ede4bso5001173b6e.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691557960; x=1692162760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utVrhDyDhknONQ77OpnDS/nE2FC8j8KjAXlDp+2PfRc=;
        b=jnv4XO01BwaCDNz8wWLQRHsaYlDjrvalT1nfctBmhDSQzsWamzcktjmKMfrM8kkbSZ
         AvqTx5PQAMAwGYIWcH1qo1NLGdFHAYyHDdFJzM5YXppPdWRai5rJGZhMA0FB5EZ+r0PJ
         rK2dDczpLe+DhsCrttdicGw4Z7kI8PpgdvPDE6U1kAKuboEvbcD9QKhnKGyCcdYGDQOi
         X6Apdv+7vO2ctCEmcgUkHGOEW5E//fvyZya+Mr7KZtHd4nuoMY+Hw7/o9wdjwMVK9sxL
         rx3z1JOb25A1KFlNSrCXzKZlcHGC+VEqwwhlVyQJPd2CkpV3Xbb6mYo29wxqLw2Y83Km
         c2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691557960; x=1692162760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utVrhDyDhknONQ77OpnDS/nE2FC8j8KjAXlDp+2PfRc=;
        b=CBG7FDH/2usuMvh3SBGfjuN4cxwvfuJJYbqnoaXWC80tBXFEEW4PIVd5KhO7A/z9y2
         ZsCDRNdwV2o5Ac5QcKgwLh2oWP8csgKOtEXLBlEjwhDaY+6NJ8ifeoDwZ+xm3k1eI+gd
         sMg+s4QtrHE8W2jXwEVtRc2ocSvQwxrSdlNzdOaPxL7H+EIISbe3irFNwGRaAhYTK7ht
         aUXMal3YDUybZcTAmSx7mvDmpUiCL9l/L/DqHM61ca9vKXeAF7Z8MaF2OYDG2KeIXXjT
         j3QqqufzE9L0v5VdCtbl++94G9wuKdhkP+Y6qHSm6A32oTUiKhqy53tjJwTHdnbzELa8
         E8Mg==
X-Gm-Message-State: AOJu0Yx0Ua4BTgdTH+4EPhM9MTHFQ6vDr0oqsIqr0IMzm14qE/e0buRx
        tFiJXRJnrYVO06l8Jv+w9KlrGWzGIiS68J5Dxck=
X-Google-Smtp-Source: AGHT+IF7AV43hXROV6MwgKr9pzy3lt3+9dbm1jsbUBIG1QFiwcuZQHC77ybTDoQE6v7Cr65BNgA0f4ympVJuSCjrEWA=
X-Received: by 2002:a05:6808:1a03:b0:3a7:458e:3df4 with SMTP id
 bk3-20020a0568081a0300b003a7458e3df4mr2003782oib.56.1691557960189; Tue, 08
 Aug 2023 22:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <TXJgqLzlM6oCfTXKSqrSBk@txt.att.net>
In-Reply-To: <TXJgqLzlM6oCfTXKSqrSBk@txt.att.net>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 9 Aug 2023 07:12:27 +0200
Message-ID: <CADo9pHh3DufUXB5atqSJ76DQUn9au-eo1M8Va=g4d4DSsufUvQ@mail.gmail.com>
Subject: Re:
To:     5598162950@mms.cricketwireless.net,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is the question?

Den ons 9 aug. 2023 kl 03:31 skrev <5598162950@mms.cricketwireless.net>:
