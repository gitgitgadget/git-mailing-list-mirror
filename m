Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C46B1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbdBAWzO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:55:14 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33296 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdBAWzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:55:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so32710070pfg.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 14:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A3Wp05v39OkoXKjhv6J+U+EoBNLZvPHFqByx/lI/Bzw=;
        b=obJ8rUdVbZJO0T+e/xoaUdqvAuuqG6fe81cDIA0P/dVUAAsAip23+0w1lBLm2LGP0l
         xLY30CLnscJHJ0jylTTiX8CEXWJJsEoXHnZbG6foek99IizaqAWiGcTHdjgflmmH2n4T
         1du6/rqBMkoI9Nzn+a02VaslFfvEX/q0u/d0TLH4/obsVKfazSxe+6XH5nJuBZ0eiK92
         pjN7LV3fjh6JeCOsH6pTCpxPfxflqIzLTaMomUoA5GWM9YL85997UI4E8Yql4mJSgNDI
         gYbEUOuDrx+vFs3JCI+C7uioOTQNUVECThzvt7U0wfdwiyYYZIbwE9G/WjvXVkOFUsYc
         BsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A3Wp05v39OkoXKjhv6J+U+EoBNLZvPHFqByx/lI/Bzw=;
        b=RcBTNbBFVXE7/2zkHU7HXbsxcGGdy/RQwCtina89jAXICyJR3ySiGWlWbi0cgHeTQt
         nNPyw8PwzfeHbJqx4uQV4m815Mw8oFj8foQHBzUyyndIXDFzM8HiMmHQ5V7iMgSj3PpE
         fUJcNHyYKrmzFtQEszQHHYU+zH7+zropIUTolfAOrPBi5FWLqyLV25+snu9mfpWxxjT6
         Yl/HRLA4DqSCnebUijIULF9E0iY6SVq3V7lWullFwDf1l9Ukrpn8kxwH3Ld6IO8oNlR3
         P1+ELOtZnw0lOVPGO9VGrTmhSzHV1XYnhqrYgULVv/UKrRwKdWbzNlIepgK5keWb88AE
         zqbQ==
X-Gm-Message-State: AIkVDXImuqqLJl4qVtlvRURML6ZI2dOBNpHAXn+rp1rqXO/+AFNFZRY7H7leG9gIvEG8KQ==
X-Received: by 10.84.238.1 with SMTP id u1mr7989304plk.174.1485989713100;
        Wed, 01 Feb 2017 14:55:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id l22sm52618700pgc.43.2017.02.01.14.55.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 14:55:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Handle PuTTY (plink/tortoiseplink) even in GIT_SSH_COMMAND
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
        <cover.1485950225.git.johannes.schindelin@gmx.de>
        <xmqqr33hoetx.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702012311440.3496@virtualbox>
Date:   Wed, 01 Feb 2017 14:55:11 -0800
In-Reply-To: <alpine.DEB.2.20.1702012311440.3496@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Feb 2017 23:17:54 +0100 (CET)")
Message-ID: <xmqqr33hmshc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Compared to the correctness issue, these are much harder to spot by
>> the submitter alone, who focused so intensely to get his code
>> "correct".  The review process is of greater value to spot these
>> issues.
>
> We will never agree on this.

That's too bad.

> From my perspective, design, explanation and maintainability are a
> consequence of making it easy for reviewers to spot where the code is
> incorrect.
>
> And correctness is not covered by "the submitter tested this". Correctness
> includes all the corner cases, where the "many eyes make bugs shallow"
> really shines.
>
> I'd rather have reviewers find bugs than users.

I'd rather have submitters find bugs than reviewers.

> I will *never* be a fan of a review process that pushes correctness to a
> back seat (yes, it is much harder than spotting typos or lines longer than
> 80 columns per row, but the ultimate goal is to deliver value to the end
> user, not to make life easy for the maintainer).

Did I ever say correctness is pushed to a back seat?

I said that it is easier to spot correctness issues for you as a
submitter than other kinds of issues without outside help (and
implied that if you are a diligent contributor, you should aim for,
and you should be able to achieve, a patch series where correctness
issues do not need to be pointed out).  But other higher level
issues are harder for any submitter to spot (regardless of
experience and competence of the submitter), because one gets so
married to one's own code, design and worldview.  And that is why
"review is primarily to spot bugs" can never be a correct viewpoint.

A reviewee needs to be prepared to accept review comments on higher
level issues, even more readily than comments on correctness issues,
because it is too easy to be constrained by early decisions one has
already made while preparing a patch series and become blind to
bigger picture after staring one's own new code for number of hours.
Higher level issues can be more easily spotted by reviewers, whose
eyes are still fresh to the series.
