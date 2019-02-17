Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F00E1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 03:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBQDes (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 22:34:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51140 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfBQDes (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 22:34:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so13877318wmj.0
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ov6DjY2s725mnwSF5l4yDhB+4C+EZth0Cx/w1SLgKd8=;
        b=u6krwUWcpyMpZJQtEFZ+6wX0hv65CgG/hHtnCKQT9jteciXNUX0wChLVqZRzcT1xjt
         V3oUs6adcuQT/JHJb/Hedw1JTm7fn2/YpN4KDIlXjxlw9KU0tJJ9+qpgX5+LRCRWzeJh
         Qh4nD+1jbAJbqupYANNV4WVhcq8QyQs7eJExw+6PhCNenCzH8rA5OgmcscI8IvYigEEY
         hkyAs4/ak4itow7CG3pl/TV2EItdCtOpbtvTopx36FagqW61+PtLmGhFnaiI1dLUvn3P
         0XMlxfGKdfv7NUI9P8Kziu0IFIwz+NBC+s3kgSmynxlgLdxh29w0N5MfODYhA0qQ6u0R
         5hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ov6DjY2s725mnwSF5l4yDhB+4C+EZth0Cx/w1SLgKd8=;
        b=ga6Oht3ffgCMeGAI/Nq4tdhnLGnlRt22PTPYM3ViKaQaUbV5x/x1p8XCNPRFp7JgnI
         Gtvbe/HjNB+mGeOxPrO2GnHjdsieCkPzMypLy8FxYOyYV3atdExJWebf5YClQMXuYs4H
         p1a+SAR0Gy9oMl+U8n3VOzwGSfKIbkksjOzne+m8GshJ7/e2RlhwTtk54kV/Ro018bJY
         3D6IW2THpKqLUKYIm2LnlD79NmEkpuQNAACS7YFMmqFmXpx9TK8gRd1GBxqI93sjDLp7
         uPhRmy9wF8x4gNnlKOtPMRHWkddlTi7YqnIJ9Xt5Q/qpNXrJXly4+hw0Lxs7id/FTkti
         QSng==
X-Gm-Message-State: AHQUAuYgDmQQ4rMW7bS2o0NGVxNSe9biaGSC+rby0eZvEEXV1wPcyAtR
        lp8htwUjDIYLZ18F63QK4Qs=
X-Google-Smtp-Source: AHgI3IaU9DX7PnzrNcftAvO5w8c63J/DJM8yXArlypvd/d8S2AyqvOx/dEwO+Um6oR1z8ajAru13aA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr10940850wmb.98.1550374486325;
        Sat, 16 Feb 2019 19:34:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i10sm19010707wrx.54.2019.02.16.19.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 19:34:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
        <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
        <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
        <20190215185202.GA28019@dev-l>
        <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
        <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
        <ad85402e-0ad2-4f4d-3b66-9250115072c0@iee.org>
        <xmqqr2c84ohn.fsf@gitster-ct.c.googlers.com>
        <dca9622d-c8e7-abcb-2e13-73bd8bb9dd84@iee.org>
Date:   Sat, 16 Feb 2019 19:34:44 -0800
In-Reply-To: <dca9622d-c8e7-abcb-2e13-73bd8bb9dd84@iee.org> (Philip Oakley's
        message of "Sat, 16 Feb 2019 12:47:52 +0000")
Message-ID: <xmqq1s473x63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

>> Those who do *not* opt into that "early warning" configuration dance
>> would eventually be warned whenever they type "diff A..B", and the
>> timing for that eventuality is not under their control, so quite
>> honestly, I do not see much point in "giving users the chance".
>
> With the opposite hat on, not giving users the choice does seem unfair
> to those that are trying to keep up. If we are warning (in the release
> notes) of an upcoming deprecation (in the code) then it does seem
> helpful that users could buy into the deprecation early, and at their
> convenience, to assist in the unlearning of an old habit, which can be
> much harder than learning a new habit, hence my comment.
>
> You are right that those who neither notice nor care will be surprised
> later, but we shouldn't let that limit others.

I still do not quite get where you are coming from.  Are you saying
that those who do not opt into the early warning may get 2 cycles
(just picked out of thin-air) of deprecation period, and with an
optional early warning feature, those who feel that 2 cycles is not
long enough to train their fingers would spend 3 cycles and they
will be helped than without?

That line of thinking sounds somewhat ridiculous---where does it
end?  If those who opt into would find it sufficient to have 3
cycles to train, there may still be people who feel 3 is not enough
and want to have 4.  As we make it longer, we'd cover more people
and at some point we'd reach the point of diminishing returns.

Wouldn't it be even better, and far simper, to just extend the
deprecation period to that many cycles to make it long enough for
majority of users' needs, without any early warning option?  

The thing is, once you train your fingers, it does not matter to you
if the deprecation warning is still there, as you'd not be typing
"diff A..B" at that point.  So I am not sure who you are trying to
help by the early warning option.

Thanks.

