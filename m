Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6B11FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 12:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757171AbeAHM2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 07:28:37 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40656 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757164AbeAHM2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 07:28:34 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so13859707wmf.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 04:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u/vAPug9rr5yc2vT5/76MlnJc/9t14Ryxv2diUVGot4=;
        b=odRNQmXjDfH+sqcQeht7tKvc5fYq2EQe3/joQkKFBJ+VQ1Q8AwcscbFIO4BUme05pK
         7XjTS7UcJeQKF40D1ShGEIBV7UWmqJ4T2jjhmmSQ1eX6NFdepDAWR6nNGnXCaW3JtFU1
         ljnDx31QuE/elS7lnPXCYXdzDI985XEXjZs7XY9sENrkGVCmxEjkkecyv1aW87MpJ9vv
         BQML/T4NpFSV69s9OhGQ1EFQwVH2MtEVnx+/pKm8qYDgG7wc5aShA75wo9bVJb0HqVx8
         4GOSUeksOQaPZ7RDdoseDDSqsjIJHgnRl1XNBs4P2pCDmOxaU5RpbwPsJ7QnU6lPsAoJ
         DO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u/vAPug9rr5yc2vT5/76MlnJc/9t14Ryxv2diUVGot4=;
        b=OUyCrY7Uu8LIxuwYKxK+Im6ETp75wMWPMhLBLuJy6ZpDQjuvxpvK9aPkaJ9JN2051v
         lOq03/3tUDdnL+s9SQ/rLuOS0JH3owa3dIxhjrMk6dMk588UsUsdC96CE5vnl1/nemfu
         68LewF5+1+io6h6HRuK+/ZQakztrmNPlmjIGabEI6pPg6b8NtVETkqe5g1mlgBjrIG6o
         rL5037DqaCfCuscR7n5B4T+0nOkWW08IqIdDdHImuhTvGs6S8JXTP4msUAI1ZyCqk5XN
         E2EUA41/OxtXwgyD8SGw0cmKXDiEtBb/EN1xO4CdVisCB4F3Avo4Nx15Pv4mPm+lVwSi
         viPw==
X-Gm-Message-State: AKGB3mJqrp+oCRmD44ILq9auP6B6j8f/kTXmrr+swXptP9RqNfGkQN6i
        xLXAGOhC503JvnE0uxyR+5s=
X-Google-Smtp-Source: ACJfBoudkcdwz1uhMe/Fl7zcOPhBwH85UhNDDmHVJbGmGemsP7kwC7OtOqYwgrLuyWn1LTOyyVVYkw==
X-Received: by 10.80.226.207 with SMTP id q15mr16901522edl.248.1515414513395;
        Mon, 08 Jan 2018 04:28:33 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y48sm7067433edd.77.2018.01.08.04.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 04:28:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com> <20180108102029.GA21232@sigill.intra.peff.net> <20180108102708.GA19461@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180108102708.GA19461@sigill.intra.peff.net>
Date:   Mon, 08 Jan 2018 13:28:31 +0100
Message-ID: <87efn0bkls.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 08 2018, Jeff King jotted:

> On Mon, Jan 08, 2018 at 05:20:29AM -0500, Jeff King wrote:
>
>> I.e., what if we did something like this:
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 611c7d24dd..04c661ba85 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -600,6 +600,15 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>>  	if (len == GIT_SHA1_HEXSZ || !len)
>>  		return GIT_SHA1_HEXSZ;
>>
>> +	/*
>> +	 * A default length of 10 implies a repository big enough that it's
>> +	 * getting expensive to double check the ambiguity of each object,
>> +	 * and the chance that any particular object of interest has a
>> +	 * collision is low.
>> +	 */
>> +	if (len >= 10)
>> +		return len;
>> +
>
> Oops, this really needs to terminate the string in addition to returning
> the length (so it was always printing 40 characters in most cases). The
> correct patch is below, but it performs the same.
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..5921298a80 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -600,6 +600,17 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>  	if (len == GIT_SHA1_HEXSZ || !len)
>  		return GIT_SHA1_HEXSZ;
>
> +	/*
> +	 * A default length of 10 implies a repository big enough that it's
> +	 * getting expensive to double check the ambiguity of each object,
> +	 * and the chance that any particular object of interest has a
> +	 * collision is low.
> +	 */
> +	if (len >= 10) {
> +		hex[len] = 0;
> +		return len;
> +	}
> +
>  	mad.init_len = len;
>  	mad.cur_len = len;
>  	mad.hex = hex;

That looks much more sensible, leaving aside other potential benefits of
MIDX.

Given the argument Linus made in e6c587c733 ("abbrev: auto size the
default abbreviation", 2016-09-30) maybe we should add a small integer
to the length for good measure, i.e. something like:

	if (len >= 10) {
		int extra = 2; /* or  just 1? or maybe 0 ... */
		hex[len + extra] = 0;
		return len + extra;
	}

I tried running:

    git log --pretty=format:%h --abbrev=7 | perl -nE 'chomp; say length'|sort|uniq -c|sort -nr

On several large repos, which forces something like the disambiguation
we had before Linus's patch, on e.g. David Turner's
2015-04-03-1M-git.git test repo it's:

     952858 7
      44541 8
       2861 9
        168 10
         17 11
          2 12

And the default abbreviation picks 12. I haven't yet found a case where
it's wrong, but if we wanted to be extra safe we could just add a byte
or two to the SHA-1.
