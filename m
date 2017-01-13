Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57AE1FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdAMA4e (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:56:34 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33966 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdAMA4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:56:34 -0500
Received: by mail-lf0-f66.google.com with SMTP id q89so3861471lfi.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x9yu8iuXeBLFScaUIFSu6tUQe015IkNcNnaU4Gfwg9A=;
        b=NCkqBATtayM1OR4LfuzQzaQdOWZjdMEntwXWzWtmcRfHrDs7VwAK1u0JlbBjTjqlIV
         2wZXtIK3lYHq9RDLMsVAngSLeUJ4gnoCKJu1QJKC5gPmlczPI+GPWfN9qP3bdr3Q60UW
         vvIy5EyLhEKSiyt267YxjUNscegk38YOxVVhfkXYmsAaOnMWpXXySP1G6MD/Hfut2ddB
         LfJ5ld+EubpE238zOyxvAMOSiHa0EXNLynKnR5Jqp/xZXirZtjzxK6a2OHnaKNV01hWG
         b/VPRyBXrotv6qY7GId8oYaV3WDHwaRK40S5NxhTjeNARE5a69kfFa3w7H13uJQSRIPT
         UnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x9yu8iuXeBLFScaUIFSu6tUQe015IkNcNnaU4Gfwg9A=;
        b=J3UFRIWUH/bQbU2WrL1n7kskklpeV+wbx6+5ntpLYjtaSvq416HpGj+EzmmAg6KKF4
         pmb2L2SD1qLI1W2hv1BSCjcdfHp9hdLijWFSpJt5dnNPrgLEAWOyUkQeXNzns1AFd4qE
         2UZpE2DVNpZECmKr/pV1JbnlLlFv+4+WzmzCKGWK9S88J+KnQVDumSUXt792bdGjRMKi
         pkmK8p8sw4pIOYkXnVCWvq9fqiOHcVpKS6dxPm+xdqemIJS7yWEP9JPqznU6mSEbZ5SJ
         7YBUOxWOo/a4MZkIrn8+THrACR8KQ0jHUru5AdU5Zjgr0JTGmlZjRxmqLCjmIV4AOs9q
         NEAA==
X-Gm-Message-State: AIkVDXJHSBHe/mdzNA26qX+xZXR9pb7n1ZJ0kIwAkf/A2pFncVOL5Z2V6g8uaH1vHlRdQA+j5p3bfLyhz2ODbg==
X-Received: by 10.25.27.145 with SMTP id b139mr5685012lfb.114.1484268992226;
 Thu, 12 Jan 2017 16:56:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 12 Jan 2017 16:56:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701121049530.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-3-jacob.e.keller@intel.com> <alpine.DEB.2.20.1701121049530.3469@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Jan 2017 16:56:11 -0800
Message-ID: <CA+P7+xpHQ7AobJNXTnHs1jf8Y67PJYqoR3yONFBb4k_=63CH5g@mail.gmail.com>
Subject: Re: [PATCH 2/5] name-rev: extend --refs to accept multiple patterns
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:56 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Wed, 11 Jan 2017, Jacob Keller wrote:
>
>> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
>> index 1408b608eb03..d072ec43b016 100755
>> --- a/t/t6007-rev-list-cherry-pick-file.sh
>> +++ b/t/t6007-rev-list-cherry-pick-file.sh
>> @@ -99,6 +99,36 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
>>       test_cmp actual.named expect
>>  '
>>
>> +test_expect_success 'name-rev multiple --refs combine inclusive' '
>> +     git rev-list --left-right --cherry-pick F...E -- bar > actual &&
>
> Our current coding style seems to skip the space between `>` and `actual`
> (this applies to all redirections added in this patch).
>

Right that's easy to fix.

>> +     git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
>> +             < actual > actual.named &&
>> +     test_cmp actual.named expect
>> +'
>> +
>> +cat >expect <<EOF
>> +<tags/F
>> +$(git rev-list --left-right --right-only --cherry-pick F...E -- bar)
>> +EOF
>
> In the current revision of t6007, we seem to list the expected output
> explicitly, i.e. *not* generating it dynamically.
>
> If you *do* insist to generate the `expect` file dynamically, a better way
> would be to include that generation in the `test_expect_success` code so
> that errors in the call can be caught, too:
>

The main reason I don't like static expecations is that often other
tests inserted before or after my test now have to know what to put
here. Specifically, the problem is that we expect the output not to be
named, but actually to be sha1 hex output. This seems really brittle
for a test.

> test_expect_success 'name-rev --refs excludes non-matched patterns' '
>         echo "<tags/F" >expect &&
>         git rev-list --left-right --right-only --cherry-pick F...E -- \
>                 bar >>expect &&
>         [...]
>
> However, if I was asked for my preference, I would suggest to specify the
> `expect` contents explicitly, to document the expectation as of time of
> writing. The reason: I debugged my share of test breakages and these
> dynamically-generated `expect` files are the worst. When things break, you
> have to dig *real* deep to figure out what is going wrong, as sometimes
> the *generation of the `expect` file* regresses.
>

Do you have a better suggestion for how to check the expect vs actual
output ignoring the raw hex data that would be there otherwise? What I
want to avoid is a brittle test that depends precisely on actions of
prior tests in generating commits and tags. Specifically in this case,
we're going to end up with the sha1 hex ID of the commit in the
expected value.. hard-coding that feels wrong.

Thanks,
Jake

> Ciao,
> Dscho
