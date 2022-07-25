Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6342CC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 09:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiGYJSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiGYJSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 05:18:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFA15A28
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 02:18:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d7so9841573plr.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqGbEHUFPpn2AjPHazFhCj3W7aIoMPBCBbOpAVCghvE=;
        b=X8mIxyga5xAIHeBpE7FJFDBMq1JsNNYDewHWpGp+ZKPByn86t+Sg26K3B7umyE4RCU
         Cj1YBVE+sk8zXI4RL7T19MKJ1Wn1QB2i4VGQdyHtV/THZnDXi+EHckbcmVeRXi9Fj9Ev
         mr+GMxOb/Go+Vu9atSEgTlSeoFMCnDWnV/qJ0ZHLQ/DWEm22xgfRdeKAyJOUgfROUn8v
         s2jGT09pHuDAjM9XmkuK4f3kLgmZqZo8gcBCKU8RKCL+C0/aTPyppftqy6+AAKExJTOT
         OCFdkZHzAvEI9J3h+i3hEVd9zZaH736zHcVWqd8zMcmmjg7c+zUsS7SWVdztWDaawnk6
         ga/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqGbEHUFPpn2AjPHazFhCj3W7aIoMPBCBbOpAVCghvE=;
        b=Q2YwiqeIydufTXOAOKe4o91RtPMa1J8WwTmPjxs3sDkadHctOt3ESndZFa4RcAfsKv
         gfv8wNcbkGycobzvkxTGT6RVUKe0T4D9mUJ2KR3S9XzvgCAvgRhHJCoofysJlKzWju9a
         QOH5NXhqxI+7stwIp0cUeBMLIX+SvO5/wlWjubcVjCezS1aZrFmKu0H60uzzINVoFDiA
         ge7evgS0QEAPNz2YyG/sndJzlnvmVB6N1iAq/HSmC85DqXjlhui97OHxNxr62td00Egy
         4Iyi8pYyEivNt8We367Cm08sAJaNonXzDlrviCVtjP3bBBFPIxBfXCDVqJ6yZiRMildV
         sw5g==
X-Gm-Message-State: AJIora/jNgHyqsvRRomOvo3w35fgJFdMeKaMuVEahm4/vo+b1psReMsc
        u3CWKq4NSDayR1iOTPho8uQ=
X-Google-Smtp-Source: AGRyM1vYDBHI8RDobYCneQbWRM0mS4BX00BGWzFNGJlJ5sLAiEJlTogy8CgNDQysXmaD7kGiRG9rdA==
X-Received: by 2002:a17:902:cccf:b0:168:c4c3:e8ca with SMTP id z15-20020a170902cccf00b00168c4c3e8camr11659561ple.40.1658740705413;
        Mon, 25 Jul 2022 02:18:25 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id me5-20020a17090b17c500b001f29ba338c1sm5019602pjb.2.2022.07.25.02.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 02:18:24 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@jeffhostetler.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Mon, 25 Jul 2022 17:18:18 +0800
Message-Id: <20220725091818.22909-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <xmqqilnnafh2.fsf@gitster.g>
References: <xmqqilnnafh2.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I've tweaked with "rebase -i" after queuing and before pushing the
> integration result out, so if you can double check the result to
> make sure I didn't screw up, there is no need to resend.

OK, got it. There is no inconsistency in understanding, I agree with
your suggestion.

Thanks for explanation.
