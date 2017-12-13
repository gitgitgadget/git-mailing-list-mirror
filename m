Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452601F406
	for <e@80x24.org>; Wed, 13 Dec 2017 02:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbdLMCBa (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 21:01:30 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:40681 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbdLMCBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 21:01:25 -0500
Received: by mail-vk0-f41.google.com with SMTP id w190so526481vkd.7
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0FjKcR/E2mF49myUsc7SfCF9PTcJO/WrQvzJ5+n4guo=;
        b=ZSXXHtcPuxg8Br9G2naXyQuxAAADkfpFIGe/DGEecWjeFm8Y2Y28j6GAHjRioPa/9e
         atNNcWqWVY/oIi+nixYZyoQl4mx0C3fgtf99VscYnirB3K2AArWyl13f752u3tzNmeXg
         cRJw1VvvwgXHThaYY4fxYjZbeApmHC9CSLQfzCezLlzIHT3s3EjH2pHsV6G0DEaGCmdI
         c/xzB+BaYrHE7hFZAi46kFRnD87pCNMnFasXfUrbydNisLHLZkJ1lw1Nd2TlP5qzocV3
         ymJ8MquiTk8h6SsHTgecX2lIADxThmqjaz+rhYZTW1/vImTjgSLNuJQnD/vJUc3RXMPW
         B7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0FjKcR/E2mF49myUsc7SfCF9PTcJO/WrQvzJ5+n4guo=;
        b=uNKL4CqhBsOypCSjUkdPle+YID+v9RomMal0LtD1s5bCIR8v5mgbYOvH4QFf5vOlp3
         cbz1jlTunaMV/XgVfZpUS0nQKgPh6jRNHB1VCRwUzs2XJ952ZXeDwcr6hsiHkGDFUt8K
         k634jhUIzbUjuQCD446fp9m9Lir5md8DfAzSrTewr1rr1XcPxbYoha0+xZCaUcBT+4Xc
         ZsgUVaSPsIpGuPeJw8sQ/gpj7sgYGCoA2xkXYGKqh964pKCSwq3bpTV/Cga6TwrdypnX
         2Z2hyL0Zs6vPhXPB/OvXPv2Jg59/bJF2pr49jIpvzJLUPD9gopShZqj27zlNcj1Pnh6O
         Wqjw==
X-Gm-Message-State: AKGB3mJWNRID+z9CzIjVARzqt9Tvu08gtVwGG5eofEUS33k/UGB2CKAh
        BeDGTwiVbD7yGCAqMPWa7BuokpLjZfzL08RZEeQ=
X-Google-Smtp-Source: ACJfBou/NtMdrd84psOmhF3g/IR23ZRxvrxjwj5lvf90T3VwQxAxQ0bvabc81Ka+V89LIK3VD4scFWhXTFfB7Y7nDGg=
X-Received: by 10.31.78.132 with SMTP id c126mr5956329vkb.163.1513130484705;
 Tue, 12 Dec 2017 18:01:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.157.195 with HTTP; Tue, 12 Dec 2017 18:01:04 -0800 (PST)
In-Reply-To: <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
References: <20171129014237.32570-1-newren@gmail.com> <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 12 Dec 2017 18:01:04 -0800
X-Google-Sender-Auth: 33INCWQOONvooXUrKVDaM8TFlFY
Message-ID: <CAPc5daU1b1sJPK37sjMKdr=xY5yg3qaHk9PPdgJ1JH9KvJxatQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/34] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, it seems that I managed to make this test pass under poison build
(see https://travis-ci.org/git/git/jobs/315658242)

Please check https://github.com/git/git/commit/e5c5e24ad91a75b5a70c056fe6c6e3bfb55b56fc
and sprinkle its fix to whichever original commits in the series that
need fixing.

Thanks.
