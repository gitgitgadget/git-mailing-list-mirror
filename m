Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5ED20229
	for <e@80x24.org>; Fri, 11 Nov 2016 05:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbcKKF3f (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 00:29:35 -0500
Received: from mail-yb0-f180.google.com ([209.85.213.180]:34724 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbcKKF3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 00:29:34 -0500
Received: by mail-yb0-f180.google.com with SMTP id d59so2155676ybi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 21:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y/y902TbBBPxs9qUNiGDsNKoxrJHGmg3APRfXREuy9o=;
        b=Hlr0gryiPf5U3g4yTxEegXEiEcM0hPugXoQPd79WjS41mg+i1iX7aGPRVfZjND0723
         5KhFCWorAxz1ac/u09eqAsBzfN5ZR7arxeA2z/lFokuY329MDUVXS/6q8wFkYN9GA80o
         cf+ysSU8RSgBOQXgNkdHL4l2jtaS+Efh1Fna/7roIaVwH608bAxlSjMgMeFZN/rx5e1W
         NOjxQiMvvHWtnBbKu2tMkaWLRAnYAJLl3qPUEc3AKcQYss8fO1CLefPjx2Lm33Xh5/Vw
         nrV3AFUiOfmJ4PAjXxPweR4fLmNdDcDUQJnlQVuJmbQGLx4XjgBh+uSugwZaTz9rretd
         crSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y/y902TbBBPxs9qUNiGDsNKoxrJHGmg3APRfXREuy9o=;
        b=TSqr4UE5SLbJ1Ii8W5yTH2wB8+XHTkaMmOIhA0a2hz48vmVZv6hVlZkXC2criqI9dL
         EA1mHeB8NTJ08+WKTKhnlYvBpkkwwj3NfRAd8R7n2NtPIMJS1uKU06OKWuuSxPbf8hUy
         8dZDW0pZr6cGxjB6Obr+44r8HVivFgmqjOdaMu51J8mtA55R96UEuOncFDCIpiRQvD5O
         jRC3TG5ZZAx8v7iiH3EVyp8uYSAr+jc3ZyRGbyqAeD5R4ky6QA1ZVpkkhLKd1nGpsW2C
         4AhKsK7DQVWz7Gx0TAYp9TFcp3UwjABsaAP93BhAVOyjmz2LdxbYKln5zoNiOEvMqohd
         QJGw==
X-Gm-Message-State: ABUngvflzOFNxmplT8KQufe2u4ZAMEm5/IgRBfRFZqErLXsX4oxMpG1222XL4vQVQ1naii+kEHyFMwZXSMrNHw==
X-Received: by 10.37.18.11 with SMTP id 11mr1071251ybs.153.1478842173787; Thu,
 10 Nov 2016 21:29:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 10 Nov 2016 21:29:13 -0800 (PST)
In-Reply-To: <CAOLa=ZRDNGGc-OA+d+T1=9JvoVe2eBZt0DYQEHmeNKhDpxQbdg@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-5-Karthik.188@gmail.com>
 <CA+P7+xqG5ACT2ZB=M8gLmDaYgSgX202+afJmZJKat6NzbFzL=g@mail.gmail.com> <CAOLa=ZRDNGGc-OA+d+T1=9JvoVe2eBZt0DYQEHmeNKhDpxQbdg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 10 Nov 2016 21:29:13 -0800
Message-ID: <CA+P7+xqXY6XvUm8Kna_GwY4XOSSGPM=-ezZECgkGcbnX_Penmg@mail.gmail.com>
Subject: Re: [PATCH v7 04/17] ref-filter: modify "%(objectname:short)" to take length
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 9:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Nov 9, 2016 at 4:57 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> Add support for %(objectname:short=<length>) which would print the
>>> abbreviated unique objectname of given length. When no length is
>>> specified, the length is 'DEFAULT_ABBREV'. The minimum length is
>>> 'MINIMUM_ABBREV'. The length may be exceeded to ensure that the provided
>>> object name is unique.
>>>
>>
>> Ok this makes sense. It may be annoying that the length might go
>> beyond the size that we wanted, but I think it's better than printing
>> a non-unique short abbreviation.
>>
>> I have one suggested change, which is to drop O_LENGTH and have
>> O_SHORT store the length always, setting it to DEFAULT_ABBREV when no
>> length provided. This allows you to drop some code. I don't think it's
>> actually worth a re-roll by itself since the current code is correct.
>>
>> Thanks,
>> Jake
>>
>
> That does make sense, It would also not error out when we use
> %(objectname:short=) and
> not specify the length. Idk, if that's desirable or not. But it does
> make the code a little more
> confusing to read at the same time.
>

I am not sure that would be the case. If you see "objectname:short"
you trreat this as if they had passed "objectname:short=<default
abbrev>" but if you see "objectname:short=" you die, no?

> So since its a small change, I'd be okay going either ways with this.
>
> --
> Regards,
> Karthik Nayak
