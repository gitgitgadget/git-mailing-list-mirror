Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD16A1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbcKUSz4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:55:56 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35812 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbcKUSzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:55:55 -0500
Received: by mail-yw0-f177.google.com with SMTP id i145so220999123ywg.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 10:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8refMTrq6lzcmmL46xmGtXn9zSXK9fgkBeXjZoPBhWk=;
        b=JedZIUqWjaH4n3sW6LqscwPGUu4zfWPp5E/yN78d9SqCX2OYqDeROC2A/ASYjo+49E
         3CXe/uyXuCP1CbH/S61MhMaAIZiMB1HJwhCx5Hn20j+kdPV+cr7Wx8OSakZGDPd13CEP
         Ka+xfxaeVNz60U+AzfOExhzfXz0x64esgAed9WghC8+Xa6jZ4qnGEbfrkdid/mv3U+WQ
         wiclmX/dCJAcUvaTI1980ZHoY1gf4S7Xc+sDU1CdNL4FglOSgpBGAIg6Qotqy8XziQVF
         GdnBDGFqWuLJqIlAGazD7J0giwdrJlhX10SZTdMQWK6vmiC2ZZ2Q3XNdY8Gq2sIiFKOQ
         siYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8refMTrq6lzcmmL46xmGtXn9zSXK9fgkBeXjZoPBhWk=;
        b=UYhO5Qw9GlkC+fpL81SI3J9+pMaOO4tS4k9NFrceYe6fxnMIvqmTJUehyXhNP/UGGM
         fbQ51XS37jzzf13Qtryadimz1a6f+Aj6WFlHUt7Sq9Oh0lIhT+qCG4B+ewgLg5VzOBRE
         cZr9II02DhYnZ+2E7KM/vPEKnTONE+UFqBZ8x9w0wQ5Ea/EyHoVuis8UJegB5Ta5TR2v
         qw/DGX6ucnSSWmDfSNogO8ZofNTepujmvIossOBAuEhtgH3y+ss+OQvufvJAhoBL8iKV
         v5X5yoZxP3TIPUWeOTwS8C7ca4g+xaOxIn0G9Lgq5Xq+PeJSue9B8Kj1aGfoeVIstfK5
         fnsQ==
X-Gm-Message-State: AKaTC014j2XU7CQv67t25cz4880nngRYRYrsY/QK1r4syJ4OjK++ozCFgdW2obJnWlQsPfvrYYgjh9/2jFwLVw==
X-Received: by 10.13.221.12 with SMTP id g12mr17155246ywe.257.1479754554976;
 Mon, 21 Nov 2016 10:55:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 21 Nov 2016 10:55:34 -0800 (PST)
In-Reply-To: <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
 <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 21 Nov 2016 10:55:34 -0800
Message-ID: <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     Stefan Beller <sbeller@google.com>
Cc:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 10:17 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 21, 2016 at 8:56 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Mon, Nov 21, 2016 at 12:11 AM, KES <kes-kes@yandex.ru> wrote:
>>> Hi.
>>>
>>
>> Hi,
>>
>>> I have some question about how diff works then give proposal:
>>>
>>> it will be very useful for each "symbol" store additional meta info as source line length. So in this case when git counter two equal sequence of commands it will do further comparison: Adds 23 chars deletes none VS adds 75 chars deletes 46
>>>
>>> Actually I got this:
>>>
>>> @@ -129,8 +132,9 @@ sub _preprocess_message {
>>>  sub _process_message {
>>>      my ($self, $message) = @_;
>>>
>>> -    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>> +    my $time =  [ gettimeofday ];
>>>
>>> +    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>>      return $self->send_error(ERROR_REQUEST_INVALID)
>>>          unless defined($method);
>>>
>>> Instead of expected:
>>> @@ -129,6 +132,8 @@ sub _preprocess_message {
>>>  sub _process_message {
>>>      my ($self, $message) = @_;
>>>
>>> +    my $time =  [ gettimeofday ];
>>> +
>>>      my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>> -
>>>      return $self->send_error(ERROR_REQUEST_INVALID)
>>>
>>
>> Have you tried the various options for git to search for smaller
>> diffs? Or using the other diff algorithms such as histogram instead of
>> patience?
>>
>
> The newest version of Git comes with a flag to move around the diff
> better, based on the work at https://github.com/mhagger/diff-slider-tools

Unfortunately in this case, I'm not convinced that it will improve the
diff. It's worth a try as well though.

Thanks,
Jake
