Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22721F597
	for <e@80x24.org>; Wed, 25 Jul 2018 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeGZBBP (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 21:01:15 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38541 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbeGZBBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 21:01:15 -0400
Received: by mail-wm0-f47.google.com with SMTP id t25-v6so159920wmi.3
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RhocosnWQLefWP7N0DO3ZU4K+aTnePe6cGbnC+t7Gog=;
        b=fi6Zy43VdL/PBQj2pR9Rl29Irdfsw/w1e6YBSINQbWiucplWuX5RhaGhLGR/nTddQa
         4+vadASjVAkOPltc4oLF2/dI5LZrTH6nkhxJAaGmuzDz9+70dXLtEikey2PS+e74zfeg
         B4snVaFB5dNbcRnrKjq5UPIECwH8KtRzTBu0aKHIVmUhIACYXvIalTs1ZpkWg0l0zygc
         5dgXgS6PjiVKsPOFrR3ae8CTGOis5004oLn/sNFnox9bj39TpQ2Urr6/E/1aRmGH2zni
         0/wqgXy9FYMU86cfcUjZQflby3yrkOm7J7M6V7DEw2mlVdSz9sCdBx/berBq6asFHllz
         obJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RhocosnWQLefWP7N0DO3ZU4K+aTnePe6cGbnC+t7Gog=;
        b=XIHl5TFk/zGLi/RON7zZJbwGGcFRRjYWXigPSif5OL3vQYU/6/CnY6ib78i0ODwxth
         5c1DYVM0R+/oUjsKELnN7jQNljUiYDYDuMk1JM0Qc+C5tl/DKl9ldtjjntGFHS0dRU+Z
         h/eWzY4aNrW05bejlZ98/ZlZ0htQlx6WtVJ8OisKMGvUjQPZT4bvvChXNUb3E7KkA7fw
         yDuJC21Rql5/rr1Rci3RVmhLz3sf19CNrcdegkNnVQYG46LbKNbV4zFCh/4UdQ+tNwvD
         Jhr7zWq4fpy5NfyqrfL7LGY3Qdc0yuTu9d/nS8+zRnQZfl0Bt/y7OoxQ5mJukBz3Dgog
         xvjA==
X-Gm-Message-State: AOUpUlEtmT+TkUuWh7bpXHfptJa+Lku88JVCYF/PRp5t17Jymfh7eG/j
        Mx8L8V0CEaKFNO4YO88lMMQ=
X-Google-Smtp-Source: AAOMgpdnrx4iP3ewSCVnNum1ofQE1/oaq+fpzpU2NN0yTOP//w2c182ylrCgLa97XrLpX2PQsBLqSA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr67934wmd.44.1532562431685;
        Wed, 25 Jul 2018 16:47:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b2-v6sm69782wmh.20.2018.07.25.16.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:47:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
Date:   Wed, 25 Jul 2018 16:47:10 -0700
In-Reply-To: <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        (Stefan Beller's message of "Wed, 25 Jul 2018 15:56:17 -0700")
Message-ID: <xmqqzhyeswsh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * jh/structured-logging (2018-07-25) 25 commits
> [...]
>>  - structured-logging: design document
>>  (this branch uses jh/json-writer.)
>>
>>  X-Gah.
>
> I am not sure what to make of this comment?

That's just a line/editor noise.

> Does it need review or is the design/intent to be
> discussed?

The topic certainy needs serious reviews and response with updated
patches (when reviews come, that is), I think.  I also agree with
somebody who said slog is not a good way to present it in the doc
that are to be used by non git developers.

