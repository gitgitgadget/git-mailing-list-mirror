Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298DE20248
	for <e@80x24.org>; Fri, 15 Mar 2019 19:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCOT0r (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 15:26:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43852 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOT0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 15:26:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id m35so8532285ede.10
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6a2KjZ5J3YAo+atmML9BJ/vjCjZSijge5Sb3UQjICKg=;
        b=sk7DAY/wGW5HcA28wivwfw6vcDCrx6k4VD88SUyQZX3NQLpCT8dDA6Xpcwl0KedubB
         w4xQXVcUvovgm8LfNXBlT2ESzK2X0z1AjtsQEsCDusSK0CUdzX2i+fHUdsI02hwmP8Y6
         U/bMJGS3OqaCuP7UXNJ4xmHj0X/INvvquRm3j4IRPpI/ePMed2pv3NpjOyIB2W2fhpkq
         C83szhP07r6HDDSzlqXma9moujKuTkU5rm2PoDhnx3IW/REwtj+D0p1x/gcLOR7rmspw
         5PLMD6b4ZzD7hRGNV+6T03ZWc4cHuaWd5pV7VCDb5bOa4XXDgpi9usg8FXnPWK6smD/D
         CYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6a2KjZ5J3YAo+atmML9BJ/vjCjZSijge5Sb3UQjICKg=;
        b=Q4Gn0OBoEB5bMhHmEivLCFWnKFgWNKxUiCQcEiChuXXMCpQmaC3hVbCD7EqRXNqvUq
         R8X1jk/yCsYA+NJRAn6QOdq3w8hnqBuRxqyMr4VhZrknWksvt3Z2wX7T8v9X8oWq0bqB
         tRIOBKCOb5W1BXb/e8boWDmh5nI1/xhq+VZ66LUsnyxpk9VpmfDWf6QTdsDba3f22Y1w
         XhP+FvwJAdsKefOHNc2EIqQLQmPdSiIx2oEwI4dTrHL8O5PrjCpoVgv9Qi8mwVU80nkw
         TZPRFQVZxlOXiveD5HOqu0rF5VGjxCc6kcOHPn6Vphq/HgnAS9pkPZVhum+Wv0ZRxTFI
         O2dw==
X-Gm-Message-State: APjAAAUiubj4cmekePJNZgeV2LD97NRh+GdawKUIJGgynG2mCJzxibVE
        46f0yznmJmg8bw4IShzboYw=
X-Google-Smtp-Source: APXvYqw5fxIcMpsNwGJPcqGo8iCjYe64Z7Wzp3KvjVm5vPGQLG4pVCxvKvaA1x3rcqHRlaWart4/jw==
X-Received: by 2002:a50:eb0c:: with SMTP id y12mr3675005edp.237.1552678004904;
        Fri, 15 Mar 2019 12:26:44 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m4sm261995ejl.49.2019.03.15.12.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:26:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
References: <cover.1552519463.git.steadmon@google.com> <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com> <87h8c6baif.fsf@evledraar.gmail.com> <1431dc76-1b1c-c581-6355-b796591e99a8@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <1431dc76-1b1c-c581-6355-b796591e99a8@jeffhostetler.com>
Date:   Fri, 15 Mar 2019 20:26:42 +0100
Message-ID: <87sgvo9bwt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Jeff Hostetler wrote:

> On 3/13/2019 7:49 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, Mar 14 2019, Josh Steadmon wrote:
>>
>>> When the value of a trace2 environment variable contains instances of
>>> the string "%ISO8601%", expand them into the current UTC timestamp in
>>> ISO 8601 format.
>>
>> Any reason not to just support feeding the path to strbuf_addftime(), to
>> e.g. support a daily/hourly log?
>>
>>> When the value of a trace2 environment variable is an absolute path
>>> referring to an existing directory, write output to randomly-named
>>> files under the given directory. If the value is an absolute path
>>> referring to a non-existent file and ends with a dash, use the value as
>>> a prefix for randomly named files.
>>>
>>> The random filenames will consist of the value of the environment
>>> variable (after potential timestamp expansion), followed by a 6
>>> character random string such as would be produced by mkstemp(3).
>>>
>>> This makes it more convenient to collect traces for every git
>>> invocation by unconditionally setting the relevant trace2 envvar to a
>>> constant directory name.
>>
>> Hrm, api-trace2.txt already specifies that the "sid" is going to be
>> unique, couldn't we just have some mode where we use that?
>>
>> But then of course when we have nested processes will contain slashes,
>> so we'd either run into deep nesting or need to munge the slashes, in
>> which case we might bump against a file length limit (although I haven't
>> seen process trees deeper than 3-4).
>
> Using the "sid" would be a good place to start.  Just take the final
> component in the string (after the last slash or the whole sid if there
> are no slashes).  That will give you a filename with microseconds since
> epoch of the command's start time and the PID.
>
> That should be unique, should not require random strings, and not go
> deep in the filesystem.  And it will let you correlate files between
> child and parent commands, if you need to.
>
> So maybe if GIT_TR2_* is set to a directory, we append the final portion
> of the "sid" and create a file inside that directory.
>
>>
>> Just to pry about the use-case since I'm doing similar collecting, why
>> are you finding this easier to process?
>>
>> With the current O_APPEND semantics you're (unless I've missed
>> something) guaranteed to get a single process tree in nested order,
>> whereas with this they'll all end up in separate files and you'll need
>> to slurp them up, sort the whole thing and stitch it together yourself
>> without the benefit of stream-parsing it where you can cheat a bit
>> knowing that e.g. a "reflog expire" entry is always coming after the
>> corresponding "gc" that invoked it.
>>
>
> Yes, with O_APPEND, you should get a series of events as they happen
> on the system all properly interleaved.  And see concurrent activity.
> This file should let you grep to see individual processes if you want
> to.
>
> Routing each command to a different file is fine if you want, but
> that opens you up to having to manage and delete them.
>
> Whether to have 1 file (with occasional rotation) or 1 file-per-command
> depends, I guess, on how you want to process them.
>
> I'm routing the Trace2 data to a named-pipe/socket and have a daemon
> collecting and filtering, so I have a single pathname for output and
> yet get the per-file stream handling that I think Josh is looking for.

Is the collecting code something you can share & general enough that it
might be useful for others?
