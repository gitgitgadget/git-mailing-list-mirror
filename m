Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFD820450
	for <e@80x24.org>; Fri,  3 Nov 2017 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbdKCTLq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 15:11:46 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:51530 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdKCTLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 15:11:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id 17so4454839qkq.8
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AoSipzHoEcW8aC1ocTqx/A9XLT8mer05rXGz4pt+5HM=;
        b=LMZySB73doE0mUoAdjRc1p+3x/wd/msiEGG7u5M/JUvHXtPOvwHGcdMT7mzGcW6Dtq
         zJXPdUveUxxb2EShvT3ZjogalLxPcTPg7Qrf2RV3gk1qK1QsYLkDBdXqvgKQrt2RveMH
         b7SoaIKEmXcVCfXPiLM0PrI4gUgd33M482R07HgB2ajKo1Xm2r45Ix9Jq/vZcVkux9M/
         9pmGbe+CA5vMsyvN6F3MLyt2vkhZ5vSvBfphyNlVjgQBc9dWYexvhHcHwtuAYWAD1/Zu
         r8UXeFFSP5mMi5F8/5pxT/hIPraokzFlMsbLrHY8egE8siU1nynkpQI2swdOfaw2/w8v
         MFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AoSipzHoEcW8aC1ocTqx/A9XLT8mer05rXGz4pt+5HM=;
        b=eqPcZuGHkPHe9tr4NJqPWkkLYg3dhLGd1vcTpx89hXNxZuvt9umaBL7TA9Gl1mC04y
         ymb7ygmefRhjec0ujCQgJ7dHZlFXJ2vyvYnIHEd2N1cDkbdH26y/avdWpQB0nyKDmeCz
         paDnYZF9w1ct9ZfNcnmxW4pvTviLvmYldbkdXNEKm3KyAif8n1uDgp4eptkeuXPUp+f6
         dHn77EtFtu2KjxYbtQCByLZx56rjFynR9gM3yivTqZY2OANXc9dtYWe2ZMGzZ+5Y2g94
         eV2fINtZCfg/jsCf95DrUY1FOdEC2Y3l+x7EM8pYGhrPQagUuF4jkemUXd2tkrvLoiFb
         RY/w==
X-Gm-Message-State: AMCzsaVuVcBFnlX2FKzA/hhqJqJFX7lvpZmyC0eckYSsalbvUys3aR9a
        az+nCFaDfpCWI4N1A7iH98V/KFAngw5PiUCQAwx47w==
X-Google-Smtp-Source: ABhQp+SAIlMNavuhYYnczI8Wz4QcBQaL0C83yWf+tO7j/+LiLnpVz8HpTiG+uou9GOURGknSSVxbXoEkqiAd/7o3OAc=
X-Received: by 10.55.125.196 with SMTP id y187mr11874403qkc.180.1509736304832;
 Fri, 03 Nov 2017 12:11:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 3 Nov 2017 12:11:43 -0700 (PDT)
In-Reply-To: <0f1f8317-9d82-5e61-5332-f877ca886056@gmail.com>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net> <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
 <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net> <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
 <1508682297.6715.15.camel@gmail.com> <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
 <CAGZ79kYAn0Hi0qaG8P5zvVOFTsfXYrtvrR7oiT0KwwWeKLqZgw@mail.gmail.com> <0f1f8317-9d82-5e61-5332-f877ca886056@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 3 Nov 2017 12:11:43 -0700
Message-ID: <CAGZ79kY+R_Kd7BbmnRb0C1H94HvZ3TGRvWKFOX8XEStjBQMB-A@mail.gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 2:32 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Monday 23 October 2017 11:07 PM, Stefan Beller wrote:
>>
>> Exactly. By memory I mean volatile RAM (as opposed to
>> memory on a spinning disk).
>>
>> Using GIT_TEST_OPTS has had some issues (I remember vaguely
>> there was an inconsistency between the output of `make test` and prove),
>> so I put my entire working tree on a tmpfs, I run roughly this script
>> after booting my computer:
>>
>>    sudo mount -t tmpfs -o size=16g tmpfs /u
>>    mkdir /u/git
>>    echo "gitdir:
>> /usr/local/google/home/sbeller/OSS/git/.git/worktrees/git"
>>>
>>> /u/git/.git
>>
>>    git -C /u/git checkout -f HEAD
>>
>>    cat <<EOF >/u/config.mak
>>    DEVELOPER=1
>>    DEVELOPERS=1
>>    CFLAGS += -g -O2
>>    CFLAGS += -DFLEX_ARRAY=2048
>>    #CFLAGS += -Wno-unused-value
>>    EOF
>
>
> Did I thank you for a good explanation? If not, thanks that was interesting
> and enlightening.
>
>> The test suite (excluding t9*) runs in less than 50 seconds on the ram
>> disk.
>>

Just tested again, I meant to say 70s instead of 50s.


> BTW, this is what I call _way way_ faster. Unfortunately due to the limited
> configuration of my system, the test suite has following timing
>
>     real    3m14.482s
>     user    2m10.556s
>     sys     1m12.328s

This sounds to me as if it is running with just one thread
(because sys+user = real); I usually run with

    cd t
    prove --jobs 25 t[0-8][0-9]*.sh

The multithreading can be seen in the timing as well
    real 1m9.913s
    user 1m50.796s
    sys 0m54.092s
as user > real already.

If you run tests via 'make test' or 'cd t && make', you can also give
a --jobs <n>
to make it faster. I have no good answer for how many, but I have the impression
overloading the system is no big deal. (I only have a few cores in this machine,
4 or 6, but still run with --jobs 25; 'git grep sleep' returns a
couple of lines,
and such threads sleeping definitely don't need a CPU)

Thanks,
Stefan
