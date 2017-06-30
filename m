Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E8A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdF3Vgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:36:53 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36787 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdF3Vgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:36:52 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so72803107pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CMHl6HyLkhiKZmpFGMRUw9qdNJuarkLb/H8LZmkDlIc=;
        b=ddml862ho6uYozA3Hcmqcu1ZyoxSDqkFmjN+ImCv/akq1Cow+sYsYLvIMVWbP5l+3Q
         gF61o+fkXW5PwAe7EMwD7k5jUDCuJzzXIajhg7mFqZNPvauNTnHsz/4BmIA87+Y/AuXK
         ppHlI699wVUoz21m2TL0fNDKBsQY8eOxaUYT5FhReFSGBLCENzUAObECzhW86ah1ecEO
         bmugcc+JWdSZa3GtcbPEWHQRUgL5N7vYo6DSqrf8SFTxsD6/e0JyUUTI2uBn86ww6PAe
         kIEigqL0JKIZpES0rr5wDsVYjezsG+sEHNaOW8jrg6OZ9sCy3qJwyPJ4uNeFaA9bBuDn
         RaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CMHl6HyLkhiKZmpFGMRUw9qdNJuarkLb/H8LZmkDlIc=;
        b=iTHMHt8r6x9wF9Y5oeZtyEJZDUkjRnvK+Ub50S3ECHqNLvfLhypBN0zADJg2zZddIA
         Yx0V+Z0imac2Xf9rN2HTDulZzxlDzh5asnjsbzOMWuhgGOGQBBsMfW5k55ubcVPy8mSU
         ErJhfFRFCJyZLAzhiO7APdvlFnfqk/bTu1T/TeWeLJG18o+dDst1HwR2zJbMsxkO5r8L
         oi3oPPg2KDRGGRZh3Oo+8GwIsj5MdOIHpFWdRkhn5nI3mdMONqUW5+RHebUSs+9dYy63
         CB2mHBgMsMmP6ubMSZhaikH8b3gw6x9DJr2jf1lGlrZqx3WYeAviWMNu2xtrA5iQFhUt
         /NmA==
X-Gm-Message-State: AKS2vOwCv6gxKARCQsuAvxDBE7Nawf64oYmd9lNQdK1eoowUyhuw1FJu
        z2SULZ6g8HgPqQ==
X-Received: by 10.84.215.220 with SMTP id g28mr26241609plj.281.1498858611605;
        Fri, 30 Jun 2017 14:36:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id s7sm15922088pgb.53.2017.06.30.14.36.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:36:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCHv2 22/25] diff.c: color moved lines differently
References: <20170630000710.10601-1-sbeller@google.com>
        <20170630205310.7380-1-sbeller@google.com>
        <20170630205310.7380-23-sbeller@google.com>
        <xmqq1sq1qiyg.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbD13RgcTuiegn4J1piFZrNu6bAxCGEKDYLThnVuYQLrg@mail.gmail.com>
Date:   Fri, 30 Jun 2017 14:36:50 -0700
In-Reply-To: <CAGZ79kbD13RgcTuiegn4J1piFZrNu6bAxCGEKDYLThnVuYQLrg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 30 Jun 2017 14:21:03 -0700")
Message-ID: <xmqqshihp37x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jun 30, 2017 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +             return (int)' ';
>>
>> Do we need a cast here?
>
> No, I figured it is good to have it here explicitly, though.
> We can drop that if you have strong preferences one way or another.

I was merely wondering if you were protecting against a funny
platform where ' ' is a negative number ;-)

>>> +static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
>>> +{
>>> +     if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
>>> +             static struct strbuf sb = STRBUF_INIT;
>>> +             const char *ap = es->line, *ae = es->line + es->len;
>>> +             int c;
>>> +
>>> +             strbuf_reset(&sb);
>>> +             while (ae > ap && isspace(*ae))
>>> +                     ae--;
>>
>> Not testing for the AT_EOL option here?
>
> No, because the other options are stronger than the AT_EOL,
> such that as you note it is still correct.
>
> If in the future, we'd have another new option e.g.
> IGNORE_TAB_BLANK_CONVERSION_BUT_WARN_ON_LENGTH_DIFF
> (useful for python programmers ;)
> this would break.

That remark makes it sound as if this is a timebomb ticking, but I
do not think that is the case.  This is merely stripping whitespaces
at the end; mixing tabs and spaces without changing the indentation
level matters only when you have something that is !isspace() to
indent to begin with ;-)

So, the effect of not checking is only a hashmap that is bit less
efficient than necessary, but is there an undue cost of actually
checking and doing this skipping only when we are ignoring the
whitespaces at the end of lines?

>> By the way, this is an unrelated tangent because I think you
> ...
> I agree.  I can make a cleanup throughout the whole code base,
> but I would prefer if that is done in a separate series, as this
> is already slightly lengthy.

Oh, I 100% agree that it is an unrelated tangent.  
