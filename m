Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F611208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdHXTQG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:16:06 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37720 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdHXTQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:16:01 -0400
Received: by mail-pg0-f53.google.com with SMTP id 83so2035539pgb.4
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DjaAT9qLNR/9jRhu10J4qhQyg0nMVAj3rSfoYkPMEvo=;
        b=X1hyzoAnqAqMNkOOWGOSnnLK+jsYd7G6CiaGTzUZVaiN/RjjbSEBfffJuJa6rDdmhi
         H5fpX/YTMblAtTsPChKna2mtKlxkxqFK07S5Ovd8T5LPviOvnrkxSBqA5/sg1SR3Psrm
         KLIuPcVDpXwd5AvijcZKFN0vDM36av7iBZ7ob06K/nUTWCPg7T9A+a3OWSbPss7qbIqa
         SH0xvKkCSDwDlqiMZcKAysNwcLATFBKYlmzSX6m/Ix4QSAqeUdVTD38wSxCiIJWAB13D
         vDVDvV+KAGiEd4VrGIEdyQyE5eKk4KEXDK+lcZy94VfHoIO18uK9Spd+Lh+je05I6YFe
         +5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DjaAT9qLNR/9jRhu10J4qhQyg0nMVAj3rSfoYkPMEvo=;
        b=SC56LyccmdTVg+GIC5WG7X1bh8cjTlHELTmQzTYieEqfFDDJUMrH32hQni5o0pUYwE
         FhA+/C4R91hLZHmbGv8/00CMf4gH2qccb5MC1mlmxilwplcH1yrHe6zLkJLI1BOnR+RQ
         6e9gQy70cpNjRPpcBd2hSycnA6YPgZtxsyGOUOPIK4BQEi+vu/Hq4y+sYpNnLPnaXPU5
         gGNtlp/rjThF0kIjuSG9aOYM8FMgcne+0zMzBbOSUzPyWmXY21ArnpFXi2cVT0VYGpFr
         OV49ZXd/ntU1MNtDMUI+j4YRWqwXTww1kLtrThXlHjI0BlftjPdaxzy6yNJ+vAPTgIYR
         qXNA==
X-Gm-Message-State: AHYfb5hD8foD5CLiXs9c7ZWYNGyPa57+0c8n26iZz6uOGNcZEwjTczwW
        sAwqz1jcxqrzhLqVNqC9jm3VIAPQc/Ul
X-Received: by 10.98.12.78 with SMTP id u75mr7397693pfi.18.1503602161043; Thu,
 24 Aug 2017 12:16:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Thu, 24 Aug 2017 12:16:00 -0700 (PDT)
In-Reply-To: <CA+sFfMdYXDt2mgnWq-HQQyBsCqYZ+689BCKEOw7siGjQoUysjg@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
 <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com> <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
 <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
 <xmqqpobkx610.fsf@gitster.mtv.corp.google.com> <CA+sFfMdYXDt2mgnWq-HQQyBsCqYZ+689BCKEOw7siGjQoUysjg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 24 Aug 2017 21:16:00 +0200
Message-ID: <CAN0heSqaRvS2N=iJDCTGe=LT+y5eUQJskOCOZ8MPJ6znWKJifA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Brandon Casey <drafnel@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 August 2017 at 20:29, Brandon Casey <drafnel@gmail.com> wrote:
> On Thu, Aug 24, 2017 at 9:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> Ah, you probably meant something like this:
>>>
>>>    const char strbuf_slopbuf = '\0';
>>>
>>> which gcc will apparently place in the read-only segment.  I did not know that.
>>
>> Yes but I highly suspect that it would be very compiler dependent
>> and not something the language lawyers would recommend us to rely
>> on.
>
> I think compilers may have the option of placing variables that are
> explicitly initialized to zero in the bss segment too, in addition to
> those that are not explicitly initialized.  So I agree that no one
> should write code that depends on their variables being placed in one
> segment or the other, but I could see someone using this behavior as
> an additional safety check; kind of a free assert, aside from the
> additional space in the .rodata segment.
>
>> My response was primarily to answer "why?" with "because we did not
>> bother".  The above is a mere tangent, i.e. "multiple copies of
>> empty strings is a horrible implementation (and there would be a way
>> to do it with a single instance)".
>
> Merely adding const to our current strbuf_slopbuf declaration does not
> buy us anything since it will be allocated in r/w memory.  i.e. it
> would still be possible to modify it via the buf member of strbuf.  So
> you can't just do this:
>
>    const char strbuf_slopbuf[1];
>
> That's pretty much equivalent to what we currently have since it only
> restricts modifying the contents of strbuf_slopbuf directly through
> the strbuf_slopbuf variable, but it does not restrict modifying it
> through a pointer to that object.
>
> Until yesterday, I was under the impression that the only way to
> access data in the rodata segment was through a constant literal.  So
> my initial thought was that we could do something like:
>
>    const char * const strbuf_slopbuf = "";
>
> ..but that variable cannot be used in a static assignment like:
>
>    struct strbuf foo = {0, 0, (char*) strbuf_slopbuf};
>
> So it seemed like our only option was to use a literal "" everywhere
> instead of a slopbuf variable _if_ we wanted to have the guarantee
> that our "slopbuf" could not be modified.
>
> But what I learned yesterday, is that at least gcc/clang will place
> the entire variable in the rodata segment if the variable is both
> marked const _and_ initialized.
>
> i.e. this will be allocated in the .rodata segment:
>
>    const char strbuf_slopbuf[1] = "";
>
>>>    #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = (char*) &strbuf_slopbuf }
>>>
>>> respectively.  Yeah, that's definitely preferable to a macro.
>>> Something similar could be done in object.c.
>>
>> What is the main objective for doing this change?  The "make sure we
>> do not write into that slopbuf" assert() bothers you and you want to
>> replace it with an address in the read-only segment?
>
> Actually nothing about the patch bothers me.  The point of that patch
> is to make sure we don't accidentally modify the slopbuf.  I was just
> looking for a way for the compiler to help out and wondering if there
> was a reason we didn't attempt to do so in the first place.
>
> I think the main takeaway here is that I learned something yesterday
> :-)  I didn't actually intend to submit a patch for any of this, but
> if anything useful came out of the discussion I thought Martin may
> incorporate it into his patch if he wanted to.

Thanks for interesting information. I also learned something new. :-)

My first thought was, well, maybe someone writes '\0' to sb.buf[len].
That should intuitively be a no-op and "ok", but the documentation
actually only says that it's safe to write to positions 0 .. len-1, so
sb.buf[len] is supposedly not safe (no-op or not). Maybe a degenerate
and rarely tested case of otherwise sane code could end up writing '\0'
to slopbuf[0]. (Arguably strbuf_setlen should have been used instead.)

I can see the value of placing the slopbuf in read-only memory, but I
think that would be a follow-up patch with its own pros and cons.

Martin
