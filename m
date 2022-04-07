Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E962C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiDGNLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343581AbiDGNL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:11:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CE25E32B
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:09:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e2442907a1so5897197fac.8
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r4CosR9sfflvD+PmOqqw3plc7uN+BYlcQvKUIrU8mn4=;
        b=Zdol3sHJmvBSbPEtrliFW63/ofD7sF5XrTqrZOb/vfZwWbTvNN3e2kZfaWqH3LOfDw
         LtlxGykZCS8ZA/B4EBNAuXoKIjBRWB8aDSizxNheh7E2S0DSf15s9fpDUw+VlBokc6xp
         3CjEAhPD9je6OcdgSnjRGT1WOwXGJhOrbp7yXGB7jUFTqUOmIlI4StHovDU+IKc5V/TP
         GMh1365P7PM25VIkwsBeW4Muv+BV+xCCnrOGCrdPXvSE8x7EWCZgcVoyHeymjPyKnG7H
         z8POjpxij7AaF7g3/06heyk68MUP4L1PnwW8VpdIx/CMkOqEQhg5ocD5WjpiK+2kkjtM
         OvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r4CosR9sfflvD+PmOqqw3plc7uN+BYlcQvKUIrU8mn4=;
        b=qkxOTiHfZu6hQcU9wIkIOypZKsAyjslQ4m1izzKWRkXsxmiaIxlmYuMmKF7katdQQn
         qanSInF4JH/sOa3XrxFgtpgTd47+y9SvuFkDjVwNi42+fVuNnanRO+VuhrwQ9LoEBOX+
         cjnvuhxua0m7EoDtqGAwhBFwN3tQc4bj7UG6FOoRiyKHY9QCTWZ1ESROJNyX01UlNebD
         YKplW8AouW1B5fnnETNJMtnNNxer56HWhGSYSbNXOxDYMD0HQEBO6iyw5rFOyLVy0l0W
         0rTBaAj8OaZ4KeO7xoTBR9e2dfBHuqT4O6s0EtuYkM37TPLSLB4plyXabISSy6NeiggC
         btDg==
X-Gm-Message-State: AOAM532dGvDE+6yFnVxXRgN7O0CXa8W8bUa8W/AezujuTrLYBvhMxCyk
        dka1PENYBmrflWatQKYOMDzZtsBzg5Rd
X-Google-Smtp-Source: ABdhPJzwZLWBYS/MBzuAJJ50CPQVnVkxCYTiGlWwZJtXAzZH/8l51dBo1zuHilZdOJsuT6cETkjJBg==
X-Received: by 2002:a05:6871:1d4:b0:de:6122:2bbb with SMTP id q20-20020a05687101d400b000de61222bbbmr6165081oad.210.1649336964856;
        Thu, 07 Apr 2022 06:09:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r29-20020a056808211d00b002f76ea70064sm7276511oiw.35.2022.04.07.06.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 06:09:24 -0700 (PDT)
Message-ID: <ea70aed6-7111-0795-f6d8-15deb505b1c0@github.com>
Date:   Thu, 7 Apr 2022 09:09:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] contrib/vscode/: debugging with VS Code and gdb
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     gitster@pobox.com, Matthieu.Moy@univ-lyon1.fr,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
References: <xmqqbkxex8oy.fsf@gitster.g>
 <20220406233946.45778-1-cogoni.guillaume@gmail.com>
 <20220406233946.45778-2-cogoni.guillaume@gmail.com>
 <220407.86tub5ce3m.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220407.86tub5ce3m.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2022 7:17 AM, Ævar Arnfjörð Bjarmason wrote:
>> On 4/6/22 10:47, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Apr 06 2022, COGONI Guillaume wrote:
>>> I really don't mind having some guide for VSCode in our developer
>>> documentation, but I think if we (as a free software project) are
>>> recommending proprietary software we should put that in some context
>>> where we explain if/why it's needed, and if free alternatives are also
>>> suitable.
>>
>> Note that VS Code is mostly open source (the pre-compiled binaries are
>> proprietary, but the source code is MIT licenced, 
>> https://github.com/Microsoft/vscode). Not to be confused with Visual
>> Studio, which is fully proprietary, but is a totally different tool 
>> (AFAIK, they only share the name).
> 
> This patch specifically proposed to link to the propriterary version.
> 
> Is there a reason we wouldn't at least recommend the fully-free version
> at https://github.com/VSCodium/vscodium, or at least mention it as
> prominently?

I think it is find to add such a reference, but I doubt it will have
much value to the reader. If the strangeness around how VS Code is
compiled bothers the reader, then they probably already avoid it.

I think this is an excellent thing to consider as a follow-up by an
expert on the topic, such as yourself, and not prevent this patch from
moving forward from the current authors.

> Two things:
> 
> First I think (disclaimer: being on the Git PLC this is just my opinion)
> that as a prominent free software project, and being under the Software
> Freedom Conservancy umbrella whose mission is
> (https://sfconservancy.org/):
> 
>     [...] fostering free and open source software (FOSS) projects,
>     driving initiatives that actively make technology more inclusive,
>     and advancing policy strategies that defend FOSS (such as copyleft).
> 
> So, maybe I'm just an old free software radical, but I believe in
> interpreting that broadly. I.e. if we're recommending third-party
> software we should prefer free alternatives, which doesn't mean that we
> can't mention proprietary software, just that we shouldn't be
> encouraging it when a free alternative will do.

Sometimes, we need to meet people where they are. If they choose to
use a proprietary editor, we can help them use that to work on our
project.

> But secondly, and everything here would apply if VSCode were replaced by
> GNU Emacs and its GUD mode, so it's not about free software on VSCode at
> all: This whole addition just seems like it's recommending a needlessly
> complex way to get to having a C debugger installed.

I completely agree with you that this should be the _start_ of the
process of documenting how to debug with a bunch of editors. There are
benefits of connecting your editor to the debugger instead of relying
on gdb or whatever directly.

I also find it hard to interpret the current section as "Do you want to
debug Git?  You should use VS Code!" I _can_ see that the section on
"useful tools" only contains one entry (so far) and that can be
read as a recommendation. This should motivate those who use other tools
to chime in with how they use their tools and what steps are required to
get efficient integrations when working on Git.

> Leaving aside completely *where* we should put such a thing I'd expect
> something much more like:
> 	
> 	BEGIN QUOTE
> 	
> 	== Using debuggers ==
...
> 	=== GUIs ===
...

I was trying to make a similar recommendation in my review. The point is
not "You should use a debugger, here is VS Code", but rather "If you want
to use a debugger with your editor, here are ways to configure your
editor of choice to debug Git." It is perfectly fine by me if these
authors want to start with the editor they know and use, as long as the
structure is such that it can be extended by other contributors to
include these other editor.

> 	=== Debugging test failures ===
> 	
> 	If you'd like to start an interactive debugger at the ponit where a test
> 	fails you may find the "debug" wrapper in t/test-lib-functions.sh useful
> 	for that.

This is a helpful idea to include in this section, but it is far too
terse to be helpful to someone who doesn't know exactly what you mean
by a '"debug" wrapper'. An example would go far here. This also
requires working with the command-line debugger (gdb, lldb, etc.), so
should be carefully differentiated from the GUI section. One way to
establish that difference would be to move it above the GUI section.

> I.e. it really shouldn't be the goal of a section on debuggers to
> "convince a newcomer that VS Code can be helpful", or that Emacs is
> helpful or whatever. Let's instead discuss the general topic at hand.
> 
> The proposed addition buries the lede in that regard. I.e. it's not made
> clear to the reader that we're just suggesting yet another interface for
> gdb, so a beginning contributor might go through it, only to find that
> all they needed was gdb, and they had that installed already.

I think that having a section on using debuggers in general, followed
by specific ways to interact with a variety of editors, would be helpful.

But I also think that this contribution does not need to be burdened by
that increase in scope. The heading "Bonus - useful tools" is a good
start that can be extended in several ways by future contributions. One
way is to reframe it as "how to debug Git" while another might be to
add other useful tools like clang-format or valgrind. I believe the best
way to go here is to be happy with the contribution with its current
scope and leave these later discussions for contributors with the right
expertise and time to write more documentation.

----

Perhaps this entire discussion would be different if the change was
added somewhere other than MyFirstContribution.txt. Is there a better
file to place this change?

MyFirstContribution.txt provides a good start to the basics of
making change, with a specific example giving chronological steps
for submitting a change. It seems like adding a section at the end
of "bonus tools" does not fit that narrative.

Taking a look myself, the only other places that _might_ make sense
include CodingGuidelines (has some integrations with Emacs included)
or SubmittingPatches (talks a lot about different email clients and
tools that help).

I think that we might want a new file where Git developers can
share best practices and custom workflows. Such a document could
help contributors optimize their process to their own tastes based
on the experience of others. I can see a long list of integrations
with editors fitting in there, along with tips like "create a RAM
disk for running tests".

My proposed name for such a file is "WorkingOnGit" but it's not
fantastic. Suggestions welcome.

---

Cogoni: In conclusion, I think that if you remove the change to
MyFirstContribution.txt, then your patch can be merged pretty
quickly (probably, that's not my decision). I expect this discussion
about a potential "WorkingOnGit" file to continue, but if it comes
to fruition, your section on VS Code would be welcome.

Thanks,
-Stolee
