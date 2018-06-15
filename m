Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1294D1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 20:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756509AbeFOUuM (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 16:50:12 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:40467 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeFOUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 16:50:11 -0400
Received: by mail-yw0-f172.google.com with SMTP id p129-v6so3786396ywg.7
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 13:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxsnXggegQJk7cbo4xkvbHVEfng65OUKqbbXsiaZbjY=;
        b=nY5/gp9VzW0VtAZ3RVN2knT3qYjA7o6tZ3Z0gM+vUGdVNM3oXCs3rnfl/KwkTPQYry
         f9odyYrJxoC5Ltl+eyoVv1BHFZCTirwiAbs9Dxpp/C08bf2DeX8R6BvmFculUKPP4L7/
         q+iq0WSgmcVpS53h7jBrCqK7Sc054M/Xqo9Nd/CE0jhNtpNNwskPRrCVNC6jHnXQ1ZcT
         j1kfkkj2XqlCo9gCQMqt55kYvI+ZmtMvGt/ARY7yg25xUg8s8qosDPMBpnQtRQJMZt16
         UhPHecBoTGJP+PIsfwWP0DsdFB/eeutjuxpmkAI8MD4KV/CGazrNMpKiC0fgLY/lKsmT
         t9xg==
X-Gm-Message-State: APt69E3aqbpryxb+fB/wagF26zHZjzPUwXvumiZP6J/flr6xQVg5yMwA
        0kekAr7ZjsWYi77Yv+F/Xu6vDQllQYDCBYXjBvE=
X-Google-Smtp-Source: ADUXVKLM1LrvaMpb9eJZ35syEI9LAcW3lJKFv9VKtMW+1PVMxShhOgHGT6oRv1t7la0QY5HID+9urA2lmXDzxT7wEpI=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr1667751ywa.16.1529095810668;
 Fri, 15 Jun 2018 13:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0wrztgh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0wrztgh.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jun 2018 16:49:58 -0400
Message-ID: <CAPig+cTFhkKiMjjOTaFCuiyQC96oH8V-d1adFmyeHfDsB5gr7A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #04; Fri, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 4:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/make-no-iconv (2018-06-15) 1 commit
>  - Makefile: make NO_ICONV really mean "no iconv"
>
>  "make NO_ICONV=NoThanks" did not override NEEDS_LIBICONV

Nit: The double-negative is a bit confusing. s/NoThanks/YesPlease/
would be easier to grok and would be more idiomatic (taking
config.mak.uname into account).

>  (i.e. linkage of -lintl, -liconv, etc. that are platform-specific
>  tweaks), which has been corrected.
