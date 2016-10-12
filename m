Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189EA20989
	for <e@80x24.org>; Wed, 12 Oct 2016 10:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbcJLKyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 06:54:49 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33670 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932614AbcJLKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 06:54:47 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so3699531lfl.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6DXpSkMC8ZzYmXaVIx0lurSyIBLCvguz17JKZNbTXss=;
        b=F9FXI+mkn1f+ozRYua7FyVkhNQckFER4mT+4HXtwjkuZAYf0eTS3i7x38OoQt+LDP1
         NGKIboFvORqtSNClANQu0Ud3SYnZQuVWdzswCFQ+SYozoQLZYVvQR90Z9LfirqRci/a7
         f+SQ2+aA/ZZjD96DWpcc1wb/v0E4XIe3BjxcYdzSRMDPJ+t3uJxlggunq73Z4aU8n2rs
         SDrNJQKWiDrYey7d1EsSBP1/WwJu9wGN59V4k6ruW92bvCUlIdvwj4Hlf8ErLt3j02P0
         /WwHDI+GSEHWNuaiqqNK+OD6xV0aGbyi+RuwGpMMzfcvox/vWU6ATVWsUbp8RCNadbn4
         8zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6DXpSkMC8ZzYmXaVIx0lurSyIBLCvguz17JKZNbTXss=;
        b=PfV20Ce8QYZzcFJ7it+s2BQOXS7erdIMyUa8k/JdDZgYjljurO1uvRumMrdPyO6U0l
         JVv4ZDELE0d2oq3jfG44JrVUgsYP+ITy2fY3dwXrYkkzh5o5T3RJ/D7bAZ76Y405SAiZ
         tWpQE5fq/iRENn2LV0hY+L4JVmrjym3vG1hFJgsTHN7+EAYqDmsi38yS5SypiPEV7eNx
         qXcjjJ6iuvSpQX2gpl11qTNH78nzzvY0v70oEpDYdomV3wMEeUxhn5KJJMOD6QozKbpH
         EMqIrLSzc6J5RbUedR/NVHgIK3yQcvQIZX1x6nO2uffuzeaoh/Nl3u/gc6YeMc4SWsjZ
         d4zA==
X-Gm-Message-State: AA6/9Rld0vFfMOFXAVVjJUjWQPy+lzBfs4aeW8GUpqmPfAL5mgBXLMpRI6VLSzsw4jJPUQ==
X-Received: by 10.25.195.143 with SMTP id t137mr374076lff.96.1476269684786;
        Wed, 12 Oct 2016 03:54:44 -0700 (PDT)
Received: from [192.168.1.26] (dfa231.neoplus.adsl.tpnet.pl. [83.23.130.231])
        by smtp.googlemail.com with ESMTPSA id b188sm1965189lfg.41.2016.10.12.03.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 03:54:43 -0700 (PDT)
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
 <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
 <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <37c12539-3edd-e04b-6e09-e977a854661c@gmail.com>
Date:   Wed, 12 Oct 2016 12:54:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 12.10.2016 o 00:26, Lars Schneider pisze: 
>> On 09 Oct 2016, at 01:06, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>> Part 1 of review, starting with the protocol v2 itself.
>>
>> W dniu 08.10.2016 o 13:25, larsxschneider@gmail.com pisze:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> +upon checkin. By default these commands process only a single
>>> +blob and terminate.  If a long running `process` filter is used
>>> +in place of `clean` and/or `smudge` filters, then Git can process
>>> +all blobs with a single filter command invocation for the entire
>>> +life of a single Git command, for example `git add --all`.  See
>>> +section below for the description of the protocol used to
>>> +communicate with a `process` filter.
>>
>> I don't remember how this part looked like in previous versions
>> of this patch series, but "... is used in place of `clean` ..."
>> does not tell explicitly about the precedence of those 
>> configuration variables.  I think it should be stated explicitly
>> that `process` takes precedence over any `clean` and/or `smudge`
>> settings for the same `filter.<driver>` (regardless of whether
>> the long running `process` filter support "clean" and/or "smudge"
>> operations or not).
> 
> This is stated explicitly later on. I moved it up here:
> 
> "If a long running `process` filter is used
> in place of `clean` and/or `smudge` filters, then Git can process
> all blobs with a single filter command invocation for the entire
> life of a single Git command, for example `git add --all`. If a 
> long running `process` filter is configured then it always takes 
> precedence over a configured single blob filter. "
> 
> OK?

Looks good to me.

I think this information about precedence between one-shot `clean`
and `smudge` filter driver configuration, and multi-file `process`
filter driver should be here for two reasons.

First, if one is interested in running filter, but do not want to
write one (he or she uses existing tool, for example one of
existing LFS solutions), one can skip the "Long Running Filter
Process" section.  But one still needs to know if to remove or
comment out old `clean` and `smudge` config, or how to provide
fallback for older Git (if one uses the same configuration with
pre-process Git and Git including support for this feature).

Second, the configuration belongs, in my opinion, here.  It is
not a part of long running filter protocol.

>>> +If the filter command (a string value) is defined via
>>> +`filter.<driver>.process` then Git can process all blobs with a
>>> +single filter invocation for the entire life of a single Git
>>> +command. This is achieved by using a packet format (pkt-line,
>>> +see technical/protocol-common.txt) based protocol over standard
>>> +input and standard output as follows. All packets, except for the
>>> +"*CONTENT" packets and the "0000" flush packet, are considered
>>> +text and therefore are terminated by a LF.
>>
>> Maybe s/standard input and output/\& of filter process,/ (that is,
>> add "... of filter process," to the third sentence in the above
>> paragraph).
> 
> You mean "This is achieved by using a packet format (pkt-line,
> see technical/protocol-common.txt) based protocol over standard
> input and standard output of filter process as follows." ?

Yes.

> I think I like the original version better.

Well, I think it is better to err out on the side of being more
explicit.

> 
>>> After the filter started
>>> Git sends a welcome message ("git-filter-client"), a list of
>>> supported protocol version numbers, and a flush packet. Git expects
>>> +to read a welcome response message ("git-filter-server") and exactly
>>> +one protocol version number from the previously sent list. All further
>>> +communication will be based on the selected version. The remaining
>>> +protocol description below documents "version=2". Please note that
>>> +"version=42" in the example below does not exist and is only there
>>> +to illustrate how the protocol would look like with more than one
>>> +version.
>>> +
>>> +After the version negotiation Git sends a list of all capabilities that
>>> +it supports and a flush packet. Git expects to read a list of desired
>>> +capabilities, which must be a subset of the supported capabilities list,
>>> +and a flush packet as response:
>>> +------------------------
>>> +packet:          git> git-filter-client
>>> +packet:          git> version=2
>>> +packet:          git> version=42
>>> +packet:          git> 0000
>>> +packet:          git< git-filter-server
>>> +packet:          git< version=2
>>> +packet:          git> clean=true
>>> +packet:          git> smudge=true
>>> +packet:          git> not-yet-invented=true
>>> +packet:          git> 0000
>>> +packet:          git< clean=true
>>> +packet:          git< smudge=true
>>> +packet:          git< 0000
>>
>> WARNING: This example is different from description!!!
> 
> Can you try to explain the difference more clearly? I read it multiple
> times and I think this is sound.

I'm sorry it was *my mistake*.  I have read the example exchange wrong.

On the other hand that means that I have other comment, which I though
was addressed already in v10, namely that not all exchanges ends with
flush packet (inconsistency, and I think a bit of lack of extendability).

>> In example you have Git sending "git-filter-client" and list of supported
>> protocol versions, terminated with flush packet,
> 
> Correct.

[thinking out loud]

And this serves as a 'canary' to detect single-shot driver mis-configured
to serve as multi-file filter driver.
 
>> then filter driver
>> process sends "git-filter-server", exactly one version, *AND* list of
>> supported capabilities in "<capability>=true" format, terminated with
>> flush packet.
> 
> Correct. That's what I read in the text and in the example.

Actually, the text reads that filter driver sends two lines: a line with
magic signature "git-filter-server", and exactly one line with protocol
version "version=2", *WITHOUT* terminating flush packet.

The example reads the same, I have just missed change of prefix from
"git<" to "git>" (that is "<" to mark response from filter, to ">" to
mark signal from Git).

So the text and example agrees, just me (and now you) misread the
example ;-/


IMHO this exchange should be also terminated with a flush packet,
even if in protocol version 2 it is fixed length list, and doesn't
strictly need it.

First, it would make easier to implement the filter driver process.
You would need only one 'read until flush' helper function, and two
higher-level functions: one for handling metadata, one for handling
contents (where handling = sending or receiving).  Currently first
data send from filter is a bit of special case: you need to send
two pkt-lines, not send this list of lines and terminate with flush.

Second, it would allow for additional possibilities for new versions
and extending protocol, either 3-part handshake (but now I think that
4-part is better, at least in some cases), or some other "early start"
extension.  OTOH we could stuff this data in additional exchange
(assuming new protocol version), and unless the exchange data goes
through slow channel (e.g. network), it shouldn't matter for the
latency that we have one more exchange.

Third, as we can see first from my error, then from yours, it would
make it easier to debug the protocol...

>>
>> In description above the example you have 4-part handshake, not 3-part;
>> the filter is described to send list of supported capabilities last
>> (a subset of what Git command supports).
> 
> Part 1: Git sends a welcome message...
> Part 2: Git expects to read a welcome response message...
> Part 3: After the version negotiation Git sends a list of all capabilities...
> Part 4: Git expects to read a list of desired capabilities...
> 
> I think example and text match, no?

Yes, it does; as I have said already, I have misread the example. 

Anyway, in some cases 4-way handshake, where Git sends list of
supported capabilities first, is better.  If the protocol has
to prepare something for each of capabilities, and perhaps check
those preparation status, it can do it after Git sends what it
could need, and before it sends what it does support.

Though it looks a bit strange that client (as Git is client here)
sends its capabilities first...

>> Moreover in the example in
>> previous version at least as far as v8 of this series, the response
>> from filter driver was fixed length list of two lines: magic string
>> "git-filter-server" and exactly one line with protocol version; this
>> part was *not* terminated with a flush packet (complicating code of
>> filter driver program a bit, I think).
>>
>> I think this version of protocol is *better*, just the text needs to
>> be updated to match.  I wanted to propose something like this in v9,...
> 
> I didn't change that behavior since v8:
> packet:          git< git-filter-server
> packet:          git< version=2

Right. 

>> By the way, now I look at it, the argument for using the
>> "<capability>=true" format instead of "capability=<capability>"
>> (or "supported-command=<capability>") is weak.  The argument for
>> using "<variable>=<value>" to make it easier to implement parsing
>> is sound, but the argument for "<capability>=true" is weak.
>>
>> The argument was that with "<capability>=true" one can simply
>> parse metadata into hash / dictionary / hashmap, and choose
>> response based on that.  Hash / hashmap / associative array
>> needs different keys, so the reasoning went for "<capability>=true"
>> over "capability=<capability>"... but the filter process still
>> needs to handle lines with repeating keys, namely "version=<N>"
>> lines!
>>
>> So the argument doesn't hold water IMVHO, and we can choose
>> version which reads better / is more natural.
> 
> I have to agree that "capability=<capability>" might read a
> little bit nicer. However, Peff suggested "<capability>=true" 
> as his preference and this is absolutely OK with me.

From what I remember it was Peff stating that he thinks "<foo>=true"
is easier for parsing (it is, but we still need to support the harder
way parsing anyway), and offered that "<foo>" is good enough (if less
consistent).

> I am happy to change that if a second reviewer shares your
> opinion.

Also, with "capability=<foo>" we can be more self descriptive,
for example "supported-command=<foo>"; though "capability" is good
enough for me.

For example

 packet:          git> wants=clean
 packet:          git> wants=smudge
 packet:          git> wants=size
 packet:          git> 0000
 packet:          git< supports=clean
 packet:          git< supports=smudge
 packet:          git< 0000

Though coming up with good names is hard; and as I said "capability"
is good enough; OTOH with "smudge=true" etc. we don't need to come
up with good name at all... though I wonder if it is a good thing `\_o,_/

>>> +Afterwards Git sends a list of "key=value" pairs terminated with
>>> +a flush packet. The list will contain at least the filter command
>>> +(based on the supported capabilities) and the pathname of the file
>>> +to filter relative to the repository root. Right after these packets
>>
>> I think you meant here "right after the flush packet", isn't it?
>> It would be more explicit.
> 
> I feel "right after these packets" reads better, but I agree that your
> version is more explicit. I will change it.

Thanks.  That doesn't matter much, but it matters.

Though it could go either way.

>>>                                                     Finally, a
>>> +second list of "key=value" pairs terminated with a flush packet
>>> +is expected. The filter can change the status in the second list.
>>
>> I would add here, to be more explicit:
>>
>> This second list of "key=value" pairs may be empty, and usually
>> would be if there is nothing wrong with response or filter; the
>> terminating flush packet must be here regardless.
>>
>> Or something like that.  The above proposal could be certainly
>> improved.
> 
> How about this:
> 
> "Finally, a
> second list of "key=value" pairs terminated with a flush packet
> is expected. The filter can change the status in the second list
> or keep the status as is with an empty list. Please note that the
> empty list must be terminated with a flush packet regardless."
> 
> TBH I like the original version and I wonder if the new version
> is redundant?!

I'm a bit unsure.  Original reads better and is shorter; the new
proposal is more explicit, but also more repetitive and longer.

>>> +------------------------
>>> +packet:          git< status=success
>>> +packet:          git< 0000
>>> +packet:          git< SMUDGED_CONTENT
>>> +packet:          git< 0000
>>> +packet:          git< 0000  # empty list, keep "status=success" unchanged!
>>
>> All right, looks good.  Is this exclamation mark "!" necessary / wanted?
> 
> Yes, to draw the attention towards the two flushes.

O.K. though shouldn't it be after "empty list", then?

>>> +------------------------
>>> +
>>> +If the result content is empty then the filter is expected to respond
>>> +with a "success" status and an empty list.
>>
>> Actually, it is empty content, not empty list; that is response (filter
>> output) composed entirely of flush packet.
> 
> Correct!
> 
> "If the result content is empty then the filter is expected to respond
> with a "success" status and a flush packet to signal the empty content."
> 
> Better?

Better, I think.

>>
>>> +------------------------
>>> +packet:          git< status=error
>>> +packet:          git< 0000
>>> +------------------------
>>> +
>>> +If the filter experiences an error during processing, then it can
>>> +send the status "error" after the content was (partially or
>>> +completely) sent. Depending on the `filter.<driver>.required` flag
>>> +Git will interpret that as error but it will not stop or restart the
>>> +filter process.
>>
>> Errr... this is literal repetition.  You need to decide whether to
>> put it before example, or after example.  Or maybe split it.
> 
> Agreed. I removed the repetition and changed the previous paragraph
> to:
> 
> "In case the filter cannot or does not want to process the content,
> it is expected to respond with an "error" status. Git will handle 
> the "error" status according to the `filter.<driver>.required` flag
> but it will not stop or restart the filter process."

All right, I think. 

>>> +------------------------
>>> +packet:          git< status=success
>>> +packet:          git< 0000
>>> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>>> +packet:          git< 0000
>>> +packet:          git< status=error
>>> +packet:          git< 0000
>>> +------------------------
>>> +
>>> +If the filter dies during the communication or does not adhere to
>>> +the protocol then Git will stop the filter process and restart it
>>> +with the next file that needs to be processed. Depending on the
>>> +`filter.<driver>.required` flag Git will interpret that as error.
>>
>> Uhh... until now the order was explanation, then example.  From the
>> duplicated description above, it is now first example, then
>> description.  Consistency would be good.
> 
> OK, I moved that down after the EOF exit explanation.

Good. 
 
>>> +The error handling for all cases above mimic the behavior of
>>> +the `filter.<driver>.clean` / `filter.<driver>.smudge` error
>>> +handling.
>>
>> You have "error handling" repeated here.
> 
> True. That might not be nice from a stylistic point of view but it is
> precise, no?
 
All right, though you could also write it as "mimic what the ...
do in those cases"; I'm not sure if its better or worse.

>>> +------------------------
>>> +packet:          git< status=abort
>>> +packet:          git< 0000
>>> +------------------------
>>> +
>>> +After the filter has processed a blob it is expected to wait for
>>> +the next "key=value" list containing a command. Git will close
>>> +the command pipe on exit. The filter is expected to detect EOF
>>> +and exit gracefully on its own.
>>
>> Any "kill filter" solutions should probably be put here.
> 
> Agreed. 
> 
>> I guess
>> that filter exiting means EOF on its standard output when read
>> by Git command, isn't it?
> 
> Yes, but at this point Git is not listening anymore.

I think it might be good idea to have here the information about
what filter process should do if it needs maybe lengthy closing
process, to not hold/stop Git command or to not be killed.

>>> +If you develop your own long running filter
>>> +process then the `GIT_TRACE_PACKET` environment variables can be
>>> +very helpful for debugging (see linkgit:git[1]).
>>
>> s/environment variables/environment variable/  - there is only
>> one GIT_TRACE_PACKET.  Unless you wanted to write about GIT_TRACE?
> 
> Agreed.
> 
> 
> Thanks for the review,

You are welcome.

Thanks for working on this series,
-- 
Jakub Narębski

