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
	by dcvr.yhbt.net (Postfix) with ESMTP id 261FB20248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfCVOxR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:53:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42480 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfCVOxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:53:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so1899675edb.9
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/mzCv0tI1Gud98MyQB96uij/l16TH8BlPCg5b8xJ6o4=;
        b=S+lOUqZiLx9GvPHjhS9DjTX/HG2lmVuAsmkk6sNF+C9AywQWuTlFlLlaO4SSsWs85X
         ytPVNZaRX7YeFi+wCO+Y0duvS+cvKaLrVLY7Z28YjhtPNAImd6kn8oD4wnzrIU1a3d97
         gJ16HMTvRK7HODtGMUkukjLwrazhlcef59e+uJh4V7hcjw+l1tmTbVMMTeXT8NRgxAJ+
         XH5LVRp0FDNmg8Wy4b6agdTH8BYC89dlmHv873plGBXbyFweKdHzEGQ1HEUV3R5m9Ee9
         d3Qyu9Dl4okmjFYQ1gTYyZOvVnbk35dFakqAIqLqYtzdRd0VXULANLOdUoDn5NnA9WqN
         uSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/mzCv0tI1Gud98MyQB96uij/l16TH8BlPCg5b8xJ6o4=;
        b=FjsWj/abP01+a/vGE+LdIkhBRE++OLQK+9sVPJqTM2/C0uH8w2CyTuvXk/7Vl3ahd6
         PaH3azHaB3EyccnZj+049olpYgU6N8BUXalo8KsFMf6hYjGdypVwcW3mPx2mhTNBtDId
         WQvBLhojDpqQPb8DnbchIDa5YsplhBgkLdozZZbYPB29PJNdkNLPCZEcnwb8+aY8Bw9H
         OJRZ394vHpUlSSR++kMnPlw90jG7PZ+CBt8jVxqynuChk5QBVYVZznLr5/af1PdrNW2/
         ek+FJlDDF3YODvS0wlNWv+dy85ni5nYFUvchy2nc4+28rjvqRp6xV+iqSKqRs2ZBI4gL
         bfJg==
X-Gm-Message-State: APjAAAVjyEZNAPToQVKg+mwvxHvFQUb0yDQIXkP38wWxuKuepzjUGrVo
        NexLCd1YNwjxu0id5Rs1MY8=
X-Google-Smtp-Source: APXvYqwghiB+w0mabD+KHiMxE8LflbY1iZmPhkhqaQBMRa3ZYeuzlk/8/rAR6Zya4ONQA8ZGsO4fAQ==
X-Received: by 2002:a17:906:484:: with SMTP id f4mr5837979eja.49.1553266394506;
        Fri, 22 Mar 2019 07:53:14 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id h32sm2487279edc.93.2019.03.22.07.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 07:53:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com> <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com> <87k1gxa8cm.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet> <87mulocmgz.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903221416230.41@tvgsbejvaqbjf.bet> <37cffd65-58bd-3fae-a4f1-44038ed52f60@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <37cffd65-58bd-3fae-a4f1-44038ed52f60@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 15:53:12 +0100
Message-ID: <87h8bvc65j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 22 2019, Jeff Hostetler wrote:

> On 3/22/2019 9:17 AM, Johannes Schindelin wrote:
>> Hi =C3=86var,
>>
>> On Thu, 21 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> On Thu, Mar 21 2019, Johannes Schindelin wrote:
>>>
>>>> On Sun, 17 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>>>
>>>>> On Fri, Feb 15 2019, Jeff Hostetler wrote:
>>>>>
>>>>>> I could see having a "~/.git_tr2_config" or something similar in
>>>>>> some place like "/etc" that only contained the Trace2 settings. It
>>>>>> would be safe to read very early inside main() and we would not
>>>>>> consider it to be part of the real config.  For example, "git
>>>>>> config" would not know about it.  Then you could enforce a
>>>>>> system-wide setting without any of the env var issues.
>>>>>
>>>>> I haven't written a patch for this, but it seems to me that we could
>>>>> just start reading /etc/gitconfig via some custom config callback
>>>>> code early as e.g. 58b284a2e91 ("worktree: add per-worktree config
>>>>> files", 2018-10-21) does for the worktree config.
>>>>
>>>> Oy. Oy, oy, oy.
>>>>
>>>> Maybe use `read_early_config()` instead? That would be *a lot*
>>>> cleaner. You could maybe use a9bcf6586d1a (alias: use the early config
>>>> machinery to expand aliases, 2017-06-14) as an inspiration.
>>>
>>> Thanks. I was thinking *only* to do /etc/gitconfig and not the whole
>>> .git/config -> ~/.gitconfig etc. sequence just in terms of saving
>>> critical time (this is the performance trace path, after all...).
>>>
>>> But on a second reading I see that read_early_config() can do that if
>>> you set config_source->file, opts->respect_includes etc. I.e. it just
>>> (depending on options) resolves to git_config_from_file() which
>>> 58b284a2e91 used directly.
>>
>> Sure, it can exclude the repo and user config, but would that not be
>> rather confusing?
>
> This was hidden in my earlier message.
>
> There's a lot a config machinery here with lots of chicken-n-egg
> problems.  I want to know at the top of main() as quickly as possible
> whether trace2 should be enabled.
>
> I don't want to slow down git by spinning up a bunch of trace2 state
> and wait until the git-dir is discovered, the "-c" args are processed,
> and we dispatch into the builtin layer and the config is enumerated
> to know if it should really be on or not.
>
> I also didn't want to introduce another full iteration of the full
> config system for startup performance reasons.
>
> I played with read_early_config() at one point and it always seemed
> to introduce side-effects.  Perhaps I was calling it earlier than it
> was expecting and that triggered some of the git-dir discovery or
> something. I don't remember all the details, I just remember that it
> changed some behaviors in subtle ways.
>
> Perhaps I could call something like git_config_from_file() with the
> right set of magic bits to get it to parse exactly 1 system config
> file that would contain my trace2 settings.  Hopefully, this will
> not have any side-effects.

Right, it also occurred to me that e.g. /home tends to be on NFS on some
systems, but very rarely /etc. I'd hate for trace reporting for git to
stall because NFS slows to a halt, so aside from temporary
implementation details (e.g. -c on the CLI not working) there's a good
case to be made for "read this from /etc/gitconfig only".

> But if we lump them in with the main /etc/gitconfig settings, we
> would have to explain that these trace2 config settings are
> system-only and ARE NOT overridden by "-c", global, local, ...
> config settings.  This would get confusing if the user tried to
> set local values and did:
> 	git config --list --show-origin
> and it showed system and local values but yet "stubbornly" refused
> to use the local values over the system values. (I think this was
> Johannes' point.)
>
> That's why I was suggesting a system trace2 config file that is a
> peer of /etc/gitconfig (maybe /etc/gittrace2) that would have these
> values and not be expected to interact with the main config system.
> That is, we just use the git_config_ routines to parse the file format,
> rather than inventing another file format, but not change the
> expectation of the established config value inheritance system.
>
> If there's no objections, I'll take a look at doing this.

I'd much rather just drop it in /etc/gitconfig with documented caveats
than introduce a new and permanent thing like /etc/gittrace2 due to a
current implementation detail.

Unlike something in core.* or whatever this facility is specialized
enough that I think it's fine to make it a bit of a special snowflake
given what it does and the target audience.

But even with those caveats it's still useful to see it in 'git config
-l --show-origin' for inspecting, and e.g. have it just work out of the
box with say the default puppetry for the likes of GitLab that now knows
how to set stuff in its /etc/gitconfig, but would need a special case
just for this.
