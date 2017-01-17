Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E446620756
	for <e@80x24.org>; Tue, 17 Jan 2017 18:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdAQSuA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 13:50:00 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:35643 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdAQSt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 13:49:57 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so101563962ith.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ew8NF6Bl0qbqBd2617szfzUIVdV2QTSp9/jfioY3aFg=;
        b=W9R0RdmTMEX6ChCS2EwD3dTL73/0nGSYBiSU4ApVXEwcxJfgkeOkEMyHOSiVv2472r
         mkcscUZwk679rFAq6w+0SBfYr6C8bNyUOMtAgO/sjzCCIHALu8RtMvHH9lKzqWOQn1Pn
         +GLQhE0s8iRYbWSQ22PwSATk4rz92XMgoPU31iQJdK9EKMuqskFNW4haySGFfuUDSycm
         TUFaqqDsK5nDsTumiOaZvuUpY6AvNjWnBuAr0aMrQFdGnDge+a64Z9+xLP7uZdFy8Wg0
         yIbXBoqS8oDpKqzFnAAQ312rsPnNU1BJBmMrmARCRUeVXy+Vd0pUSh/d0z5D92SokZEN
         ZoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ew8NF6Bl0qbqBd2617szfzUIVdV2QTSp9/jfioY3aFg=;
        b=aAVZbHWdvSyRs8GB1qoPUiIOAIRg8zIXmNjP3iK/At2HVi55rDmJa08DMhcqlKwSK2
         lLJzJylXl5otz0oMQVV46ygKXitsIM2o6gNNVjs2ycoRGU2lWmVpMBK689dYe9NUn9XH
         jMljYKW307YefeN36UeWaHBLaGtJBqTgvTqZenevkvnNZRews+luAB5ARog/j3ZUhyt6
         3uRRaNY6ds4iTxy0DDcyiWtXMSCiTivK8wkDP3Gx9fPNYPvtQ2ZWhtLCURwLgwUcJ1k3
         kWHRWNW6goF2BJVA1Sg1Lw8e4g022GRkQ9rGUjf3vHPYTMpAVAICslMoSUmoyUF61QyJ
         rf1Q==
X-Gm-Message-State: AIkVDXIANVTi0liJzwWu4sUzYTzBRa76Gk434HnGemojHGkCT5yReqqHvxZ8VtIAbbTh8F77DHjxdVIBOktpJ6S6
X-Received: by 10.36.141.2 with SMTP id w2mr21606709itd.114.1484678597689;
 Tue, 17 Jan 2017 10:43:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 17 Jan 2017 10:43:17 -0800 (PST)
In-Reply-To: <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jan 2017 10:43:17 -0800
Message-ID: <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     "Brian J. Davis" <bitminer@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 1:02 PM, Brian J. Davis <bitminer@gmail.com> wrote:

>>
>> Technically it is submodule.<name>.url instead of
>> submodule.<path>.url. The name is usually the path initially, and once
>> you move the submodule, only the path changes, the name is supposed to
>> be constant and stay the same.
>
> I am not certain what is meant by this.  All I know is I can use my
> "directory_to_checkout" above to place in tree relative from root the
> project any where in the tree not already tracked by git.  You state name
> instead of path, but it allows path correct? Either that or I have gone off
> reservation with my use of git for years now. Maybe this is a deviation from
> how it is documented/should work and how it actually works?  It works great
> how I use it.

Yes name can equal the path (and usually does). This is a minor detail
that is only relevant for renaming submodules, so ... maybe let's not
focus on it too much. :)

>>>
>>>
>>> but if say I want to pull from some server 2 and do a
>>>
>>> git submodule update --init --recursive
>>
>> That is why the "git submodule init" exists at all.
>>
>>      git submodule init
>>      $EDIT .git/config # change submodule.<name>.url to server2
>>      git submodule update # that uses the adapted url and
>>      # creates the submodule repository.
>>
>>      # From now on the submodule is on its own.
>>      cd <submodule> && git config --list
>>      # prints an "origin" remote and a lot more
>>
>> For a better explanation, I started a documentation series, see
>>
>> https://github.com/gitster/git/commit/e2b51b9df618ceeff7c4ec044e20f5ce9a87241e
>>
>> (It is not finished, but that is supposed to explain this exact pain
>> point in the
>> STATES section, feel free to point out missing things or what is hard
>> to understand)
>
> I am not sure I got much out of the STATES section regarding my problem.

Your original problem as far as I understand is this:

  You have a project with submodules.
  The submodules are described in the .gitmodules file.
  But the URL is pointing to an undesired location.
  You want to rewrite the URLs before actually cloning the submodules.

And to solve this problem we need to perform multiple steps:

  # --no is the default, just for clarity here:
  git clone <project> --no-recurse-submodules
  # The submodules are now in the *uninitialized* state

  git submodule init
  # the submodules are in the initialized state

  git submodule update
  # submodules are populated, i.e. cloned from
  # the configured URLs and put into the working tree at
  # the appropriate path.

Between the init and the update step you can modify the URLs.
These commands are just a repetition from the first email, but the
git commands can be viewed as moving from one state to another
for submodules; submodules itself can be seen as a state machine
according to that proposed documentation. Maybe such a state machine
makes it easier to understand for some people.

>>> what I would get is from someserver1 not someserver2 as there is no
>>> "origin"
>>> support for submodules.  Is this correct?  If so can origin support be
>>> added
>>> to submodules?
>>
>> Can you explain more in detail what you mean by origin support?
>
> Yes so when we do a:
>
> git push origin master
>
> origin is of course the Remote (Remotes
> https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
>
> So I best use terminology "Remotes" support.  Git push supports remotes, but
> git submodules does not.  The basic idea is this:
>
> If Git allowed multiple submodule
> (https://git-scm.com/book/en/v2/Git-Tools-Submodules) Remotes to be
> specified say as an example:
>
> git submodule add [remote] [url]
>
> git submodule add origin https://github.com/chaconinc/DbConnector
> git submodule add indhouse https://indhouse .corp/chaconinc/DbConnector
>
> Where:
>
> [submodule "DbConnector"]
>     path = DbConnector
>     url = https://github.com/chaconinc/DbConnector
>
> Could then change to:
>
> [submodule "DbConnector"]
>     path = DbConnector
>     remote.origin.url = https://github.com/chaconinc/DbConnector
>     remote.origin.url = https://indhouse .corp/chaconinc/DbConnector

here I assume there is a typo and the second remote.origin.url should be
remote.inhouse.url ?

>
>
> Then it should be possible to get:
>
> git submodules update --init --recursive

which would setup the submodule with both

[remote "origin"]
  url = https://github.com/..
[remote "inhouse"]
  url = https://inhouse.corp/..

But where do we clone it from?
(Or do we just do a "git init" on that submodule and fetch
from both remotes? in which order?)

>
> To support
>
> git submodules update [remote] --init --recursive

This would just clone/fetch from the specified remote?
If implementing this, we may run into a collision with the
specified submodules, what if a submodule is at
path "origin" ?

Does "git submodule update origin --init --recursive"
then mean to update the single "origin" submodule or
all submodules from their origin remote?

>
> And thus allow
>
> git submodules update origin --init --recursive
>
> git submodules update indhouse --init --recursive

understood. I like the idea of being able to specify
multiple remotes from the superproject..
