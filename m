Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE19D208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 07:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeHFJp5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 05:45:57 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40270 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeHFJp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 05:45:56 -0400
Received: by mail-lj1-f174.google.com with SMTP id j19-v6so9763919ljc.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HYLkgmA0cl4jgMG+kvpovf4Cjmh1BdPbjLeuwsS/rsc=;
        b=JMNovlUA2K+fH3lWqMxmWY04qDQXPoHN9eXFEDkPUBKO7zGsvd/P+7QGmVAWNrZMuQ
         JPphOSz9+/r0mMr/sWBaAa5nJBotReFvEhxGDryHZb1abtZA9cFmyUXjrlwJRuJfwTqU
         R+XrRIa+6P9rgNkSVD3B04Gt7W0/HhZKsUT8oUFIxP2hVRlKgG/KWj9J4wjS5SgPuW1J
         CdhNw+yL2sM42Y/6xhnUVi+hrZV6Kyhdi4rRg3h/KbSkyROrlsuzeYlHNQQQRwLybD5O
         aUA5gYU+S4O3f/7fbHcH+nqXWwR+X+L7KJ2jJjaFvMvWEKTyCfii/DwTYzdIOuewf+QV
         Ofvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HYLkgmA0cl4jgMG+kvpovf4Cjmh1BdPbjLeuwsS/rsc=;
        b=j/+HYUnvHvxXvnbpQ5tx3JmvM0RIgprNjmxcXK/PjeCFmvX8AmB1ZOBuavtSzzQ5od
         PRIYvpHMoB5U8lEA4o3V8t48QuZOMA43chr+4EMwye5IDyM9K1CCl7ZTUpC6LDG5yLV4
         C9mzrJMqF6PAEk9LxeRKOSYV3eGlD8stdOWyrBAZ6QsA28p3LVncBTz9LFUeMcHK35ZL
         qjX0x6BLmLdskI+ogNsgq0syu0JizJbd8uIvQMbYo7HUxZJO2XYaALwacwkiSg4xZhWg
         GRv+duwsuZa2ISMD6E+EcyyMK30lm4sNsZiHMgkb35+1FeYt5QxhddsCJ186opDDTsKd
         d4Rw==
X-Gm-Message-State: AOUpUlHt05yPVdNV3m2fU3uqsTnaJuRHZ/HrYJEj4TK9xdnt2wEjmXVl
        5EGFncrOZlx3Ni104l8hsKLY83tor4usjKwAWZk=
X-Google-Smtp-Source: AAOMgpcgg1/pmdfo/mKzqUMEvmhc+F2Z731UQfu9UYFayop0nFYxlEzilcINcsxKZyWAy3a2iQa2/5eyi9pCy9spsys=
X-Received: by 2002:a2e:2bd7:: with SMTP id r84-v6mr12340041ljr.40.1533541089179;
 Mon, 06 Aug 2018 00:38:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 00:38:08 -0700 (PDT)
In-Reply-To: <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com> <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com> <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com> <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Mon, 6 Aug 2018 00:38:08 -0700
Message-ID: <CA+KyZp7jpXmi0XKpWrqi5uh=LkUMNneu9=0fejo3Qh1LwJGP3w@mail.gmail.com>
Subject: Re: concurrent access to multiple local git repos is error prone
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To add something to the previous message, I have strong evidence that
the problem occurs when *different* repos are accessed concurrency,
not the same repo, as bizarre as that may be.

-alex

On Mon, Aug 6, 2018 at 12:36 AM, Alexander Mills
<alexander.d.mills@gmail.com> wrote:
> Hi Johnathan,
>
> Yeah this concurrency problem is real. Not only does it happen with
> `git status` the same thing happens with `git rev-parse
> --show-toplevel`.
> What happens is that I get no stdout when repos are accessed
> concurrently (and no stderr). If I limit concurrency to 1, the problem
> goes away. When I up the concurrency, the problem is sporadic, which
> is the exact signal for a concurrency/race-condition related issue.
> The signs are damn clear. I have seen this problem on MacOS I think a
> year back on a different project, but I never reported it b/c I hadn't
> really verified it.
>
> Like I said I am on Ubuntu. I have 3 git repos that are incorporated
> into the tool that's generating the problem. For one repo I got this:
>
> $ git fsck
>
> Checking object directories: 100% (256/256), done.
> dangling tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
> For `$ git version --build-options` I have:
>
> git version 2.17.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
>
>
> -alex
>
>
>
> On Sun, Aug 5, 2018 at 1:11 AM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> Alexander Mills wrote:
>>
>>> Yeah in this case what appeared to be happening is that if `git status`=
 was
>>> called concurrently, frequently I wouldnt get any stdout..
>>
>> Thanks for reporting.  A few questions:
>>
>> What platform are you on?  What version of Git are you running?  What
>> is the output of "git version --build-options"?
>>
>> What is the exit status from these "git status" invocations that
>> didn't write output?  What options are you passing to "git status"?
>> Are there any other interesting symptoms?
>>
>> Is this part of a larger tool or script?  Are there other operations
>> going on (e.g. something sending signals to these git processes)?
>>
>> Does the repository pass "git fsck"?  Any other symptoms or hints that
>> could help in tracking this down?
>>
>> Can you paste a transcript of the commands or script you ran and what
>> output it produced?  Is this something I should be able to reproduce?
>>
>> Thanks and hope that helps,
>> Jonathan
>
>
>
> --
> Alexander D. Mills
> =C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
> alexander.d.mills@gmail.com
>
> www.linkedin.com/pub/alexander-mills/b/7a5/418/



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
