Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C99208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbdHXS3Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 14:29:16 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35971 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdHXS3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 14:29:15 -0400
Received: by mail-yw0-f181.google.com with SMTP id h127so1554388ywf.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RtpNf2YXi7tp5CQnRCnKJTswMg8CFzLDQPd1TG5eAF8=;
        b=TEgjMqmn0K1EheP8mZkp7kyQkPMZl4FAmgHfiE09qFNaf23ZkIGGR/mFCar/kFl/mF
         saeoEq+B6zqp1yj9NONNqztvmrK4ueZVSw8iItrCQA0s9yCCIcnUPy4rSMTSFiOTWQZA
         Kv+USA7ah8N2xsykAHRGUogfnC/jKNrhCaQUDwRr4Ke/h+rH2RVjkNl3iMhxTyofLcsR
         x+kjRURPWwaDTS0BG9LXjlGLubPpbU7O/1/P+z88MydcR5paOjY0OkVCQMxcwoOE13+g
         W94TtpI5P0YBsg7G+3Und5/Jy40zVnuHa1cGFkPNdr+9hmkvaRSjTuM7B7paIkFViwTj
         i9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RtpNf2YXi7tp5CQnRCnKJTswMg8CFzLDQPd1TG5eAF8=;
        b=nbd9fa8Md+xVzoe6zEC/rWnb5qh8pHDOTHO5XofWnLQ+aywOaQyyOj95ftvjq/8fjX
         CRMI4D7POmpS/VnJrfcfHg2Cobrpnty+Us/rTLRsjGzcsTI3Yy881VgHTFiF8PnpUlQd
         4FU6pTZN+wEtr3MqP3bi5z0wrUKKBcox7BTFjhO5i/GfLoZNiLQzBjP4DblxgdYkDR8L
         cvQ/Wg/d98SCkbZUwW0M3F5B8ABGKsp8StMo0i0Qoitfgm74N+obckcQZRvUneOQnDke
         OOtWeQ9wmCq3MLTgrv3f+hFdfuUwZSUSvYyoco5YNbnrb3D+GWIXQSvVSKcM6rdllyU7
         7eGQ==
X-Gm-Message-State: AHYfb5i0+9qeVleELoW8Le1J5E5WqtUH5eL/oxIfi84jhYjGSGHc56RM
        xh8f5N7EotDhNydCNmGxSA3yKE5M8w==
X-Received: by 10.37.177.10 with SMTP id g10mr6561596ybj.34.1503599354530;
 Thu, 24 Aug 2017 11:29:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Thu, 24 Aug 2017 11:29:13 -0700 (PDT)
In-Reply-To: <xmqqpobkx610.fsf@gitster.mtv.corp.google.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
 <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com> <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
 <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com> <xmqqpobkx610.fsf@gitster.mtv.corp.google.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Thu, 24 Aug 2017 11:29:13 -0700
Message-ID: <CA+sFfMdYXDt2mgnWq-HQQyBsCqYZ+689BCKEOw7siGjQoUysjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 9:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> Ah, you probably meant something like this:
>>
>>    const char strbuf_slopbuf = '\0';
>>
>> which gcc will apparently place in the read-only segment.  I did not know that.
>
> Yes but I highly suspect that it would be very compiler dependent
> and not something the language lawyers would recommend us to rely
> on.

I think compilers may have the option of placing variables that are
explicitly initialized to zero in the bss segment too, in addition to
those that are not explicitly initialized.  So I agree that no one
should write code that depends on their variables being placed in one
segment or the other, but I could see someone using this behavior as
an additional safety check; kind of a free assert, aside from the
additional space in the .rodata segment.

> My response was primarily to answer "why?" with "because we did not
> bother".  The above is a mere tangent, i.e. "multiple copies of
> empty strings is a horrible implementation (and there would be a way
> to do it with a single instance)".

Merely adding const to our current strbuf_slopbuf declaration does not
buy us anything since it will be allocated in r/w memory.  i.e. it
would still be possible to modify it via the buf member of strbuf.  So
you can't just do this:

   const char strbuf_slopbuf[1];

That's pretty much equivalent to what we currently have since it only
restricts modifying the contents of strbuf_slopbuf directly through
the strbuf_slopbuf variable, but it does not restrict modifying it
through a pointer to that object.

Until yesterday, I was under the impression that the only way to
access data in the rodata segment was through a constant literal.  So
my initial thought was that we could do something like:

   const char * const strbuf_slopbuf = "";

..but that variable cannot be used in a static assignment like:

   struct strbuf foo = {0, 0, (char*) strbuf_slopbuf};

So it seemed like our only option was to use a literal "" everywhere
instead of a slopbuf variable _if_ we wanted to have the guarantee
that our "slopbuf" could not be modified.

But what I learned yesterday, is that at least gcc/clang will place
the entire variable in the rodata segment if the variable is both
marked const _and_ initialized.

i.e. this will be allocated in the .rodata segment:

   const char strbuf_slopbuf[1] = "";

>>    #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = (char*) &strbuf_slopbuf }
>>
>> respectively.  Yeah, that's definitely preferable to a macro.
>> Something similar could be done in object.c.
>
> What is the main objective for doing this change?  The "make sure we
> do not write into that slopbuf" assert() bothers you and you want to
> replace it with an address in the read-only segment?

Actually nothing about the patch bothers me.  The point of that patch
is to make sure we don't accidentally modify the slopbuf.  I was just
looking for a way for the compiler to help out and wondering if there
was a reason we didn't attempt to do so in the first place.

I think the main takeaway here is that I learned something yesterday
:-)  I didn't actually intend to submit a patch for any of this, but
if anything useful came out of the discussion I thought Martin may
incorporate it into his patch if he wanted to.

-Brandon
