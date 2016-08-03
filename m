Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25781F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbcHCWso (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:48:44 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35969 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcHCWsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:48:42 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so465522480wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:48:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1lrWjEDfcauYfpZUY8ZyP/UfFtrvZuDSp/euGR+qjIk=;
        b=I2UMA76EbIvcoXjSA81Zuz/+S5Qu3f7nuT+BXkEFenmpkcWA2QNnzMmI10vVh7v5jn
         tHy2xI94O8CgY8vxE6QBO9v3Ko9DTGOihADnVikJoMmyvhRMoMcBuBuHIRpiNVhg5B8Z
         XqzRsyVx8o9VmOyD2ae/VvijCJ9pBacpvSIHnqs1whq2H0E5Yhz0v5Yg5OwPT2XL1BKz
         N5Gif5PLJwKcH3ipuewRRKkzODaX1mwWU+z+gefg/F0Vg353e0NqRzE7hlX6tAb4Mp8z
         5g6mfX1aLo5wmfwZig+NTCjVT2cyT19n5Owr14gG5jdRDJTvlwKyvE4lyH5rYE4wu40U
         9Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=1lrWjEDfcauYfpZUY8ZyP/UfFtrvZuDSp/euGR+qjIk=;
        b=CKapeP+xt9+p9ds66Ab3cvvzfvB1j8+nKsmwrzKhg+nvYM/VPu4MU5+/h+Q+syJbfo
         p1Q3QK/4RGH8FrlgFH/SuKtgfyInV8jIneY+VbjRe4giUdNGZpjh0uIx57t/vuTVfj23
         iKf44g1wolDN3kaKBj2AlC9pf0qbdlAEe3fCazeJFd5vu5JChU18D3h7gSo8nTO6KzTg
         9kpCHrKTqDkKx+afoNbrIUZ6wdcLO6MuA7Hp3Rct4453VVxKFe0bIkqM7rCDI8mwpZvB
         QJmjvx6yjM7XG7Xn803Z++Gpvh0tq1Bi1zxF7JBumNo/bDFlLH/5SAqt8Opg/N/y1L8t
         DVIA==
X-Gm-Message-State: AEkoouvQV17AzFbRiFJd0EGKYQzcGAe5rQukG4cCHELnkV6g53Qm8r1djRovvtgOGR9lXg==
X-Received: by 10.194.148.19 with SMTP id to19mr70133655wjb.81.1470264479417;
        Wed, 03 Aug 2016 15:47:59 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id o4sm9782025wjd.15.2016.08.03.15.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 15:47:58 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
 <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <986d7918-d701-66ba-c04f-4cda56cf598e@gmail.com>
Date:	Thu, 4 Aug 2016 00:47:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[Note that some of this might have been invalidated by v4]

W dniu 01.08.2016 o 15:32, Lars Schneider pisze:
>> On 31 Jul 2016, at 00:05, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:

>>> Git starts the filter on first usage and expects a welcome
>>> message, protocol version number, and filter capabilities
>>> separated by spaces:
>>> ------------------------
>>> packet:          git< git-filter-protocol\n
>>> packet:          git< version 2\n
>>> packet:          git< capabilities clean smudge\n
>>
>> Sorry for going back and forth, but now I think that 'capabilities' are
>> not really needed here, though they are in line with "version" in
>> the second packet / line, namely "version 2".  If it does not make
>> parsing more difficult...
> 
> I don't understand what you mean with "they are not really needed"?
> The field is necessary to understand the protocol, no?
> 
> In the last roll I added the "key=value" format to the protocol upon
> yours and Peff's suggestion. Would it be OK to change the startup
> sequence accordingly?
> 
> packet:          git< version=2\n
> packet:          git< capabilities=clean smudge\n
 
With current implementation, Git checks second packet of the handshake
for version, and third packet for capabilities.  The "capabilities" or
"capabilities=" is entirely redundant; it is the position of packet
(it is the packet number) that matters.  At least for now.

The only thing that "version" in "version 2" and "capabilities"
in "capabilities: clean smudge" helps is self-describing of the protocol.

To really make use of them you would have to end handshake with flush
packet, and do a parsing: loop over every packet, and match known
patterns.  Well, perhaps with exception of known header: it doesn't
makes sense to have "version N" anywhere else than second packet,
and it doesn't makes sense to repeat it.

We also don't want to proliferate packets unnecessarily.  Each packet
is a bit (a tiny bit) of a performance hit.
 
>>> ------------------------
>>> Supported filter capabilities are "clean", "smudge", "stream",
>>> and "shutdown".
>>
>> I'd rather put "stream" and "shutdown" capabilities into separate
>> patches, for easier review.
> 
> I agree with "shutdown". I think I would like to remove the "stream"
> option and make it the default for the following reasons:
> 
> (1) As you mentioned elsewhere, "stream" is not really streaming at this
> point because we don't read/write in parallel.

We could, following the example of original per-file filter drivers.
It is as simple as starting writer using start_async(), as if we did
writing from Git in a child process.

Though that might be left for later (assuming that protocol is flexible
enough), as synchronous protocol (write, then read) is a bit simpler to
implement.

> (2) Junio and you pointed out that if we transmit size and flush packet
> then we have redundancy in the protocol.

Providing size upfront can be a hint for filter or Git.  For example
HTTP provides Content-Length: header, though it is not strictly necessary.

> (3) With the newly introduced "success"/"reject"/"failure" packet at the 
> end of a filter operation, a filter process has a way to signal Git that
> something went wrong. Initially I had the idea that a filter process just
> stops writing and Git would detect the mismatch between expected bytes
> and received bytes. But the final status packet is a much clearer solution.

The solution with stopping writing wouldn't work, I don't think.

> (4) Maintaining two slightly different protocols is a waste of resources 
> and only increases the size of this (already large) patch.

Right, better to design and implement basic protocol, taking care that
it is extensible, and only then add to it.

> My only argument for the size packet was that this allows efficient buffer
> allocation. However, in non of my benchmarks this was actually a problem.
> Therefore this is probably a epsilon optimization and should be removed.
> 
> OK with everyone?

All right.

>>> After the filter has processed a blob it is expected to wait for
>>> the next command. A demo implementation can be found in
>>> `t/t0021/rot13-filter.pl` located in the Git core repository.
>>
>> If filter does not support "shutdown" capability (or if said
>> capability is postponed for later patch), it should behave sanely
>> when Git command reaps it (SIGTERM + wait + SIGKILL?, SIGCHLD?).
> 
> How would you do this? Don't you think the current solution is
> good enough for processes that don't need a proper shutdown?

Actually... couldn't filter driver register atexit() / signal handler
to do a clean exit, if it is needed?
 
 
>> I wonder if it would be worth it to explain the reasoning behind
>> this solution and show alternate ones.
>>
>> * Using a separate variable to signal that filters are invoked
>>   per-command rather than per-file, and use pkt-line interface,
>>   like boolean-valued `useProtocol`, or `protocolVersion` set
>>   to '2' or 'v2', or `persistence` set to 'per-command', there
>>   is high risk of user's trying to use exiting one-shot per-file
>>   filters... and Git hanging.
>>
>> * Using new variables for each capability, e.g. `processSmudge`
>>   and `processClean` would lead to explosion of variable names;
>>   I think.
>>
>> * Current solution of using `process` in addition to `clean`
>>   and `smudge` clearly says that you need to use different
>>   command for per-file (`clean` and `smudge`), and per-command
>>   filter, while allowing to use them together.
>>
>>   The possible disadvantage is Git command starting `process`
>>   filter, only to see that it doesn't offer required capability,
>>   for example offering only "clean" but not "smudge".  There
>>   is simple workaround - set `smudge` variable (same as not
>>   present capability) to empty string.
> 
> If you think it is necessary to have this discussion in the
> commit message, then I will add it.

I think it would be good idea (not necessary, but helpful), though
possibly not in such exacting detail.  Just why this one, one sentence
or more.
 
 >>> +single filter invocation for the entire life of a single Git
>>> +command. This is achieved by using the following packet
>>> +format (pkt-line, see protocol-common.txt) based protocol over
>>
>> Can we linkgit-it (to technical documentation)?
> 
> I don't think that is possible because it was never done. See:
> git grep "linkgit:tech"

A pity.  Well, not your problem, anyway.

>>> +Git starts the filter on first usage and expects a welcome
>>
>> Is "usage" here correct?  Perhaps it would be more readable
>> to say that Git starts filter when encountering first file
>> that needs cleaning or smudgeing.
> 
> OK. How about this:
> 
> Git starts the filter when it encounters the first file
> that needs to be cleaned or smudged. After the filter started
> Git expects a welcome message, protocol version number, and 
> filter capabilities separated by spaces:

Better. 

>>> +
>>> +After the filter has processed a blob it is expected to wait for
>>> +the next command. A demo implementation can be found in
>>> +`t/t0021/rot13-filter.pl` located in the Git core repository.
>>
>> It is actually in Git sources.  Is it the best way to refer to
>> such files?
> 
> Well, I could add a github.com link but I don't think everyone
> would like that. What would you suggest?

Sorry, I wasn't clear.  What I meant is if "<file> located in the
Git core repository" is the best way to refer to such files, and
if we could do better.

But I think it is all right as it is.

Later we might want to provide some example filter.<driver>.process
filters e.g. in contrib/.  But that's for the future.
 
>>> +
>>> +Please note that you cannot use an existing filter.<driver>.clean
>>> +or filter.<driver>.smudge command as filter.<driver>.process
>>> +command. As soon as Git would detect a file that needs to be
>>> +processed by this filter, it would stop responding.
>>
>> This isn't.
> 
> Would that be better?
> 
> 
> Please note that you cannot use an existing `filter.<driver>.clean`
> or `filter.<driver>.smudge` command as `filter.<driver>.process`
> command because the former two use a different inter process 
> communication protocol than the latter one. As soon as Git would detect 
> a file that needs to be processed by such an invalid "process" filter, 
> it would wait for a proper protocol handshake and appear "hanging".

This is better.

-- 
Jakub Narębski

