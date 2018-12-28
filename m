Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A191F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeL1UNq (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:13:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbeL1UNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:13:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so21865371wrr.0
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=9lQQRt5+ev1qIeq+7M7TfeWv2GHLcKBhV2pN29DN0+Y=;
        b=tBMmoza+ehYkXN6acepCw7RwQpKjbZa4nEhtgH18i/FwbNgoAw+0OvjBYzQHCOD66P
         di6yVtjzMRtQRkG+Ntnp+xaeiiXOLd920aBeEqInl/YCgdQsYw70Hm0YhVhMMCGIUGy/
         ay6d2dSAndaTchujMy0qIQdS9FlrK7r7VSc1jxAn0JiZV+fz82GHKYvzxDhdIKwZSYks
         4GXcm6dW+Q0fer72BXwxrItheRv7CciB7dvPTK1ca29CjJqIkjOuvcWUPfO3WG9ppXSj
         iIpJwn4d86Dmi2HURzLqvNIXvV2//WNVf7SIR0ptwktNqopGxFhp7zNUTzsCdxqYhv7q
         wD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=9lQQRt5+ev1qIeq+7M7TfeWv2GHLcKBhV2pN29DN0+Y=;
        b=X6hZZppQxYUGN2tXFaE7/on+XLr8IP6xrid3EXx7nARQjW/fEbJigEsi3bYWSHilAt
         NcZiWhfhFvwOaX5YDIgmYN3tKKPjhjOQj0kT5JzzGPyeGmXh47dTHwS5h6DT7WKGKEf8
         b+7HvBLWMSw0SuVKVsCvNuxMVMEApguZYGPwel0d1vI7SSXDiR9gOnugUFBZpCEd1tb2
         X6v7kOT0DZSgEpYSPjPjE/oUwN/VUhilHTfDo9Y7czPu+C3A9CTXLhR/qSOeyNrLdDms
         SNlGYHfFPvIM1vKeczn9S13u9FRk7QQcxaHLHw8K5SO/sZcj45KxrOTtQ902J8Lwa/80
         RoQA==
X-Gm-Message-State: AJcUukfD16K6LG3hB4RZzcSKSbRJb2pdupwGfC3bSlj1c0mSdNb4HwZN
        5UeLZ9bE99+7tRL5lMPJDIY=
X-Google-Smtp-Source: ALg8bN699EUjx86kPI9ToEH0RI0XV9YdT7g8t2VXUst0qyVSlz+qQRqHallOKnKQcjDF6vn/8Wc5Ow==
X-Received: by 2002:adf:9205:: with SMTP id 5mr26416911wrj.189.1546028023979;
        Fri, 28 Dec 2018 12:13:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f18sm24130799wrs.92.2018.12.28.12.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:13:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] imap-send: Fix compilation without deprecated OpenSSL APIs
Date:   Fri, 28 Dec 2018 11:20:00 -0800
References: <20181227023548.396-1-rosenp@gmail.com>
        <xmqqwonvpjiy.fsf@gitster-ct.c.googlers.com>
        <CAKxU2N9egn6MbJeWUWFsyYpnwOCj4=mckmkJJtVJGhmQUt36aw@mail.gmail.com>
Message-ID: <xmqqftuhmmtl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rosen Penev <rosenp@gmail.com> writes:

> On Wed, Dec 26, 2018 at 10:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Rosen Penev <rosenp@gmail.com> writes:
>>
>> > Initialization in OpenSSL has been deprecated in version 1.1.
>>
>> https://www.openssl.org/docs/man1.0.2/ssl/SSL_library_init.html says
>>
>>         SSL_library_init() must be called before any other action takes
>>         place.
>>
>> https://www.openssl.org/docs/man1.1.0/ssl/SSL_library_init.html says
>> the same.
> Later on in the document it mentions that it is deprecated.
>>
>> Which makes it necessary for us to defend the following claim
>>
>> > This makes
>> > compilation fail when deprecated APIs for OpenSSL are compile-time
>> > disabled.
>>
>> as a valid problem description more rigorously.  To me, the cursory
>> web-serfing I did above makes me suspect that an OpenSSL
>> implementation with such a compile-time disabling _is_ buggy, as it
>> forbids the API users to call an API function they are told to call
>> before doing anything else.
> I agree the man page is misleading. The changelog for 1.1.0 is very
> clear though:
>
> Added support for auto-initialisation and de-initialisation of the library.
>      OpenSSL no longer requires explicit init or deinit routines to be called,
>      except in certain circumstances. See the OPENSSL_init_crypto() and
>      OPENSSL_init_ssl() man pages for further information.
>      [Matt Caswell]

All it says is explicit calls to SSL_library_init() is now optional.
It does not say it is a compile-time-error worthy offense to make
explicit init/deinit calls.  Which still means that an OpenSSL
implementation with such a compile-time disabling _is_ buggy, as it
forbids the API users to call an API function they are told to call
before doing anything else.

>> > diff --git a/imap-send.c b/imap-send.c
>> > index b4eb886e2..21f741c8c 100644
>> > --- a/imap-send.c
>> > +++ b/imap-send.c
>> > @@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>> >       int ret;
>> >       X509 *cert;
>> >
>> > +#if (OPENSSL_VERSION_NUMBER < 0x10000000L)
>>
>> https://www.openssl.org/docs/man1.1.0/crypto/OPENSSL_VERSION_NUMBER.html
>>
>> says that OPENSSL_VERSION_NUMBER is of form 0xMNNFFPPS where M is
>> major, NN is minor, FF is fix, PP is patch and S is status, and
>> gives an example that 0x00906023 stands for 0.9.6.b beta 3 (M=0,
>> NN=09, FF=06, PP=02 and S=3).  So "< 0x10000000L" means "anything
>> with M smaller than 1".  IOW, we would no longer call _init() for
>> e.g. "version 1.0.0 beta 0".  That contradicts with the first claim
>> of the proposed log message ("deprecated in 1.1" implying that it is
>> not yet deprecated in say 1.0.2).
> This is a mistake. I will send a v2 to fix.
>
> Oh I see what I did wrong. I mistakenly copied the above
> OPENSSL_VERSION_NUMBER check without looking carefully at the number.

Yup, please be careful next time.

>>
>>
>>
>> >       SSL_library_init();
>> >       SSL_load_error_strings();
>> > +#endif
>> >
>> >       meth = SSLv23_method();
>> >       if (!meth) {
