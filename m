Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5DE202FC
	for <e@80x24.org>; Sun, 22 Oct 2017 09:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdJVJgd (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 05:36:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46843 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdJVJgc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 05:36:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id k7so9641829pga.3
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=5Aq8s55Hd+m5Nf//45zRnVc+IsJ1Ru1g5X5m05XsbU0=;
        b=AWeNd2c/+Xzz/7ZbSZ0LACp5grInu8uBflcQYWhGQOLPzoDQS1XB2GSCZLYCeHZV3a
         IQRugh0wT/GynG9nqVNxfsJRdsmKqRHaC0qFLmlhVD0Mw0x2unpjJKmFydA6giPPCT+v
         L5Ggzj8Xl8331FQKK13pzrMAxEGDhYHnJ0s2/NFg3DFOV/iQhwMimkn4Io8WXKyVGUIW
         7sowjdqvav9586gze0fdqKoXWfPK62yKjDlYA0Z7zgXDCU2BX/F4MyjELOnfi/0bqPIC
         enQkL2HiPie6eRVZ8xp4ElyKM0T+aNcZu5CLeW2g5uAmNvnXhKFcdum/sAWZjilDtGVj
         GA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=5Aq8s55Hd+m5Nf//45zRnVc+IsJ1Ru1g5X5m05XsbU0=;
        b=tk5XzfyLteTmrMXTBazQnrvKZkWxMXNX28OLAfYcgHnq8VDQmboWsffRa0+BBYDn7u
         VBtU61YgDBulo5ygLRW6ev0MQ5Y45TQewnKHMhcMegd1dL77K/L4evYxsJMXbEURpsem
         J8TsnTVOkDy6UZ6wOPPReYkVN8qpIdKOSurVRMGp4VTXhVvc2IsH15Ea/lQxpX/9A0UK
         nlSLiZ6vUY0SRRnw1kbCrkEPOoRwWtUiv57yRJ2n2eVq/uFgQSVzmm3ENzX0birm8DLL
         6BggSJr6O7R//wWaH9wPm2oklpwQjxKLiWChNDpi3j22dskGeVbUwQstDG/RVvh8sCMP
         bClg==
X-Gm-Message-State: AMCzsaWWGVkBcUQ7xPe1Oe2XucS5pkfPUyrnvRKmhmdqDf6Mwa4vhbSr
        VfybGCsL0mUDWkb8JZjNWVg=
X-Google-Smtp-Source: ABhQp+R7Kzd/WuYG8A0PUPvWjSlbXR+Lo5JDDW9qLM4VgbBoUR0TDX4OJBFA9Cc8fUWY9R+p+wQ/QA==
X-Received: by 10.98.236.16 with SMTP id k16mr9895293pfh.152.1508664992078;
        Sun, 22 Oct 2017 02:36:32 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id 2sm10043855pfn.185.2017.10.22.02.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Oct 2017 02:36:31 -0700 (PDT)
Message-ID: <1508664986.6715.4.camel@gmail.com>
Subject: Re: Re* Is t5601 flaky for anybody else?
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
In-Reply-To: <20171017210833.n5vgly7z2zi5dhuh@sigill.intra.peff.net>
References: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
         <20171017171046.GA48544@google.com>
         <xmqqshehmqrg.fsf_-_@gitster.mtv.corp.google.com>
         <20171017210833.n5vgly7z2zi5dhuh@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 22 Oct 2017 15:06:26 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-17 at 17:08 -0400, Jeff King wrote:
> On Wed, Oct 18, 2017 at 06:02:59AM +0900, Junio C Hamano wrote:
> 
> FWIW, I can't replicate the problem on either "master" or "pu". I wonder
> why.
> 

Neither can I. I tried running t5601 on "master" and on "pu" after
reverting the patch found in this thread. Both ran successfully without
issues.

-- 
Kaartic
