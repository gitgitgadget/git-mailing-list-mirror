Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FC8202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 15:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755866AbdGKPzT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:55:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36372 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755831AbdGKPzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:55:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so389957pgy.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tu7sjC3J07TgnUllEO5fuejQBBcENym1vVS/dKxZNA0=;
        b=ZVXtfuRvWK17RXppl2e5uW5J40k4EJvP9PMbVVbYzWn9wz7sxDqU/py0exin9H1qyU
         1FDQPI9UfTgrOdVzblewtJwPkLvs5IYGLgRFYYAhicIMSWjWd8Qb5ervfMFHj2k1sr8v
         CGmFQwGrvt4eqkwd1Vd4xJ15EjRvb4AzagbReTVUEv9/Xz1HbtlnEsvyuSD5GvaX5Aj5
         svQCc21z+TPgF7/Ds4UXiYzVpumED1EC4Ogjke/NJ99y4a7DGlyyeKBf81Lw2P9RdTG1
         FI2Wc/8FGIoIFm3UgtCyw3+TNwC7nLHV/bBY+yooQGLdBap6T6K4FybVjd3DeD2W89it
         NVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tu7sjC3J07TgnUllEO5fuejQBBcENym1vVS/dKxZNA0=;
        b=foWiA0dr/PCYhSYtGrnom29FFBfk/qR6CKCE/wHDCnEZg2vUagin5Jq6opxaOh+vMn
         Ys5KyZR1Z4Xd6geo93qOsaCx+RSE5Xz2Q/VldftBLxfvg4Tqc3pCPwLyWvKIYzyzEFE8
         yeERUVjQuszfFdZGVqHiZD7rmAQIH1B7rW8ydefLmypHyX6esFjifknfpPRqrkBqwQq3
         4HJ+/+sg38ZEaVC7yVlPuYOGfk71mZrFkuGgh6NHw2OokDEt2756auhMnEKZNeX2XM7u
         TvFws/7Z/9nPUiE1n7tGJHu6bIN87HwD4L8NfJMHpDNTPM7zOX8BWe4kiBK8pDfvIzZV
         fuNQ==
X-Gm-Message-State: AIVw112XRDMgXGjwS8qUXW0JhAvsA+PVjnThBWX22TZ97DxKKqlESJes
        re3+SU9n8Jt7iA==
X-Received: by 10.98.13.70 with SMTP id v67mr38775361pfi.182.1499788517041;
        Tue, 11 Jul 2017 08:55:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id v205sm448830pgb.51.2017.07.11.08.55.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 08:55:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
        <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
        <A334F9D4-E884-4A8F-A0DA-C07214CF9001@gmail.com>
Date:   Tue, 11 Jul 2017 08:55:15 -0700
In-Reply-To: <A334F9D4-E884-4A8F-A0DA-C07214CF9001@gmail.com> (Lars
        Schneider's message of "Tue, 11 Jul 2017 11:18:17 +0200")
Message-ID: <xmqq37a33r4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Thanks for the explanation! I looked at the Git release calendar [1] and
> realized that 2.14-rc0 is scheduled for this Thursday. My assumption was
> that either on this date 2.14 will be cut from the tip of master or master
> would not change significantly after the rc0 date until the 2.14 release.

Your assumption is still correct.  Undercooked topics may be reclassified
to "Will cook in 'next'" any time.

Thanks.

> [1] http://tinyurl.com/gitCal
