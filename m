Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C141F51C
	for <e@80x24.org>; Fri, 18 May 2018 19:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeERTZu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 15:25:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38990 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeERTZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 15:25:49 -0400
Received: by mail-qk0-f195.google.com with SMTP id z75-v6so7326857qkb.6
        for <git@vger.kernel.org>; Fri, 18 May 2018 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=expoHl0XRVNSP/nHAIthPEdbBCodHPoEt+oEaUDKofE=;
        b=iJcefETn6w46gjkuUZWNllzKBpROOIXHVtfQN03NEPrCsLCpHK88PAvVcZk9KJBX1v
         ZFUr3XD/JA9zxJSdNWgaQ9DvKGbVb56XDK4aCQIWAEPJ+izRVYN7Fsvbek1AZJF/fmh/
         FnkRBTsIXP7lGRmWqW2WDiW6zRy66QztsAjziqvMpAJFBlGf8MMQnXTXJf5vdzvoioTJ
         D1bLdRMZTqdvVjW7nDZuppWbDJfIripIYXRJ/cNe6DjWxFsKGYB/Areur00rryqbaf7F
         Lb7ZV18AKsZrOctQvwtNllyX6/DL7lsDAfEJiD9Fic8lL8wpqSuZvDGdykHlpAnW5326
         xu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=expoHl0XRVNSP/nHAIthPEdbBCodHPoEt+oEaUDKofE=;
        b=Njgqjkxkedrt14FIQexVPYVwfv2MZ6ZG3OX+k9eKHgWg/u8Be1i6kLkv59ChR5T/qn
         ITrVfMyaH6iz7w04UTPVc7PBJ7T4zHtS6JIYAaD0I25xRjOt9IOfkSRFD7ObzCXiKP4Z
         nJTdoF7WuXpTIrYCLG5yr/mWH4I89ROF9d+fFGHmS3dhqK/9xQmjQDFiygCkhecVBu1+
         j9PLtCul9je+cgun6jWkNfNRX1JNjSl+vOn/+aX+6ODa+ugsdlFD4/9dmU+F/pZ6D21G
         dtx9ktWVi74bxJt5Ek0csF1m/rQPYJjH1NP5YpnnNK2Fk1PcANbQ3KA/ZeNwrYGkVq5k
         I6zQ==
X-Gm-Message-State: ALKqPwflCbIkNDHYpBLdgKal7eOYSu/JDUqjYVt9YPuCDh2R/XIurD2u
        vYJLHermFJPajox3vEWtFJ4sTWm6kcXGyzF6ftM=
X-Google-Smtp-Source: AB8JxZrhLxaDP7PrZujfYdaZo1Amn1HvyG64jPS74U/XeHJomjO6HChqXZ/SZLfwBB9ymIqhaU9ebr9E01wA9Wu1Hy4=
X-Received: by 2002:a37:6c02:: with SMTP id h2-v6mr9422784qkc.145.1526671548769;
 Fri, 18 May 2018 12:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 18 May 2018 12:25:48 -0700 (PDT)
In-Reply-To: <20180518141751.16350-3-szeder.dev@gmail.com>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com> <20180518141751.16350-1-szeder.dev@gmail.com>
 <20180518141751.16350-3-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 May 2018 15:25:48 -0400
X-Google-Sender-Auth: QNFQ35sUM109BAeL56ZXvsZn3fc
Message-ID: <CAPig+cR3phOhx79n6Z2bA2O=PrUPPnbcgHgHOYYYmyOiwjVdEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t9902-completion: exercise __git_complete_index_file()
 directly
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 10:17 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> The tests added in 2f271cd9cf (t9902-completion: add tests
> demonstrating issues with quoted pathnames, 2018-05-08) and in
> 2ab6eab4fe (completion: improve handling quoted paths in 'git
> ls-files's output, 2018-03-28) have a few shortcomings:
>
>   - All these test use the 'test_completion' helper function, thus

s/these test/&s/

>     they are exercising the whole completion machinery, although they
>     are only interested in how git-aware path completion, specifically
>     the __git_complete_index_file() function deals with unusual
>     characters in pathnames and on the command line.
>
>   - These tests can't satisfactorily test the case of pathnames
>     containing spaces, because 'test_completion' gets the words on the
>     command line as a single argument and it uses space as word
>     separator.
>
>   - Some of the tests are protected by different FUNNYNAMES_* prereqs
>     depending on whether they put backslashes and double quotes or
>     separator characters (FS, GS, RS, US) in pathnames, although a
>     filesystem not allowing one likely doesn't allow the others
>     either.
>
>   - One of the tests operates on paths containing '|' and '&'
>     characters without being protected by a FUNNYNAMES prereq, but
>     some filesystems (notably on Windows) don't allow these characters
>     in pathnames, either.
>
> Replace these tests with basically equivalent, more focused tests that
> call __git_complete_index_file() directly.  Since this function only
> looks at the current word to be completed, i.e. the $cur variable, we
> can easily include pathnames containing spaces in the tests, so use
> such pathnames instead of pathnames containing '|' and '&'.  Finally,
> use only a single FUNNYNAMES prereq for all kinds of special
> characters.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
