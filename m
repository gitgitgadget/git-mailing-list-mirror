Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948CC1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 10:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfJDKs2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 06:48:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33169 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 06:48:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so6042455ljd.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lQyWi73YC3mCuJXeP8F0iB4gmUJQL+CK/2C7zaABJuo=;
        b=i+C6cxbFBEWsGICJtPt9wnTTe/RHlRWM+VR4YcNJDzh2zdxBEgKYOGvPA6yRcBs1ft
         4QcYv+ExfRpwYIXIjXLIau5O5wWyOMeQ5/wA3Et9fb5NHZHjFTNLcZpOgT80I2WbPhtT
         0TaVtINXv6bEgSId5KhVb0+RzzVlL2naDb70tXxJZAAYhEcm68BmyrQDBrV8/mzD5THH
         IuqaRH6NySut1c1b+2KF8viOOWwHWrh1jN41juCao0DynKiyszzLf+1jEPmXl4Z8DJzz
         IvQVVj3SjM3NIj/EQnbCCSehNiJEWQs1EE+ktgMCdBUiCUgYsWyAbIfeNnilFhxRPENd
         ZtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lQyWi73YC3mCuJXeP8F0iB4gmUJQL+CK/2C7zaABJuo=;
        b=IsRboGokCs25E/9UxNuleK94BooCAB0l4xhMJ9w76GiznZzZYZGaSTTsBnAFF+lMpX
         bbjcXvne1IfhhkwPnXJ1z8xE1PakVN/r+umMKrmYfSa2JrSV7/DWb9M2gHwkjmiX2t3V
         /UKnt9EWYZUUy2WMkNUh+kxz31Q2SfLzdhZYBakBb9GZxY4cdd/tZc6ztKRye7TXCHxV
         Sa5WXzWUC6itweEjxmanLKZaIOqg229+gFQkyecTp0xtIetnANtc+hrlBrO6U6jY/iGY
         w7iyJU4yQY9e+5Lw2GgN6qJuPZ3/duJRHGjnS1RzHYuou+ZoHuU6lQ3i7Y3R4ObOllbJ
         S9lg==
X-Gm-Message-State: APjAAAXcQvC/925qHQO8RCUaom+YdnLm4YKmBWtZDKRLgNg89LHOo8C9
        JD/sZHHkGzHQ5bmC4VqD3o0=
X-Google-Smtp-Source: APXvYqwzZBXIH0hZZMzBr2BaxXVH8fns5thJQWxEOUfM6zu+9l6hIDV4sthpa3XF4iwyij9sd2+T6w==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr9079183ljj.138.1570186103882;
        Fri, 04 Oct 2019 03:48:23 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i142sm1080609lfi.5.2019.10.04.03.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 03:48:22 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster\@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
Date:   Fri, 04 Oct 2019 12:48:18 +0200
In-Reply-To: <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 19 Sep 2019 15:21:08 -0700")
Message-ID: <86zhigokgd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Sep 19, 2019 at 11:37 AM Derrick Stolee <stolee@gmail.com> wrote:
[...]
>> II. Approach
>>
>> The action items below match the problems listed above.
>>
>> 1. Improve the documentation for contributing to Git.
>>
>> In preparation for this email, I talked to someone familiar with issues
>> around new contributors, and they sat down to try and figure out how to
>> contribute to Git. The first place they went was https://github.com/git/=
git
>> and looked at the README. It takes deep reading of a paragraph to see a
>> link to the SubmittingPatches docs.
>>
>> To improve this experience, we could rewrite the README to have clearer
>> section markers, including one "Contributing to Git" section relatively
>> high in the doc. We may want to update the README for multiple reasons.
>> It should link to the new "My First Contribution" document
>> (https://git-scm.com/docs/MyFirstContribution).
[...]
>> 3. Introduce a new "mentors" mailing list
>>
>> From personal experience, all new contributors at Microsoft (after Jeff
>> Hostetler at least) have first had their patches reviewed privately by
>> the team before sending them upstream. Each time, the new contributor
>> gained confidence about the code and had help interpreting feedback from
>> the list.
>>
>> We want to make this kind of experience part of the open Git community.
>>
>> The idea discussed in the virtual summit was to create a new mailing
>> list (probably a Google group) of Git community members. The point of
>> the list is for a new contributor to safely say "I'm looking for a
>> mentor!" and the list can help pair them with a mentor. This must
>> include (a) who is available now? and (b) what area of the code are they
>> hoping to change?
[...]
> Sounds useful for new contributors, _if_ there are enough volunteers
> with enough time.  I'm a little worried it might be initially staffed
> well and make a nice splash, but wane with time and possibly even to
> the point that it makes new contributors more jaded than if we didn't
> have such a list.  Hopefully my fears are unfounded, as it did sound
> at the conference like there might be a good number of volunteers, but
> I just wanted to voice the concern.  (And I feel bad, but I really
> don't know that I have the bandwidth to volunteer.)
>
> Another point that might help here:  New contributors might be
> surprised by the rigor of the code review process, and might assume
> they just aren't good enough to contribute.  It might be useful to
> countermand that subtle unspoken assumption by pointing out how much
> existing long-term contributors spend revising patches.  Personally,
> despite doing my best to think of issues and make sure to send in
> really high quality patches, I still generally expect to spend at
> least as much time after submitting patches revising them as I did in
> coming up with them originally, and I'm not surprised if the time is
> doubled.  And that's after contributing for years.  I don't generally
> experience reviews anywhere near as thorough in other communities.

Doing code reviews is another area that new people might not know that
it is something they can do, and that it is something that helps the
project.  You don't need to be subsystem "owner" to perform code review,
you just need to know the topic; though knowing CodingConventions before
commenting about style is a must.  IMHO this can help a lot, especially
for patch series where Junio waits for any review.

You don't even need to be subscribed to git@vger.kernel.org mailing
list; thanks to public-inbox.org (and GMane before that) you can use
Usenet news reader like for example Gnus (in GNU Emacs) to read and
respond via nntp://news.public-inbox.org/inbox.comp.version-control.git

I don't think that this way of contributing (by doing code review) is
specified anywhere in Git documentation or anywhere on Git-related web
pages.

Best,
--=20
Jakub Nar=C4=99bski
