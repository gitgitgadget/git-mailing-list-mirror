Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB0B1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRTaD (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:30:03 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37651 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRTaD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:30:03 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11-v6so9954696wmc.2
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=phsDKEh/5Xm52WKFBRaqIryVnnRGzQjpdCtWj8w7TZc=;
        b=dTIJGQufokfAecpO7ZytyrU0FjyXWn6/fNVXx1rAJCitFF9L9QYpXaAJAk4aGaerKu
         TxVtry4DXTxAJY+uJkl1QuGWLfJpMXOg2UvzMdOD0yXqCpt/erl/O5cn9O7OenhPXMPr
         NfjuCaudRoniM/LTKUNnMP//6uP0BFN3GOb0vqJ8eoFlPIxcJ9OhLBbxira38pYwseKo
         qlb9jL1WN2xeqCFBSMha6CYIULYJjTtN1/NRIGJ8e2CL17o7NkHdvI/f9d5UMKovA+S2
         2qrqjUFx+YFPrAqwLsx2Im1vXUW7rzN+e6s6bS2BXc7tMxz89uJthqoax0LrCHi4Cpw1
         kRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=phsDKEh/5Xm52WKFBRaqIryVnnRGzQjpdCtWj8w7TZc=;
        b=Azg4f/m0zuSjT2jU0FokjwGD9xX21DXewETaB6gxpVDpwNYjXGBWWTxMfUy9BtWjda
         5u3hwjPnKSf8E9rXK4fBCqODXMyAdHreYZSwz+doJezFlZk45Ca3mMD75QdJY54tZOWL
         WQT81gN1A1GstOqG4px58hbcYVN9qmd00jKl7vUupQicARLuNOFIWnx8aNsrvXGoZtg8
         XaIL712dW1xrZWUy7eyn18abhe3kCSsi5kNuOvg2U/N3fOCpwJY1K5kbhveHInM/B2lO
         CIebXCJ9Lg9ONoSPCCWD9choLhFxB9NZ/KoKmJ6dY/wTzaVRj6aN5zjjUeFE3Ue7x/JN
         Xg6Q==
X-Gm-Message-State: AOUpUlFHxpM9SLm7BjdIWdwEoCQWSPJfYs/JFbshILRIXm8uxlqsRAx2
        KZaC8me3Y+L89bmFMlN39jyB0lFW
X-Google-Smtp-Source: AA+uWPy1oo32VBGPhfkuBkj2fO0RIl4Tg6I5oT78NqQdGBcwR2Si3M2B3ZZu1grMuyzA+Mzu6OBEsA==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr21522097wmp.129.1534609306394;
        Sat, 18 Aug 2018 09:21:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm13228409wmv.6.2018.08.18.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:21:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael =?utf-8?Q?Mur=C3=A9?= <batolettre@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-bug: Distributed bug tracker embedded in git
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
Date:   Sat, 18 Aug 2018 09:21:45 -0700
In-Reply-To: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
        ("Michael =?utf-8?Q?Mur=C3=A9=22's?= message of "Sat, 18 Aug 2018 00:06:35
 +0200")
Message-ID: <xmqq6007abmu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Muré <batolettre@gmail.com> writes:

> I released today git-bug, a distributed bug tracker that embeds in
> git. It use git's internal storage to store bugs information in a way
> that can be merged without conflict. You can push/pull to the normal
> git remote you are already using to interact with other people. Normal
> code and bugs are completely separated and no files are added in the
> regular branches.

This reminds me of a demo Scott Chacon showed us ages ago, the name
of which escapes me.  I guess great minds think alike, or something?
