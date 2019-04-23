Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E361F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfDWWUf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:20:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34215 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:20:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id a6so14145453edv.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=RJqDYl0HSKl5exPUIJuKXNplnOb8BEQmj1plybK/sMs=;
        b=qDzsshlOm6QPiSNI2l5aIxRqBk+HikhT9PPTaIPp17cn80yDVSj+A5uHIfoYQpjkYz
         dNpKFcPu/1tzxi2JxiqVWQl5DmAQpJEel+05C/o0OgdH6tLML9wLuuHveu3HqcYZK3Cu
         V79V/AzeUtAaw7/bjeTyf6+KIECgRwf3YRPIboGndqU7mBMIf3GZb22YYj5mg4tdbMqr
         KIMKSCHWX8IDHpjGbAE826tIxtmLLUUvZmdiMJxyL/zltqjaQyDXBy/MqfROaj3OcXm8
         GOJT6BgkTFqc770FFGUBvdZm+NDiUqsLudYFXWD+T5GEnT33S73WwErnQ+u3sn/Fp7RA
         r7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=RJqDYl0HSKl5exPUIJuKXNplnOb8BEQmj1plybK/sMs=;
        b=dhzQuGhbkz3uAUwX+jT3ngkCyTB6fEAIdMNqf2lqfYCAY9XUezCY+SDnw1kqd+Cqj7
         +6sEE8sd3bewgrT/b+GJQEvsa8Ee53F8Q55F+bPcCioGCxxiQSckWPsX6dkvCKUyqGq0
         em8/4esTPX1/se57Wx8+23rjl2sPYnjqT0j1vLRBQrz8lzL9gGg0RmZ20UrFEcMA2/6H
         9Q0a6iP7Jabt19x2xTmHZuoz5QV4rXOyhpMcuYG+reZhQB6QfuzeeQbKdJg9cgkSwdom
         8ITZiLL5cU7AVmwhYHoaasUgLgh78gY+uaymc/7AUA3sMGHziloHO0tq7uq2578AQUox
         msWA==
X-Gm-Message-State: APjAAAW++B4pojiLBUtz/ugLmRYlPLkoehg3N0K4NhPoZdcTDiTt5719
        c4bG41JSpbiJ1mlRDAWod4FapIPC
X-Google-Smtp-Source: APXvYqxlrPTfhOslHO/2avYfjalC3F72wr8PA+WQuoqrh88WIU5u7OH2JH728x9RBB3tXuslhgebeQ==
X-Received: by 2002:a17:906:724c:: with SMTP id n12mr2194481ejk.192.1556058033305;
        Tue, 23 Apr 2019 15:20:33 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id j18sm3449099edf.72.2019.04.23.15.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:20:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
References: <20190423053130.GA13162@sigill.intra.peff.net> <20190423203801.29156-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190423203801.29156-1-jonathantanmy@google.com>
Date:   Wed, 24 Apr 2019 00:18:55 +0200
Message-ID: <871s1stlf4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 23 2019, Jonathan Tan wrote:

>> The problem I see is that the client doesn't get to vet the list of
>> URIs; it only gets to specify a protocol match. But there are many other
>> reasons it might want to reject a URI: we don't like the protocol, the
>> domain name is on a blacklist (or not on a whitelist), the domain name
>> can't resolve, we can't make a TCP connection to the server, we can't
>> successfully fetch the pack.
>>
>> You'll note that those rise in complexity and time as you go down the
>> list. I'm not sure where on that spectrum we'd want our clients to stop
>> vetting (and it may even depend on config). But I think we ought to
>> design the protocol to put the decision in the hands of the client so
>> that it _can_ make those choices itself.
>>
>> I.e., I think the conversation ought to be more like:
>>
>>   Server: I support packfile-uris X, Y, Z.
>>
>>   Client: Great. I'll use URIs X and Z.
>>
>>   Server: OK, here's your pack, minus any objects I know are in X and Z.
>>           I'll send you the objects from Y as normal.
>>
>> And then the client is free to pick and choose.
>
> One drawback I see is that the server needs to compute objects to be
> sent twice - once to generate the URIs and once after the client has
> informed the server which URIs it wants.
>
> If we expect some packfile-uris to not be usable sometimes (for any of
> the reasons you listed), this would be nice. The protocol in my patches
> support a rudimentary version of this (if any of the URIs don't work for
> any reason, just fetch again without advertising that we support
> packfile URIs) but the packfile received during the first patch is
> wasted.

This is really orthagonal to this series, but wouldn't a better
resumption strategy here be to walk the pack we just downloaded, run the
equivalent of 'commit-graph write' on it to figure out likely "tip"
commits, and use those in "have" lines to negotiate with the server the
next time around?

I've sometimes wished we optionally had that sort of fetch algorithm, in
particular now setting "alternates" on a freshly init-ed repo will do
the full initial fetch even though we have most/all of the objects in
the alternates now.

> So the tradeoff is: in the good case, your suggestion means that we make
> another fetch request, increasing the load on the server and taking more
> time. In the bad case, your suggestions means that we avoid sending a
> useless packfile upon the first patch, and if the server is smart
> enough, even the second packfile will be smaller. It depends on how
> often we think the bad case occurs, if servers will typically send more
> than one packfile-uri, and how smart we think servers will typically be.
>
>> The initial server uri
>> list can come in the capabilities list, or it can be a separate request
>> once the client sees the server supports packfile-uris and wants to ask
>> about them.
>
> I don't think this is possible - the URI list is dependent on the wants
> and haves.
>
>> We may need some way for the server to group the uris so
>> that the client knows which ones are alternates of each other (and which
>> ones are needed to make a complete set).
>
> My initial design didn't have this feature (in fact, it seems to me that
> each thing should have one canonical URL, which means that there is no
> need for an alternate) - do you think we should be thinking about this
> at this stage?
