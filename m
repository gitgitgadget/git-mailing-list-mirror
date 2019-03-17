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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8253A20248
	for <e@80x24.org>; Sun, 17 Mar 2019 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCQOWw (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 10:22:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40464 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQOWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 10:22:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so624355edw.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RkXYG+oKojuqRfAJhXBp6g8ki71qAZSE8h1AnmC1+lU=;
        b=CcvledofOco6JTttL7v2K7A20quVErG/WtZo6IXPB97wWRr/cIp2ccvH3nLuHzNgAe
         bCz02xOA7R8p00Kc7OGDCrnPSTHO8hBKR8DwXYFnTELvzNBFRbfuWpEkrhEr+hGZpf3C
         X8bZZ86r6y7Scxf0ksenLcxe7P5rRtH+ESN5BufDBOtOFkaXY8XM9RLgKY7Kbwi8xBh8
         WKMVeT606MTeg8pPz00J1cV9uYkX04UxNPgObQNJI6niGSeGaB+tnAuapbyccxUElamL
         N5TonDkldeIGz3LjIBaxvTEuvkYOTH792H88WlimEd7H0a8Jm5OVlJ9fjFaEp/OEd1UU
         3HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RkXYG+oKojuqRfAJhXBp6g8ki71qAZSE8h1AnmC1+lU=;
        b=fQeykpsGkSuL7TFF94d6Kbnx9Xgo+LBbo9tt+2qVrda8ttoiiYJYSxxE2Bz+orHJeW
         24GTKnYwK+iBfaTXkdbuol3KiUr/IN1AO/D3x4aCqF8BAqfuKBI8sTuraAS9y0XtyYsj
         Wnum/yS671chEt4C/1Qhayo/B20htGM+jiyR2iXT6twz0w3N6LWsLMjkwwTMHhFz0Wtm
         8flivH8m8Bc6K/kb1hf8sZ3TCNvOpc/GiCLLyVVg17cCj12Gu0jZOoEPqH6GvNKHeyjN
         HAH9Np2OSrdPAet0UsVQSqYkzkhFU/xyrEtkSvQ1Mv5vZYeYSDZFQCr20kShOkNIvWdU
         5vFg==
X-Gm-Message-State: APjAAAXjDrOthuebirwHGOuHZSc8SIpmPC/QbrX+24fS4xihEn8OD+f/
        WsEa7x3dK5hgBgkxpVjRMqM=
X-Google-Smtp-Source: APXvYqzQqzksYxGkD4QIpqiMPRklGB3ap3e3uV5HqCj2YZ8WdJaiLne4WBiQL3whw20AQHiLGLKVXQ==
X-Received: by 2002:a50:e703:: with SMTP id a3mr9508449edn.205.1552832569767;
        Sun, 17 Mar 2019 07:22:49 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x45sm2605473edb.42.2019.03.17.07.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 07:22:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com> <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com>
Date:   Sun, 17 Mar 2019 15:22:49 +0100
Message-ID: <87k1gxa8cm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 15 2019, Jeff Hostetler wrote:

> On 2/14/2019 7:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:
>>
>>> V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h
>>>
>>> There are no other outstanding comments that I'm aware of.
>>
>> Not a comment on this, just a follow-up question. I started looking into
>> whether this could be driven by config instead of getenv(). A lot easier
>> to set up in some cases than injecting env variables, especialy if the
>> log target supported a strftime() string, is any of that something
>> you've looked into already (so I don't do dupe work...).
>>
>> There's the chicken & egg problem with wanting to do traces way before
>> we get to reading config, so I expect that such a facility would need to
>> work by always trace record at the beginning until we get far enough to
>> write the config, and then either stop and throw away the buffer, or
>> write out the existing trace to the configured target, and continue.
>>
>
> Yes, I beat my head against the config settings for quite a while
> before settling on using an env var.
>
> I wanted to get the:
> () full process elapsed time,
> () the full original argv,
> () all of the command dispatch, run-dashed, and alias expansion,
> () and for my atexit() to run last.
> So I hooked into main() before the config is loaded.
>
> In most commands, the config is processed about the same time as
> parse_options() is called.  And we have to insert code in
> git_default_config() to load my settings.  This happens after all
> of the .git dir discovery, "-c" and "-C" processing, alias expansion,
> command dispatch and etc.  And the argv received in the cmd_*()
> function has been modified.  So we lose some information.  (I tried
> this for a while and didn't like the results.)
>
> I also tried using read_early_config() various places, but there
> were problems here too.  Too early and the "-c" settings weren't
> parsed yet.  And there was an issue about when .git dir was discovered,
> so local config settings weren't ready yet.
>
> I also recall having a problem when doing an early iteration with
> side effects (or rather the early iteration caused something to be
> set that caused the real iteration (in cmd_*()) to short-cut), but
> I don't remember the details.
>
> So we have a custom installer that also sets the environment variable
> after git is installed and haven't had any problems.
>
>
> I hesitate to say we should always start allocating a bunch of data
> and spinning up the TLS data and etc. before we know if tracing is
> wanted.  Just seems expensive for most users.
>
>
> I could see having a "~/.git_tr2_config" or something similar in
> some place like "/etc" that only contained the Trace2 settings.
> It would be safe to read very early inside main() and we would not
> consider it to be part of the real config.  For example, "git config"
> would not know about it.  Then you could enforce a system-wide
> setting without any of the env var issues.

I haven't written a patch for this, but it seems to me that we could
just start reading /etc/gitconfig via some custom config callback code
early as e.g. 58b284a2e91 ("worktree: add per-worktree config files",
2018-10-21) does for the worktree config.

It would ignore everything except trace.* or wherever namespace we'll
put this in, and "-c" etc. wouldn't work. We could just document that as
a limitation for now which could be fixed later.

It wouldn't make things worse, and would mean you could easily set
logging system-wide without needing to inject environment variables in
lots of custom (and sometimes hard-to-do) places, which I expect is the
most common use-case, and is the one I have.

> WRT the strftime() question, we could either add syntax to the
> env var value (or the tr2 config setting) to have some tokens
> for that.  I just stuck with absolute pathnames since I started
> by copying what was done for GIT_TRACE.
>
> Jeff
