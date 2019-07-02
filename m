Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27A41F461
	for <e@80x24.org>; Tue,  2 Jul 2019 14:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGBOys (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 10:54:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37124 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBOys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 10:54:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so14164494qkl.4
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VfnRHVnopgV8BhMg+5PrJcu3TsbEATw67y2831aommQ=;
        b=EgyB/Obx1/3gq/THZVjRim56Mcl+noser0F3dMXGF0VySzawGxGyfBlmqMsZmuB/AC
         6Ept7E9mnjCqMtU1Q0S19Ayv8VK52OgcpKSdqgKd6RdgP5XbJyNodVUrSlJJ/18V7e/K
         lDWbBfmjgS8e2+ZqbkLmIjE8MKUQX/qJlAVGALQ//rfApfnL9FBkfmqb6JSPF1Souxug
         KsprH5fyrXwvUKLSYPr0PL3CoG5tWukQp+hoYBwRkJu1JLomdXsxyX9CTy8ZWjkD96dU
         BFYY3t+ujaCUz6nc/PcHyYSawp565fnb05mUV/63HiwbJNzZaMvMR3FpXE/oxF4zqjfK
         71vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfnRHVnopgV8BhMg+5PrJcu3TsbEATw67y2831aommQ=;
        b=g4LJH+oOJJCADUK0DKqrBSfcg462pWB8ryu2QtfzcprW0OLrV57CL7zpTd1qcmYjJs
         oN1Mbi70lyB0slCO0MpyH8P6yR+LNfZo1xvHstauQ73axgXkWM5KJJ1nOOC9H5lcyQuZ
         4VqMbK7TugNptnXLBgTtSbX5WqSV0UXIm9IKJY+q8Vwr7xDT+GZi14tkazHJRI6k0gGo
         EBVFVa4mMKsULHi06ky/MHz0Y87hdINz8izGWcVrWYnYqgoSJUZ+NUxs9ySQU3Vd9yNq
         DgZWZGx1WPldNDwaYI4d/luaJGBvhXsVG6gVR7M83w4zagOSpE+TJ9kYflweb7QVzUoO
         b3TQ==
X-Gm-Message-State: APjAAAVBNw6fY+gwTDTUcEYJ75UOKOWHpkrl/dPfjQan5VaawqLO9J+E
        0SuqAOIEec9zxi5PRd0bCjngr+Bk/Ks=
X-Google-Smtp-Source: APXvYqxqp7l31YPqHZJwJQnrodF75F2a2uRCdBrJuHWm89zOjNfs6wtN8U6+C3wjOIJZ+IcenKO+8g==
X-Received: by 2002:ae9:f303:: with SMTP id p3mr25807477qkg.320.1562079286929;
        Tue, 02 Jul 2019 07:54:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:858c:78f0:58f6:666c? ([2001:4898:a800:1010:36c2:78f0:58f6:666c])
        by smtp.gmail.com with ESMTPSA id e52sm6788374qtk.20.2019.07.02.07.54.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:54:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate
 setting
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <87sgro7lxo.fsf@evledraar.gmail.com>
 <CACsJy8Aqdb_-5ituTQMNjacHiJbw4abV=HsH9s6PoAGKyuwdJg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8720cee9-bd50-6641-c029-234a9b00e1ea@gmail.com>
Date:   Tue, 2 Jul 2019 10:54:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Aqdb_-5ituTQMNjacHiJbw4abV=HsH9s6PoAGKyuwdJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/2/2019 7:09 AM, Duy Nguyen wrote:
> On Tue, Jul 2, 2019 at 5:47 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>
>>
>> On Wed, Jun 19 2019, Derrick Stolee via GitGitGadget wrote:
>>
>>>  core.commitGraph::
>>>       If true, then git will read the commit-graph file (if it exists)
>>> -     to parse the graph structure of commits. Defaults to false. See
>>> +     to parse the graph structure of commits. Defaults to false, unless
>>> +     `core.featureAdoptionRate` is at least three. See
>>>       linkgit:git-commit-graph[1] for more information.
>>>
>>>  core.useReplaceRefs::
>>> @@ -601,3 +602,21 @@ core.abbrev::
>>>       in your repository, which hopefully is enough for
>>>       abbreviated object names to stay unique for some time.
>>>       The minimum length is 4.
>>> +
>>> +core.featureAdoptionRate::
>>> +     Set an integer value on a scale from 0 to 10 describing your
>>> +     desire to adopt new performance features. Defaults to 0. As
>>> +     the value increases, features are enabled by changing the
>>> +     default values of other config settings. If a config variable
>>> +     is specified explicitly, the explicit value will override these
>>> +     defaults:
>>> ++
>>> +If the value is at least 3, then the following defaults are modified.
>>> +These represent relatively new features that have existed for multiple
>>> +major releases, and present significant performance benefits. They do
>>> +not modify the user-facing output of porcelain commands.
>>> ++
>>> +* `core.commitGraph=true` enables reading commit-graph files.
>>> ++
>>> +* `gc.writeCommitGraph=true` eneables writing commit-graph files during
>>
>> I barked up a similar tree in
>> https://public-inbox.org/git/CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-fmg1R0EQ@mail.gmail.com/
>>
>> I wonder if you've seen that & what you think about that
>> approach. I.e. have a core.version=2.28 (or core.version=+6) or whatever
>> to opt-in to features we'd make default in 2.28. Would that be your
>> core.featureAdoptionRate=6 (28-28 = 6)?

I had not seen that message. Thanks for the link.

However, I don't think that your idea of "give me features that will be
default soon" is enough, as some of these features will _never_ be
turned on by default. It's more about how much a user is willing to have
some slight changes (i.e. extra files during maintenance [commit-graph],
different index format, changed ahead/behind messages in status) in
exchange for an overall "better" experience. Here "better" is decided by
the community members adjusting the values on this feature.
>> I admit that question is partly rhetorical, because I think it suggests
>> how hard it would be for users to reason about this.

The intention here is to make this as simple for users as possible. I want
to be able to say "I highly recommend you set core.featureAdoptionRate=5"
and for them to not need to know what is happening. Of course, they can
learn more about the details and opt-out as things change.

>> The "core.version" idea also sucks, but at least it's bound to our
>> advertised version number, so it's obvious if you set it to e.g. +2 what
>> feature track you're on, and furthermore when we'd commit to making that
>> the default for users who don't set core.version (although we could of
>> course always change our minds...). It's also something that mirrors how
>> e.g. Perl, C compilers (with --std=*) treat this sort of thing.
>>
>> So I'm all for a facility to have a setting to collectively opt-in to
>> new things early. But I think for such a thing we really should a) at
>> least in principle commit to making those things the default eventually
> 
> Some features may be best enabled for certain setups. This is why I
> set configuration variables repo size, worktree size.. instead of just
> one number.

You are right that some features are best for different scale factors:

 * commit-graph is best with a deep history.
 * index version 4 is best with a large working directory.

These things are usually correlated, and users don't always know what
exactly is "large" for any of these variables.

Further, these features actually don't have much downside even if
a user is legitimately struggling with one of these scale factors and
not another.

>> (if they don't suck) b) it needs to be obvious to the user how the
>> "rate" relates to git releases.
> 
> I see this more like gcc =O options. And for those options, the
> developers decide what to include. If you know what you want already,
> you can just turn specific keys on. Otherwise you count on devs to do
> the right things.
> 
> It would help if we have something like "gcc -Q -O2 --help=optimizers"
> so you can see exactly what you need to turn on to achieve the same
> thing. Then you can just set those have the same "per release"
> settings.
> 
> Which makes me think about a slightly different implementation detail
> (which I ignored because I didn't think further about per-release
> stuff): since these are basically meta config to change defaults, we
> can just implement them as a (builtin, or bundled) config file. The
> user can see what are included much easier we have several different
> config "profiles" (deep history, large worktree, bleeding-edge...) and
> the user can include one or all [1].

In some sense, this is creating a list of growing config profiles that
each include the previous one:

  config-3 (core.commitGraph, gc.writeCommitGraph, index.version)
  config-5 (config-3 + pack.useSparse)
  config-7 (config-5 + status.aheadBehind, fetch.showForcedUpdates)

The issue you seem to have is that we are not creating multiple
dimensions of options. I think simplicity is key here. Anyone with
the knowledge to deeply understand multiple dimensions can just
assign the config options as they see fit. This is _not_ a feature
for power users.
 
> [1] it also opens up the opportunity to have a standard (but optional)
> set of aliases. But that's a touchy topic.

Standard aliases is an interesting topic, but tangential to the
topic at hand and I'd prefer to leave it out of the current
discussion.

-Stolee
