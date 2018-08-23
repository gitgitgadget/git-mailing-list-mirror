Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540E91F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHXANe (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:13:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeHXANe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:13:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so5693415wrf.3
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CJEsuxjmRCzsoLhMW8VoI5ng4fjtEFTY0J8vMTgjXlI=;
        b=TwapB+cb3aL8RZANG6DM2zt7FAqw7WcwZFoy1vvGp0mEDVMTLcSaJE1Bw2WXWNj/+7
         QfPr2QYBhwVgGd8CqwCEMpO7vm/7er/WivoS8AvbwMTRWGOozfySoVxQl6EPGmwhlzBO
         g+JS9eDiVaTZGmO/cO6qIAN/zG9smsFoW8QKZoS4re/pl7Rs8ehmDGwTv15ExM8EO0S1
         HI94m+ikELlLFbcCfxJeKx7u2+b6b2j8dxWW2QZtzy9hjwjjnW1pI5AW06NrubaQtMPO
         LJvGhlp4iyzNd+rpq+kErX7xGaKZY6eZ+t/qUvKHYYGCMii21Mp0Na3M0P30BpIcniBa
         mkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CJEsuxjmRCzsoLhMW8VoI5ng4fjtEFTY0J8vMTgjXlI=;
        b=PwsJejo5jvx1w/bjc0CTPJKSg1MdVJSFQXG6cvQLW8UGMmxCD7J5WkdnFH4iR5zIyi
         0zUj3wq761lBjaIHAbX3A2vVZqkhtkwcsqTBS6N0zZ9b9gdjc6dPecG1wDMuHHFzfNxO
         HrNZ6jdvnM5vBPp32kBJMqVUIp85i7AswU9lZJPDGOWcgjk0SGH0om9fQq54Y1CZ1f0P
         nPZKgSbT+RO/mhcDtI9wBFS1OpNG+jK+LgOc6I9Bjyd4Ouhud6lXO/F2BVlheya7XzS6
         54cE0meiN3VykSuzEJU38KGmBCYHuWQAufXB6/202y38xKSmTS2uoMvyXxPg9PHgvUHS
         /RmA==
X-Gm-Message-State: APzg51Cm8iqPXRTUD4B8VVFN0o723bkDOWsc+9wV037P2CDB8ECyJFJL
        Jc3p4OsdE1gz4dr6ff3kzso=
X-Google-Smtp-Source: ANB0VdYBUraKCvgmo2Rd6j05k5iYUfiWfb2iUPB/7UllzhWT9x1d6eqQHNYALl/eLTtltDw4uCz/SQ==
X-Received: by 2002:a5d:4684:: with SMTP id u4-v6mr2673407wrq.76.1535056929741;
        Thu, 23 Aug 2018 13:42:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l16-v6sm3906265wmc.38.2018.08.23.13.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 13:42:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 3/5] tests: use shorter here-docs in chainlint.sed for AIX sed
References: <20180823152502.3886-2-avarab@gmail.com>
        <20180823203604.5564-4-avarab@gmail.com>
Date:   Thu, 23 Aug 2018 13:42:08 -0700
In-Reply-To: <20180823203604.5564-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Aug 2018 20:36:02 +0000")
Message-ID: <xmqqa7pcizmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Improve the portability of chainlint by using shorter here-docs. On
> AIX sed will complain about:
>
>     sed: 0602-417 The label :hereslurp is greater than eight
>     characters
>
> As noted in [1] there's still a remaining recently introduced
> portability issue also introduced in 878f988350 ("t/test-lib: teach
> --chain-lint to detect broken &&-chains in subshells", 2018-07-11), so
> under AIX the tests must be run with GIT_TEST_CHAIN_LINT=0.
>
> I don't know how to solve the other issue, and this gets us some of
> the way to GIT_TEST_CHAIN_LINT=1 working again on AIX.
>
> 1. https://public-inbox.org/git/871sapezba.fsf@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

I'll globally do s/here-doc/label/ while queueing.

POSIX says "The implementation shall support label arguments
recognized as unique up to at least 8 bytes", so replacing these
labels to shorter strings makes perfect sense.

Will queue; thanks.

>  t/chainlint.sed | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/chainlint.sed b/t/chainlint.sed
> index 8544df38df..2333705b27 100644
> --- a/t/chainlint.sed
> +++ b/t/chainlint.sed
> @@ -97,11 +97,11 @@
>  /<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
>  	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
>  	s/[ 	]*<<//
> -	:hereslurp
> +	:hered
>  	N
>  	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
>  		s/\n.*$//
> -		bhereslurp
> +		bhered
>  	}
>  	s/^<[^>]*>//
>  	s/\n.*$//
> @@ -283,11 +283,11 @@ bfolded
>  :heredoc
>  s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
>  s/[ 	]*<<//
> -:hereslurpsub
> +:heredsub
>  N
>  /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
>  	s/\n.*$//
> -	bhereslurpsub
> +	bheredsub
>  }
>  s/^<[^>]*>//
>  s/\n.*$//
