Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430471F453
	for <e@80x24.org>; Mon, 18 Feb 2019 00:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfBRAWC (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 19:22:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38264 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfBRAWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 19:22:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so15284562wmh.3
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HJ3JN57+gyIdB8GC6RL8cmsPw/X1STE6yV/6qxr4ddw=;
        b=BHRqhLPXGMkESGWUfdm5GjB6he1wKWSsA23ELd68bfgePsSg46K1dEDe2mYR6jmr5A
         31rGl0BRYe1GykcI7HCFHlEqmaXUXDy0Dr4uP9gEqYuyeNPNrqFCEmGnspVNXEtX4oIN
         7ie3jC8K8z4rpYScITs88epCTeGAV8MGEY5CFdFGVMhwfCSVkGyBE4+aF2bgsgU/NvuC
         9j0ncD3ZeNP6rZCHtzlEULsjm0yqI/Od0UgA1ZiuabgZ0glHSSRudwB70Qm+mdgIkLCH
         LQImgR4vnfvGdt//Y2YtchOXxTdWYVj1CmMHr3sKFtd8Jay2NDL1VjGxgB/3GTB1XN6t
         ONMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HJ3JN57+gyIdB8GC6RL8cmsPw/X1STE6yV/6qxr4ddw=;
        b=qnRvktnRtZm5cdf0CKuF8oy3MLjrHtY5JoQ/KEWB5WQUurkOR1vJh1QLpRZL+3JFhh
         MKbQJGsZvMLoeeL1mKO2lOYS0Ri0qcBYUcNsPDnNgTVjKHqXpsTA9MOVTpio4uyjU/B1
         X7dFkv9Fu+t/IkyG6VWM8X8UJ+5yLO/vK2E+3U6FkZmYLNJxc+nRbmObEyoA6StPDp1S
         /GuZE26VUltxn7VGlyQhxa/+C7S4Fyn9F908jtaZalfEivJe6o+CghCQ7YpW/E1wRgK2
         i0PnSi4qrpiWm5iQnW7uLpYuHLxzG5jV806L1ynrB4y6xLM9W8dKyESkNj8BwsYYCymH
         msVg==
X-Gm-Message-State: AHQUAubrcK/de0FrMRo/7RA3jgrxqkDi+t2Msm4Fj0B64DEkn5L7Zl4v
        xxaOubFkUGQQYpPaVfcNP8U=
X-Google-Smtp-Source: AHgI3IaibH/vYRa6HKDiAp2tJ3/o2c+lY6PqE0PIAb7eqyZnoX7c0RtN8nq8YVOP2oqzxBhnSlu4MA==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr14715439wmc.102.1550449318899;
        Sun, 17 Feb 2019 16:21:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h137sm10003205wmg.41.2019.02.17.16.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 16:21:56 -0800 (PST)
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
        <xmqq1s473x63.fsf@gitster-ct.c.googlers.com>
        <d2127f77-9124-0e01-e96b-b6a1650ebc59@iee.org>
Date:   Sun, 17 Feb 2019 16:21:55 -0800
In-Reply-To: <d2127f77-9124-0e01-e96b-b6a1650ebc59@iee.org> (Philip Oakley's
        message of "Sun, 17 Feb 2019 23:34:53 +0000")
Message-ID: <xmqqpnrq2bfg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> It was my understanding that the end point would be total removal of
> any options and the typing of the double dot would be an error. Given
> that hard end point I was looking to ensure that users of double dots
> have a manageable route to unlearning old bad habits. Thus the first
> phase would be opt-in,

Sorry, but I do not see any logical connection in this "Thus".  If
we are still undecided if deprecating double-dot is a good idea and
trying to gauge the impact, then perhaps an early "opt-in" to leave
the door open for aborting the transition plan might make sense (as
an escape hatch for _us_ the project developers to make excuse to
the end users).  But I am getting an impression that it is not the
plan you have in mind.

> To train the fingers, and to check local scripts and aliases, the user
> needs feedback, preferably at a time of their convenience (as opposed
> to being a time of inconvenience), so assuming they have been paying
> moderate attention to the release notes, providing the opt-in phase
> gives them that.

And to those who haven't been paying attention, what happens when
your "first phase" period expires?

I would be a lot more sympathetic if your argument were "some people
will not be ready to start training, and they will be helped if we
had an opt-out knob early in the long deprecation period".  Even
those who have not been paying attention at all _will_ be hit by
deprecation warning, and that is when they can decide if they want
to start training or they are not ready and want to postpone, so in
that sense, "initial opt-out" may make sense, but I do not see how
"initial opt-in" can be a viable thing.

