Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20011F453
	for <e@80x24.org>; Mon, 18 Feb 2019 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfBRSjy (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 13:39:54 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51672 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfBRSjy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 13:39:54 -0500
Received: by mail-wm1-f47.google.com with SMTP id n19so115310wmi.1
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/lOAJz1I97PuV3rJSz4zFo4rNu+Jr17MsJmo1ASkdFo=;
        b=C1px27uq47OKdIJ4912IfJ2G5b0YVVeFKGP0TF6NcjRD+Bz4oQ3j53porPjpRwrW3m
         VSv3+D34p18oVgdbKRpUlFyDpahYykrNWQ6AHdaJRrDrUiOXAuCMOmsg8vDABGFCG6Cg
         pd7UOiN8MA7uBFTWu27QBAg5IgUL2hRIxMVTzDw9lsx8XwCnxeVLz0/aTC757NyAjd8l
         CFWPzjG79yNtXFz4VMe0O9chLQ+us6yDQszYGG7KytzP6ld5ALfM57WgIjDmnwaYq17T
         5Xxauts5GKTzsT2yJauKjmPiU85r/Mq1WBh4iAY4099TmKnbHODPA+17UYfuwO0grTJo
         uEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/lOAJz1I97PuV3rJSz4zFo4rNu+Jr17MsJmo1ASkdFo=;
        b=OSrrz6Z9ky0yogIvm1Gns1l40tlnut1FgMGlWIcaRurB07uJiPgE01cJaeSNclH5uU
         FERkWzGteBgxcBbERh2vaU26y45NQ9+DvkbYnxvWhzbPvzIbKwNwyRX7VrJqQCRp5Pk1
         vgpI6HTqPt5RcnT1CbN71gCwOc4PZlZTMQRXFtFyEj4bInadchZCrv6nyqLUJ7ysfFZL
         jc7r5WgDEcw6I3yu3xiwwPwySKZXVNcnTMpzxGP0QBV2coz/Tg4MLmLj0M+HkKc8SO4j
         p7Ao3yD5qmgXsNi1bKhrUz/vFwCUSmRp+Au/QdNlEq/+XbcbSASw4O2KonTjjzWtCg/n
         qVPQ==
X-Gm-Message-State: AHQUAuYRT1RS30igP06MyrSbuNMpm78uMKRcUrvfitJqVlKGdKgwmuLq
        fSe92rr6cyltHsrCZu/qKuk=
X-Google-Smtp-Source: AHgI3IZ0UDv/FqpQO9z7WJzB0UY7aWnd8rGl4prWCofnnSWSh9sGtNOuArRJ460WBq6GYNxU+2xtDw==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr141409wmb.52.1550515191473;
        Mon, 18 Feb 2019 10:39:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 90sm33505256wrk.95.2019.02.18.10.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 10:39:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Senol Yazici'" <sypsilon@googlemail.com>, <git@vger.kernel.org>
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status Notification (Failure))
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
Date:   Mon, 18 Feb 2019 10:39:50 -0800
In-Reply-To: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 18 Feb 2019 11:51:57 -0500")
Message-ID: <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> Taking a lesson from other Open Source projects, Jenkins has deprecated
>> Master/Slave in favour of Controller/Agent. This seems not only more
>> acceptable to some, but in my view more descriptive. The terms on the page
>> above do not actually make any descriptive sense to a newbie. And confusion
>> could ensue from the dictionary definitions:
>> 
>> * Lieutenant: an aide or representative of another in the performance of
>> duty : assistant (not what that repository is for)
>> * Dictator: one holding complete autocratic control : a person with unlimited
>> governmental power (not how the git team behaves)
>> * Blessed: honored in worship : hallowed; of or enjoying happiness (although
>> I can see the happiness part of this one)
>
> It probably would be worth submitting this as an issue to the
> documentation project at
> https://github.com/git/git-scm.com. Depending on the response from
> the committers, I might be willing to take that on, but digging
> deeper, I'm not sure the terms I proposed as sufficient.

I personally do not feel these three words are so problematic to
spend bandwidth discussing on here; it probably is partly because I
am not a native speaker and am not too much disturbed by connotations
they may make those who are more fluent with the language feel.

The page describing various ways a project can be structured uses
the kernel project as one of the examples, and over there, at least
"lieutenant" is a well understood term to describe those who feed
Linus (because Linus does not scale otherwise).  I do not know if
Linus is called "dictator" there but I trust those who wrote that
"distributed" page knew what the words commonly used in the example
project they chose.  Deviating from the words they use would make
the example harder to understand.

For that matter, I do not know why borrowing vocabulary from any
well understood area, be it military or religion, is a bad idea to
begin with.  I personally have no issues with people who worship
deity of their own (or none). That probably is also due to where I
come from, where we have 8 million of them ;-)

So, if the reason why some people feel "blessed" is a bad phrasing
to use is because it came from a particilar religion and other
religions have no such concept, I do not agree with such a feeling
at all, as long as those who hear it all know what the speaker means
by the word.  I would have more problems if we pick a word rarely
used that nobody would understand.

I _think_ that is what the distinction between "acceptable" vs "more
descriptive" mentioned in the early part I quoted in this message
talks about---I do not quite by "acceptable" part, but I care more
about "more descriptive" part.

Thansk.



