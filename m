Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F73DC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiHBTsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBTsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 15:48:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCB4AD63
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 12:48:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t22so6683807pjy.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=00y+u98dm4XOK0DfxQ6aT5S2GQDkEh0Dy46J3FoFJdQ=;
        b=a5FAXVabIaL5WQ6KSQw8ZNTPkuq2LFgH2Kd0zukMc4Ea0VQ7SjD9NFCGG8ngZz3eYM
         0vgvdmPoAuwo0lnLQfThzaxcnKk5gt4/PM71b05mJic2PGSCRDBRf65vlf+sA9v0oCj0
         OOgdsO9o8vwsIEmVxNpdx4Hd7I8ljqdaKKgcgfv6ar/ep3hohjFHFU5GBPUCjdpppCoQ
         pheVmMMqWs2Ftmo19mCUgY5lcno0Y8Rnn+R0AcSfHHJNy8ZdPJEpjcDTNZNBQSlQ3RgL
         AIzmyAWornD8iN/1+lH3QuZ60UHHrEpsS6H9gymGlglffD4sdub1cQaRqVauzf6SXcOB
         Ikmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=00y+u98dm4XOK0DfxQ6aT5S2GQDkEh0Dy46J3FoFJdQ=;
        b=x6zAiJliFyZlWpk3Scr5mEW248hXhRPtlDhFu6W/gPtWgFCGcYDVyn5n22nl7CYF3l
         zeWufxIDNKF1bjj4F5G9K3eLQ42zZXhyNMMlJBlmSuesR+AgaVAxW1KPJKL4C2fLxZQZ
         XRVQSoRG7YmEK+EMRxSnObI57IfEUsvhaJIpefeY2z2F5Q+25N8WpOUVdqceVWS//MCa
         Yvf2mwjT0eIuwCKr86UHAlp6NgdTw8Rs1yhBcyPPzvzhIP/hTQ588/O55CSs6ByTJWQY
         H5GaUout3I9YrPisgOpaMQuF4SsIZ1aUWEmvzOPsQUgSZP23dFG+CxtG07XD7G1EU6v2
         tB4g==
X-Gm-Message-State: ACgBeo0A3e3HkZ9ohe3vmndlc5MomiIys8UdQAg3BnQxgRHEO+Hswsrc
        rMtXDUoYkt9ACzQ9Csyg3cTi
X-Google-Smtp-Source: AA6agR74U5gzmhiQp/Zy1EEqG6VJyLGYqyiegBYEajQTEnrj9EFJhmHeectkGenPqahzFCnG3ykYaA==
X-Received: by 2002:a17:90b:4b8d:b0:1f5:2ed8:9b2e with SMTP id lr13-20020a17090b4b8d00b001f52ed89b2emr1101270pjb.194.1659469715983;
        Tue, 02 Aug 2022 12:48:35 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b66-20020a621b45000000b0052d50e14f1dsm5767658pfb.78.2022.08.02.12.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 12:48:35 -0700 (PDT)
Message-ID: <392ae6f1-c2f1-ab0f-c832-f8e53800506a@github.com>
Date:   Tue, 2 Aug 2022 12:48:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/7] Generalize 'scalar diagnose' into 'git bugreport
 --diagnose'
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <220802.867d3rgx8n.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220802.867d3rgx8n.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:
> 
>> [...] I didn't see a major UX benefit of 'git diagnose' vs 'git
>> bugreport --diagnose', so I went with the latter, simpler approach.
> 
> I really wanted to like this, but I find the end result here really
> confusing from a UX perspective.
> 
> You can now run "git bugreport --diagnose", which creates a giant *.zip
> file to go along with your *.txt, but your *.txt makes no reference to
> it.
> 
> Should you ... attach it to your bug report to this mailing list, do
> something else?
> 
> The documentation doesn't offer much in the way of hints, other than
> suggesting (with --no-report) that this --diagnose is for something
> entirely different (and that's how "scalar" uses it).
> 
> I know what it's really for after reading this series, but for "git
> bugreport" in particular we should be really careful about not making
> the UX confusing.
> 
> The generated *.zip contains some really deep info about your repo (and
> not just metadata, e.g. copies of the index, various logs etc.), someone
> e.g. in a proprietary setting really doesn't want to be sharing that
> info.
> 
> So I would like to see real integration into "git bugreport", i.e. for
> us to smartly report more repository metrics, e.g. approx number of
> loose objects, the sort of state "__git_ps1" might report, etc.
> 
> But I think the end-state here makes things much more confusing for
> users.
> 

The "confusing UX" you describe here doesn't seem to be an inherent issue
with the implementation (nor is it as insurmountable as you're implying), it
largely appears to be an issue of under-documentation. I'll improve that in
V2 [1], but I want clarify what I was/am going for here as well.

In the context of a bug report, the diagnostics are intended to be used as
supplemental information to aid in debugging (i.e., attached with the report
in the email to the list). They're especially valuable when a bug reporter
isn't very familiar with Git internals and they can't reproduce the issue. A
lot of bugs can be investigated without those diagnostics, though, which is
why '--diagnose' isn't "on" by default.

There are also valid use-cases (beyond 'scalar diagnose') for '--no-report':
someone requests more information after looking into an already-generated
report, or a developer wants to investigate a bug on their own and use the
diagnostics as a "starting point" to guide more in-depth debugging. 

As for the proprietary data issue, I'd be open to having an option to
configure which diagnostics a user wants (either something like '--diagnose
<level>' or a separate option entirely). I'm pretty indifferent on the UI,
though, so I'll defer to other contributors on 1) if they want that feature,
and 2) what they think that should look like.

[1] https://lore.kernel.org/git/f3235afe-25cc-21a4-fc35-56e35d6be0ce@github.com/

>> An alternative implementation considered was creating a new 'git diagnose'
>> builtin, but the new command would end up duplicating much of
>> 'builtin/bugreport.c'.
> 
> It seems we always "return" from cmd_bugreport() quite quickly, and we
> basically only share the code to create the output directory. Just
> duplicating or sharing that seems like a much better approach for now
> than creating the above UX confusion.
> 
> Note that you can also share code between multiple built-ins, even in
> the same file (see e.g. builtin/{checkout,log}.c). So we could even
> share something like the safe_create_leading_directories() calling code
> in bugreport.c without libifying it.
> 

You deleted the part where I addressed this suggestion directly:

> Although that issue could be overcome with refactoring, I didn't see a
> major UX benefit of 'git diagnose' vs 'git bugreport --diagnose', so I
> went with the latter, simpler approach.

And, in the process of writing down my thoughts on the UX above, I've become
more convinced that including '--diagnose' in 'git bugreport' is the better
way to present this functionality to users.

>> Finally, despite 'scalar diagnose' now being nothing more than a wrapper for
>> 'git bugreport --diagnose', it is not being deprecated in this series.
>> Although deprecation -> removal could be a future cleanup effort, 'scalar
>> diagnose' is kept around for now as an alias for users already accustomed to
>> using it in 'scalar'.
> 
> We don't have a "make install" to get a "scalar" onto user's systems
> yet, do we really need to worry about those users?
> 
> Or is this a reference to the out-of-tree version of "scalar", not
> git.git's?
> 

In practice, it's the "out-of-tree Scalar" users that would care the most.
That said, with Scalar in the Git tree (albeit 'contrib/' and not built by
default), I think it's reasonable to want to avoid breaking changes if
possible. The continued existence of 'scalar diagnose' wouldn't really be
hurting anyone anyway, so there's no pressing need to deprecate it now.
