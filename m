Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320A91F404
	for <e@80x24.org>; Wed, 31 Jan 2018 00:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeAaA6A (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 19:58:00 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41846 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeAaA6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 19:58:00 -0500
Received: by mail-yw0-f193.google.com with SMTP id b129so6256010ywa.8
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 16:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M6NTMlUI6SBijrajDr7biHzGX+TzHSAsrLzLwFvqQnk=;
        b=I1rOiU2MJ/hMMzVxOba5ocqqxWotWVzGfl38QLNbzXbiGJsfoQz2iu6oweIcs9big/
         KK+VYnHkTffMMwXwvYzaRwpm5b5x1BQ3vsqCIwkxn5ZRlLOBxzenQdEwGIqe3Z2ZdN4R
         xRtr8WAdFcKwfdacpaJPJ2z1EhvNoaqV3HzHyufONyrGrhf1NXXHvOMaFGCAHlyd2cN5
         Cxkyso/5DoqmWnEsUH1KhZO3I+wmL3fOSqWt9tohaEHnvW/Ve+SicRj75Imz8XK+bPJZ
         glcgT9etVBkXATiEfKx4TWEE5P3n8ie20nSLYa+ugGIT68bjoMZ2bwa+0Hso9aE1KLcV
         Z/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M6NTMlUI6SBijrajDr7biHzGX+TzHSAsrLzLwFvqQnk=;
        b=N+ZBjqS2aOY5o3c46HiQ1JEvHXJ7iApY4+KFUJBeB0rLQWONKxz4PzLhwDTnJOZHZ6
         O5raEkJjg+RqxCLC7G3Y525dOCn/HRqGKlcvuEyDOHHLOLQiNBuDxDA3BnWB5IWHYm77
         J+VqX628DyNYDqILjdqRN6j8x004HlRrws3SxMN0j/U00K9/rBVIKCUWdE0ApYt6ayyq
         VLMnW8jvijSfVi98+0l/Kw6sgHMEXByzS4AwrAwu9xWXAF2F8I1svFVE7LxywsKoHqap
         piz9RNsdOr97Tp/Is+TeRIW1bLWXicMjiu8T46ZI7DwOKA97vtCQ6HKOX14r3VRrNcIi
         aHqw==
X-Gm-Message-State: AKwxytfc6ztejNRYa39GA+POphfuELAv/1dL3ZEwmo0GQSsJgGmMe5xj
        /OOWKPFdHH2n/c01ysYKkNODbYpvfT71ZXtR1xVkzCDt5yM=
X-Google-Smtp-Source: AH8x225Eki3EtWU+/ZTyRcvudAE1/vhXRhOBr7tmCC/1zd1rN0TSxIMu7J0VFZUkFplH97jlnPyngUOdnRgElZJT/Ww=
X-Received: by 10.129.156.134 with SMTP id t128mr20834837ywg.108.1517360279093;
 Tue, 30 Jan 2018 16:57:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 16:57:58 -0800 (PST)
In-Reply-To: <CACsJy8C98HD59DGgqyWtZzj2RVqFe9GN=810A6fs2mMYBh_53Q@mail.gmail.com>
References: <20180129223728.30569-1-bmwill@google.com> <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
 <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com> <CAGZ79kZ-hZzKtv05d5_7O2ndNZvGkU7qYnrn52zwpqSTqCiygQ@mail.gmail.com>
 <CACsJy8C98HD59DGgqyWtZzj2RVqFe9GN=810A6fs2mMYBh_53Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 16:57:58 -0800
Message-ID: <CAGZ79kZNB=3fXOeJwhXGqyBi3mKmE-9nmM-ooXJOzy5OcYaoqQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 4:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 31, 2018 at 6:01 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Jan 30, 2018 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> Is it simpler (though hacky) to just  do
>>>>
>>>> #ifdef __cplusplus
>>>> #define new not_new
>>>> #define try really_try
>>>> ...
>>>>
>>>> somewhere in git-compat-util.h?
>>>
>>> Very tempting, especially given that your approach automatically
>>> would cover topics in flight without any merge conflict ;-)
>>>
>>> I agree that it is hacky and somewhat ugly, but the hackiness
>>> somehow does not bother me too much in this case; perhaps because
>>> attempting to use a C++ compiler may already be hacky in the first
>>> place?
>>>
>>> It probably depends on the reason why we are doing this topic.  If a
>>> report about our source code coming from the C++ oriented tool cite
>>> the symbol names seen by machines, then the "hacky" approach will
>>> give us "not_new" where Brandon's patch may give us "new_oid", or
>>> whatever symbol that is more appropriate for the context it appears
>>> than such an automated cute name.
>
> Well. the world after post processing is always ugly. But we could try
> "#define new new__" to get the not so ugly names. new_oid is
> definitely better regardless of c/c++ though so I could see that as a
> good cleanup.
>
>>>> Do we use any C features that are incompatible with C++? (or do we not
>>>> need to care?)
>>>
>>> Good question.
>>
>> implicit casts from void?
>> e.g. xmalloc returns a void pointer, not the type requested.
>> https://embeddedartistry.com/blog/2017/2/28/c-casting-or-oh-no-we-broke-malloc
>
> That causes lots of warnings but not errors (I bit the bullet and
> tried to compile git with g++).

And for g++ there is a flag to disable this specific set of warnings.
I think the value of using C++ analysis tools is in the LLVM/clang
world, not GNU.

> The next set of changes would be to
> reorganize nested enum/struct declarations. Even if nested, C
> considers these flat while C++ sees them in namespaces. There's some
> warnings about confusion with the new cool feature string literals,
> but that's easy to fix.
>
> There's also C99 designator in builtin/clean.c (I thought we avoided
> C99, I can start using this specific feature more now :D)

That was a test balloon? See 512f41cfac
(clean.c: use designated initializer, 2017-07-14)

One of the big advantages would be stricter type checking, such as
signed/unsigned confusion, that we occasionally have.
e.g. 61d36330b4 (prefer "!=" when checking read_in_full()
result, 2017-09-27) or what is referenced from there 561598cfcf
(read_pack_header: handle signed/unsigned comparison in read result,
2017-09-13).

The bugs resulting in these patches could have been caught more easily
with C++ checking IMHO.

> I was stuck at the thread_local thing in index-pack.c and gave up. So
> I don't know what else we would need to change.

Thanks for experimenting!
Stefan

> --
> Duy
