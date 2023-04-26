Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D645C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 22:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjDZWQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 18:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 18:16:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A6DD
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 15:16:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso637371276.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682547399; x=1685139399;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6nAXYTb0rUohmhot8WunOnPdCsOy7DxmDkao/kqR7w=;
        b=2UfNMTekPhKgTOrezEHwoNXI8bwOlwZZagbCc49Yjr3DEF4RNrMK7jfVq+tGf26Pwq
         Imk4DFaXQvw0WQnlvLdNB20CZaab8rRHMkXMpaMXjkM/Je4+c6/USKMR5FileLTa67iA
         OnBRx05IfwJyq/dY1L7LpXJAmQxdr3Jup3V+4rc+aBznfR5dTpYbhvj/jXMmsBVzublH
         TcmRJG1tdtDbXPm57tkR09iutt5TMY6t1fkmcgKV09BeSTY9VAqnU1pbU8ps6S+rM8hO
         KtQQxyhn5esIDAVmSo+4ikK+kIjMvN6Cl4j27ZXEPxZhntfLzZrPg9KTPVQ+Fy+0X26o
         m1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682547399; x=1685139399;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6nAXYTb0rUohmhot8WunOnPdCsOy7DxmDkao/kqR7w=;
        b=b97zimw4R+oxrY1+lCnqo0N0qD3610UoW35fnxGPGA9XGeRrg+TMSEa5gCcoq6Ll9N
         8wRin9ww6tEACmOza1RjDE43fMkA1999pmDUZVDRq/EOHX2EuBn1VBDy/tF4BJfjhaNg
         HuuLIgdKfLWHWbR0jfMuMbrnnQWGxG93MsV9UXpQ3on4/t07P9mqWqaRGUdByc85AWhU
         J/r/Q2ehcuYUFbm/icUjsceD8sYjIE/Phx0ds+TEiaFRIj/snZsvW6GZ3Cc4lp1+hogF
         168jFS3cg+Zpwh1h2wubsF2H8BWb6wFV6K8g2yUIVObyq3pE50Juv5LaWuKT7b2I7cqH
         BN1g==
X-Gm-Message-State: AC+VfDwF/9K2ATXXkDoaQk8JqfbHb9rI1KigB5uaqi//Wg1j1Oey8Ewe
        muE2FGb2TjLUCqGdKx1YTKhF9YzJhKQ5DA==
X-Google-Smtp-Source: ACHHUZ46jWpGqNUZU31u5VZzKQsDRzW7ERFku+Tfs/LI9sk5/w91u3j5AhafFlnsET1U7yrOJQC6Ii2jb3+8bA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:690c:2f82:b0:54f:e2ca:3085 with SMTP
 id ew2-20020a05690c2f8200b0054fe2ca3085mr2450692ywb.1.1682547399012; Wed, 26
 Apr 2023 15:16:39 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:16:37 -0700
In-Reply-To: <xmqq354nxzqr.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqq354nxzqr.fsf@gitster.g>
Message-ID: <kl6lr0s6mgqi.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: gc/doc-cocci-updates (Re: What's cooking in git.git (Apr 2023, #07;
 Tue, 25))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/doc-cocci-updates (2023-04-12) 2 commits
>  - cocci: codify authoring and reviewing practices
>  - cocci: add headings to and reword README
>
>  Update documentation regarding Coccinelle patches.
>
>  Expecting review response.
>  cf. <xmqqmt3by5sc.fsf@gitster.g>
>  source: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>

I'm preparing a reroll based on what's been discussed on that thread.
The feedback has pretty helpful in gauging the general consensus.
