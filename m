Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8572A20281
	for <e@80x24.org>; Tue, 23 May 2017 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030768AbdEWS3O (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 14:29:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35142 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030763AbdEWS3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 14:29:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so122387732pfb.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mdiugME4HvMmGCm2N43eMZdZ2jo2L1mpARP5HjnYW/I=;
        b=L58CWtHf62qArH2VTUKxj7A7s0o0sL+sj+MwZX48vl7xjSDsMwNpj1Wkd0wt7OXH34
         Zd+HH9/luTOP1iaWo1Rvuk1ogENj/fPTXtg2/Ms/9e8bSJWrvse+tgQ1cjeF14H4Q38i
         Crh+vnY3GwxM6KEPRiQnhZXLyp0hUaQERomxrrLOP19TnjSduadoMyy6xsZGz2hStXAH
         J0n9do7Dyc0/q+dNDrxrqtALGLrHuVxeRH517h2ooXUwwLI6SUVxN7DjQDPjQ6DPOX9v
         2KhbrXYjmGD5zfE8ZYjg9bxKScdg8BbP3Ovc9r6GiLyCgR7CiqBOSGUBF6Gpo6j5TWXD
         fMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mdiugME4HvMmGCm2N43eMZdZ2jo2L1mpARP5HjnYW/I=;
        b=qHlpytgoHsz3xQkXEbonAF0+lKg3T4NtPNg4PD9FdoKkExSntfry2BR0KJbNT6n9bd
         JGOWaqRwgnRbiSxs//wl3dkI2aVgxCNP327MsWV5K2eFLHpxLNr59cakXS/7LdOciDGK
         6t6ywA3nPPKvjrqqULc4dbiIggrqVOiBTRSE0udtDXu5uHJ+5jE9+bVtBJk5G0xu9Hor
         1wTfo3N+XH/8Ix+tB+3s9vlsEibhU2l+0/69CXDXw8AjJaNnZNdcMVziKdnsEn4iB4VL
         EbT19XTcYdLOkLLSAuYKmR1NRNqOPIOuE75XcKtU9POWLpW43W0l8xAr9kEppPuRyGZr
         YMDw==
X-Gm-Message-State: AODbwcB9YgeeRjUIxkqhurz7cDf++Y105+ls3h+34yAPw7r/G1TAyWlk
        3vQ26+FftC3w96FN7Qv7ynJuI0m6qM+PQY3vNw==
X-Received: by 10.99.60.81 with SMTP id i17mr33804333pgn.183.1495564152619;
 Tue, 23 May 2017 11:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 11:29:12 -0700 (PDT)
In-Reply-To: <xmqqefvgks0g.fsf@gitster.mtv.corp.google.com>
References: <20170522194806.13568-1-sbeller@google.com> <20170522194806.13568-3-sbeller@google.com>
 <xmqqefvgks0g.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 11:29:12 -0700
Message-ID: <CAGZ79kb2iu1D1hRbGNx9aP_ebCyXzrCZQorbop7BG11vSUNzoA@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] submodule test invocation: only pass additional arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
>> index e8f70b806f..2672f104cf 100755
>> --- a/t/t2013-checkout-submodule.sh
>> +++ b/t/t2013-checkout-submodule.sh
>> @@ -65,9 +65,9 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>>
>>  KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
>>  KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
>> -test_submodule_switch_recursing "git checkout --recurse-submodules"
>> +test_submodule_switch_recursing "checkout"
>>
>> -test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
>> +test_submodule_forced_switch_recursing "checkout -f"
>>
>>  test_submodule_switch "git checkout"
>
> Doesn't the above look crazy to you?

Oh well. The commit message doesn't explain why the craziness is
required here (really!).

    submodule test invocation: only pass additional arguments

    In a later patch we want to introduce a config option to trigger
    the submodule recursing by default. As this option should be
    available and uniform across all commands that deal with submodules
    we'd want to test for this option in the submodule update library.

    So instead of calling the whole test set again for
    "git -c submodule.recurse foo" instead of
    "git foo --recurse-submodules", we'd only want to introduce one
    basic test that tests if the option is recognized and respected
    to not overload the test suite.

>
> It is hostile to other people (and those who need to make merges)
> who have to work with test_submodule_switch_recursing that older one
> used to take the full command but its definition suddenly changes so
> that the caller now must omit the leading "git".

I am not aware of other people (or other series in flight by myself) that use
one of the switches currently.

>  Even worse,
> another helper with a similar-sounding name, test_submodule_switch,
> still must be called with the leading "git".

Oh, yeah that is a real issue. I will migrate all of them.

>
> The same comment applies to the one we can see below.

An alternative would be to come up with a slightly different name
to ensure we do not have issues with other series in flight. The function
name is already pretty long, so encoding even more information in it
may be not a good idea. But the argument is shorter, so maybe:

- test_submodule_switch_recursing "git reset --hard --recurse-submodules"
+ test_submodule_switch_recursing_args_only  "reset --hard"

Thanks,
Stefan
