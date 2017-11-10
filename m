Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF831F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbdKJUBm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 15:01:42 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:54755 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKJUBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 15:01:41 -0500
Received: by mail-qk0-f182.google.com with SMTP id l69so6712784qkl.11
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 12:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cQQmg7cAoZuFuCTCF7pF0/jLAWQf5BrCpB3+ryQlWM0=;
        b=Y3I6KOeW6OYrixLpEIrzZly0NOg4bBEFn2jD2mcyflYMPN/gaFsBj5wrPsx4Lwxoxq
         hyYWbkC/gguNxDB0cLuZjPrY9UDxze/ZOqcljMLWIsCBSPlPSGjVuy5HuOCCIAEL2HyI
         0nn9pZuvK8r4JbQT6eLBz/nkH0XUAkCGea0yfI8rEvgvahIqkoMguVRUI1jL41FyJa0Q
         bTBWULdn8T09HUtfhQF6IPUWoqTzhdEU5HpAHnXYAdy67LFQaZdp0Q2/VG1vaUoZlPxh
         CFSWoA57bIweuXaPUTKlQqVFmlerRFRQJGyse+ICxhIKEf4o1RIQ7y+yuHC/A+qP32Op
         OCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQQmg7cAoZuFuCTCF7pF0/jLAWQf5BrCpB3+ryQlWM0=;
        b=ixgzrGMqv+k7nIMO/USG1I4K9jNAABd2ArJ3sKD7i89efMVyhhXtQ/MIT/MVkg/Ot+
         l0t7S/AjInhvxv8qWq8MnifgHTgz8f0/y+30A74uz+DUd9JyqxJ81IOyWqOe3g3a8W6b
         Ce9iLTUw5bo+YfMCVuxTk20g+MKTdmRnoaLpDbRVDvVnq8ioDgEj2MibHVniOC7wFzKN
         skniyn8uWtaTZX4nMle4tBK22lhiHWVKAGaw2A9vQMpvxz5AfJex7DyF+rOh19hytu0I
         UY/b1BICp7PBrCy0IBRW0FQmbU9lfcNgq0h2rzaydvwTtJQBk7JZCOZP1EVrkiONfNGm
         0oHQ==
X-Gm-Message-State: AJaThX4uFAk4EfDju4+lNOmVyOKrvG4Sgyu6x68gBm6h9WetayaRziKP
        2y32LUAndS8j1e6qV3336dppbWfmtXM3nbBKaTK7RA==
X-Google-Smtp-Source: AGs4zMY7oJf9npRxocSPB+B5Z//moGQEfmtu1kqYPgBm7H1HABCq6rJhADc7jMUxzNweXG1/pmHTGzorgQhX2eV9sL4=
X-Received: by 10.55.33.13 with SMTP id h13mr2486945qkh.176.1510344100347;
 Fri, 10 Nov 2017 12:01:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 10 Nov 2017 12:01:39 -0800 (PST)
In-Reply-To: <CA+P7+xoA5KNW7PEiW0wZp-aohsKbnH8AGAvkk3Y3Ghv=Jhp+hw@mail.gmail.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
 <20171109001007.11894-1-sbeller@google.com> <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
 <CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com> <CA+P7+xoA5KNW7PEiW0wZp-aohsKbnH8AGAvkk3Y3Ghv=Jhp+hw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Nov 2017 12:01:39 -0800
Message-ID: <CAGZ79kbBypJfDn28j2Z_SCFG9iCZnx-sWmH6D2vqnS+tNKpnBw@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
>>> Basically, a workflow where it's easier to have each submodule checked
>>> out at master, and we can still keep track of historical relationship
>>> of what commit was the submodule at some time ago, but without causing
>>> some of these headaches.
>>
>> So essentially a repo or otherwise parallel workflow just with the versioning
>> happening magically behind your back?
>
> Ideally, my developers would like to just have each submodule checked
> out at master.
>
> Ideally, I'd like to be able to checkout an old version of the parent
> project and have it recorded what version of the shared submodule was
> at at the time.

This sounds as if a "passive superproject" would work best for you, i.e.
each commit in a submodule is bubbled up into the superproject,
making a commit potentially even behind the scenes, such that the
user interaction with the superproject would be none.

However this approach also sounds careless, as there is no precondition
that e.g. the superproject builds with all the submodules as is; it is a mere
tracking of "at this time we have the submodules arranged as such",
whereas for the versioning aspect, you would want to have commit messages
in the superproject saying *why* you bumped up a specific submodule.
The user may not like to give such an explanation as they already wrote
a commit message for the individual project.

Also this approach sounds like a local approach, as it is not clear to me,
why you'd want to share the superproject history.

> Ideally, my developers don't want to have to worry about knowing that
> they shouldn't "git add -a" or "git commit -a" when they have a
> submodule checked out at a different location from the parent projects
> gitlink.
>
> Thanks,
> Jake
>
