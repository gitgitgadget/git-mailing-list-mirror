Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKUAK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUAKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:10:55 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21DE2BB31
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:10:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g10so9123364plo.11
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IakcSMxcHTCW4Au2utu1G3sMPNGGakg/41za0bdKWOw=;
        b=QX6xukFfB/8ytgP373tWZcHs8CX0v1m0F25g9D0c+fCIbJ8UrLT/HBOIe2zTduaf1u
         Cx0mxAwq3XdVOZG67tU2CZVS5O0helm4P4iay/UxY6r6RIRCkVf1HjjPBc4xZb2kA4xl
         7D2mLh8ew4SwFE/NVN1cXOo9YjcUx/ReXdXFcUTu0uYulOFsb20nQdmJ4YFAkQo/yWrd
         CxLGo0nsZ4q46AeYo/We9IMWNXKrMcSS6l68Zo/hEGOqApaR2nKpo/QaTCHDpuN3kBFR
         7hyWPcXBaXcf6RH8W+7WelgnNCOmyB2G9tDU9GwXOQ4zmCf/veYYqF/cux0ZPTMdnnd8
         SntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IakcSMxcHTCW4Au2utu1G3sMPNGGakg/41za0bdKWOw=;
        b=P/N3YDtLA8J6nMd0mJph+2Tpo/tOdgDZyxHYPuviZHnZ9O+dgCFJbCVksRgXZm7d7O
         7vmagiEHGWs9vuMtb3X5Jvf3FChv4tl/6pcFM5lv+InexaOA0dPIgO4/B1vVriLkU7Nd
         YwtTKB+DGAXKpbhTcSC0RzQBcnaNsvK7HO5b9iI5ZDpnZb1DzlWWNdjMruH26DVKnfeK
         1/x5TbS2RAs0LQhryvQ30S5dueOwpEcxcZCGjtDoArlArSRY/cotdl1vva0/p+PzTvgt
         UdQyMZNE285MMcnvn7y1vfIECBuQRUbT7VU5CT52ZUkuaw7X2JT7sZygnZ3CaBI3SzWk
         BV9Q==
X-Gm-Message-State: ANoB5pmRemdjuar0Hy7FVeoJ8Sc1RBLcmf37Cr1AezAgQ8D8Mwqq0g/x
        SOB+fDWAIFwiCzzSAnUx0LkpL8YNqdDTow==
X-Google-Smtp-Source: AA0mqf4q1jaZcmdX2LPMDkUNyYtfBBeMND/ohd5CskDcMVSyxtW31o8Asq4TCZFd4w1kfV6bkaZipw==
X-Received: by 2002:a17:90a:7885:b0:217:e32e:e931 with SMTP id x5-20020a17090a788500b00217e32ee931mr23811729pjk.146.1668989454315;
        Sun, 20 Nov 2022 16:10:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d19-20020a170903209300b00186fa988a13sm8099280plc.166.2022.11.20.16.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:10:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local>
Date:   Mon, 21 Nov 2022 09:10:53 +0900
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local> (Taylor Blau's message of "Fri, 18
        Nov 2022 21:22:28 -0500")
Message-ID: <xmqq35ad181e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another question.  

Quite a many topics are marked as "Will cook in 'next'".  After we
go into the pre-release feature freeze period, most topics in 'next'
are marked as such, and are expected to stay there until the final,
but as we are yet to tag -rc0, I am a bit puzzled.

Are there concrete exit criteria for them?  Or are they, at this
very close to -rc0, already judged to be a bit premature for the
upcoming release so I can safely keep them in 'next' until the
final?

Thanks.



