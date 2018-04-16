Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973701F404
	for <e@80x24.org>; Mon, 16 Apr 2018 19:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeDPTWm (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 15:22:42 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:38410 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbeDPTWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 15:22:40 -0400
Received: by mail-yw0-f179.google.com with SMTP id h28so5871144ywk.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zn2oiDfUVJXZ46Rhem5I6cW8zBPpnmVWihdNgbNQVRg=;
        b=L3Hfr0iztBW/7c7FiAOou1FbPcNOXNN43OneujWwYQxVSKecNuFRlkaau3dBdzk3X6
         DVdOKO/CM1gJqpdPtI6TAIygTpAaW5148hFFI7zcUeHVUbiahTVEwJDMK3Sj/3HJ0CtO
         wQR6+yGtoq2grpjnMWs7Xn5UTJAWHDqiiJnA8HMvcIMQPw18jLFmrujdGk2TwSHrGS/G
         Eoq9oBFb28mBcqyQRflK9B0t48pNhZQyrKE/AlfrQm5xBwq2UmcML+5k/hXopC+TCHGn
         QvBHN5/KkcLwcQHCjkzDZZcAgT5z1tu85u/p3hQc1HrMs94pbo76jCL4De2ULDWRnc37
         FJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zn2oiDfUVJXZ46Rhem5I6cW8zBPpnmVWihdNgbNQVRg=;
        b=BwBYKeyT3Eu7UkoA+sqrgdNxGsP3MAmwYuvMY5dSS3n/68oDa1ppuU1jK7x8nBk2hX
         Q4EhDzspBHYBnq2vpJwnB17ochmhGdUbQ/Egx89K6hJIVZBR2Cu0rc3xdaAOzEUPGOr8
         DVBLkPDl5noo4FS71JFH1TU3Saq6NzEkD/zd4RNPi7czxSZlEApKNdI0yL0Eemr6M4fZ
         tvDPUDiach+OoFAWutenX+z3laFimvNFGhpFV9DpARf7eP4MRxnjt2+7jSgzVixh7tl1
         5HqEmyl+ep31KQQKQqZ4IJ+spPEdl7H8oFd5fS4jX0CsObOuhe/ZrAtuwHiMV+20tNTu
         8dgQ==
X-Gm-Message-State: ALQs6tBwEe2ick+pgYPO1KSaugQe7ibPqp0n6ovQtWiRFoPmqf1GvCFB
        xVRdnK/2UrsUAD0aWUyqXS4MvmXc0SYRvb1w9JOA0g==
X-Google-Smtp-Source: AIpwx49ktdqs1M5GwzFm2G1RMsLN/kWTzjSeMbGS1zZ9thY+xfkeYJmVT62BJD7ELgoecoH1KsU1KVo52Pqv8A+Z3/I=
X-Received: by 10.13.226.142 with SMTP id l136mr3457367ywe.500.1523906559446;
 Mon, 16 Apr 2018 12:22:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 16 Apr 2018 12:22:38
 -0700 (PDT)
In-Reply-To: <20180416133312.241ada0390d6fec18856b027@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <CAGZ79kZbZ03D7ysaVXYkV3v0jO6K7kEOc9sT2zA+Xc6mqLNL9Q@mail.gmail.com>
 <20180416133312.241ada0390d6fec18856b027@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Apr 2018 12:22:38 -0700
Message-ID: <CAGZ79kZE-uKSMBhOF-Xu+HW5Vr5p+C1aHTmQN40OArpmM22-YA@mail.gmail.com>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

> I acknowledge that the two mechanisms are different, in particular
> because git *writes* the gitmodules file itself.
>
> I am not opposed to change the name, something like
> 'core.submodulesConfigFile' might highlight that the syntax of the file
> is the one of git config, but I think it's too long.

I was not speculating on a better name, but on the nature of the
configuration, gitignore is additive and errors are easy to see, but in
gitmodules, there is only one "correct" path+name, so the problem
space is not additive, rather we can have a discussion where we get
the correct config from with low odds of errors.

>> > The new configuration setting can be used to set an *alternative*
>> > location for the gitmodules file; IMHO there is no need to provide
>> > *additional* locations like in the case of exclude files.
>>
>> I think there *may* be a need for additional files.
>> Currently there is only the .gitmodules file and the configuration
>> in .git/config overriding settings from .gitmodules.
>>
>> There was some discussion on the mailing list in the past, which
>> presented a intermediate layer in between these two places, in
>> a special ref, such that:
>>     base is in .gitmodules
>>     overwritten via refs/meta/submodules:.gitmodules
>>     overwritten via the .git/config
>>
>> The intermediate would be a config file that is tracked on another
>> ref. This (a) decouples main project history from submodule history
>> and (b) makes it easier to distribute as it is part of the repository.
>>
>> For example (a) is desired if you dig up an old project and the
>> submodules have all moved from one git hosting provider to another.
>> Another example would be when you fork a project with submodules
>> and don't want to mess with the main history but you just want to
>> adjust the submodule URLs. That is possible with such an intermediate
>> additional place.
>>
>> For (b) you can imagine the fork that you want to distribute in your
>> community and you don't want to tell everyone to change the
>> submodule URLs, but instead you can provide them with a prepared
>> .gitmodules file, that they have to place into that special ref (which
>> can be done via fetching).
>>
>> I digress as these ideas seem to be orthogonal to your patch series,
>> just FYI. prior discussion starting at:
>> https://public-inbox.org/git/1462317985-640-1-git-send-email-sbeller@google.com/
>> I recall there was a better discussion even prior to that, but have no
>> link handy.
>>
>
> Just to understand, is that 'refs/meta/submodules:.gitmodules' file
> meant to be managed manually? Or do you imagine some options to
> instruct "git submodule" to *write* to that file instead of .gitmodules?

I imagined it to be managed manually as it would enable some
workflows for downstream users of superproject repos.

But I'd think a convenient way to write to this location would be
super useful, so we ought to have that eventually.

> In the latter case your idea could cover my use case too, couldn't it?

I would think so, yes.

> But most importantly, is this realistically going to be added?

I plan on adding it eventually. It depends on the priorities and
schedule, no promises, though.

> Currently I am not that familiar with the git code base to do it
> myself, and I've never explicitly dealt with special refs in git.

I think core git only uses them for "actual refs", e.g. remote
tracking branches are used to know about the sha1. This new
special ref would be used to store content outside the main tree,
so we'd have too lookup the blob in that not-checked-out commit
and read and write there.

> The approach of this patch series is a lot simpler, and something I can
> work on in my spare time.
> Presumably (b) could even be partially supported with my changes, by
> having both '.gitmodules' and some custom '.gitmodules-alternative'
> files in the repository and tell users to clone with:
>
>   git clone --config core.submodulesFile=.gitmodules-alternative URL
>
> Not as clean as your idea but doable.

Traditionally Git had a strong stance on not transporting config
in the repo (except submodule URLs :/) itself, so I guess
this .gitmodules-alternative would not be a file in the tree, but
a URL or something?

> [...]
>> > Since the gitmodules file is meant to be checked in into the repository,
>> > the overridden file path should be relative to the work-tree; is there
>> > a way to enforce this constraint at run time (i.e. validate the config
>> > value), or is it enough to have it documented?
>>
>> I think we'd want to check at run time, if we need this constraint.
>>
>
> I'll look into it once we decide which the way to go.
>
> Thank you.
>

Thanks for bringing up this easier approach.
Stefan
