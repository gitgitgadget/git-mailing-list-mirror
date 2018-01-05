Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4E71F428
	for <e@80x24.org>; Fri,  5 Jan 2018 14:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeAEOhQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 09:37:16 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35639 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeAEOhP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 09:37:15 -0500
Received: by mail-vk0-f50.google.com with SMTP id o73so3582378vkd.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w1uabzGQzU1j8xZZXnUlge/m30PUjSPAo9rDqlGlF4Q=;
        b=NOjK2q/nevmHP3JI8E6vvnWcFS489G8VSmlCkUc0hiwsZYFJ6+pz03Qzd0k5eIdXlD
         LD/WJ/zjvURxjrMilFVE+WWcewSy8wBwUAJQkORSVLVSPMesy9zHmacc8Fcl60IQkB0B
         ZV/iJMBpxh6VOewvnhpDyiwEH20/lBtAwTBCrs7Ql83eZNdbghVc0iwlB8qjfveScNom
         Xoe7sDw/MlZDbrycM13RGgmzbOUOGUtWX1s27Ec9TkMVIMetriyHu/VEVmPNHLyz2zQ1
         N5L0qVjfFA5Zw+w/nQ2l25f034eShpEVscvGSIdLnJm2qqzQ9VHdeXntvvVSRmcMKPh0
         twFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w1uabzGQzU1j8xZZXnUlge/m30PUjSPAo9rDqlGlF4Q=;
        b=W3fcvO+sfATMXdBwRQexvlMCYfo+86thkV6arXi52eFMj57nHZY/4u/eTGEqJd3pyk
         W7gnExmJ2pIwfxbLto5n0aHNbexE1YzvA9j/TAMhpqbEsQGAot5xML+UHVW/rdnfm80M
         zdvewDZlRm4yaKvNfYU/SfRatIV2j2vv7FiHW87iv3qkZ6/vT5YhRWW0MgwZSL8QFUAd
         52LfMuihUNryvtk+7QilAIt0tou1B/8XaKpKtMdI7cj7S36o4O1l85t8uoEG1BFaRIM7
         Fb/Hvfp3GQumyXB/WlCyV1YvuAcFzS1fl9DslscPatZouGlgFYenQTrtGca0nfZiftNy
         moSw==
X-Gm-Message-State: AKwxyteGH7C3GHwS5xJZQOFAOfyittXv88C3XG1eQ8jGp2qProe3mDne
        11eML53epejlyqssQTHTTyMXAk3/BUip5qrpTo8=
X-Google-Smtp-Source: ACJfBou1tg+aLsARHkNVkV9sRFYIqn+cl+sSAsULgrEPranfNc9hCawH89LlB2RVRie6XI8Gwe4g5HQMUSJlTyWRzug=
X-Received: by 10.31.254.137 with SMTP id l131mr2886791vki.153.1515163034809;
 Fri, 05 Jan 2018 06:37:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.15 with HTTP; Fri, 5 Jan 2018 06:37:14 -0800 (PST)
In-Reply-To: <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com>
References: <20171228041352.27880-14-newren@gmail.com> <20180104005223.13566-1-szeder.dev@gmail.com>
 <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 5 Jan 2018 15:37:14 +0100
Message-ID: <CAM0VKj==Ua5rAj=z3gr0LSRQRNYeECtdE5NwwcPqy7j75BX5zQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/34] directory rename detection: tests for handling
 overwriting untracked files
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 10:10 PM, Elijah Newren <newren@gmail.com> wrote:
> On Wed, Jan 3, 2018 at 5:52 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>
>>> +             test $(git rev-parse :0:y/b) =3D $(git rev-parse O:z/b) &=
&
>>
>> There is a test helper for that :)
>>
>>   test_cmp_rev :0:y/b O:z/b
>>
>> Note, that this is not only a matter of useful output on failure, but
>> also that of correctness and robustness.
>
>
> Cool, good to know.  Is there any reason test_cmp_rev is not
> documented in t/README?

Because of mere oversight, perhaps?  (both for this and for the
'verbose' helper)
I forgot that the test helpers are documented in 't/README' (well,
apparently only some of them), I usually go straight to
't/test-lib-functions.sh' to find test helpers or to learn what they are
doing.

> I already changed these yesterday, as part of trying to avoid the use
> of plain 'test' as you suggested (I was just waiting another day or so
> for more feedback before resubmitting the series).  Since I tended to
> have several of these rev-parse comparisons in a single test, I simply
> combined them:
>     git rev-parse >actual
>       :0:y/b :1:x/c :2:x/c :3:x/c
>     git rev-parse >expect
>       O:z/b O:x/c A:x/c B:x/c
>     test_cmp expect actual
>
> That does result in fewer rev-parse invocations, which is probably
> good, but the test_cmp_rev does seem slightly more readable.  Hmmm...

Yeah, the significantly more 'git rev-parse' invocations are the reason
why I didn't recommend 'test_cmd_rev' in those cases.  Folks running the
test suite on Windows probably won't be very happy about such a change.
Though I had a bit of a "Huh?!" moment when seeing those combined 'git
rev-parse' pairs for the first time, I don't think converting them to a
list of 'test_cmp_rev' invocations would make it notably easier to
read.
Have you considered vertically aligning the corresponding rev arguments
in those 'git rev-parse' pairs?

Furthermore, on second look, while 'test_cmp_rev' does produce output on
failure, it's not really useful for humans, being only a diff of two
files with a single object name in each.  As it is, I don't think it's
any more useful than the output of those combined 'git
rev-parse'-'test_cmp' combos would be, so no gain there, either.
OTOH, we could easily enhance 'test_cmp_rev' to include the given revs
in its error message...

I leave it up to you.
