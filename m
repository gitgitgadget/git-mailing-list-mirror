Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816BC7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 16:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjEJQ2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJQ2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 12:28:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F5DD
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:28:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so16031a12.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683736132; x=1686328132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QOM1HOxBH69L1Xvcs5nwPjrvVW/2PcL8LyT9+J03BQM=;
        b=sEVXECKYICHESRaHLrXWsxcCG4OHwJdY1Br9MEH3494E9K0n62GBjrBJT+RDsECsog
         GDuoNj5niezh8vxpDagttNgURvRnPP7FHI2NUYUEclovqQbOYI/d/Po8SPhXgMT/GxHV
         f2VtZ2xb3L643LR62Oj0IdHp+/AWqS90QpcNHFuJUgXFtDeq2belL2znL0piiCxSkIV6
         EXymdC541FvJ4LmRtoR9nIc8nt1AnnebSDGiZAUR2jG00mk/PRr05x+9WGXGCXh7ltt8
         JrwK/xATm9VwwkbZegP2EhNi2hrDVhbMEbvZmkZ1dirLFXtE34hiY6p3kizUOwD+Vvvv
         Ca5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736132; x=1686328132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOM1HOxBH69L1Xvcs5nwPjrvVW/2PcL8LyT9+J03BQM=;
        b=Nkm2PY4/iwy6a/69AhgqPAwypRLxLOoPXYKp7rpp2SIzQfLQTSo8C89NWrvot/zHrv
         cjVYHwnc6FsfiwMI/6bv84ZxX4kEGjURUAAkFKYh0oZZ9NQZ6E1qgtcsSoZ0tY23CmBj
         5KYbso5QfrrmeoNpvRaQCI5xgVDxwJ72VMs4iLSBPlNLap0gduhatdRrMr6SCOM+1aYN
         z0oHzmX1LXA7hYidZb7NRau9iIUNLRlg9JcO6ViWzHIkBT1ZWx+cYo3ngInrLxzKlDTZ
         pP5gVrxZo33+0fLL1D4L4g84dGeUw/QczS1mmhTzL0gr+lpotvoRJhadQh8/eyvuf/6c
         uo/w==
X-Gm-Message-State: AC+VfDwPpYxU+/4U2pDW7IX3IiWJ0rOh966FwO/515WRjUhyDGCXYqL+
        eYnEMgOmpH8URXxmQYvShqnSWr/LkGI+r825OQW+dRKj8iIoBWG+JG4=
X-Google-Smtp-Source: ACHHUZ6WRwEQqhe9db3PVbe4M8L16yHjnMkTzzdGlAQM5VUrL0RVPEiErcD83BKPWJwG5hzxqGtRaOPwBz5lOTIQkgg=
X-Received: by 2002:a50:c347:0:b0:50a:20bf:d92d with SMTP id
 q7-20020a50c347000000b0050a20bfd92dmr65757edb.5.1683736131895; Wed, 10 May
 2023 09:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFySSZBFxupHp-o8ApF4A1KnmefUYTPcbbRZgk1-FUknbw07_w@mail.gmail.com>
 <20230510023737.2500-1-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20230510023737.2500-1-tenglong.tl@alibaba-inc.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 10 May 2023 09:28:40 -0700
Message-ID: <CAFySSZCaE2zRtbsu0-VEHx12U0GeVy21GAATpTH0LNWKk-PX1g@mail.gmail.com>
Subject: Re: Join us for Review Club
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No worries, you're welcome to just spectate and learn about the
process! Part of the goal of review club is to show newer contributors
and reviewers how the review process on this project works
