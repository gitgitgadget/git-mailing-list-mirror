Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593591FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 22:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750760AbdALWTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 17:19:38 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33476 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdALWTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 17:19:37 -0500
Received: by mail-io0-f174.google.com with SMTP id v96so30174863ioi.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ragah5ScAjpOvuViGeZzZJEd4jgCO00/aZyvcv05ZOU=;
        b=agdqYDJAfuMAF+v+jmSWeZeDOjFADntfhYT1Rsb2l/0kLp1taq1LAf06Qv23abxAsc
         VpXcnFE7uLFs9K2a0K/+VS7sXrQ3m4YNNO0MVn/w0mtunFsmAUkxnwZNIhh+NwCMC02M
         ONAxDILdyyl1rBNeVX3JNHmhSFKkRk4d3+CBJHREAQJ6caJUuI5gEqhQTat8siCmaINc
         xqJJ4wWoVVAKr50gW82wd0/NhbQHj/yUB2GbbFIGYOSoTEE8uOfcXW8wpdQ07V3zDrIV
         zw62GULS6pA8q+JyQOkBN92dnwU6kyKbxzzmbFnIxWThYlfj3kp1oV94xuB9FxPgg0PG
         S6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ragah5ScAjpOvuViGeZzZJEd4jgCO00/aZyvcv05ZOU=;
        b=WhTkNk5xpKTz2ANesrcnvHYPBwkj7wmCDgHyPyj/dPQDub5vjTpO3Zgr718HJojSND
         qKvmjlFs+OAAGs9yqinL2Pu6sc9CXVCMr6vWqB5rIvS5Uv1A3pQgdnFbzvsvo+9Q3VQW
         PzhrLmr54gOV8dwfdBzKVsG7OjkbVcN5R5SWMrLd1ttikiGbyLRATQ6P9rxpTehtZDc9
         Et4HexRVG5ZSbzuE0BTcj9hXYaPX4oDKihiTWQOIBJLC6of9n/T1iDP0zmt2mhhq4dRQ
         eq+twVc/OjOWkj/D761NfJmL4YfK9UwIcEcS5gniDR5JsIVtrFohHOk2RL+Y6/Ng9iHj
         bf3Q==
X-Gm-Message-State: AIkVDXK/XOJjxW3MDhbZvW6e+RS6cR9IIBsjJ5CNSt3sL3bmRn2he/GMjEwZOe9j26SKCXKut7LHpVnFb4ZBlh+J
X-Received: by 10.107.3.160 with SMTP id e32mr15502740ioi.52.1484259576379;
 Thu, 12 Jan 2017 14:19:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 12 Jan 2017 14:19:35 -0800 (PST)
In-Reply-To: <xmqqtw94hs8f.fsf@gitster.mtv.corp.google.com>
References: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com> <20170112001253.27679-1-sbeller@google.com>
 <xmqqtw94hs8f.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Jan 2017 14:19:35 -0800
Message-ID: <CAGZ79kZWYytJbXJZ=qeStuSe3tZ3qiCZZ-01Y0Ud9TcqsorjMw@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] unpack-trees: support super-prefix option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is only patchv4 that is rerolled, patches 1-3 remain as is.
>
> Good timing, as I was about to send a reminder to suggest rerolling
> 4/4 alone ;-)
>
>> +static const char *super_prefixed(const char *path)
>> +{
>
> There used to be a comment that explains why we keep two static
> buffers around here.  Even though it is in the log message, the
> in-code comment would save people trouble of having to go through
> "git blame" output.
>
> I'd say something like
>
>         /*
>          * It is necessary and sufficient to have two static buffers
>          * as the return value of this function is fed to error()
>          * using the unpack_*_errors[] templates we can see above.
>          */
>
> perhaps.

If you think it helps, I can reroll with such a comment.
At the time of fixing up for v4 I felt like it is overly verbose.
Such a comment is only useful in understanding the choice of 2.
I thought it was sufficient in the log as once you're interested in
that function you'd read the output of blame anyway.

On the other hand having statically allocated arrays of fixed size is
dangerous in terms of maintainability, i.e. down the road someone
thinks this is a good function to reuse and then they may run into
subtle bugs as they will not be aware of the internally static buffer
that is overwritten after a certain time.

>
>> +     static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
>> +     static int super_prefix_len = -1;
>> +     static unsigned idx = 0;
>> +
>
> If we initialize this to 1 (or even better, "ARRAY_SIZE(buf) - 1"),
> then we would use buf[0] first and then buf[1], which feels more
> natural to me.

Yes I agree, though I overcomplicating things just so that they feel
more natural seems wrong as well.

At the time I assumed that having a static variable initialized to 0
was slightly cheaper, as the init code just memsets all of .bss to 0
unlike the .data segment that has to be crafted manually.
But to get that variable into the .bss section reliably we'd have
to omit the "=0". (My compiler recognized that it can be put into
.bss because it is 0)

>
> Other than that, this looks OK.  Will queue.
>
> Thanks.

Thanks,
Stefan
