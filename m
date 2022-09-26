Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574DC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIZQj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIZQit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:38:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A35132D50
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:26:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-349c4310cf7so72433357b3.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z1Y1hjEZpGUIk+boOBzN53M+d0fX4Aj71zDEvoFKD70=;
        b=L62LC+J1SACXyUNXKtdtyki6iXhea+jJxX6b0YL/eOPw14/9PYx0Eve1Z8VjyO0u8b
         WD9+bRHLKxpnY3nVw5Z1wVlscivvk1ldsc+68Pa0yVdHNrWP/tgaa4SNwatvMJJsFfZ/
         pIRkcLvjGjXRpf8Y4zfaU6/jzEWaYwtRXqS1SAD+OOzhbGR4PC86LYMfrtJBP1jyjLbw
         OfikkE86alS/g/uFun/+Gz4cJXNymRj3amRT0ezgHgXCIZ+Su8wBqipR5A0sf46dekbt
         /jQS6l8iaftHeZryBvQTj4HULtoZ4XnCIzsWRmVq5iygGgzuD3vRii6DI78siQjjNuH9
         TYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z1Y1hjEZpGUIk+boOBzN53M+d0fX4Aj71zDEvoFKD70=;
        b=ywQMPAOx4yuDaLix7IUVqpMtX3hDgaew7xXZq4HU3RZU9N1T5giByVn265/Uw9v6o/
         ON1NiUYVVAwqvs2m8z1benbNsrqyZ0uTQHqJ8vc3I7kaMNq8EmgYWGwg+7DUmQM4weSb
         T6b7NQoLiq5Y/q0P80N7QRNtTKRROeeytSQzgw5S8rpLuFW0hyMNh5Pk1HROyLsIW6J3
         DAhdsVM1afLNKF4NJB1UetXrT4kc4f1J1QP91VTZ65jdxjYieCJ8y4unqPRD5ABHO2iN
         gAToELNkU5dflOVbKg8wh4/76PFodEn5qQmv0/faxj+/K6nbQZJQOVC3jDpR/rs6boqr
         9bsQ==
X-Gm-Message-State: ACrzQf08pRSINUqCJIs/3Jxt8R7uGOlBS581I5VKPZluX1uTpIb5wHGN
        ntwnpNQsmjSTcKh7KgieN++a7RJfAExNo/gXLSRbWBsQZHGXrw==
X-Google-Smtp-Source: AMsMyM60cJA79nYocnqLY6NzUzXq4TSq80Q8cdG2Yr5nvLfftGy8/MT9Sx6eQNb9VRstqczT7oJIgOfQZcd/+uCX204=
X-Received: by 2002:a81:6c01:0:b0:34d:2175:2027 with SMTP id
 h1-20020a816c01000000b0034d21752027mr21205466ywc.157.1664205965963; Mon, 26
 Sep 2022 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com>
 <07e739b7-bb60-c23f-7077-2c8f8cc00b62@dunelm.org.uk>
In-Reply-To: <07e739b7-bb60-c23f-7077-2c8f8cc00b62@dunelm.org.uk>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Sep 2022 17:25:53 +0200
Message-ID: <CAP8UFD3pZLiyDFZTDdMH-_D+d0zp7q0MfiOujf82ZhrLULJwHQ@mail.gmail.com>
Subject: Re: Handling the Git trademark
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Sep 20, 2022 at 10:38 AM Phillip Wood <phillip.wood123@gmail.com> wrote:

> Thanks for taking the time to start a discussion on this. My immediate
> reaction is that it would be a shame to lose control of the trademark by
> not enforcing it.

Thanks for your opinion on this!

> If it is taking up too much of the leadership
> committee's time perhaps we could consider asking for more volunteers to
> handle some of the load. Would a few people volunteering a couple of
> hours a month make a useful difference?

Yeah, I think that would make a difference. Thanks for the suggestion!

> One other thought is that there are a number of companies which use
> "git" in their name that benefit indirectly from the git project
> enforcing the trademark and thereby ensuring the name "git" is trusted.
> If we were ever in the unfortunate position of having to take time
> consuming (and presumably costly) legal action perhaps we could approach
> them for support?

Yeah, we have already thought about this, but we haven't needed such
support yet.

Best,
Christian.
