Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0205B1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeFATqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:46:47 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34315 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbeFATqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:46:43 -0400
Received: by mail-yw0-f170.google.com with SMTP id b125-v6so5681107ywe.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V5DAe8VogVO6a1AZn/Pci+6cz5fPzGjEYtD62jfbg7Q=;
        b=mRYntgfu2sjybI14GUakQwwklOrM8XI6vbB6rCQl3Di1ck8lXkgCPgGtveo06THXHr
         byrOWj7pOiagRcJUFdsmI+eAsKzL5lndGIniktqtnm014lxeFQBBQ+3Hj0V9B7Tyo0xE
         q11maUZQt7XSLts1wTStIu4DogFHdn+SfZb33I0rWGkphCx3RLcvFEFZumWli4GV5pWb
         femFGq9jDuQg2XqolvpF7aexxo8lOasa14bPWNa5my+n4GN+amNl6txqEGmvv/4AHi58
         AimoPWXwrazrDDVjRkWQZo/cw18d1jshXYsol6Jm9EDeNeudgSeD7gXs7LkijMx7aJR4
         x3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V5DAe8VogVO6a1AZn/Pci+6cz5fPzGjEYtD62jfbg7Q=;
        b=W2WOQUAjPXoe6dD2giZgevnKOTxhHMXEjfao7e/ONg6LIY1Z4qiLghmTvXxZVwN8bs
         sNm3oGU1TumZHQpfivBpmofpIbd/33d3KoSKkPHv4y1yE33s5neMu5w1oc4y5gw+h2HF
         KPpsaADs41rhsLJ5La10kZVBoPVEEwaB5XRuWdgxykeQlbWRVOqwX2uxUFQidZfef2+N
         EswbDNYYkI+0MPFcAwpR+zrVYINDpFycKYjQdxgICcrR2MIYIjHwngY3Yt1sjN29oYkh
         9prhTWfyQcxQM423H/JHW0VCL/Lh0jB7BnkZllXHJ5izJI+Ty8mt/DP72kRgBs1QnTFl
         YuVg==
X-Gm-Message-State: ALKqPwcDVXZ6u4eQYv84B0CgricUBoD88djrhrDTdBoEKNGpGEEYFmXe
        UhIJjXx60/yVkxgwRN/JEQoosy1SNJb80iey7Wrk3w==
X-Google-Smtp-Source: ADUXVKK/xfatzVV+J+C5aF+9r0EnTmZQCQdkx7xz+5s7jwY9TBDJKWll0eUf8RnzlLR3ZIVT/Le/266r1tE174l4AtM=
X-Received: by 2002:a81:50d4:: with SMTP id e203-v6mr6825672ywb.421.1527882402671;
 Fri, 01 Jun 2018 12:46:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 12:46:42 -0700 (PDT)
In-Reply-To: <061ebcf7-f88e-4d4d-da73-f81e9251ee3b@talktalk.net>
References: <20180531110130.18839-1-alban.gruin@gmail.com> <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
 <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com> <061ebcf7-f88e-4d4d-da73-f81e9251ee3b@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Jun 2018 12:46:42 -0700
Message-ID: <CAGZ79ka7SMLdiVJVNU9Dzpzv4yQSYeODFnBxpwTDEhNnNkj7eg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for the explanation, I see what you're trying to do. I don't have a
> strong feeling either way, I can see the potential advantage but as it
> changes strings that are currently translated I'm not sure it is cost free.
> Do you know how the translators feel about the change as they're the ones it
> is aimed at?

No, not at all.

Hence I am being vague on how much we desire it.
