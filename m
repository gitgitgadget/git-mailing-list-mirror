Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6BEB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbjFNPgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjFNPgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:36:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CE1FDD
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:36:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97881a996a0so141342666b.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686756997; x=1689348997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9jzaKOgZvR20f+VZwFHJNIlcWIhrWAOHV0BWoIL28c=;
        b=DrGruwxHcWxfM0CiPTbUMI/ln3/kHMhvR16dRFW2SjJEE74m6PQ/tjkCMsJ+ggnWVK
         R6Eka8jq2kmzWmSIR3zE9EbyIOqWIBvQH+6qcGNqBCa2TqssgLjUWBBrg5wkuITCDn8i
         BhZPdH6QxHJ8XgRWQPRaynavBgTg4XpAAWr9H6wSgPuI7G1ACr29A/BlN7SjBmHQHyHV
         TDJoWyDhU/i/1C5sDyCU2sGjQbOGfMSWt7eKO6xkz7p13xRIR5In4Twq8Re+DFWkRdR8
         2kS5o8ax8fm9wllpi9i9+MdDOdQJ1t39fA38Z4MAjOWcAWgWWZHngBSMu5CkB3vq4aqu
         ziXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756997; x=1689348997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9jzaKOgZvR20f+VZwFHJNIlcWIhrWAOHV0BWoIL28c=;
        b=dQNGCMGsRkazVmYZ6GqXoIzHPIGh8jWmAXUYlDyCmC5SKCXoLXNcz3Xn+xNDih/r7L
         Hv9HzD7t6F3a2YZUwUA9al/2dIpNkbyH41xd8maTnTV7k5okPcCtRQ++wkcVaMob4Id9
         a8ETKYXUepusRYxVGBCHN/yxeCP0atFHfmbMQ4R/8O/bx2159A0DiKy0HXlwEOOUNtZm
         UVBrqwQBtxqE732zcYNrMAPwBhmS/UH2q9OyLZubpwMtnfUcS4LLSDMEiPGRQArxG4FH
         iwxYtQOBdgraq3MZ75q+bUnf6Bg6/OqV0jp76kIiqAOp3bv+Bwu9Bx5asMfZNVBz6+2m
         o6mA==
X-Gm-Message-State: AC+VfDyMz7vitYXMahKz6nwnhVpt70c84CW1HNn4xe0Fhrn0xnAkXdz8
        kasu3Is3Qpe7yfrcL4/XgVhE5byWOWFu8k6Xg1Y=
X-Google-Smtp-Source: ACHHUZ5EQKtCuVGGOkX6URGZColK3kV+R+2BIcJYrTI288oBJBmPgV5KrbL0bqSDDh9fqcqnXUVpSjxvdduiLjy3NFM=
X-Received: by 2002:a17:907:970a:b0:961:69a2:c8d6 with SMTP id
 jg10-20020a170907970a00b0096169a2c8d6mr18694347ejc.69.1686756997301; Wed, 14
 Jun 2023 08:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com> <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Jun 2023 17:36:25 +0200
Message-ID: <CAP8UFD1uTFCMoh9SnxNpRkvAK=6_VLLo_7yH5tuqS2auyX5G4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] docs: interpret-trailers: reword and add examples
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2023 at 4:08=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series makes some small improvements to the docs for
> git-interpret-trailers. The intent is to make it easier to read for
> beginners who have never used this command before.

Thanks, and sorry for the late review. I found a few things that I
think could be improved, but I like the direction.
