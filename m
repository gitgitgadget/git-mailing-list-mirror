Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02842C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiBXOMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiBXOMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:12:17 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0995C205C4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:11:45 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d3so3710697qvb.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7tpgTBez6tx65cqIQ4PvdTqrYej25jnX6lyiYJm2Pyo=;
        b=S9tdzIyBCZjyDB3Pt3e0CO3mua/bMjEGd8SBn2fO8OTahZfEgA3Hmd1VjNqpgjyFfG
         zRSw8wI2nG6KYp292DxD4xw+r1UEBIu5fr+nQGY1g5rlKHWwx+xVAEZcfvVgGlOE6cLZ
         u8wQ5Jfy84cfc/US7iyY/FTzVTcppdizWvTLZ7H9LLBK95iZisHNx8Y4iFdxN9jvKMU4
         la6g6118OBVLq8E+O/cnaBr2FvfPggH1Ma3fsKrje1rKPeVFBQR8JITpr7/0VU4XuwkJ
         ZpYwPsEUxvQCAp4CcMFmEyZPfp6zTMPC0tX52SO579NfdofPdTnhqNoF8SVHDuqHEGSp
         Nh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7tpgTBez6tx65cqIQ4PvdTqrYej25jnX6lyiYJm2Pyo=;
        b=MQR5Citpkx3G9EqVFtrhhXOofXYuw/g8oSggfMKG8P+P7wANlMNC/jeOChU9ainqhD
         xDTl16OHWAFe+YOthy4fGNzQuDyc+fur3Z1FB50NTle0ppHl730VB5yn4BSkvYUNzms6
         PeydfxOAbinbQnEbC/4QaklAWWd+vHV4lF/aognLUcY3pAoflibirn3HBGwWlylYLA6s
         VX7Pphh2BOa3gj2bFiYGkMfq3ByW6VNZBE9LVYSKdCgr49JR4LEQzfAK+UvJLghEhld6
         cxmR65pOiY7MXE/yq69FJecMDB1m+Tqs2NUpWcpH8TZEuG7NigEEU5ol/GYynA13VdK0
         qt/A==
X-Gm-Message-State: AOAM530DyOnObhICnQXbDAc54R8xRGzy/B8qHvLOQ0Nk14kMBGHZaddj
        U2bNhisPqJaSD09BXiZspqHJ
X-Google-Smtp-Source: ABdhPJx+qY8vVsXzuVgHHEbc52+A3QZQun/1smAcx6T7Lq8yIYksERY9oxcbfciXFyeJK3/ln3zNeQ==
X-Received: by 2002:ac8:5fd5:0:b0:2de:6411:f1f5 with SMTP id k21-20020ac85fd5000000b002de6411f1f5mr2351662qta.470.1645711903893;
        Thu, 24 Feb 2022 06:11:43 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i20sm1567513qtr.38.2022.02.24.06.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:11:43 -0800 (PST)
Message-ID: <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
Date:   Thu, 24 Feb 2022 09:11:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 5:17 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
> 
> [Note: The E-Mail address you CC'd for me (presumably, dropped in this
> reply) is not my E-Mail address, this one is]

Sorry about that. I appear to have gotten it right on the partial
bundles series, but somehow had a brain fart here.
 
> [Also CC-ing some people who have expressed interest in this are, and
> would probably like to be kept in the loop going forward]

Thanks. The more eyes, the better.

>> There have been several suggestions to improve Git clone speeds and
>> reliability by supplementing the Git protocol with static content. The
>> Packfile URI [0] feature lets the Git response include URIs that point to
>> packfiles that the client must download to complete the request.
>>
>> Last year, Ævar suggested using bundles instead of packfiles [1] [2]. This
>> design has the same benefits to the packfile URI feature because it offloads
>> most object downloads to static content fetches. The main advantage over
>> packfile URIs is that the remote Git server does not need to know what is in
>> those bundles. The Git client tells the server what it downloaded during the
>> fetch negotiation afterwards. This includes any chance that the client did
>> not have access to those bundles or otherwise failed to access them. I
>> agreed that this was a much more desirable way to serve static content, but
>> had concerns about the flexibility of that design [3]. I have not heard more
>> on the topic since October, so I started investigating this idea myself in
>> December, resulting in this RFC.
> 
> This timing is both quite fortunate & unfortunate for me, since I'd been
> blocked / waiting on various things until very recently to submit a
> non-RFC re-roll of (a larger version of) that series you mentioned from
> October.
> 
> I guess the good news is that we'll have at least one guaranteed very
> interested reviewer for each other's patches, and that the design that
> makes it into git.git in the end will definitely be well hashed out :)
> 
> I won't be able to review this in any detail right at this hour, but
> will be doing so. I'd also like to submit what I've got in some form
> soon for hashing the two out.
> 
> It will be some 50+ patches on the ML in total though related to this
> topic, so I think the two of us coming up with some way to manage all of
> that for both ourselves & others would be nice. Perhaps we could also
> have an off-list (video) chat in real time to clarify/discuss various
> thing related to this.

I look forward to seeing your full implementation. There are many things
about your RFC that left me confused and not fully understanding your
vision. You reference a few of them further down, so I'll mention them
specifically in that context.

> Having said that, basically:
> 
>> I focused on maximizing flexibility for the service that organizes and
>> serves bundles. This includes:
>>
>>  * Bundle URIs work for full and partial clones.
>>
>>  * Bundle URIs can assist with git fetch in addition to git clone.
>>
>>  * Users can set up bundle servers independent of the remote Git server if
>>    they specify the bundle URI via a --bundle-uri argument.
>>
>> This series is based on the recently-submitted series that adds object
>> filters to bundles [4]. There is a slight adjacent-line-add conflict with
>> js/apply-partial-clone-filters-recursively, but that is in the last few
>> patches, so it will be easy to rebase by the time we have a fully-reviewable
>> patch series for those steps.
>>
>> The general breakdown is as follows:
>>
>>  * Patch 1 adds documentation for the feature in its entirety.
>>
>>  * Patches 2-14 add the ability to run ‘git clone --bundle-uri=’
>>
>>  * Patches 15-17 add bundle fetches to ‘git fetch’ calls
>>
>>  * Patches 18-25 add a new ‘features’ capability that allows a server to
>>    advertise bundle URIs (and in the future, other features).
>>
>> I consider the patches in their current form to be “RFC quality”. There are
>> multiple places where tests are missing or special cases are not checked.
>> The goal for this RFC is to seek feedback on the high-level ideas before
>> committing to the deep work of creating mergeable patches.
> 
> Having skimmed through all of this a *very rough* overview of what
> you've got here & the direction I chose to go in is:
> 
> 1. I didn't go for an initial step of teaching "git bundle" any direct
>    remote operation, rather it's straight to  the protocol v2 bits etc.
> 
>    I don't think there's anything wrong with that, but didn't see much
>    point in teaching  "git bundle" to do that when the eventual state is
>    to have "git fetch" do so anyway.
> 
>    But in either case the "fetch" parts are either a thin wrapper for
>    "git bundle fetch", or a "git bundle fetch/unbundle" is a thin
>    equivalent to "init" "fetch" (with bundle-uri) + "unbundle".

I'm not married to this specific implementation, although having the
bundle fetch be something a user could run independently of 'git fetch'
or 'git clone' might be desirable.

> 2. By far the main difference is that you're heavily leaning on a TOC
>    format which encodes certain assumptions that aren't true of
>    clones/fetches in general (but probably are for most fetches), whereas
>    my design (as we previously discussed) leans entirely on the client
>    making sense of the bundle header & content itself.
> 
>    E.g. you have a "bundle.tableOfContents.forFetch", but e.g. if you've
>    got a git.git clone of "master" and want to:
> 
>        git fetch origin refs/heads/todo:todo
> 
>    The assumption that we can cleanly separate "clone" from "fetch" breaks
>    down.
> 
>    I.e. such a thing needs to assume that "clone" implies "you have
>    most of the objects you need already" and that "fetch" means "..an
>    incremental update thereof", doesn't it?
> 
>    Whereas I think (but we'll hash that out) that having a client fetch the
>    bundle header and working that out via current reachability checks will
>    be just as fast/faster, and such a thing is definitely more
>    general/applicable to all sorts/types of fetches.
> 
>    (A TOC mechanism might still be good/valuable, but I hope it can be a
>    cheap/discardable way to simply cache those bundle headers, or serve
>    them up all at once)

Note that the TOC is completely optional, and you could serve a bundle from
the advertised URI. The biggest difference is that the TOC allows flexibility
that your design did not (or at least, I could not detect how to get that
flexibility out of it).

The biggest thing that I am trying to understand from your design is something
I'm going to make an educated guess about: if you _do_ break the repo into
multiple bundles, then the bundle URI advertisement sends multiple URIs that
must _all_ be inspected to get the full bundle content.

The change in the TOC model is that there can be multiple potential servers
hosting multiple bundles, and the bundle URI advertisement sending multiple
URIs means "any of these would work. Try one close to you, or use the others
as a fallback." This seems like the biggest incompatibility in our approaches
based on my understanding.

Finally, the biggest thing that is possible in my model that is not in yours
is the idea of an independent bundle server that is not known by the origin
server. It seems that everything relies on the bundle URI advertisement,
while this implementation allows a --bundle-uri=<X> at clone time or a
configured URI.

Again, the TOC is critical here, so there can be one well-known URI for the
TOC that doesn't change over time, and can be used to fetch multiple bundles.

And perhaps you are intending the bundle URI to point to a directory listing,
but that seems like it would need a format that Git understands. And you
mention parsing bundle headers, which I would really like to see how you
intend to implement that without downloading too much data from the remotes.
The TOC can be extended to include whatever header information you intend to
use for these decisions.

> 3. Ditto "bundle.<id>.timestamp" in the design (presumably assumes not-rewound
>    histories), and "requires" (can also currently be inferred from bundle
>    headers).
> 
> 4. I still need to go over your just-submitted "bundle filters"
>    (https://lore.kernel.org/git/pull.1159.git.1645638911.gitgitgadget@gmail.com/)
>    in detail but by adding a @filter to the file format (good!) presumably the
>    "bundle.<id>.filter" amounts to a cache of the headers (which was 100% in line
>    with any design I had for such extra information associated with a bundle).
> 
> In (partial) summary: I really want to lean more heavily into the
> distributed nature of git in that a "bundle clone" be no more special
> than the same operation performed locally where "clone/fetch" is
> pointed-to a directory containing X number of local bundles, and has to
> make sense of whether those help with the clone/fetch operation. I.e. by
> parsing their headers & comparing that to the ref advertisement.

Cloning and fetching from bundles is fundamentally different from the
dynamic fetch negotiation of the Git protocol, so I see this intent as
a drawback to your approach, not a strength.

> Maybe a meta-format TOC will be needed eventually, and I'm not against
> such a thing.
> 
> I'd just like to make sure we wouldn't add such a thing as a premature
> optimization or something that would needlessly complicate the
> design. In particular (quoting from a part of 01/25:
>     
>     +A further optimization is that the client can avoid downloading any
>     +bundles if their timestamps are not larger than the stored timestamp.
>     +After fetching new bundles, this local timestamp value is updated.
> 
> Such caching seems sensible, but to me seems basically redundant to what
> you'd get by doing the same with just:
> 
>  * A set of dumb bundle files in a directory on a webserver
>  * Having unique names for each of those (e.g. naming them
>    https://<host>/<hash-of-content>.bundle instead of
>    https://<host>/weekly.bundle)

The bundles on my prototype server do have unique names (the timestamp
is part of the name), even though they don't include a hash of the
contents. This is mostly for readability when a human looks at the
TOC, since it does not affect the correctness. A hash could be used in
the name if the bundle server wanted, but it also isn't required.

>  * Since the content wouldn't change (HTTP headers indicating caching
>    forever) a client would have downloaded say the last 6 of your set of
>    7 "daily" rotating bundles already, and we'd locally cache their
>    entire header, not just a timestamp.

This model either requires Git understanding how to walk that
directory of files on the webserver OR for the origin server to be
aware of the hash of every bundle that might be fetched. That coupling
is exactly the kind of thing I think is too difficult for serving with
packfile URIs.

> I.e. I think you'd get the same reduction in requests and more from
> that. I.e. (to go back to the earlier example) of:
> 
>     git fetch origin refs/heads/todo:todo
> 
> You'd get the tip of "ls-refs" for TODO, and locally discover that one
> of the 6 "daily" bundles whose headers (but not necessarily content) you
> already downloaded had that advertised OID, and grab it from there.

It would be easy to special-case custom refspecs as not wanting bundle
data. This goes back to the idea that serving from static content is
_not_ dynamic enough to handle these cases and therefore should not be
a major concern for the design.

Everything about using static content should be a _heuristic_ that
works for most users most-frequent operations. Most users have a
standard refs/heads/*:refs/remotes/origin/* refspec when fetching, so
they want as much data as they can get from that refspec from the
bundles.

> The critical difference being that such an arrangement would not be
> assuming linear history/additive only (i.e. only fast-forward) which the
> "forFetch" + "timestamp" surely does.

Generally, refs/heads/* does move forward. Yes, if someone force-pushes
then there is a chance that some extra data from their older version is
stored in a bundle somewhere.

> And, I think we'll be much better off both in the short and long term by
> heavily leaning into HTTP caching features and things like request
> pipelining + range requests than a custom meta-index format.

The point of TOC is not to split bundles small enough to avoid those
features. Those things are still possible, and I expect that anyone
organizing a bundle server would want one very large bundle to handle
the majority of the repo data. Range requests are critical for allowing
resumable clones for that large data.

> IOW is a TOC format needed if we assume for a moment for the sake of
> argument that for a given repository the say 100 bundles you'd
> potentially serve up aren't remote at all, but something you've got
> mmap()'d and can inspect the bundle headers for and compare with the
> remote "ls-refs"?
> 
> Because if that's the case we could basically get to the same place via
> HTTP caching features, and doing it that way has the advantage of
> piggy-backing on all existing caching infrastructure.
1. 100 bundles is probably at least triple the maximum I would
   recommend, unless you have a have a super-active monorepo that
   wants bundles computed hourly.

2. You keep saying "inspecting the headers" to make a decision, but
   I have yet to see you present a way that you would organize bundles
   such that that decision isn't just "get all bundles I haven't
   already downloaded" and then be equivalent to the timestamp
   heuristic.

> Have 1000 computers on your network that keep fetching torvalds/linux?
> Stick a proxy configured to cache the first say 1MB of <bundle-base-url>
> in front of them.
> 
> Now all their requests to discover if the bundles help will be local
> (and it would probably make sense to cache the actual content
> too). Whereas any type of custom caching strategy would be
> per-git-client.
> 
> Just food for thought, and sorry that this E-Mail/braindump got so long
> already...

I recommend that when you have the time you look carefully at Patch 1
which actually includes the design document for the feature. That doc
contains concrete descriptions of all the ways the presented design is
flexible for users and server administrators.

In particular, I think an extremely valuable aspect of this design is
the ability for someone to spin up their own bundle server in their
build lab and modify their build scripts to fetch from that bundle
server before going to the origin remote. If your design can handle
that scenario, then I'd love to see how.

Take your time preparing your patches, and I'll give them a careful
read then they are available. I expect that you have some great ideas
that could augment this design, and I'm sure that your code will have
some implementation details that are better than mine. We can find a
way to combine to get the best of both worlds.

That said, I do feel that I must not have done an adequate job of
describing how important I think it is to have a more flexible design
than what you presented before. You continue to push back that your
ideas are sufficient, but I disagree. Unfortunately, I cannot be
sure either way until I see your full implementation.

Thanks,
-Stolee
