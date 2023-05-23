Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E829C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbjEWRYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjEWRYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 13:24:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4107AE58
        for <git@vger.kernel.org>; Tue, 23 May 2023 10:24:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso329a12.0
        for <git@vger.kernel.org>; Tue, 23 May 2023 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684862645; x=1687454645;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i/p5XbLkWpteeRi9cBOzoJzLD/7UWTQ2/KKZjf/aWf4=;
        b=lyCk9nR0d3tPxIY6IcOL0eB8TKKd8ZAN2qfGiPjloB+UqMh/aY9hkmwolZQx38tdHp
         bOMrSQdbdMhvtPtjAlHlvBt+EnNUv6/giYzHUsD8a7Cp2odNi6wTQxfG24JJqjb8U7os
         K+Dq4q2O/99rGziDPTgG/6CSxMBzR6TPz9ACOgqPhR8OzdOmkjF2CONZ+3B2iABqMZ21
         Dl52L4Hhan4QldHKsklbsBMYy6J+vCyANQ5vIWJOXeuCn9LaplegUbLl5hBmAUiMB3YS
         KpGipTk4WVIpJB4JvmkOp3DYHlkhHU58NZ+dsXmxISPNiAhbsLON7EYIGLMnEuT7KEkJ
         l2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862645; x=1687454645;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/p5XbLkWpteeRi9cBOzoJzLD/7UWTQ2/KKZjf/aWf4=;
        b=DpHdQZgRoRvIn4nrp2OiYjO1f63teHXmHcfet8CiSkjEsgUBgaQnptvF0WeWrr4cGy
         BbNTTBNlOBJhDjMynCCL16F1aNjgn/L3Li2eUacBeIwfmyAVUz7IbyDcsEwKOjEtiyPB
         CCLLmX2SK/CKzeqMvedQPjN7hejwZaPjjCLht0rNpnghqMDYhY8g/0joWRtmTtjt4Xtv
         66BMieFjVv+q5/QjqjQAzt8IqqAWg+Bxd/mkLVl8otCz1Bke0yVSdRctStSRnEXmVzOl
         3QPwYiLlLayujeiQYI19h24/jcfhnbPBlW+Tz6HE/trmxJWJptr9FLPIGmP5u00Bay/B
         I9yg==
X-Gm-Message-State: AC+VfDwq4LbXedkRIKRPw/96sRpU5w6j55+Zegqu1JiiybP8utzSCQJZ
        k3lK8418loAVg3erlSZxVE/Hn/9FrsALmimdNBp5Un9MgCxu6apmafXwXy6K
X-Google-Smtp-Source: ACHHUZ7JmWTwbaMwQNqAhK9Z51OtqjzPvBF04ZfTGw5uHVq/PmjKSc+/614KComZzzx+KCNCFCkHXpVZ6DnfML0cRto=
X-Received: by 2002:a50:d61e:0:b0:502:7e99:a1a7 with SMTP id
 x30-20020a50d61e000000b005027e99a1a7mr6498edi.1.1684862645548; Tue, 23 May
 2023 10:24:05 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 23 May 2023 10:23:54 -0700
Message-ID: <CAJoAoZkdkA9zwDJbasfyjS-fcgfDquzJy9kpLVTv71p7YZasoA@mail.gmail.com>
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
(17:00 UTC) via Google Meet. Please note the time change from previous
weeks.

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
*   Session topic: &lt;TBD>
