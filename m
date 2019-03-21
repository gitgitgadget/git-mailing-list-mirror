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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3438320248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCUOsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:48:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37857 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUOsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:48:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so5241029edq.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WofBzvSeGPtLpJzl1N/R5Tj/odPwDns1xs8/sTRcGwM=;
        b=fEMgCWU6viC15cH2yXYIm28PtMXrj0p9aw7/oYfyTHI67VJve4KBHyNOV7r7tqSpRx
         KrAIb8OWa/gCpCmCnTbt/ghD33Yt0gm9OEzlYskpdSGaXTi/JERUrpPSlPDhbWDIHaf+
         m9xkYNXZPsPSZC3NkA8PRdM2WrNbakfiZtHI3K9rR90/T77GafsnUWbjLbhlzOppZDwC
         cv87BYwscO6gug/RWbrAutcYmz7qE8yCwIDQ1fCKLWznCBHaTPRu9UCOGWX6LL/KoNcr
         /ufw3Fr5b+AXBQY23CoQzVgQT8WN88lIwEsbU5lMXuremgLzYrTnh4o3+kmThLl3rwIY
         mhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WofBzvSeGPtLpJzl1N/R5Tj/odPwDns1xs8/sTRcGwM=;
        b=I09jDwenCYU+Z1xZokYOPLkOKe01wtNqsZCLlYBGgwQVQZ9EEF8lljXgFkkjh+w0bQ
         PAgeD+r1aA4R5uVchYpuazlRShc3Ec52QNDWsIJqa4cK70Wk/qe/daBjD6uOLOeoyVNN
         uPgzjHQnpHSEEevcegrWz1/zw/UUAnHps2Fy3TxUDC1uGMEUKh7hkvFbqduKo23vcx6Q
         gJradF/yLZ3yalvATO1fDNDMziG2vDsjMeCIPpHXLCM1sGPeSn0GT9smreWzy7GMlbNt
         S2LgB4BOgQJrEMlsv+CYjx+5JhVt0xC2CxyQjwf0g+HNQPYmkaLm3AEwQr0a8MajonkR
         WW5Q==
X-Gm-Message-State: APjAAAX0Yoc7rTou/Qor3DZ+b0VrtSFaRiOa4cNhWq+FXihzjWcxNo/Z
        YGPnIH/eKzHw4daVN8RZD/k=
X-Google-Smtp-Source: APXvYqxmJLRaJJ9zt0HW1F7cpJdVo0OwT1QPm2RapSWiX8JvXL8FylUh2uy7Z9/P0DLCffOMsagAAA==
X-Received: by 2002:a50:baab:: with SMTP id x40mr2697112ede.244.1553179730796;
        Thu, 21 Mar 2019 07:48:50 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id a51sm1648050edd.57.2019.03.21.07.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:48:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com> <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com> <87k1gxa8cm.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet>
Date:   Thu, 21 Mar 2019 15:48:28 +0100
Message-ID: <87mulocmgz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Sun, 17 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Fri, Feb 15 2019, Jeff Hostetler wrote:
>>
>> > On 2/14/2019 7:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >>
>> >> On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:
>> >>
>> >>> V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h
>> >>>
>> >>> There are no other outstanding comments that I'm aware of.
>> >>
>> >> Not a comment on this, just a follow-up question. I started looking i=
nto
>> >> whether this could be driven by config instead of getenv(). A lot eas=
ier
>> >> to set up in some cases than injecting env variables, especialy if the
>> >> log target supported a strftime() string, is any of that something
>> >> you've looked into already (so I don't do dupe work...).
>> >>
>> >> There's the chicken & egg problem with wanting to do traces way before
>> >> we get to reading config, so I expect that such a facility would need=
 to
>> >> work by always trace record at the beginning until we get far enough =
to
>> >> write the config, and then either stop and throw away the buffer, or
>> >> write out the existing trace to the configured target, and continue.
>> >>
>> >
>> > Yes, I beat my head against the config settings for quite a while
>> > before settling on using an env var.
>> >
>> > I wanted to get the:
>> > () full process elapsed time,
>> > () the full original argv,
>> > () all of the command dispatch, run-dashed, and alias expansion,
>> > () and for my atexit() to run last.
>> > So I hooked into main() before the config is loaded.
>> >
>> > In most commands, the config is processed about the same time as
>> > parse_options() is called.  And we have to insert code in
>> > git_default_config() to load my settings.  This happens after all
>> > of the .git dir discovery, "-c" and "-C" processing, alias expansion,
>> > command dispatch and etc.  And the argv received in the cmd_*()
>> > function has been modified.  So we lose some information.  (I tried
>> > this for a while and didn't like the results.)
>> >
>> > I also tried using read_early_config() various places, but there
>> > were problems here too.  Too early and the "-c" settings weren't
>> > parsed yet.  And there was an issue about when .git dir was discovered,
>> > so local config settings weren't ready yet.
>> >
>> > I also recall having a problem when doing an early iteration with
>> > side effects (or rather the early iteration caused something to be
>> > set that caused the real iteration (in cmd_*()) to short-cut), but
>> > I don't remember the details.
>> >
>> > So we have a custom installer that also sets the environment variable
>> > after git is installed and haven't had any problems.
>> >
>> >
>> > I hesitate to say we should always start allocating a bunch of data
>> > and spinning up the TLS data and etc. before we know if tracing is
>> > wanted.  Just seems expensive for most users.
>> >
>> >
>> > I could see having a "~/.git_tr2_config" or something similar in
>> > some place like "/etc" that only contained the Trace2 settings.
>> > It would be safe to read very early inside main() and we would not
>> > consider it to be part of the real config.  For example, "git config"
>> > would not know about it.  Then you could enforce a system-wide
>> > setting without any of the env var issues.
>>
>> I haven't written a patch for this, but it seems to me that we could
>> just start reading /etc/gitconfig via some custom config callback code
>> early as e.g. 58b284a2e91 ("worktree: add per-worktree config files",
>> 2018-10-21) does for the worktree config.
>
> Oy. Oy, oy, oy.
>
> Maybe use `read_early_config()` instead? That would be *a lot* cleaner.
> You could maybe use a9bcf6586d1a (alias: use the early config machinery to
> expand aliases, 2017-06-14) as an inspiration.

Thanks. I was thinking *only* to do /etc/gitconfig and not the whole
.git/config -> ~/.gitconfig etc. sequence just in terms of saving
critical time (this is the performance trace path, after all...).

But on a second reading I see that read_early_config() can do that if
you set config_source->file, opts->respect_includes etc. I.e. it just
(depending on options) resolves to git_config_from_file() which
58b284a2e91 used directly.

>> It would ignore everything except trace.* or wherever namespace we'll
>> put this in, and "-c" etc. wouldn't work. We could just document that as
>> a limitation for now which could be fixed later.
>>
>> It wouldn't make things worse, and would mean you could easily set
>> logging system-wide without needing to inject environment variables in
>> lots of custom (and sometimes hard-to-do) places, which I expect is the
>> most common use-case, and is the one I have.
>
> Yes, I agree, those are good goals to address.
>
> Ciao,
> Dscho
>
>> > WRT the strftime() question, we could either add syntax to the
>> > env var value (or the tr2 config setting) to have some tokens
>> > for that.  I just stuck with absolute pathnames since I started
>> > by copying what was done for GIT_TRACE.
>> >
>> > Jeff
>>
