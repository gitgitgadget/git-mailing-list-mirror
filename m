Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209051F462
	for <e@80x24.org>; Tue, 21 May 2019 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfEUOTN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 10:19:13 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38846 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUOTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 10:19:13 -0400
Received: by mail-ed1-f50.google.com with SMTP id w11so29618703edl.5
        for <git@vger.kernel.org>; Tue, 21 May 2019 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Inl91Ooft7NES490ElQQl1KXzKFFv3ViRPJeMRtsJmk=;
        b=HetdfjzCzhzI1rGXpKoQE6V7TA9cDQB/iLpwQIggDfHuwlRvAA8ZQqUSyc7vBPWp2g
         Oz3s2MDk6yAfl34u+4Pds9Iif0tQcACAszeg/SC0BaQjioovjKPz/eCNnXYlLspPhNMz
         H8yGMhZLfkOEwMHJA806AOjxOs3IUVhTRK9B+N8Grv58z4y8/dEIAOuW2W+PfvULZJBr
         UKQI45aaFL0FP0P0iTWPHhAY8ZxpOU1++WE98IWnwIym+LT7OgfZz/zjDaMGe2GnsuaA
         aRuJy5FtaAVokukcljKCOsEb1hQaVdPmgJK3n5BSuPGkh4ZciEK26XS1fTCGo7yS+G+f
         Ahag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Inl91Ooft7NES490ElQQl1KXzKFFv3ViRPJeMRtsJmk=;
        b=DYxWnVNCWC6unimc05hZ7cWdUMNpeIMPPO99MReiNrm6UXlehw6Wniil03z6vdWLf8
         S2UI0hWwCMrSaa6MsOJH9ZDGIypK+ynIoH1UQD6f6Z1fCsqQCh7NmWtXVRZbxE8xy+AA
         81QdEKoo7PxwHivy9Yk2Km4A5ucz/ZiwuiEkyLMEQvVXEThGbGubK5eoFMMrjHwghnny
         Sp/OS7TEeaoFDVYimU8g86B7hnxNQEu1sojLtjQMWBz2IwR3KBh8MLbemW/ovXEXTghE
         AOGgK7xEdPZ9cu/VNtttSVtkHNxbzUGmFQHGOS27EwInXCINTTp/IqKTfYiHuFhfdliY
         I4qw==
X-Gm-Message-State: APjAAAU2kkN2AjARP1qIjBt2GMinjzzebrglbObb+zRPd01WbtckAXPN
        k69CrjmrwCGDjDlIlQxHB88=
X-Google-Smtp-Source: APXvYqxdzgZKApSaGzWOumTU8InxQix+uC5dYeCSZo+ompw4SGt0KLrw2IG6K4oK1gr3pKeEo5RfWQ==
X-Received: by 2002:a17:906:e101:: with SMTP id gj1mr29233571ejb.54.1558448351745;
        Tue, 21 May 2019 07:19:11 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id g11sm6329159eda.42.2019.05.21.07.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 07:19:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I made a flame graph renderer for git's trace2 output
References: <87zhnuwdkp.fsf@evledraar.gmail.com> <20190510210324.GA30947@sigill.intra.peff.net> <87y33evuop.fsf@evledraar.gmail.com> <d1f9a2f4-500d-d5f6-af3d-75d3fdb1323b@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d1f9a2f4-500d-d5f6-af3d-75d3fdb1323b@jeffhostetler.com>
Date:   Tue, 21 May 2019 16:19:09 +0200
Message-ID: <877eajvqjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 20 2019, Jeff Hostetler wrote:

> On 5/10/2019 5:57 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Fri, May 10 2019, Jeff King wrote:
>>
>>> On Fri, May 10, 2019 at 05:09:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>>
>>>> As noted in TODOs in the script there's various stuff I'd like to do
>>>> better, and this also shows how we need a lot more trace regions to get
>>>> granular data.
>>>
>>> Hmm. My gut reaction was: doesn't "perf record -g make test" already
>>> give us that granular data? I know "perf" isn't available everywhere,
>>> but the idea of the FlameGraph repo is that it takes input from a lot of
>>> sources (though I don't know if it supports any Windows-specific formats
>>> yet, which is presumably a point of interesting to trace-2 authors).
>>>
>>> But having generated such a flamegraph, it's not all that helpful. It
>>> mainly tells us that we spend a lot of time on fork/exec. Which is no
>>> surprise, since the test suite is geared not towards heavy workloads,
>>> but lots of tiny functionality tests.
>>>
>>> TBH, I'm not sure that flame-graphing the test suite is going to be all
>>> that useful in the long run. It's going to be heavily weighted by the
>>> types of things the test suite does. Flamegraphs are good for
>>> understanding where your time is going for a particular workload, but
>>> the workload of the test suite is not that interesting.
>>>
>>> And once you do have a particular workload of interest that you can
>>> replay, then I think the granular "perf" results really can be helpful.
>>>
>>> I think the trace2 flamegraph would be most useful if you were
>>> collecting across a broad spectrum of workloads done by a user. You
>>> _can_ do that with perf or similar tools, but it can be a bit awkward.
>>> I do wonder how painful it would be to alias "git" to "perf record git"
>>> for a day or something.
>>
>> Yeah I should have mentioned that I'm mainly linking to the test suite
>> rendering as a demo.
>>
>> My actual use-case for this is to see what production nodes are spending
>> their time on, similar to what Microsoft is doing with their use of this
>> facility.
>>
>> The test suite serves as a really good test-case for the output, and to
>> stress-test my aggregation script, since we're pretty much guaranteed to
>> run all our commands, and cover a lot of unusual cases.
>>
>> It also shows that we've got a long way to go in improving the trace2
>> facility, i.e. adding region enter/leave for some of the things we spend
>> the most time on.
>>
>
> Very nice!
>
> Yes, there is more work to do to add more regions to get more
> granular data for interesting/problematic things.  My primary
> goal in this phase has been to get the basic machinery in place
> and be vetted with some universally interesting regions, such as
> reading/writing the index and the phases of status.
>
> Going forward, we can trivially (permanently) add new regions as we
> want.  I tend to use temporary "experimental" regions during my perf
> investigations so that I don't clutter up the mainline source with
> uninteresting noise.

Indeed, a lot more regions are needed.

> WRT the TODO's in your script:
>
> [] I don't think data events will be useful for your usage.  The data
> values are orthogonal to the time values.

I haven't done this, so I'm not asserting that it's useful, but from
some brief grepping a few datapoints are overwhelmingly common, and can
be faked up into regions of sorts for the purposes of a flamegraph.

E.g. "git checkout" will reliably have read/version early on, and then
write/version, in that case mostly/entirely redundant to the
do_{read,write}_index region, but in general I think we'll be able to
loosely plot data points say as "given the median runtime, here's the
median % of time into the command we first encounter this data point".

> [] I would add the child_start/_exit events to the stack.  This will
> give you the names of non-builtin/shell commands and hooks.  The
> various "child_class" and "use_shell" and "hook_name" fields will help
> you avoid duplicate stack frames (which you'll get for builtin
> commands).

Yeah that's very useful. Any reason not to do something like this:

    diff --git a/git.c b/git.c
    index 1bf9c94550..6c926ae013 100644
    --- a/git.c
    +++ b/git.c
    @@ -698 +698 @@ static void execv_dashed_external(const char **argv)
    -       trace2_cmd_name("_run_dashed_");
    +       trace2_cmd_name(is_builtin(argv[0]) ? argv[0] : "_run_dashed_");

I haven't tested, but we e.g. report 'git-submodule' as just
'_run_dashed_', seems we could do better...
