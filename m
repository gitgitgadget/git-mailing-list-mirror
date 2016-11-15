Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E471F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 07:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755456AbcKOH4e (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 02:56:34 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34445 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbcKOH4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 02:56:33 -0500
Received: by mail-yw0-f177.google.com with SMTP id t125so86342362ywc.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 23:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZE56KpsISERwJ4qDgI+shHP1SebxUNiJJSGxFTu8m4c=;
        b=bG+ELtoZNGjrB7wOyxP6zr55D6iHs7Snr+cersMRBRR1jcCuFv3mp4sCpWMoLnSL9X
         n25s4NelwE8PEthFGQeZ71j8u+L7uFMYRgoThkk4rFKvsMAtGOerBNesufZ2XzGZWC96
         EapS1XGc9god6juqG3Q3xjQwdICLNMn74Haf8/LJ7B6lJepF7gP4LVc0bW7GR4hoi+Ky
         akuuOP7uYr82IDLofk1JXg1ujs61+OuU5v5XHKwfuyQolXyjY7ec6gBbJT9tlgoE7wEA
         k5bNIb6bha2o2gM0m1ZvtIYLJFUaXXr+mQ0V5PstA34qyw4F09UxllxW4HId0vsP/dZE
         dTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZE56KpsISERwJ4qDgI+shHP1SebxUNiJJSGxFTu8m4c=;
        b=hAP4sQip46OEjJwy+e/XEQTlG4tXaQ5jyRIy1VgBZZ0Iu2wVLlUi9zCz54Vq87Dsne
         gvvqryNi2yf0dvr8iaTgN/v0HcZHWbN2mThBTdsFiAdnL/mXPykDII6hHaQf2iuyc3jX
         8FJ8uGVVeuzWmlq0mlUzbCE668JsBLQwBgHWzNMjpNnAIq9wigKeeceQx85xrHEJRRxS
         JXeWdOoypBWjLYWHR9DGdvmyAwvwAEoBYct5r0ABtLMvZl/4ZwgiWK4scE5HsJ8eTz/t
         JT2E3ROKRs6PxueGqcghSYwEWR9wnfKhzQXOCdpkHwJAiMaf9ImAIP7jf07xud7Y1mgT
         84DA==
X-Gm-Message-State: ABUngvc4ozkcuctZlnfmxaJoF2XZBrF2GtIUjJOiERRLqJIBQeS/RMOA0fC8V/TKCaO9rR5iwp675W/AettA1w==
X-Received: by 10.13.221.12 with SMTP id g12mr21271806ywe.257.1479196593064;
 Mon, 14 Nov 2016 23:56:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 14 Nov 2016 23:56:12 -0800 (PST)
In-Reply-To: <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 14 Nov 2016 23:56:12 -0800
Message-ID: <CA+P7+xrrg8Dn26JX7LPGV+FFUsPe7XcoGm2btBN=-dX=cBLeMA@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 11:55 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Nov 14, 2016 at 10:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Tue, Nov 15, 2016 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>>>  - More importantly, what do these do?  I do not think of a good
>>>>>    description that generalizes "base of refs/foo/bar/boz is foo" to
>>>>>    explain your :base.
>>>>
>>>> $ ./git for-each-ref --format "%(refname)%(end) %(refname:dir)"
>>>> refs/heads/master                  refs/heads
>>>> refs/heads/ref-filter                refs/heads
>>>> refs/remotes/junio/va/i18n     refs/remotes/junio/va
>>>>
>>>> $ ./git for-each-ref  refs/heads --format
>>>> "%(align:left,30)%(refname)%(end) %(refname:base)"
>>>> refs/heads/master                 heads
>>>> refs/heads/ref-filter                heads
>>>> refs/remotes/junio/va/i18n     remotes
>>>>
>>>> I guess this should clear it up.
>>>
>>> Hmph.
>>>
>>> I would guess from these examples that :dir is an equivalent to
>>> dirname().  But it is unclear how :base is defined.  Is it the path
>>> component that comes immediately after "refs/" that appears at the
>>> beginning?
>>
>> ':dir' is equivalent to dirname(). Yup, base is the folder right after 'refs/'.
>> For local branches it is 'heads' for remotes it is 'remotes'. This is useful
>> when we want to make decisions based on the type of branch we're dealing
>> with (using along with %(if)...%(end)).
>>
>> --
>> Regards,
>> Karthik Nayak
>
>
> dirname makes sense. What about implementing a reverse variant of
> strip, which you could perform stripping of right-most components and
> instead of stripping by a number, strip "to" a number, ie: keep the
> left N most components, and then you could use something like
>
> "keep=2" to keep "refs/heads"
>
> ?
>
> I think that would be more general purpose than basename, and less confusing?
>
> Thanks,
> Jake

You could even make it compatible with strip so that:

"keep=2,strip=1" would return the equivalent of base?

Thanks,
Jake
