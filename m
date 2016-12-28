Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA761FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 08:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbcL1Iyv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 03:54:51 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34461 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbcL1Iyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 03:54:50 -0500
Received: by mail-yw0-f194.google.com with SMTP id a10so24163641ywa.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=btl1BqMCz2mdiV4+JflCVw6sOeJdqps0rcyShKFgLF0=;
        b=cUCWynbQ+RjoJ11BeQniqYT8h8JP0JIoDA1JAgrB8ICWAs2uI4X8CU+2HbwDIgwwuw
         Z0ZOI8GqWEJ0sRSBC7YfB5wpkpn0dMN2R9e5xCfnrhkSfq1dINmnpa4DDxkHvmDe2EXq
         pzZnYWjZ71/9m82akX2SP+3zBu9GSAdrtGRdvK7n5i9+DHiG4PJeLtH7G0nWCJZpufsh
         J2/TdTnH2xl7xIFbRbWnE5zYgx+cBSC9tnOZgaTTc610BWb8eN1YSYsCgt9A24QVPjmY
         I6gaLVVxM9PZ1c+uGWYiDwspPZm350Yh2sTjgqPhn0wy3qkhPLHTX2GBT5paEIfkY6Je
         E3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=btl1BqMCz2mdiV4+JflCVw6sOeJdqps0rcyShKFgLF0=;
        b=clQ00vEeUeYonCdVNG1h8lVZnDq1Irf3g65jmORuY7Orh+9wA13FxZq4gM5QgU3bRy
         7Bcu9WLnLSt7Uc8wvbcdEwrz1YeXHQuINGd+YZeCP+a+VYv+5H9A96pLIYbSfP7gXeCS
         L6Rma8sr6nS7fWnkZOLptJ44hIJMwMLk4CO+CuVUUhznbFJ4rNHawELAoEFTVHOzc/ex
         ZVMYNng/hOGEcEn4kGXrK4F8hyNIKZJ2e2TQ03+pPc2nXiD3aFjRY8XaltDvCDI7qb3z
         +tpcxz13wjYkAXKlRndDqVSJb9FoJ0WhYVWGlqFv9gi9vrtxzGCbjF4gTaZ50YQ9tIAZ
         s9lA==
X-Gm-Message-State: AIkVDXLY247RsAiragfe/wbTR5hSHWaIfH8Plf93zDLD/XOA51cbPwLU1MbGdNxHby59TF7QcSxZW2UZB7SF3w==
X-Received: by 10.129.121.1 with SMTP id u1mr28278056ywc.146.1482915289591;
 Wed, 28 Dec 2016 00:54:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Wed, 28 Dec 2016 00:54:19 -0800 (PST)
In-Reply-To: <xmqqo9zx6phw.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-16-Karthik.188@gmail.com>
 <xmqqo9zx6phw.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 14:24:19 +0530
Message-ID: <CAOLa=ZTs7G_fk77j-QxiM7fLncPRtJ8DfNGaw1upyT1CSx3Xyw@mail.gmail.com>
Subject: Re: [PATCH v9 15/20] ref-filter: modify the 'lstrip=<N>' option to
 work with negative '<N>'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Currently the 'lstrip=<N>' option only takes a positive value '<N>'
>> and strips '<N>' slash-separated path components from the left. Modify
>> the 'lstrip' option to also take a negative number '<N>' which would
>> only _leave_ behind 'N' slash-separated path components from the left.
>
> "would only leave behind N components from the left" sounds as if
> the result is A/B, when you are given A/B/C/D/E and asked to
> lstrip:-2.  Given these two tests added by the patch ...
>
>> +test_atom head refname:lstrip=-1 master
>> +test_atom head refname:lstrip=-2 heads/master
>
> ... I somehow think that is not what you wanted to say.  Instead,
> you strip from the left as many as necessary and leave -N
> components that appear at the right-most end, no?
>

Yup, you're correct it should be 'leave -N components from the right-most
end'. Will change that.

>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -98,7 +98,8 @@ refname::
>>       abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
>>       slash-separated path components from the front of the refname
>>       (e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
>> -     `<N>` must be a positive integer.
>> +     if `<N>` is a negative number, then only `<N>` path components
>> +     are left behind.
>
> I think positive <N> is so obvious not to require an example but it
> is good that you have one.  The negative <N> case needs illustration
> more than the positive case.  Perhaps something like:
>
>     (e.g. %(refname:lstrip=-1) strips components of refs/tags/frotz
>     from the left to leave only one component, i.e. 'frotz').

Good point, but i'll be using N = -2 rather than -1 since N=-1 can
also be obtained
by using N=2 as shown in the existing documentation. With N=-2 we differentiate
the use cases of N= positive and negative numbers.

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index 9123c6f..814d77a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -99,7 +99,8 @@ refname::
        slash-separated path components from the front of the refname
        (e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
        if `<N>` is a negative number, then only `<N>` path components
-       are left behind.
+       are left behind. (e.g., `%(refname:lstrip=-2)` turns
+       `refs/tags/foo` into `tags/foo`).


>
> Would %(refname:lstrip=-4) attempt to strip components of
> refs/tags/frotz from the left to leave only four components, and
> because the original does not have that many components, it ends
> with refs/tags/frotz?
>

It ends up with 'refs/tags/frotz' since there are not enough components.

> I am debating myself if we need something like "When the ref does
> not have enough components, the result becomes an empty string if
> stripping with positive <N>, or it becomes the full refname if
> stripping with negative <N>.  Neither is an error." is necessary
> here.  Or is it too obvious?

I had the same self-debate, and dropped it for being too obvious.

On Wed, Dec 28, 2016 at 8:38 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> I do not think it hurts to have, and makes this obvious.
>

But as Jacob mentioned, it doesn't hurt to mention the obvious
sometimes. So i'll
add that in :)

-- 
Regards,
Karthik Nayak
