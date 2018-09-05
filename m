Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E821F404
	for <e@80x24.org>; Wed,  5 Sep 2018 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIFC3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 22:29:10 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35732 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIFC3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 22:29:09 -0400
Received: by mail-wm0-f52.google.com with SMTP id o18-v6so9250788wmc.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TsXrVLoXJKApbVDpGMOOOlbVGXb67k/kXr6JkyNUZeQ=;
        b=lfXQNvxGvZFOJRZ7GanHYw+hHbpFUM68NBGynF05OX0wr4fv0FQIieTO2niNIbr9IX
         6pi1W4LG4kAiaUf/v1WFdtW9y98RSNU1Dc2IOdXuA9axtwn8UBsO6EEF+o+DF72HBMFs
         97DoJpVxYm/cLR7Im//E+JOgFW/zSgjFqi/1mlQgyUunfZEeK4ZzL1yx2EaCFqhViZ5F
         20ba/cZR3Xj+AdQOrxGLykhc8U7t+r7bEtOcs4wG8rVXC9TkP3SVjHem72DDRQ1wEu1P
         TxWaY4S/CJccPA+O7zqIW6GWgHIflU9YafyW5ZWnjn204Y0mpOH17x5+3C3DWsrwMvQF
         pY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TsXrVLoXJKApbVDpGMOOOlbVGXb67k/kXr6JkyNUZeQ=;
        b=EYPhgn2JHuMEW6j25l00BN+lTJir47ERq0dFVY3/JuK5lu0DYmLPOKyZMcxeoAmRR9
         Bll1yggdK+QDi2CWEt+SNcu8h9bZVtvi6FIKI1Zyk8fy/A/zzSjgFSDdYZTIlRufMpwk
         YyPbWrQefHWkj2raNOGVa2nwF70dQcfEwI6wOLulNyuUKgGdB5AgvQYXs+qLUQq8taeR
         CER8dXBdZFz+of0bdLCpu5NXDuiC+G/30GQVrDlwx3UKs2pH1rmzniHynh6/SFnq+TL6
         UaNTHymp8wdgZg/wBdFl+bN9KqO5g7Ayj32KAnGTQC7LXknhZ5jN3mzCYT35hlugs+DR
         lRNQ==
X-Gm-Message-State: APzg51CEL5w75I5KAxrQ9JIP/j6c9ZV1DEDTY4TBFmsbDee8we6yLEaB
        AJG2c2XLyz3a1mzlqpN7+DQ=
X-Google-Smtp-Source: ANB0VdZFUK11Mr3YKipClRHTe/IpQaBhs0Bp2S0JZsdH+uwISx+1p/FDpXgDBaBQhmExKTOORQbooQ==
X-Received: by 2002:a1c:6705:: with SMTP id b5-v6mr222849wmc.78.1536184619285;
        Wed, 05 Sep 2018 14:56:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l16-v6sm2070663wmc.38.2018.09.05.14.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:56:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <CAPig+cSETNc5nRxf_zQq6JE8zNyUvKmdPWNsm6=NMSOXm2DV=A@mail.gmail.com>
        <20180905203111.GA9752@sigill.intra.peff.net>
Date:   Wed, 05 Sep 2018 14:56:58 -0700
In-Reply-To: <20180905203111.GA9752@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Sep 2018 16:31:11 -0400")
Message-ID: <xmqqlg8f38wl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> [1]: https://public-inbox.org/git/20180830075431.GF11944@sigill.intra.peff.net/
>
> Yeah, I'm not sure which is easier for Junio. I figured by replying
> inline, it makes it easy to pick up on top of the others (since it
> really does depend on them and should be in the same topic). But it is
> easier to overlook as "meh, just more discussion".
>
> Either way, yes, I'd be happy to see that patch on top.

Thanks.
