Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F274C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352358AbiETRyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiETRyE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:54:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91218540D
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:54:02 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l15so6037312ilh.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uOkIK7QDj71di+Q3Fq/gKhbmtmzb0kGAzTowoprlQEw=;
        b=ILhxw1h5tcIBE83Ru+ZPQGpqJvpNOiMfKYnONUARB9G/qKTg7qIVZUMpjnlSIduhp2
         MPmgmCkUCEOCuTeRpAk3/vfymeLXhCbBOAUs8spBaM48xGgbEcFqclZHn5292ir2x+vR
         gkdCXO/eSL9FgV7qEEOM32CHDQDsbg3KEQLFjtTkmjO/rjgRIf5nlhLIxastFx9/i0Xr
         MQqaUP4/DGEbi9c299Xex4t4AxO/j633jUfNvTFReCndVwLbHhkB9/vJq5N0oqX3suP8
         /gjxHHeNNGysmZXoK5oVJa82J/+VO0lJHIvHs+ZSjHDy6bQbEr0KQUJi1oUKRrpSiuxn
         6vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOkIK7QDj71di+Q3Fq/gKhbmtmzb0kGAzTowoprlQEw=;
        b=mvlX98ESR4LTK1xLt+afur4G7SV5a3JFvEqpG7AB1IB0TmJKr3TYWMBtsac/+b4hWO
         P5xYv/kVsdBGQtTyiysbOyyOVC5kFe/deqk3/yVaxcqwNN4A88uFXSa5Sg1ZD68XucVc
         eFC0POliAeoOaIpF7Ng+4PUaCvofyZt5Cy5O4Q7nu1rKDLTz1TwmiCISy+LKTp7N9i2w
         QmWxFmHsq0t/PcY8PCw+cewrEDYbkv5C8gKAKWn58l3sczhMSqG40JyljYQM2xbT09ht
         6Ri9/oQgjNQ0kL9RlgjtUp+UVGxbppXHXhAFGSIFuZTaSY+BtpeETmIx1UVdE/udsSYz
         1Syw==
X-Gm-Message-State: AOAM533vpCvWW0WDrm3GkOk5oxQ/+K4ayCXnc2D0zV2jKm3gtHBTEWwh
        RmwL2v2tvT5sPmPBo9sUaHbV
X-Google-Smtp-Source: ABdhPJyeR6N4crc+BbTyEwJ6tgN9R7gCOdOkByuDfTo+1sG3Xy/WdqYbkOdFPMNRiiLDBdO7XjDgYg==
X-Received: by 2002:a05:6e02:16c8:b0:2d0:f399:5be2 with SMTP id 8-20020a056e0216c800b002d0f3995be2mr6088882ilx.290.1653069241475;
        Fri, 20 May 2022 10:54:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id 10-20020a92c64a000000b002cdfeead6basm2082318ill.63.2022.05.20.10.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 10:54:00 -0700 (PDT)
Message-ID: <3c886213-d20a-b05c-3ee7-011151139fd3@github.com>
Date:   Fri, 20 May 2022 13:53:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Discussion] What is Git's Security Boundary?
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Christian Couder <christian.couder@gmail.com>
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
 <220517.86k0ak6zpo.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220517.86k0ak6zpo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2022 8:55 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 26 2022, Derrick Stolee wrote:
> 
> [Snip and just focusing on the "what to do with config" part of this]:
> 
>> Question: Is "protected" config _really_ more trustworthy?
>> ----------------------------------------------------------
>>
>> This leads to an interesting question: Do we think that `~/.gitconfig`
>> and `/etc/gitconfig` are "more trustworthy" than `.git/config`?
>>
>> I think that if an attacker has access to write to system or global config,
>> then they have access to do more harm without Git. On the other hand,
>> local config overrides the other config values, so local config can "unset"
>> any potentially-malicious values in system and global config. I don't
>> think such "defensive config" is common.
> 
> I think this is a subset of areas where we rightfully piggy-back on FS
> permissions, and should continue to do so.
> 
> I.e. we should trust /etc/gitconfig and the like because someone who can
> modify it can modify /usr/bin/git anyway, so trying to defend against
> anything in that area is pointless.
> 
> Yes we allow overriding that config, but that should be thought of as a
> convenience, not as a nascent security boundary.

Thanks. This was my thought, too. I thought it worth bringing up to confirm.

>> Example Security Boundary Question: Unprotected Config and Executing Code
>> -------------------------------------------------------------------------
>>
>> We have a lot of ways of executing external code from within Git. This is
>> a key extensibility feature for customizing Git functionality. One way to
>> do this is to create executable files in the $GIT_DIR/hooks/ directory.
>> Git will discover these hooks and run them at the appropriate times.
>>
>> There are also many config options that specify external commands to run:
>>
>> * `core.fsmonitor=<path>` is executed before scanning the worktree for
>>   created or modified files.
>>
>> * `core.editor` specifies an editor when writing commit messages, among
>>   other user-input scenarios.
>>
>> * `credential.helper` specifies an external tool to assist with connecting
>>   to a remote repository.
>>
>> * `uploadPack.packObjectsHook` chooses an alternative for `git pack-objects`
>>   during `git upload-pack`.
>>
>> The list is actually quite long. This last one, `uploadPack.packObjectsHook`
>> _does_ do a check for protected config: it does not allow its value to
>> come from repository-local config.
>>
>> However, most of these options really do want to have customization on a
>> per-repository basis, hence this proliferation of config options and
>> local hook directories.
>>
>> I'm concerned that as long as we allow arbitrary execution to happen based
>> on repository-local data, we will always have security risks in Git. For
>> that reason, I'm interested in exploring ways to change how we execute
>> code externally, even if it means we would (eventually) need to introduce
>> a breaking change.
> 
> I agree that we should mainly be thinking of these config values that
> directly execute something external, but as elaborated on below I think
> any security solution that narrowly focuses only on these is on the
> wrong path.
> 
> You can e.g. point git-send-email to hostile server, or disable its
> SSL/TLS settings with config. Ditto HTTP settings to disable certificate
> checking etc. etc.
> 
> You can also set transfer.fsckObjects=false or one of the fsck.*
> settings and open the door to fetching a payload which propagates a
> known part CVE. But more below.

These examples you mention are definitely things that can go wrong, but
they become much harder to use as an attack because of the extra hoops
needed by the user.

The one thing I think is particularly interesting in your examples is the
case of checking certs. I'm thinking specifically of a case where someone
updates the local repo config to have a different remote URL and tricks
the user into pushing their private repo to another location. (Although,
why didn't they just do that themselves with their read access to the
repo?)

A leaky bucket can have many holes, but that doesn't mean we shouldn't
start patching the holes we see and can reach. And the process of fixing
the ones we know about makes it easier to fix more in the future using
similar mechanisms.

>> The idea would be to allow repository-local customization by selecting
>> from a list of "installed" executables. The list of "installed"
>> executables comes from protected config (and the Git binary itself).
> 
> Most of this type of config doesn't point to a path to an executable,
> but is a string we'll give to "sh -c" or equivalent. E.g. for editors we
> couldn't naively add "emacs" to such a whitelist, as it supports
> command-line options to evaluate arbitrary code.
>
> How would your plan handle such cases?

We could add "emacs" if we assume there are no other arguments. Extra
arguments would need to be part of the "installed hook".

>> The plan I would like to put forward is to restrict all external execution
>> to be from one of these sources:
>>
>> 1. Specified in system config (`/etc/gitconfig`).
>> 2. Specified in global config (`~/.gitconfig`).
>> 3. An allow-list of known tools, on $PATH (e.g. `vim`).
>>
>> Such a change would be a major one, and would require changing a lot of
>> existing code paths. In particular, this completely removes the
>> functionality of the `$GIT_DIR/hooks/` directory in favor of a config-
>> based approach. This would require wide communication before pulling all
>> support for the old way, and likely a 3.0 version designation. After the
>> old hook mechanism is removed, the "safe.directory" protection from 2.35.2
>> would no longer be needed.
> 
> Aside from any of the details of safe.directory & how we discover hook
> it was my understanding per [1] that Johannes Schindelin disagreed with
> this assessment of what safe.directory was for.
> 
> I.e. now the known vector is a hook, but in the previous off-list
> discussions I'd proposed narrowing the new safe.directory error down to
> handle that hook case only, but per the "cat being out of the bag" in
> [1] there was concern about other non-hook issues being found.
> 
> Perhaps that assessment has changed, just noting it here for
> completeness.

You're right that since there are other ways to use shared repos to break
user expectations and create a vulnerability, then safe.directory will
likely still be needed.

I also think that safe.directory is still insufficient because a shared
repo can be marked as "safe" but then be attacked later when a "trusted"
user is compromised.

> In any case, I don't think that we'd need to make the removal of
> $GIT_DIR/hooks support in favor of config-based hooks a dependency of
> any such proposal.
> 
> The current config-based hook proposal would allow you to exhaustively
> emulate $GIT_DIR/hooks by defining all our hooks to those
> paths. Therefore any security mechanism could surely consider the old
> $GIT_DIR/hooks to be handled equivalently to however it would handle
> that sort of config-based hooks configuration.

Here's another way I would phrase my thoughts here:

If we were designing the hook mechanism _today_, then I would absolutely
advocate that we require the hook definitions to come from protected
config and not be repository local. It is too dangerous to let this level
of arbitrary execution be done in shared repository context.

The question we face today is two-fold:

1. Is that enough of a risk that we would want to break backwards
   compatibility and remove $GIT_DIR/hooks as a hook mechanism?

2. Should any _new_ way of configuring hooks be more secure than the
   $GIT_DIR/hooks mechanism?

In my opinion, I think the answer to (2) is "absolutely yes" and the
answer to (1) is "maybe". The full answer depends on how well the new
system works, which is only something we can learn after it is built and
used in real-world scenarios.

>> At minimum, in the short term, this would affect the proposed design of
>> config-based hooks.
>>
>> I think this is a good example to think about at a high level before going
>> into the technical details. We can use it to test any proposed security
>> boundary definitions to see if it lands on one side or another. Here are
>> some points:
>>
>> 1. These config-based executables cannot be set in a full repository by
>>    a "git clone" operation.
>>
>> 2. These config-based executables can be set in an embedded bare
>>    repository, but the user needs to move deeper into the repository for
>>    that to have any affect. This leads to some amount of social engineering
>>    being involved in the attack. See [4] for recent discussion on this.
>>
>>    [4] https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/
>>
>> 3. If users are sharing a common Git repository, then if an attacker gains
>>    control of one user's account, they can use the shared repository as an
>>    attack vector to gain control of the other users' accounts. For this
>>    case, do we consider the "safe.directory" config as an indicator of
>>    "I trust this repo and all users that can access it _in perpetuity_" or
>>    instead "I need to use this repo, even though it is owned by someone
>>    else."
>>
>> 4. Git's dedication to backwards compatibility might prevent any attempt
>>    to change how hooks are specified or config can be used to customize
>>    its behavior.
>>
>> 5. The technical challenge of converting all possible execution paths may
>>    be too daunting to ever feel the project is "complete" and be able to
>>    confidently say "Git is safe from these kinds of attacks".
>>
>>
>> Conclusion
>> ----------
>>
>> I look forward to hearing from the community about this topic. There are
>> so many things to think about in this space, and I hope that a lot of
>> voices can share their perspectives here.
>>
>> Please collect any action items here at the end. I would love to add a
>> doc to the Git tree that summarizes our conclusions here, even if it is
>> only a start to our evolving security boundary.
> 
> This didn't make it on-list, but in the off-list discussion about
> safe.directory I pointed out that this class of problem is something
> Emacs has been dealing with for decades, and which we'd do well to try
> to emulate. [2] below is the relevant part of my
> <220303.861qzi3mag.gmgdl@evledraar.gmail.com> (sent on Thu, 03 Mar 2022
> 19:27:59 +0100), I also mentioned it in passing in [3].
> 
> The brief overview for it in Emacs's documentation is available here:
> https://www.gnu.org/software/emacs/manual/html_node/emacs/Safe-File-Variables.html
> 
> I feel strongly that something like that is a much better direction to
> go in than an approch that tries to narrowly classify only "dangerous"
> config.
>
> That sort of approach would basically do the reverse. We'd whitelist
> "safe" config (e.g. diff.orderFile or whatever), and ask the user if
> they're OK with using config that falls outside of the whitelisting.
> 
> By classifying our own config (and we'd probably need more than just
> "safe" and "executes arbitrary code") the common case is that users
> shouldn't need to answer those questions, as we'd know that the config
> is safe.

You are focusing on the part where it displays all config that is not
known to be "safe" but ignore the parts where it refuses to take changes
for config that is known to be "risky".

Essentially I'm advocating for adding the less-invasive "never accept
risky config from untrusted sources" and you are advocating for "always
prompt for any untrusted config that isn't completely safe".
 
> This would be implemented by having a config mechanism "mark" which
> area(s) of config are "safe". We'd only pay attention to such a config
> from sources that area already "safe".

Such a direction seems like it would need a significant amount of extra
work before it would make Git usable in these shared scenarios. The
amount of "safe" config seems to be quite large _and_ continues to grow.
We would need to evaluate every boolean config option as it is written
and do an extra step to add it to this allow-list. Of course, this also
assumes that we are only guarding these repo-local config options when the
filesystem communicates that the repo is owned by someone else. I'd like
to remove the owner from the equation and stop trusting repo-local config
for things like this, if at all possible.

> So, to begin with this addresses cases where e.g. a tool like git-annex
> will execute arbitrary executables based on git configuration, which any
> mechanism that marks only config git itself knows about won't be able to
> do (it uses its own config space).
> 
> But it also extends this mechanism from being something *just* focused
> on narrowly addressing security to something generally useful. E.g. even
> if a repository on disk has "safe" config I might still want to say that
> I don't want to use its alias.* config or whatever.

This sounds again like an opposite direction: you want to have something
in your global config that ignores certain config keys in repo-local
config. That creates a user-specified deny-list which I find an interesting
direction.

My goal is to make Git safer for users who would not set up such a deny-
list.

> Whatever mechanism we end up with here, I think that now that the dust
> has settled on the CVE we'd do well to consider those sorts of
> problems.
> 
> A core.editor pointing to "rm -rf /" is a security issue, but any such
> issues are just subsets of annoying third-party config doing something I
> didn't ask for.

I feel you are making my point exactly: "rm -rf /" is just a placeholder
for something I don't want to happen and can be harmful. The flexibility
here allows attackers to be very creative with how they attack Git users
and I'd like to shut down those approaches however possible.

Thanks,
-Stolee
