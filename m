Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2300F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCMQA0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:00:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43285 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCMQA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:00:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so1987722ede.10
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NDRnNOKtz2efdBH7OvbIgYvPXG8L3Iwee2GHH4eAvP4=;
        b=Jj9hvZZsH8YpbMhrFXf6p0KZcr7ZaYtqeUl6AwZ/owHgz86VEvsiq1nmOur3jm/u90
         QE8QS0JtzbJQ/lVrpejQBZC1ngx8wRoF8i012Df+zVd7VRgjbbPIV2ZkVbJvqGYrWwWm
         wkKWfGwPXMHsbo03n4gNWhEAUKypJDan99PSva9L3uRMezpiksD7lb8tI0HWMzTElYnR
         dj61sN3uhWEDhCSraQg2jq4lVgENHnOfE0U9tA8GTk7nghEz6MqBhsHZgPBtV6A/4Gsp
         tI7ULlL0mSdop9GVXbQcP1ZELUoOM7pBPGTaopLZkZiHdh9ln9hJHDrk7TzM6Z2UWfzg
         PvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NDRnNOKtz2efdBH7OvbIgYvPXG8L3Iwee2GHH4eAvP4=;
        b=bnN/bO6iDb4jQ3kGGroir2XR9ZIzeDOI8SenqNSwmnvKPjPkIwOBB6+2VwOkjocNmE
         pBpl4hTGzW0uAWJX/LH5VxVUjiatXLAVUY82M8+R/lOgPWCkLzEUSE0EHg0EXArvcUFu
         RMO53rKgg9C42dS+5Hqw3yMRg8mOgNdVUsMEAq/xubRiv31lIe55lmwCPIeMPrbu3INz
         PrVBpn0TmXKeOoYHBifAKMMmLxhFjmSyxLaXET8COK62Rz+dpQxCwVIDn1zKW5gydXiY
         mYzqguoit3MjeWxWZAN95FQnnQtEL9IGuGYHxmfPzPwW23DDDuTLn9eZyOtstkbow8s5
         vLZQ==
X-Gm-Message-State: APjAAAX/Cw5Pjr1n4fuDEYJXtzLy5sA0hiG0bpmdnmAxFdRB42GEcqeH
        4BCY0uvUt6gBUgK/W9A9wKHhwIEj
X-Google-Smtp-Source: APXvYqwhhKQGxi+8dBE2bXkl9ao0sjaFODXT6zrw5t6wpigGg5uReT4RfdjV0e0oYbsglqpbe4fmzw==
X-Received: by 2002:a50:8d86:: with SMTP id r6mr8258788edh.103.1552492824454;
        Wed, 13 Mar 2019 09:00:24 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id m32sm749330edc.17.2019.03.13.09.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 09:00:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test on Fedora 29
References: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
        <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
        <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
        <20190311033755.GB7087@sigill.intra.peff.net>
        <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
        <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
        <20190311182328.GB16865@sigill.intra.peff.net>
        <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
        <20190312105159.GB2023@sigill.intra.peff.net>
        <7435b80b-6bd7-cab9-c646-5c81b639f117@virtuell-zuhause.de>
        <20190313153923.GC24101@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190313153923.GC24101@sigill.intra.peff.net>
Date:   Wed, 13 Mar 2019 17:00:20 +0100
Message-ID: <87lg1ibw8b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 13 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 12:47:51PM +0100, Thomas Braun wrote:
>
>> > Reading Thomas's email again, that might actually have been what he was
>> > recommending. If so, sorry for the confusion. And I agree that's a valid
>> > solution.
>>
>> Yes that is what I tried to explain. Looks like it was lost in translation.
>
> I think the problem was on the reading end. :)
>
>> > That said, I do wonder at some point if there's a huge value in using a
>> > submodule at that point. I think there is if the dependent project is
>> > large (and if it's optional, and some people might not need it). But in
>> > this case, it is not a big deal to just carry the sha1dc code in-tree.
>>
>> A big win with submodules is that you have separate histories and can,
>> quite easily, update to newer versions without manual copying.
>
> True. We'd generally be picking up snapshots in our in-tree sha1dc/, so
> bisecting on it is not as fine-grained. We _could_ pull in the full
> history using something like git-subtree, but that comes with its own
> complications.
>
>> One grievance with submodules is the URL switching if you need to go
>> with a forked repo for some time and then back to the original.
>> Is it possible to have multiple remotes for a submodule?
>>
>> Something like:
>>
>> [submodule "libfoo"]
>> 	path = include/foo
>> 	url1 = git://foo.com/upstream/lib.git
>> 	url2 = git://foo.com/myFork/lib.git
>>
>> With that the error prone git submodule sync step is not required anymore.
>
> I assume you'd fetch from _all_ of them during a fetch, and assume that
> one of them will get you the objects you need (or I guess if you are
> looking for a specific object, you'd try them one at a time until you
> get the object).
>
> That makes sense, though it might be kind of annoying when fetching is
> expensive (especially if it involves manually authenticating).
>
>> submodule.alternateLocation looks like it is going into the right direction.
>
> I think that's mostly about pointing back to the superproject for local
> storage. Though I think there's a pretty reasonable solution to the
> problem we're discussing there: git.git could carry a "sha1dc" branch
> that points to our modified submodule history. So it's "in-tree" in the
> sense that that it is in our repo, and under our full control, but still
> managed like a submodule.
>
> And we'd probably not even duplicate a lot of storage in the actual
> clone of the upstream project, because it would be pointing to us as an
> alternate.

Now if only we could think of some way to give the people best
positioned to fix some of these UI issues for git users everywhere the
incentive to do so[1] :)

1. https://public-inbox.org/git/20171208223001.556-5-avarab@gmail.com/
