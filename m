Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022BD1F42D
	for <e@80x24.org>; Wed, 30 May 2018 23:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeE3XF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 19:05:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38213 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeE3XF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 19:05:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id m129-v6so50534613wmb.3
        for <git@vger.kernel.org>; Wed, 30 May 2018 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b6OWoYxK83rUaJV9a7+suctpBKxITh06NGW6E+KsIl0=;
        b=ouP/PB4MntrsalrIqsDNouNd3S6uF82YV387dy9dv2baYnw3y6tUdao/UavXyKW00F
         5kJQqphE0xNWYMCZPItfCPumLVS6bwAhkwfmiqKRMZ1+PcbwX/rH1U8CvenE3/rz6cQa
         UTnoHqy68q2Z5Nnvas33qe6PYhaXs0UIGve+OzMYh7JK545PoWkhbDjiJ2Z7xXg3Yw9b
         JCLczz4bNll6E5DvYPdX0mQkZY0BWE4iBCwtyE+WBj28s332gpdULXOYGIspFke78pPT
         82WaKywjAfpDO5q10XAJ8dRJCfDOlteaiH2IFdV8QFaF4MYgB2d9Ak9+FtdgQUjGor8T
         TPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b6OWoYxK83rUaJV9a7+suctpBKxITh06NGW6E+KsIl0=;
        b=BoLJwTX3fyliWLZPrqdCB79+Vzuu5tqjMl0aGx6giOGk7Zq4iNfisQ8h3msAIE0ESq
         W4Zi6h5rZ2sMQ2Szkwt4YP2tnfZEu7lyf1haOQVBmryxbbPmHmMA8B43lwu9JIhUazM7
         5Cu7tvBAZNAo9pYY6/Fn7cNwxlYRL7P5wn+5a8hxRlA/fSarLY9Ey6M/s5sVlK+R4OA8
         xUnMLqCERRAyaUdEy6BIML6eAl4wLKFLCAAdoM+LK7UwUGAohsT5CiDkejO8jaAPoTla
         FIBVl36YAXWQiXDj2FUt3PRwzsCyfDAfuFswGI9qijx0/+LGFZuvX984Vns2RcXA6TKX
         c8lg==
X-Gm-Message-State: ALKqPwdZyPdGBjPrue352avDvlgiGNB0xDvkJiycxpYRTVm5wl4QuhAF
        L3g5X3Pfk6qmP/8decXs8dI=
X-Google-Smtp-Source: ADUXVKIpoEY/WuaS34tVGPDSlfKKspvf/q/bsPjtB8JcOR6+lOWghAU8TXv1xYrleejbuUFveWd/4g==
X-Received: by 2002:a1c:8d8a:: with SMTP id p132-v6mr2574110wmd.49.1527721555947;
        Wed, 30 May 2018 16:05:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x63-v6sm30146878wma.25.2018.05.30.16.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 16:05:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 3/4] color.ui config: don't die on unknown values
References: <20180530210641.19771-1-avarab@gmail.com>
        <20180530210641.19771-4-avarab@gmail.com>
Date:   Thu, 31 May 2018 08:05:54 +0900
In-Reply-To: <20180530210641.19771-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 May 2018 21:06:40 +0000")
Message-ID: <xmqqin74d9rh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Before this change git will die on any unknown color.ui values:
>
>     $ git -c color.ui=doesnotexist show
>     fatal: bad numeric config value 'doesnotexist' for 'color.ui': invalid unit

I do not think "unit" is correct, so there may be some room for
improvement.  For _this_ particular case, I agree that it is not the
end of the world if we did not color the output (because we do not
know what the 'doesnotyetexist' token from the future is trying to
tell us), but as a general principle, we should diagnose and die, if
a misconfiguration is easy to correct, than blindly go ahead and do
random things that the end-user did not expect by giving something
we do not (but they thought they do) understand.

If we really want to introduce "here is a setting you may not
understand, in which case you may safely ignore", the right way to
do so is to follow the model the index extension took, where from
the syntax of the unknown thing an old/existing code can tell if it
is optional.  Forcing all codepaths to forever ignore what they do
not understand and what they happen to think is a safe fallback is
simply being irresponsible---the existing code does not understand
the new setting so they do not even know if their "current
behaviour" as a fallback is a safe and sensible one from the point
of view of the person who asked for the feature from the future.
