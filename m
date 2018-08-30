Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71551F428
	for <e@80x24.org>; Thu, 30 Aug 2018 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHaBZH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:25:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33927 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeHaBZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:25:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so9343993wrd.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NtyStg2B/U23ImAFJ4frpM8I8ATQMS2laMGwZxzJsQ8=;
        b=qEePlOaAzlywkYHfXeGyU8d/DrJi8l01z7Tcnr8pr5TYbM+De3ziaG6Cz/oM0z3bky
         NRYcFb3ST2s7ZS1H2p9SpR1r2AD7dA2QY849Z/9fu5WfqOMfW4oojdkUV3WQvR2Mzec7
         oAyV+X0PQ923u1NiT5DjsRRhBtpARULGBuMKKp65bTUKHjiTnqNKDDOVWNsbpuDtRLML
         d7fagRE6ePUuRSfbFoiO8VxkENPtA+DtEenAHyTPVe3EZGeOpgP6XHekpXNYxj6kIL02
         ujzF0JWNEKR/eP/Wl+3foGGyYRT/3KzWKUNMIZeWaVqnzbickFz763TGW7AGzeSUlq42
         V7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NtyStg2B/U23ImAFJ4frpM8I8ATQMS2laMGwZxzJsQ8=;
        b=LuRPORUUaZtmylWAnJ7LOS5mO5qaWQxgkRX6HJITdrRuwXCweV18wGX0MYPWZJEvsj
         HIjPHPmQLBRo5TOo/YR1/+SiaQvxBGlv0YdbFyVXYN/s1feyA5KkkyYvBisxCV10fPA/
         ySZlJO248zXh5AwgujsAn0htQ1HTXuLyK7pOaX4JHJaXswOGrUfKW3/0AAHpMCQwI3wE
         Od6BOeno3QHq7UxHuC2s/jFFO6o4U7pNZKy37fx/qbB+qNpSU4npMwnsjS8mfxBzeWCP
         GlxX8HbCgGhU0qQAJYZNvRsi5Y5OmDYF0/2p/zGaxYe85e16lQ/zRhWBb7M1Q9OiAuLj
         qZCA==
X-Gm-Message-State: APzg51CuUqx3DmRZQx9+tst0Cza+qWECqY7O0hQqloFglkStVAQGpdYz
        hzNQe9bcoep+fdraho4WjUY=
X-Google-Smtp-Source: ANB0VdY9FJMVwQ69GnMtXDwnofUxxQqHY6I4cozzQLEwpPYDA6natSR26zu4LRTb+MaJ7hOjdv1f6g==
X-Received: by 2002:adf:eb47:: with SMTP id u7-v6mr8702694wrn.22.1535664058522;
        Thu, 30 Aug 2018 14:20:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y184-v6sm3100941wmg.17.2018.08.30.14.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:20:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H?= =?utf-8?Q?=C3=B8gsberg?= 
        <krh@redhat.com>
Subject: Re: [PATCH v4 2/6] push tests: correct quoting in interpolated string
References: <20180813192249.27585-1-avarab@gmail.com>
        <20180830201244.25759-3-avarab@gmail.com>
Date:   Thu, 30 Aug 2018 14:20:57 -0700
In-Reply-To: <20180830201244.25759-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Aug 2018 20:12:40 +0000")
Message-ID: <xmqqefef4kli.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The quoted -m'msg' option is passed as a string to another function,
> where due to interpolation it'll end up meaning the same as if we did
> just did -m'msg' here.

"as if we did just did"?  Also the sentence says -m'msg' is treated
as if we gave -m'msg' that is tautology.  Perhaps

	... as if we just did -mmsg here.

is what you meant?

But I think the pointing out I did in the old thread is wrong.  If
you change your "-mtag.message" to "-m'tag  message'" (notice that
I have two spaces between the words) and then insert an invocation
of "git show -s testTag" immediately after "git tag" is run to
create testTag with $tag_args in test_force_push_tag, I can
observe in "cd t && sh t5516-fetch-push.sh -v" output that
the single quote is taking effect just fine.  IOW, I do not see
anything wrong in the original "-m'msg'", which probably anticipated
that we may want to change it to -m'tag message' or something to
clarify.

However,...

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 539c25aada..69f7c9bfe6 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1009,7 +1009,7 @@ test_force_push_tag () {
>  }
>  
>  test_force_push_tag "lightweight tag" "-f"
> -test_force_push_tag "annotated tag" "-f -a -m'msg'"
> +test_force_push_tag "annotated tag" "-f -a -mtag.message"

Comparing test_force_push_tag and test_force_fetch_tag which is
added in the next step, I notice that the former ignores $1 so
passing "annotated tag" here has no effect.  That may be worth
fixing in a follow-up patch like this.
