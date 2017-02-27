Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95661F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdB0Ty2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:54:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35844 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdB0TyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:54:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id 25so1984395pgy.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LELsSJl/SVdspeAxvVPm6uefG+1TRYS5+PmVC4Aq6oo=;
        b=H2Fx3zOpfJeu5XELVV3QOCPLYeHJtk6xJfBBQ7edEtTjOmT82LJ2+j9BjxVhVhvdYK
         IIhbZ9oJc992bdn3Wk4thmiU9t9znf8QTvn4EwU80UsIn2DVQh1bG6yNn6Pen+74JWHI
         fVLKnhq7SIUWjWzHPjsy9yhxnGP0b6Zlk3Q/b/pC+IVEHNt59h+GOS5n1esu3dYIRMjP
         jHIWJfYS8u9JV9Oe4VBpyIk7pdOKz/CEkP3rn6co5NJeozfTlWp+dOBKaRvokrPGhYoB
         5dfgHeaSvJL9PmevrBo2zxArC7ft6SfifKl60wjulcWH/qDEm7oCtDuLKmtyUQ7Cz9jP
         Q6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LELsSJl/SVdspeAxvVPm6uefG+1TRYS5+PmVC4Aq6oo=;
        b=UhGfuZhm8vYCUU7fRDxWJ4FSnopUDuLzew8MKnzwsmouDGDdXx91XI7h1Okz7Dv27q
         6cN8ncr6EehIJR3wqIdudg9P4FCjAx7cr5z4nO0MpPU6PI0bEmEryp17LDseIAu4qeXv
         WvyjF3ioIBP47eEFfSn3pW0ti4P2D23GadKKEiCCGBxvG4DbNj65z1AVR0vZ9upUjF8A
         HB72cHNhkUJw/KkOUS4pMMaGR5W8PZDSTLGWBEiL0640IFbi/9i+K9lhU2NVNbGAjSVS
         YWNP0Bv3FjXbi6k3B8EGvT0Nbsmtrz8+o2/glDZOzH/zmd4i5qJCN9IspNScSCzAznZ7
         F6Mw==
X-Gm-Message-State: AMke39lp0HKWAcMni80jnwa5Eqnn3BnM7+A+5mDyYBMbZ62ufvk8P/p3l6Xh6HQFzRCw/g==
X-Received: by 10.84.231.134 with SMTP id g6mr26910878plk.110.1488224733568;
        Mon, 27 Feb 2017 11:45:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id r17sm32363158pgg.19.2017.02.27.11.45.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:45:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     "G. Sylvie Davies" <sylvie@bit-booster.com>,
        Jeff King <peff@peff.net>,
        Michael Spiegel <michael.m.spiegel@gmail.com>,
        git@vger.kernel.org
Subject: Re: show all merge conflicts
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
        <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
        <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
        <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
        <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
        <6ff25254-720e-5b85-ba6d-22b16e91b354@drmicha.warpmail.net>
Date:   Mon, 27 Feb 2017 11:45:31 -0800
In-Reply-To: <6ff25254-720e-5b85-ba6d-22b16e91b354@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 27 Feb 2017 15:28:32 +0100")
Message-ID: <xmqqr32jwh7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> If you're curious, I kept rebasing Thomas' remerge-diff (on top of our
> next) so far. You can find it at
>
> https://github.com/mjg/git/tree/remerge-diff

;-).
Yes, this was a good one.  


> if you're interested. I don't know what problems were found back then,
> or what it would take to get this in-tree now.

If I recall correctly, everybody was in favor of what it does (or at
least attempted to do), but was leaky and not ready for "log -p" to
be used on a long stretch of history or something?
