Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973E71F404
	for <e@80x24.org>; Wed, 31 Jan 2018 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeAaMeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 07:34:01 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:40426 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeAaMeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 07:34:00 -0500
Received: by mail-lf0-f41.google.com with SMTP id h92so20439435lfi.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 04:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LMq84o+O9Rbcv55R3zR/a4TxrueESQd0/y2gjB3bc+4=;
        b=A3dvDRUyMQyeBroPePdMeoHMz3ycSpUSm9+5YHjWRaMmrLhDk2lrKLiuI228HUSQrb
         InBFQPHr8N9VO8IMISQ9mf0FM5wXrhAGgp/KugixNHg5OS/TFZTB7WQF21HlkJ+yufX0
         YgSZf56eQNwyaJOphOf4YA6kPy8AEq+l8wZDhDX0+1PUl0YbETAfBE5US7uoioqIvuV8
         eEuC+dhwzC6Q4Ii7Fz5GeFBO4/JQOmiyippHWNcEk3/v2JZUJhctz5Z/+hTEt+iWF7Cl
         ia7oU3CThc1+B8LoKWyQb6XjITdliZ3Rb6fzVHGhA60b5XscrpS9grLhFgXGIA8FEum5
         3PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LMq84o+O9Rbcv55R3zR/a4TxrueESQd0/y2gjB3bc+4=;
        b=o/6coHTM9PXY0XHj05DukiRL1N3FXupVZVRkU91oxVr00UYOrkpk10Hzof8Kylj25S
         R/Lx6Rb+AbonWICebahLGnOzmbKIZmCZzm9vQt4kz/O6verFXiZbnAWveI4pDO/VAkUe
         Pt3YVQ1dP/cxSCjSDNqg231blLt3rZ5AaR5Hspg5a1fCM9CJYOiipFNeAOnttOwIyFHN
         tuVlLRUutYKrOtE8dcrmJdhY3ZyCDMsZvMVPSTl02DCFhtPa2gcgNViXITK8Kn7AsC/V
         X0LvVB3CMUbpHFfzL5mtwvabD6iZxhdYZs1w9ppP2KIMq0IFFrmAuqOoaf+h19g8ovDY
         aemg==
X-Gm-Message-State: AKwxytc2d2LnKppqsCCJ2x1I4gIHmG28PDBHb04xktOkuHb0kf4RK8bo
        zAa+1o1jrgUdS+R4ph3qHyexs74MSyPUyc0MxjI=
X-Google-Smtp-Source: AH8x2278ZbTYH9TAWbANzM/l2vU9jMzhvUxto1c8fL0o9wJmw7y6OMd/kkuw9mEasBT+VfaH5B9zTlCxNfgUaCGWWQQ=
X-Received: by 10.46.62.24 with SMTP id l24mr8167851lja.25.1517402038227; Wed,
 31 Jan 2018 04:33:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.44.11 with HTTP; Wed, 31 Jan 2018 04:33:57 -0800 (PST)
In-Reply-To: <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
 <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
 <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
 <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com> <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Wed, 31 Jan 2018 07:33:57 -0500
Message-ID: <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Avery Pennarun <apenwarr@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 6:37 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>> There has not been feedback for a while on this thread.
>>> I think that is because subtrees are not in anyone's hot
>>> interest area currently.
>>>
>>> This is definitely the right place to submit&discuss bugs.
>>> Looking through "git log --format="%ae %s" -S subtree",
>>> it seems as if Avery (apenwarr@gmail.com) was mostly
>>> interested in developing subtrees, though I think he has
>>> moved on. Originally it was invented by Junio, who is
>>> the active maintainer of the project in 68faf68938
>>> (A new merge stragety 'subtree'., 2007-02-15)
>>
>> Thanks for trying to help, but I have *NOTHING* to do with the "git
>> subtree" subcommand (and I personally have no interest in it).  What
>> I did was a subtree merge strategy (i.e. "git merge -s subtree"),
>> which is totally a different thing.
>>
>> David Greene offered to take it over in 2015, and then we saw some
>> activity by David Aguilar in 2016, but otherwise the subcommand from
>> contrib/ has pretty much been dormant these days.
>
> Strictly speaking, the 'git subtree' command does in fact use 'git
> merge -s subtree' under the covers, so Junio is at least partly
> responsible for giving me the idea :)
>
> I actually have never looked into how signed commits work and although
> I still use git-subtree occasionally (it hasn't needed any
> maintenance, for my simple use cases), I have never used it with
> signed commits.
>
> git-subtree maintains a cache that maps commit ids in the "original
> project" with their equivalents in the "merged project."  If there's
> something magic about how commit ids work with signed commits, I could
> imagine that causing the "no a valid object name" problems.  Or,
> git-subtree in --squash mode actually generates new commit objects
> using some magic of its own.  If it were to accidentally copy a
> signature into a commit that no longer matches the original, I imagine
> that new object might get rejected.
>
> Unfortunately I don't have time to look into it.  The git-subtree code
> is pretty straightforward, though, so if Stephen has an hour or two to
> look deeper it's probably possible to fix it up.  The tool is not
> actually as magical and difficult as it might seem at first glance :)
>
> Sorry I can't help more.
>
> Good luck,
>
> Avery

Thanks all for the discussion/replies.

We use subtrees extensively in our environment right now. The "sub"
repos (90+) are located on GitHub, while the "main/parent" repo is
provided by a vendor on website hosting infrastructure.

I will take a look at:
git/Documentation/CodingGuidelines
git/Documentation/SubmittingPatches
git/contrib/subtree/

Should I follow up in this thread with a patch (it might be a while)?

Thanks!
Steve
