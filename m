Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CC320248
	for <e@80x24.org>; Fri, 12 Apr 2019 02:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDLCaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 22:30:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37747 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfDLCaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 22:30:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so9023889wmf.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bZI0Sc8bvoK4DvZG67R9QmxDBFkql8cXeuEg8fUNZOM=;
        b=oVnomxgsW2Ar4FBPXynliZLokHxYetB3NuaeFbmXSVFPlhZQ94Pp4VYnc3gdLxRVg0
         DJYGMjVZkxUMyr/W5DklHTtb/Gd2YlHCuYsFZhQF8lEgOE3GWZBrBDogVhTljHz3p1De
         VT8x4SnUpCWkrSmaVOEv8FbM2swTeoa0jIOiw3u0a6ccVipqjiYuv9PJS82HGfHbmEn/
         /cxi6VxZgP0d3WUV9OR1liIGq80gsEoAplBpGSyQ3XyIhapxNU7YR47npeyW58hHYk90
         Q9bitcDCB7ild9xAxSAcFqx39LgIhIADQIeQ8N38AcNnSiQwM/N3wqnK2NNmtqOyJ+4+
         gP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bZI0Sc8bvoK4DvZG67R9QmxDBFkql8cXeuEg8fUNZOM=;
        b=O9U8DQKDZ2sKGc9sO4e+ORgQGnnFcoIw0QgaTjDrg5qH6nJ3R1TNToGRRkh+rSTVeF
         gYeClrwKOU+BKArPWG4WLFil3Pw88JliQpN1TgmLAGwnfn2KiblwWCowAjY4L9cJSdMy
         Mq8x7IeD5FElmO3NIvGbsOS0/VjFy28pFZc2sX0b6GBx2+ApCFRsfphv9Hd0P+iGl0+8
         TLqOsEvnn2tgfF7iHPoAUYgVW8W4KvB6L0hQ171G9AzempqhQV1ec+k3YMGgbVC973Oa
         VQ3FL1ZE4iyhpOMIGZTfST6qTSZWTxOqZcQac5yC+JL8vTBQYvntMCirpYLpgA4Upwk4
         c+qA==
X-Gm-Message-State: APjAAAU2uOxDPisg/xKcaPUYyPEghpVpcmgMOXIQzOKVJ5dkAVYb8mbK
        dVNZOQXeImWwFVJUJ/hNV/gEDowuz2U=
X-Google-Smtp-Source: APXvYqyK5XbqQuxs9scok+tIYZvT+8zVYqeB5wP/XLiJ11gMECfsubTzg545+mRuZh3AE57RARB5Jw==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr9229979wmi.60.1555036199995;
        Thu, 11 Apr 2019 19:29:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g13sm5312049wmh.11.2019.04.11.19.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 19:29:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com
Subject: Re: [PATCH v3 00/10] trace2: load trace2 settings from system config
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Apr 2019 11:29:58 +0900
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com> (Jeff Hostetler via
        GitGitGadget's message of "Thu, 11 Apr 2019 08:18:37 -0700 (PDT)")
Message-ID: <xmqqv9zkymzd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is version 3.
> [] It incorporates Ævar's suggestions WRT the format and uniqueness of the
> SID. [] It now reads both system and global config for trace2 settings and
> handles includes as Jonathan suggested.

Following the ISO more closely with Ts and Zs in the format looks
like a good idea (i.e. it gives a more familiar-looking result).  I
have no string opinions on the per-user config or inclusion, but I
think it probably is an essential ingredient to give an opt-out
escape hatch to make this appear less big-brotherly [*1*].

	Side note *1*: and hence less scary.  An otherwise useful
	mechanism can have an appearance that it can also be misused
	for bad purposes, and at that point, to those with fear, it
	does not matter how useful an application the mechanism has.

	I think "by default you are opting in due to your belonging
	to this organization in the first place (hence we give you
	/etc/gitconfig that lets us collect your usage patterns) but
	you could easily opt-out by overriding in $HOME/.gitconfig"
	strikes a good balance.

> I added a read_very_early_config() function that is similar to 
> read_early_config()but omits repo local, worktree, and -c command line
> settings. This felt like a little bit of a hack, but it made the intent
> clear.

I am not yet judging if the "very early config" itself is a good
thing to have (and if it is good, then it is not a "hack" ;-)), but
I very much agree that it is a very good change to have a helper
that makes the intent clear.

>      -+# Now test using system config by using a mocked up config file
>      -+# rather than inheriting "/etc/gitconfig".  Here we do not use
>      -+# GIT_TR2* environment variables.
>      -+
>       +unset GIT_TR2_BRIEF


This does not have to be sane_unset, as we are not aiming for making
our tests "set -e" clean.  But in tXXXX-*.sh scripts, it may not be
a bad idea to stick to sane_unset regardless, as people tend to cut
and paste without thinking enough.

>      @@ -512,19 +454,28 @@
>       + */
>       +/* clang-format off */
>
>      ++	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TR2_CONFIG_PARAMS",
>      ++				       "trace2.configparams" },
>      ++
>      ++	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TR2_DST_DEBUG",
>      ++				       "trace2.destinationdebug" },
>      ++
>      ++	[TR2_SYSENV_NORMAL]        = { "GIT_TR2",
>      ++				       "trace2.normaltarget" },
>      ++	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TR2_BRIEF",
>      ++				       "trace2.normalbrief" },
>      ++
>      ++	[TR2_SYSENV_EVENT]         = { "GIT_TR2_EVENT",
>      ++				       "trace2.eventtarget" },
>      ++	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TR2_EVENT_BRIEF",
>      ++				       "trace2.eventbrief" },
>      ++	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TR2_EVENT_NESTING",
>      ++				       "trace2.eventnesting" },
>      ++
>      ++	[TR2_SYSENV_PERF]          = { "GIT_TR2_PERF",
>      ++				       "trace2.perftarget" },
>      ++	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TR2_PERF_BRIEF",
>      ++				       "trace2.perfbrief" },


With use of designated initializers, the table got a lot cleaner to
read.  Is the above "format off" still needed (I am a bit curious
how clang-format wants these entries to look like)?

>      ++	if (pid > 999999)
>      ++		strbuf_addf(&tr2sid_buf, "W%06d", (int)(pid % 1000000));
>      ++	else
>      ++		strbuf_addf(&tr2sid_buf, "P%06d", (int)pid);

I do not think it matters too much, but this is kind-of curious.

How would the users of the log utilize the distinction between W and
P?  Do they discard the ones with W when they care about the exact
process that left the trace entries, or something?  If it's not a
plausibly useful use pattern (and I do not think it is), I wonder if
we want to go with only W (i.e. truncated to the lower N digits)
entries, if you are shooting for a fixed-width output from this
function.  If you want less chance of collisions, you obviously
could use hexadecimal to gain back a few more bits.

After all, if the application does care the PID, that could be in
the log data itself (i.e. an "start" event can say "my pid is blah").

Thanks.  I'll wait until learning what others think.
