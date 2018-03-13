Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6D51FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 11:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeCMLfL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Mar 2018 07:35:11 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35555 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbeCMLfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 07:35:10 -0400
Received: by mail-qk0-f177.google.com with SMTP id s188so14917510qkb.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 04:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jx34ZkZoaJ0Zvtwu80MUligjpwXVdswU2BJG0MSr7Ww=;
        b=loSfQx5LHn/YxtUGj16iOoh81s+1ddymOhpivseQG1ob5lD034EPLVBmfqutdf6dAc
         zzhft6ekjQjaZcuRBSROp4e1dcLXUaf5+BRrcQedRHZaU1yhs559GIhKul1AF2RJzNen
         t8cMGJzOih9G5FXFbZWHvAJh0Xs6zUfydX1ilTkY+ogUEaKamp7Ltr/NXsyjK7/2VXS/
         Nre/IHSnoZiHTugF7E9TsKGzMwW/PLt1wixI9YMAv5cb85lwqQ+o9nIrdcVQK9qhs2IJ
         Ii4mJ/N25bW5QVI5xGO4OtEzASWrXGx8drbh/9xskJpC1sqt0k5ri8+Vy4iu3re6UiSi
         69eA==
X-Gm-Message-State: AElRT7H0X/Ons1e/pyNGY06eYBpWB2ePOqSYQPuOIV4omeFXzMD0Xuh9
        54FiWVK2bo/xDt48eyarcSekEtEjzC4kcCtlBcabtg==
X-Google-Smtp-Source: AG47ELvX077+NCznkBWrndx0GHkw7zjFjh06qlGtgySbmQUyOjZo1oO3mKYR7PExvBV11syAxueHbckESvWl+fC2s3A=
X-Received: by 10.55.20.149 with SMTP id 21mr433907qku.66.1520940909356; Tue,
 13 Mar 2018 04:35:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.42.235 with HTTP; Tue, 13 Mar 2018 04:35:08 -0700 (PDT)
In-Reply-To: <87zi3cp9rp.fsf@evledraar.gmail.com>
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
 <873714qr7i.fsf@evledraar.gmail.com> <CANT8FXTT=5sGp9Wn4h5t=k4TiiADQrf--hDv5EmCx=KoGHgwXg@mail.gmail.com>
 <87zi3cp9rp.fsf@evledraar.gmail.com>
From:   Michal Novotny <clime@redhat.com>
Date:   Tue, 13 Mar 2018 12:35:08 +0100
Message-ID: <CANT8FXSN7-fD7YCqr=asraG-ttupiJfrzhCNaW86-RQ4m05Rbw@mail.gmail.com>
Subject: Re: allow "~" to be present in a tag name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 11:09 AM, Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Mar 13 2018, Michal Novotny jotted:
>
>> On Tue, Mar 13, 2018 at 10:07 AM, Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Tue, Mar 13 2018, Michal Novotny jotted:
>>>
>>>> Hello,
>>>>
>>>> currently, if I try to create a tag that has tilde "~"  in name, an
>>>> error is raised. E.g.
>>>>
>>>> $ git tag rpkg-util-1.4~rc1
>>>> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.
>>>>
>>>> Now, actually it would be very cool if tilde was allowed in a tag name
>>>> because we would like to use it for tagging pre-releases of (not-only
>>>> rpm) packages.
>>>>
>>>> Is there some deep technical reason why tilde cannot be present in a
>>>> tag name? I tried that e.g.
>>>
>>> Yes, because a trailing tilde is part of git's rev syntax, see "man
>>> git-rev-parse", or try in any repo:
>>>
>>>     git show HEAD
>>>     git show HEAD~2
>>>     git show HEAD^~2
>>
>> Right, reading the man pages:
>>
>> <rev>~<n>, e.g. master~3
>>            A suffix ~<n> to a revision parameter means the commit
>> object that is the <n>th generation ancestor of the named commit
>> object, following only the first
>>            parents. I.e.  <rev>~3 is equivalent to <rev>^^^ which is
>> equivalent to <rev>^1^1^1. See below for an illustration of the usage
>> of this form.
>>
>> Would it be acceptable to disallow only ~<n> (<n> as [0-9]+) in a tag
>> name but allow ~[^0-9].*, i.e. if the immediately following symbol
>> after '~' is a letter, do not
>> interpret ~ as a special character. Could it work?
>
> We could make that work, with some caveats:
>
>  1) The syntax we've reserved for refnames is quite small, and my bias
>     at least would be to say you should just make a tag like
>     rpkg-util-1.4-rc1 instead (as e.g. git.git and linux.git do).

There is kind of clash of symbolics with rpm world. In rpm world, the component
after the last dash in a package full (versioned) name is usually
reserved for a downstream
packager who increments it as he/she adds patches to the original
sources. I will
need to do slightly more research here of what is possible.

Thank you so far!

>
>     Carving out an exception like this also means we couldn't use
>     ~[^0-9].* for anything magical in the future.
>
>     But I think that's a rather small objection, we have other syntax
>     escape hatches, and we're unlikely to use ~[^0-9].* as some new
>     magic.
>
>  2) If we patch git to accept this, you'll be creating refs that aren't
>     inter-operable with previous versions of git.
>
>     This is a big deal. E.g. you'll happily create this special ref,
>     then try to push it to github, and they'll croak because that's an
>     invalid ref to them. Ditto some co-worker of yours who's using an
>     older version of git.
>
>     FWIW if you manually create such a tag e.g. for-each-ref will emit
>     'warning: ignoring ref with broken name' and just not show it.
>
>>>
>>> etc.
>>>
>>> Although I guess git could learn to disambiguate that form from the tag
>>> you're trying to create.
>>>
>>>> git tag rpkg-util-1.4%rc1
>>>>
>>>> but percentage sign does not seem to be particular fitting for
>>>> pre-release marking.
>>>>
>>>> Thank you
>>>> clime
