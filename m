Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63121F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeHRRsJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:48:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53256 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:48:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so10109049wmh.3
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gHM9V0yiA/rGFYLJRFnqhq03Da6Rvm3F2I9Ts6siWd0=;
        b=IG2YsmMycNnBJJQSQQDoEoJvs0Y/kJkqFjzwUK8UQeVpnLPu3fNn4gATKeMVY7ztYA
         eQ9rCBUvKZsXYJ3zF8UPXOQ5v+1MrYoXm4muvlkiaRRJS8hxJnGwhonnK1X7M4Tlk+nB
         3MvvGsipC4z+AL3zTYvtvDWdYzpWB1V3EsJm/5XVXyL0P39gKshxG87ZGnXkxgoQ4voQ
         YjSeooYXPoEF8djvHnXYjB5TWMccNnaWdP1FYgIdBzkCz1yxfqXQCLrbWIl0r+kogFBE
         /c3TcZMm1vI/IBBvpUeWuW6YiOsWneRv+abXaRhRW7Eo22UhoIeYTA/Sj2QNQWF6uSiZ
         iOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gHM9V0yiA/rGFYLJRFnqhq03Da6Rvm3F2I9Ts6siWd0=;
        b=SV/yAvHXZfQ8boRBDabMSw+1Cj1XBSgOhDNVyjB/TiI6ODERxAadIz+doaXVOPr7lh
         d/2KW0EKFYGjsLqneehtXXFRAJGTQW9f/8+udssL2qegKevqvCFQUOQRzrFMrME/jY39
         j4zykb88rIIJ3tw1RxO5fmT8IORyc2KHfeAb5NMuDkZvh7wCXFu82emTl91ttbTXhU4G
         e+c48k3fbMvSKk5K6ByI7U/4/v+RhD6BMF5VMY7pb7lmMOoAWhjmOVmp1tYi1j1JzpfQ
         MuguhHxrtpgrF/Vu7fqOR4RsEfD6IkSV296JDlpLqaNW6jQJC2OUSOoVOcF3Gpecsk0v
         LkHg==
X-Gm-Message-State: AOUpUlF3rhlSnGHYgom9KgmjI2yeYZfjGbjnAm1f0cfjv54ycrNUNLYp
        5uhAfs4ckTB+AsK2Imy0tfg=
X-Google-Smtp-Source: AA+uWPxEOpqzzuZe2NRhJ3WWkfLLFcrE7+mc8HzdlX3kmGKPIGbS9u0nri1ymk9dFBVcmzX0Oh0Qog==
X-Received: by 2002:a1c:dac6:: with SMTP id r189-v6mr21375161wmg.150.1534603211641;
        Sat, 18 Aug 2018 07:40:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w14-v6sm12762048wme.6.2018.08.18.07.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 07:40:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818060911.GC241538@aiede.svl.corp.google.com>
Date:   Sat, 18 Aug 2018 07:40:08 -0700
In-Reply-To: <20180818060911.GC241538@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 17 Aug 2018 23:09:11 -0700")
Message-ID: <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/sideband.c
>> +++ b/sideband.c
>> @@ -75,7 +75,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>
> Not about this patch: should the 'n' parameter be a size_t instead of
> an int?  It doesn't matter in practice (since the caller has an int,
> it can never be more than INT_MAX) but it might make the intent
> clearer.

I tend to agree, but I think a separate "clean-up" patch to do so is
more appropriate than rolling it into this fix.

>>  		/*
>>  		 * Match case insensitively, so we colorize output from existing
>>  		 * servers regardless of the case that they use for their
>> 		 * messages. We only highlight the word precisely, so
>> 		 * "successful" stays uncolored.
>> 		 */
>> 		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
>
> Not about this patch: should this check "&& src[len] == ':'" instead,
> as discussed upthread?

I originally was of an opinion that we should take only lowercase
keyword followed by a colon, primarily because that is what we
produce.  Then "the real world need" told us that we are better off
catching the keyword case-insensitively.  Recalling that lesson, I
am not sure I would support "let's limit to the colon, rejecting any
other punctionation letter".

In any case, we should make such a policy decision outside a patch
like this one that is about fixing a behaviour which all users would
consider as a bug regardless of the policy they support.

>> @@ -100,8 +103,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>>  		}
>>  	}
>>  
>> -	strbuf_add(dest, src, n);
>> +	if (0 < n)
>> +		strbuf_add(dest, src, n);
>
> This check seems unnecessary.  strbuf_add can cope fine with !n.

I was primarily interested in catching negatives, and !n was a mere
optimization, but you are correct to point out that negative n at
this point in the codeflow is a BUG().
