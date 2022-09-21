Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9628EC54EE9
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 00:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIUAYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIUAYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 20:24:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F177E86
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 17:24:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d82so4276543pfd.10
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MD9Mr3vRjSF6E744Jrtn53g4n3HIPS6VBJ0qwdcbWuw=;
        b=ol/IByEEmwjxE/7hxHhlTFLVdQGQjj3Y5Qga8XfA/7HXCTGeIVLz4EQMft76oF+tXp
         qtm1p4cuT/psfURqvUR/9JlEOpgcmCoTq/vBprz7Neamkbc/IUk3UgtIgmOZkErNS/rO
         uZTICQANXTCS2QO7+L5XhaCBeQmmLohIgvkldftrm70STZAu0rbCDTDx+mg+6xpQSJbB
         KnEaMkBcgn/zhE7mlvZgYlKgViLk++dy0ok3Tem/nEehvoLsAAnyQtPXvMbjshZLVh7M
         D8vJS7DTTmcMTtL0tyLyGnINOcgymyCVOzIDkpBN74NVZ/UwRA+LNfZ3zLhniLijUSXG
         eUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MD9Mr3vRjSF6E744Jrtn53g4n3HIPS6VBJ0qwdcbWuw=;
        b=reKhM6DpslweYTaxZJ066YKOdQIEo53ylBnV3GmYkZC74T99T/mZDbGH6TlRrLxGmc
         EyCQxIFAlER4cKhcd1tdDwFpdF/8Uiim32496ZSeN49XVm6ITHM6DqMWsG1raFCvtnXQ
         bwBO1tKns60bOcfkTnqn4E3w2XkxXd1NfkmyUL8awaO8oUp54WdFDy2qDh6G/0wwDM/B
         M8bKdJqS3kmpqhjm5uh5uLXMAPmKz4OHqe5DjhoJHpvzw6l49rPJnn/T6+i3Bo1TE+Pf
         IPFpqzayq2JcUTMe7Taa+Lf8mb2PFz5hx9KqvRK1zEt2eEMVBhZ/cmlU1Ds1OqjA/nuP
         iQEQ==
X-Gm-Message-State: ACrzQf2HFOPbxSQCZE2eEkCfcH5ZY4GqsZuM7axD7f+5TfOJYKke/aj4
        gyuObrG81QqXUAskDdltj7vu/jWk86timtXM
X-Google-Smtp-Source: AMsMyM6XSuaxBiTP87ifGJyGxmMKMppBVZm8xP2q6E4QQR3v1jgR40XgiboEka0h9bi8LvIbg7yGYQ==
X-Received: by 2002:a63:f446:0:b0:42a:a729:18f0 with SMTP id p6-20020a63f446000000b0042aa72918f0mr22116956pgk.589.1663719849287;
        Tue, 20 Sep 2022 17:24:09 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:74ff:c083:b5dd:df36])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0017824e7065fsm485573plg.180.2022.09.20.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 17:24:08 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:24:06 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input
 requested
Message-ID: <YypZpsAlZtt0b2hp.jacob@initialcommit.io>
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
 <xmqqillth1am.fsf@gitster.g>
 <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
 <YyaOJa1FNyWK+M4U.jacob@initialcommit.io>
 <Yyo+iBNF1bydcQt+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyo+iBNF1bydcQt+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 06:28:24PM -0400, Jeff King wrote:
> Taking it all together, a script like this works:
... 
> I think this could be done inside Git, though it would be a little
> awkward. Maybe it's worth living with that script for a while and seeing
> if you like it.
> 
> -Peff

Wow thanks for putting that script together! Looks awesome I'm looking forward
to testing it out - I think it should be fine for my purposes.

Also unrelated - thought of a different patch idea to work on related to the git
shortlog command, so will be submitting that hopefully one of these days... o.O
