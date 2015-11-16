From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Mon, 16 Nov 2015 14:56:21 -0800
Message-ID: <CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
	<CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
	<564A279C.6000802@web.de>
	<CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
	<564A4DB1.4070507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 23:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyShI-0001P5-0P
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 23:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbKPW4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 17:56:24 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35312 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbbKPW4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 17:56:22 -0500
Received: by ykba77 with SMTP id a77so265631461ykb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QPN/sq48CPPm/b6BfdJsnPpveoTPs4eh7fSq93IQVbc=;
        b=Qy2YTsLqOqCfVjfhUWcw0Q47Aymq9NDc4ubl5Ah1+qBmJcBTuOeRVJrSrFb0u7ehhu
         iEgEpDyIiYDLz1PfhT9Tx7EjUHAYbaOk0JukbqubvTa4+YVUABCOOfWorMqrpvTyJuF7
         tM7q3OovXOoskS2fP2p6po+vphhEb6HNCM3PjGuugD7QEAdJYqFr63UMcCyviptVIdHH
         hmQMv1Qs8bMjZ4PKme9IEUzhHiaKJMwMCmTODxYhG6KMNWAo3U27gUmdrsJCC5PxG3dP
         h3zZrFu3ZraK1IvJeOtGcqiHlVMu4W0SpVYWYIdGKfbatEewO/LqjMMfbSmjwidTwcp7
         kQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QPN/sq48CPPm/b6BfdJsnPpveoTPs4eh7fSq93IQVbc=;
        b=ad0DYO7cUCLNBziD9pDRh09IdNUePf4sbKTXIiv8OEJPHlZMCGh3fOby7vax3Mtl/U
         7Zxr1SoCWVZvSc6GHC7l3z9pjxrFYVDgzmHgU2fO/4PIEnDf9xxJY/oOwJt3+k3bCSjC
         mQ/jXO98B1EJlGcmj24fAdkNc80eUkLR0lyE4FjWaycENvi/9SfzQle8cebsGo3AWUo9
         SAfIzTAKD2bw9b1AY7WgMg3X7pzeClZENukK2Hi7/SVRfEi9PnXKpu62YO4FsAIsvew9
         2YevVvZDewEn4qWl9H3mGa9L4M8RPa1luf6aJN2UiXOA0zi4yNb6e+AkfghvdxHMzv28
         blPg==
X-Gm-Message-State: ALoCoQmjeG+PUOlMVeriCA/iBd/pH4ylDe8yLBZOLirrKGFAdxQGSpe3Pd24vs3ZMvJ84RIBbMBj
X-Received: by 10.129.75.131 with SMTP id y125mr42317377ywa.48.1447714581914;
 Mon, 16 Nov 2015 14:56:21 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 16 Nov 2015 14:56:21 -0800 (PST)
In-Reply-To: <564A4DB1.4070507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281362>

On Mon, Nov 16, 2015 at 1:42 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 16.11.2015 um 20:25 schrieb Stefan Beller:
>>
>> On Mon, Nov 16, 2015 at 10:59 AM, Jens Lehmann <Jens.Lehmann@web.de>
>> wrote:
>>>
>>> Am 14.11.2015 um 01:10 schrieb Stefan Beller:
>>>>
>>>> Thanks for pointing out that we already have some kind of server
>>>> support.
>>>>
>>>> I wonder if we should add an additional way to make fetching only some
>>>> sha1s possible. ("I don't want users to fetch any sha1, but only those
>>>> where superprojects point{ed} to", even if you force push a
>>>> superproject,
>>>> you want to want to only allow fetching all sha1s which exist in the
>>>> current
>>>> superprojects branch.)
>>>
>>>
>>>
>>> Me thinks the restrictions for sha1-fetching could come from the branches
>>> these sha1s are found in the upstream submodule: if the client is allowed
>>> to fetch a branch, it should be able to fetch any sha1 on that branch.
>>
>>
>> I'd agree on that. The server side even with uploadpack.allowTipSHA1InWant
>> set, is not sufficient though.
>>
>> To fetch an arbitrary sha1, you would need to check if that sha1 is part
>> of the history of any advertised branch and then allow fetching
>> serverside,
>> which sounds like some work for the server, which we may want to avoid
>> by having smarter data structures there.
>>
>> Instead of having to search all branches for the requested sha1, we could
>> have
>> some sort of data structure to make it not an O(n) operation (n being
>> all objects
>> in the repo).
>>
>> Maybe I overestimate the work which needs to be done, because the server
>> has
>> bitmaps nowadays.
>>
>> Maybe a lazy reverse-pointer graph can be established on the serverside.
>> So I guess when we add the feature to fetch arbitrary sha1s, reachable
>> from
>> any branch, people using submodules will make use of the feature. (such as
>> with
>> git fetch --recurse --depth 1 or via a new `git fetch --recursive
>> --up-to-submodule-tip-only`)
>>
>> So once the server is asked for a certain sha1, it will do the
>> reachability check,
>> which takes some effort, but then stores the result in the form:
>> "If ${current tip sha} of ${branch} is reachable, so is requested $sha1."
>>
>> So when the next fetch request for $sha1 arrives, the server only needs to
>> check for ${current tip sha} to be part of $branch, which is expected to
>> be
>> a shorter revwalk from the tip. (Because it is nearer to the tip, a bitmap
>> could
>> just tell you or at least shorten the walk even more)
>> If the ${branch} has changed, the next evaluation for $sha1 can update
>> the cache,
>> such that the reverse lookup is not expensive on expectation.
>
>
> Makes sense, although I do not know enough about the server side to tell if
> it would need such an optimization or will cope with the load just fine.
>
> But even if we'd enable such a feature without having to set an extra config
> option, a submodule fetch asking for certain sha1s would have to fall back
> to a simple "fetch all" like we do now when the server doesn't support that
> for backwards compatibility. But maybe that's just obvious.

It's not obvious to me.  Say you run the command:

    git clone --recursive --depth=1 ...

Currently the depth argument for the submodules is ignored, because it
doesn't work out conceptually. This is because recursive fetches fetch the
branch tips and not the submodule-specified sha1.

If we want to make it work, we would need to think about, what we want
to achieve here.
depth is usually used to reduce the transmit time/bandwidth required.

So if the server tells us it's not allowing fetching of arbitrary
sha1s by its cryptic message:

    $ git fetch origin 6f963a895a97d720c909fcf4eb0544a272ef7c49:refs/heads/copy
    error: no such remote ref 6f963a895a97d720c909fcf4eb0544a272ef7c49

we have two choices, either error out with

    die(_("Server doesn't support cloning of arbitrary sha1s"))

or we could pretend as if we know how to fix it by cloning regularly
with the whole history
attached and then present a tightened history by shallowing after
cloning. But that would
defeat the whole point of the depth argument in the first place, the
time and bandwidth would
have been wasted. So instead I'd rather have the user make the choice.



>
>> I assume this will mostly be used with submodules, so only a few sha1s
>> need
>> this caching.
>
>
> I won't bet on that, some of the submodules at $DAYJOB are rather busy and
> see almost the same traffic as their superprojects ;-)

But do you update the superproject with each submodules commit?
(We plan to update the superproject in Gerrit with each submodule eventually,
so yeah that point is nuts.)

>
> Submodules should never be aware of their superproject. But a superproject
> does know its submodules, so I don't think the influence you describe here
> is a problem per se. It's just looking like a corner case to me, as in a
> lot of scenarios submodules do not live on the same server. And even if
> they do, a superproject has no canonical way of finding their submodule's
> repos (except for submodules that use relative URLs). So I'd rather like
> to see a generic solution first, before we think about adding an optimized
> version for certain setups later ;-)

ok. :)

>
> The only real itch I have with the "superproject declaring submodule sha1s
> fetchable on the server" approach is that it smells like a security problem.
> The access rights of superprojects are often different from those of the
> submodules it contains and this feels like a privilege escalation waiting
> to happen.

Yeah, I agree. It was one of my first ideas, probably not the best
idea on this topic.
Currently I am amazed by the reverse lazy caching if that check should ever be
a problem on the server side.
