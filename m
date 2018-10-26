Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA2C1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 14:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJZWrF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 18:47:05 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41687 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJZWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 18:47:05 -0400
Received: by mail-qk1-f180.google.com with SMTP id g13-v6so711473qke.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6FwMB64qv+Y/a1/rMhinKPrPyw5oKswd+bDh7XhTmE=;
        b=A1/Njsr9kiJCQhsDeboIqQwNyf3zlr9V3FPQKoyDVITx5gatO7Rx6Lt+AzPEKYRwAZ
         3Es2DwHIBJ1H5g6MC6VMiAvuMoZ9sM8jXiDXHfaTCJXmZOS2qTMv89DLVzQWSebq0N5i
         DbOcUKScalQ0KogWlbafCpMe51VpQ4YXHzRkBjNxBcZdR8RG25ZvfyIEumG9RTd7+1N2
         apCzxGuomzVckwijfDmufJgR7CIFShhpeenbloMRBuHqTWm3o4I7aO+13WxPKqLeINFK
         koIXGNwUeXBI9+t+X37eCa8rwGWkOmgCQIznOcs2cc5L9+Rda9JwD0KXCPKFCZkdVKxl
         O92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6FwMB64qv+Y/a1/rMhinKPrPyw5oKswd+bDh7XhTmE=;
        b=o55BU+kzJKlIQzvZy7cE4I/De0RQqOf9kjGguqkxkdz/Dd+Pn9167uMm+lGr9skBiB
         Ykxi0/tocvjPzNen3TQCW9GoZw0doDKnY1HTUMdZuUfRDQrIlG9K964vDXZ6WmrvjIET
         pOrh6JMt9jUdqptIau55ZahlJ+RjfjgiP4FIoeRYg0nd7eNDl7JJARlzpr8adLqbadnq
         cD/0Nimghg3/7d7PB3mHrgnUoz/i8IdLpJePOV/XSgZPekQYNBJdDW6tgqATgVNnYq3g
         pyebaEP+rBjRMlexpk2AqELy8ECpwohoaOD3siyToXFAU/8vuHRKAz4oURcjNzw7i+xn
         cWBA==
X-Gm-Message-State: AGRZ1gIE55WPu7DSLb/UaLp37sCk2KwbNz5OjQRPwDKVg6uErwUrLIGD
        XCEAoCOXob+Pe+lhYHjshhLI8HfE66s=
X-Google-Smtp-Source: AJdET5ekFxI+M31teZXYXHA9rN44UHbfAGsWrNKlulOx4iUH11SCWL6CGKqcIqyucRSwsGUECZm6iw==
X-Received: by 2002:a37:6c01:: with SMTP id h1-v6mr3201483qkc.67.1540562990182;
        Fri, 26 Oct 2018 07:09:50 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b134-v6sm9374235qka.45.2018.10.26.07.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:09:49 -0700 (PDT)
Subject: Re: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef
 NO_PTHREADS
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org
References: <20181018170934.GA21138@sigill.intra.peff.net>
 <20181018180522.17642-1-pclouds@gmail.com>
 <20181023202842.GA17371@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
Date:   Fri, 26 Oct 2018 10:09:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023202842.GA17371@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/23/2018 4:28 PM, Jeff King wrote:
> On Thu, Oct 18, 2018 at 08:05:22PM +0200, Nguyễn Thái Ngọc Duy wrote:
> 
>> On Thu, Oct 18, 2018 at 7:09 PM Jeff King <peff@peff.net> wrote:
>>>> In this particular case though I think we should be able to avoid so
>>>> much #if if we make a wrapper for pthread api that would return an
>>>> error or something when pthread is not available. But similar
>>>> situation may happen elsewhere too.
>>>
>>> Yeah, I think that is generally the preferred method anyway, just
>>> because of readability and simplicity.
>>
>> I've wanted to do this for a while, so let's test the water and see if
>> it's well received.
>>
>> This patch is a proof of concept that adds just enough macros so that
>> I can build index-pack.c on a single thread mode with zero #ifdef
>> related to NO_PTHREADS.
>>
>> Besides readability and simplicity, it reduces the chances of breaking
>> conditional builds (e.g. you rename a variable name but forgot that
>> the variable is in #if block that is not used by your
>> compiler/platform).
> 
> Yes, I love this. We're already halfway there with things like
> read_lock() in index-pack and elsewhere, which are conditionally no-ops.
> The resulting code is much easier to read, I think.
> 

I am also very much in favor of this.  I updated a couple of places 
threading is being used that I've been working in (preload-index and 
read-cache) and both are much simplified using your proof of concept patch.

>> Performance-wise I don't think there is any loss for single thread
>> mode. I rely on compilers recognizing HAVE_THREADS being a constant
>> and remove dead code or at least optimize in favor of non-dead code.
>>
>> Memory-wise, yes we use some more memory in single thread mode. But we
>> don't have zillions of mutexes or thread id, so a bit extra memory
>> does not worry me so much.
> 
> Yeah, I don't think carrying around a handful of ints is going to be a
> big deal.
> 

Just to be complete, there _is_ an additional cost.  Today, code paths 
that are only executed when there are pthreads available are excluded 
from the binary (via #ifdef).  With this change, those code paths would 
now be included causing some code bloat to NO_PTHREAD threaded images.

One example of this is in read-cache.c where the ieot read/write 
functions aren't included for NO_PTHREAD but now would be.

> I also think we may want to make a fundamental shift in our view of
> thread support. In the early days, it was "well, this is a thing that
> modern systems can take advantage of for certain commands". But these
> days I suspect it is more like "there are a handful of legacy systems
> that do not even support threads".
> 
> I don't think we should break the build on those legacy systems, but
> it's probably OK to stop thinking of it as "non-threaded platforms are
> the default and must pay zero cost" and more as "threaded platforms are
> the default, and non-threaded ones are OK to pay a small cost as long as
> they still work".
> 

I agree though I'm still curious if there are still no-threaded 
platforms taking new versions of git.  Perhaps we should do the 
depreciation warning you suggested elsewhere and see how much push back 
we get.  It's unlikely we'd get lucky and be able to stop supporting 
them completely but it's worth asking!

>> @@ -74,4 +79,29 @@ int init_recursive_mutex(pthread_mutex_t *m)
>>   		pthread_mutexattr_destroy(&a);
>>   	}
>>   	return ret;
>> +#else
>> +	return ENOSYS;
>> +#endif
>> +}
> 
> I suspect some of these ENOSYS could just become a silent success.
> ("yep, I initialized your dummy mutex"). But it probably doesn't matter
> much either way, as we would not generally even bother checking this
> return.
> 
>> +#ifdef NO_PTHREADS
>> +int dummy_pthread_create(pthread_t *pthread, const void *attr,
>> +			 void *(*fn)(void *), void *data)
>> +{
>> +	return ENOSYS;
>>   }
> 
> Whereas for this one, ENOSYS makes a lot of sense (we should avoid the
> threaded code-path anyway when we see that online_cpus()==1, and this
> would let us know when we mess that up).
> 

This highlights something anyone writing multi-threaded code will need 
to pay attention to that wasn't an issue before.  If you attempt to 
create more threads than online_cpus(), the pthread_create() call will 
fail and needs to be handled gracefully.

One example of this is in preload-index.c where (up to) 20 threads are 
created irrespective of what online_cpus() returns and if 
pthread_create() fails, it just dies.  The logic would need to be 
updated for this to work correctly.

I still think this is a much simpler issue to deal with than what we 
have today with having to write/debug multiple code paths but I did want 
to point it out for completeness.

>> +int dummy_pthread_init(void *data)
>> +{
>> +	/*
>> +	 * Do nothing.
>> +	 *
>> +	 * The main purpose of this function is to break compiler's
>> +	 * flow analysis or it may realize that functions like
>> +	 * pthread_mutex_init() is no-op, which means the (static)
>> +	 * variable is not used/initialized at all and trigger
>> +	 * -Wunused-variable
>> +	 */
>> +	return ENOSYS;
>> +}
> 
> It might be worth marking the dummy variables as MAYBE_UNUSED, exactly
> to avoid this kind of compiler complaint.
> 
> -Peff
> 
