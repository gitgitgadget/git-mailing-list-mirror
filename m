Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FCD71F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeIJV7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:59:12 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39465 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:59:12 -0400
Received: by mail-wr1-f47.google.com with SMTP id s14-v6so13762727wrw.6
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E1rVjpl4M/RYEbQk4TLlgz1X595w4v4TDfenRBlWkmg=;
        b=c+jj4cpCKEH+xXPmfL6wLGwNbQ8ECHpU9jnJR6FU9tB0FopEqJZ6xxCvCdbnOIEeZ4
         gy0PtHKBaOGT90guNsF9YEsXk3uTJApkwHcdihW79vlcg34dcc30qO49Z6IC3bbuwPwN
         A5XX3Tpzr/i9U8KgINp+LjKyKlOwMVSUIPAKtrdvLARljkN/ZLQyEvsX1YbTtAczcAaW
         PfOuGQxCzR1CVQ8191c2cTjYDYe2Ct8mYCP5HZVTRXzeIfq/87Ds+VOP5DaWyANUFYea
         tMrIddTgkPPB9Q4bzIKb4vrNY+yJYfLJyaC/TFCizh6y5MfRhzMNu02KLb7DKtMZ2Jak
         7eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E1rVjpl4M/RYEbQk4TLlgz1X595w4v4TDfenRBlWkmg=;
        b=YOLUnKT9JnrbZ/ndFLDs8Y2HDKrgO1yHREghLgR3ErxrbSTrQxOHr5rpR1qNwhHXpf
         HyA8kkWKieb1++fhq9fmeL3iSIUcwpIJhTuaFdx5+69gcnoFkYQzsBGb/giyRv1Fzmkj
         Eb+xxEoGR3TMvTQVMrjuKjSr3AzQ9CEqTmlPB43xe5HJbvpvpfMOSlD/af4bldYwk6DA
         fsCj+Tgegp+vCO2a+oI3eCaL4p7F0q2NNc4bv/NYoN+hqJI31lD+lugbobLU9QmcKJme
         jP8ozhuHYJpZ5AF9Eut/e3HCaaMdZmgIsqiUnvEmGisq8nW/ywPlhOjHd6Fp4pqj7ABi
         lAoA==
X-Gm-Message-State: APzg51BSv2iSoNURSDWPYqnxzGYcsXsXont4ePMzwnC0OOi8BrzeMJmK
        /J95cp64KXNKImAMFM1TY1+cVBKI
X-Google-Smtp-Source: ANB0VdbPiJo7HTMA0PfAHAE32/aHMdMUaPNeZdtsxXYpK/fOZQzJ4Zx/+To//PdkHZqrJzRrJQofyQ==
X-Received: by 2002:adf:f84b:: with SMTP id d11-v6mr15204276wrq.172.1536599048936;
        Mon, 10 Sep 2018 10:04:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm20033663wmd.29.2018.09.10.10.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:04:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stas Bekman <stas@stason.org>, git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <20180908212256.GB31560@sigill.intra.peff.net>
Date:   Mon, 10 Sep 2018 10:04:07 -0700
In-Reply-To: <20180908212256.GB31560@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 8 Sep 2018 17:22:57 -0400")
Message-ID: <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 08, 2018 at 11:58:47AM -0700, Stas Bekman wrote:
>
>> This doesn’t:
>> 
>> [include]
>>         path = '../.gitconfig'
>
> So I think it's been covered elsewhere that single quotes aren't a thing
> in git's config format. I will say that this was actually a minor
> surprise to me, after a decade of working with the format. ;)
>
> I don't know if it's worth changing now or not It would be
> backwards-incompatible, but I wonder if we could do it in a sane way.
> E.g., with a rule like:
>
>   - if the first non-whitespace character of the value is a
>     single-quote, assume the value is quoted and apply normal shell
>     rules (i.e., no backslash escapes until the ending single-quote)
>
>   - otherwise, single-quotes are not special at all

At least the rule would not force those with ' in the middle of
their family names to surround the user.name with extra double
quotes, and it would probably be a good and safe practical solution.
Being safe "by magic" tend to become hard to explain, but in this
case the magic part is probably still simple enough.




