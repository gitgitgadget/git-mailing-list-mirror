Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4198EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 21:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFUV4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFUV4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 17:56:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF61994
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 14:56:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b9863bfdso10215e9.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687384558; x=1689976558;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11lS+p7uqkfHs9KOZxZOgdfVcIhMR8KJOANQzPypv9w=;
        b=d1AewSUi0YvxLopeGyXAsXdINRM5AeJp6+3VeP+KASkfLtxFMDPPmCsm3ymAn4GMHo
         7XGdb6vcBZHm6tNXJvd7Vj8Uluv5yMX0y+Zki5ixX9ZZcrps71JDM8ePJwHqVaM6y8Uv
         FCtVinBE2TUCNs4uVNECYEO66DAbokSr3gBmWqf52cpQyQUq8EbVUSHzfa9w8hz4YUoh
         RqK7udOHr4f1qIXplRqNrt24dpxNg4xsXq5D1T+LlGDUehMJClFk1ajzRsRmQSZQ3F6d
         WOeJ9C8UjgySv6b9qVN2a22gqRixP76Rm3fz/xG0qYByg6G+VZJXwYmgwF9Tiujr++HC
         ckeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687384558; x=1689976558;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11lS+p7uqkfHs9KOZxZOgdfVcIhMR8KJOANQzPypv9w=;
        b=Iy1iigVtjGzYpNIlQFQN/3QjGh3SrJxUNWalG3VJFpmqWtbcIWESbS30ffgGS4EZGK
         Iv59mKGoUrP73yQNLrLutIdlouO7bSy+UXVTx3NA9t2rPw9s6+6H/+6woCY4me6kSEMc
         q3ETtCStTr1GatuBSa2hJC0FKoKyPfeoUOinbTOvl9eiI4dW1cKVELHVKGZghiae/8UF
         wyW/F1SACYuk3KYg6DG0RNUMP3grjyRYK3RGd4Z7M/3MeWCh9/AOc0U/4csIuR9UPd3c
         d5PKeHux94emCmwGVMAa+aIQWjtzg6hzmq5w/LUQ5gAwtbH97pppkWFaf+n0jzvTDPrK
         +mdg==
X-Gm-Message-State: AC+VfDxDg9s0N6L6FEuaxWaEcw29+eIdm+BKZYfuhUDx62VvqizFu0Uc
        dY9QTbC5p/Gp4lSg06eTROYlsTq8Mh43jylZBO7dPMcPxEmXc1ebDee23w==
X-Google-Smtp-Source: ACHHUZ5kxEgXBszvErYD6gqs/CZD6RoV+10JfYnt5dyeDfsqMqTAoyB8qpj0T67mLYPVh1IjLdGWSBXXQxba+L2croE=
X-Received: by 2002:a05:600c:520f:b0:3f4:fb7:48d4 with SMTP id
 fb15-20020a05600c520f00b003f40fb748d4mr676254wmb.3.1687384558291; Wed, 21 Jun
 2023 14:55:58 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Wed, 21 Jun 2023 14:55:47 -0700
Message-ID: <CAJoAoZmyG_rDu-Ucr11m1_wyJmq+6mx2pNKEhGM+pniWGJJBBA@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 17:00 UTC
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

We're hoping to hold this meeting every Thursday at 10am Pacific
(17:00 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

*   (asynchronous) What's cooking in libification?
    *   Patches we sent regarding libification
    *   Patches for review related to the libification effort
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
*   Session topic: TBD

 - Emily
