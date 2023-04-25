Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D698C77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjDYVWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjDYVWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:22:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155616F34
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:22:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5062c6aed59so7332a12.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682457766; x=1685049766;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UOntKFKhDEkAjqcoGJjVk6tiiwsU5YHMxpMiawiyaWQ=;
        b=usvlUI/p6+EcI52L9B3OP14NDiEEylrONV5ltl7WV61D1VfZvKAfmZR4cHmHQrENP9
         oUwaTS/zecHdp0JGsk5eBnAZwp/QwZJBcPu2ifLvJRkiWj8T6+RCk7FS+zgYXzZhKHBw
         JTwdqTOAtNY0hneTI3QGupfFNBfTNDXyy3eT6vj4XaUJ7yw/BzkglmESNAjd194nCBIc
         5/Lz4SbigmoPyIoSaC2j7gvylCqGt3/ic98wEclTko76hAXfOJWHqYx0BIrdXQHG92Q4
         kuaINYj6YWtrBCyTXIGtHUFiVzw5AKxjsy3RWcJLKf0DK4Qgt4laTFQkXJOrN12Hubkj
         TgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457766; x=1685049766;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOntKFKhDEkAjqcoGJjVk6tiiwsU5YHMxpMiawiyaWQ=;
        b=hVaKDaCx0Lr460E5ryGPdbPBuaVkmKlajuCw45faB4KGbEDkon9MNnN4jV0gHj4lbN
         4kBHxxur/86t7KgEdiJufZ3T99Iau/ZEz3PBPduH+cybDAoGBo2p/8WpKg1Cp2a3ND9P
         m+4ALh4wnYMQ6sHs8zHlSMfYCV1/5Y9DUgcrOj4DeAAFKkbzJ2/zBpnqdxGWRSjrR6k/
         nl4Aplp/q26/Ej4VDTcKt0sgY3shUrOmeyEbMbPu9tRobVs2VpoQNQxKcO/AtQKpHJjn
         QhC6DBkZDEZOJTwO6q4PURgcmZSheJPYZja4zip7jyXUCupM0Z82ibysCb3eshwbm9wJ
         o79A==
X-Gm-Message-State: AC+VfDzwyqO92+LQzZuZXfcFcHPTt7reHIHs/aULl7wOjO2LGHnRvhaf
        9jq4u61axGADJcQGVMzw6SmfAAdVIqlZW7NuBd5/xWlf5IEju12M/CKDADSZ
X-Google-Smtp-Source: ACHHUZ7QtM868BU1NAiuF6Fdk4egCqS1rdbRgKW3aVDIGggWbEAPsc/QmeM5GS1QuCLotB18Hc4M2U1PO/8KcqN2gqo=
X-Received: by 2002:a05:6402:e82:b0:507:6632:bbbf with SMTP id
 h2-20020a0564020e8200b005076632bbbfmr26182eda.6.1682457765762; Tue, 25 Apr
 2023 14:22:45 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 25 Apr 2023 14:22:34 -0700
Message-ID: <CAJoAoZ=vS-pLOAvdJC94O_JEdtApgXnh8gPuE93gC3iCJJUEwA@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list at the beginning of the
meeting.)
 - Session topic: <TBD>
