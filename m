Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1B61F858
	for <e@80x24.org>; Sun, 31 Jul 2016 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcGaTtL (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 15:49:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35573 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcGaTtI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 15:49:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so23436234wmg.2
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 12:49:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5ro5CK7QSKiSSXVNWRBuUOj5LQWPiSV29Xnym1ZVJ7I=;
        b=RnIjaLjzxa2yT2VqIvKOKOJe89mPGNz8Ohe8GE/PAgOLqaap3M8aMHfa+M3WP4FrE1
         HGl6Ojg1wzYyzb/aHSU3UfYQVdX34lLmc/cPylwg+M+K4NMYiDxZl08aOi0Z80oQC3Sj
         FeXJDj2XcssWccCTAoTtV+ipNGAjTIXKUubBmPku2/xsoWv54IPpbgP5U3P72Pm2lxuk
         Zvkyf7dkgQuxCUASswDbSfNaFrw7mEIwU0WPM6G7+zExiAQeYOwyldghi1WUj4lZDNoV
         LT7+wimLysC/uMRuWe7iKdZ8F7yyn74QK7ZExbW8Rf/wfAvGEJZS7AY1ZJeXaLAYR13l
         dywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5ro5CK7QSKiSSXVNWRBuUOj5LQWPiSV29Xnym1ZVJ7I=;
        b=Cb85mP/ll24Iff+VSmJxFWxI6mlplqqdMFYBCi8Dt8Ma9gClwWx4JxQXRMzhoLqD3B
         9o+aWfvggVaIc0FkeRlP5gmumHTL3TUQxdLA+kk3ih6t2LDhgP+2hmw8X8ZYNdg+cI6A
         X6BTa1ij6pqRtw7NAZcy9cGdRD7+ZrmmymnSLjP/DZLsWMlSsuMt2ZbOlzqRxOuD+5fm
         BsO+lRroVoqJH6M1vng+Vk0ve7Vv1jMv/838veJ7K4aBwolHkPqPFDnOAdH24SkBb7dd
         21Qtem6vE8fA/mpBgICcBuyxx0KyTsiu27G8vX2zn9TgGKek2M7+qlA4c2ExNuyG8LpR
         iKYQ==
X-Gm-Message-State: AEkoouuJSZ6VfVLTVGziCa9OTf89Pa7W24JMAhkDMrXYDLHOsX6NDfy6BpOXyzcHZV5VnA==
X-Received: by 10.194.176.165 with SMTP id cj5mr21175476wjc.82.1469994546382;
        Sun, 31 Jul 2016 12:49:06 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4D55.dip0.t-ipconnect.de. [93.219.77.85])
        by smtp.gmail.com with ESMTPSA id t188sm13460537wme.19.2016.07.31.12.49.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jul 2016 12:49:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <69988611-06ec-048d-12e7-7b87882ddc6a@gmail.com>
Date:	Sun, 31 Jul 2016 21:49:04 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <6765D972-876A-4F94-A170-468002498296@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com> <69988611-06ec-048d-12e7-7b87882ddc6a@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 31 Jul 2016, at 11:42, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> [Excuse me replying to myself, but there are a few things I forgot,
> or realized only later]

No worries :)

> 
> W dniu 31.07.2016 o 00:05, Jakub Narębski pisze:
>> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Git's clean/smudge mechanism invokes an external filter process for every
>>> single blob that is affected by a filter. If Git filters a lot of blobs
>>> then the startup time of the external filter processes can become a
>>> significant part of the overall Git execution time.
>>> 
>>> This patch adds the filter.<driver>.process string option which, if used,
>>> keeps the external filter process running and processes all blobs with
>>> the following packet format (pkt-line) based protocol over standard input
>>> and standard output.
>> 
>> I think it would be nice to have here at least summary of the benchmarks
>> you did in https://github.com/github/git-lfs/pull/1382
> 
> Note that this feature is especially useful if startup time is long,
> that is if you are using an operating system with costly fork / new process
> startup time like MS Windows (which you have mentioned), or writing
> filter in a programming language with large startup time like Java
> or Python (the latter may have changed since).
> 
>  https://gnustavo.wordpress.com/2012/06/28/programming-languages-start-up-times/

OK, I will add this. Is it OK to add the link to the commit message?
(since I don't know how long the link will be available).


> [...]
>> I was thinking about having possible responses to receiving file
>> contents (or starting receiving in the streaming case) to be:
>> 
>>  packet:          git< ok size=7\n    (or "ok 7\n", if size is known)
>> 
>> or
>> 
>>  packet:          git< ok\n           (if filter does not know size upfront)
>> 
>> or
>> 
>>  packet:          git< fail <msg>\n   (or just "fail" + packet with msg)
>> 
>> The last would be when filter knows upfront that it cannot perform
>> the operation.  Though sending an empty file with non-"success" final
>> would work as well.
> 
> [...]
> 
>>> In case the filter cannot process the content, it is expected
>>> to respond with the result content size 0 (only if "stream" is
>>> not defined) and a "reject" packet.
>>> ------------------------
>>> packet:          git< size=0\n    (omitted with capability "stream")
>>> packet:          git< reject\n
>>> ------------------------
>> 
>> This is *wrong* idea!  Empty file, with size=0, can be a perfectly
>> legitimate response.  
> 
> Actually, I think I have misunderstood your intent.  If you want to have
> simpler protocol, with only one place to signal errors, that is after
> sending a response, then proper way of signaling the error condition
> would be to send empty file and then "reject" instead of "success":
> 
>   packet:          git< size=0\n    (omitted with capability "stream")
>   packet:          git< 0000        (we need this flush packet)
>   packet:          git< reject\n
> 
> Otherwise in the case without size upfront (capability "stream")
> file with contents "reject" would be mistaken for the "reject" packet.
> 
> See below for proposal with two places to signal errors: before sending
> first byte, and after.

Right now the protocol is implemented covering the following cases:

## CASE 1 - no stream success

packet:          git< size=57\n
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< success\n


## CASE 2 - no stream success but 0 byte response

packet:          git< size=0\n
packet:          git< success\n


## CASE 3 - no stream filter; filter doesn't want to process the file

packet:          git< size=0\n
packet:          git< reject\n


## CASE 4 - no stream filter; filter error

packet:          git< size=57\n
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< error\n

CASE 4 is not explicitly checked. If a final message is neither
"success" nor "reject" then it is interpreted as error. If that
happens then Git will shutdown and restart the filter process
if there is another file to filter. 

Alternatively a filter process can shutdown itself, too, to signal
an error.

The corresponding stream filter look like this:

## CASE 1 - stream success

packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< success\n


## CASE 2 - stream success but 0 byte response

packet:          git< 0000
packet:          git< success\n


## CASE 3 - stream filter; filter doesn't want to process the file

packet:          git< 0000
packet:          git< reject\n


## CASE 4 - stream filter; filter error

packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< error\n

--

I just realized that the size 0 case is a bit inconsistent
in the no stream case as it has no flush packet. Maybe I 
should indeed remove the flush packet in the no stream case
completely?!

Do the cases above make sense to you?

Regarding error handling. I would prefer it if the filter prints
all errors to STDERR by itself. I think that is the safest
option to communicate errors to the users because if the communication
got into a bad state then Git might not be able to read the errors
properly.

See Peff's response on the topic, too:
http://public-inbox.org/git/20160729165018.GA6553%40sigill.intra.peff.net/


> NOTE: there is a bit of mixed and possibly confusing notation, that
> is 0000 is flush packet, not packet with 0000 as content.  Perhaps
> write pkt-line in full?

I am not sure I understand what you mean (maybe it's too late for me...).
Can you try to rephrase or give an example?

Thank you,
Lars



> 
> 
> [...]
>>> ---
>>> Documentation/gitattributes.txt |  84 ++++++++-
>>> convert.c                       | 400 +++++++++++++++++++++++++++++++++++++--
>>> t/t0021-conversion.sh           | 405 ++++++++++++++++++++++++++++++++++++++++
>>> t/t0021/rot13-filter.pl         | 177 ++++++++++++++++++
>>> 4 files changed, 1053 insertions(+), 13 deletions(-)
>>> create mode 100755 t/t0021/rot13-filter.pl
> 
> Wouldn't it be better for easier review to split it into separate patches?
> Perhaps at least the new test...
> 
> [...]
>> I would assume that we have two error conditions.  
>> 
>> First situation is when the filter knows upfront (after receiving name
>> and size of file, and after receiving contents for not-streaming filters)
>> that it cannot process the file (like e.g. LFS filter with artifactory
>> replica/shard being a bit behind master, and not including contents of
>> the file being filtered).
>> 
>> My proposal is to reply with "fail" _in place of_ size of reply:
>> 
>>   packet:         git< fail\n       (any case: size known or not, stream or not)
>> 
>> It could be "reject", or "error" instead of "fail".
>> 
>> 
>> Another situation is if filter encounters error during output,
>> either with streaming filter (or non-stream, but not storing whole
>> input upfront) realizing in the middle of output that there is something
>> wrong with input (e.g. converting between encoding, and encountering
>> character that cannot be represented in output encoding), or e.g. filter
>> process being killed, or network connection dropping with LFS filter, etc.
>> The filter has send some packets with output already.  In this case
>> filter should flush, and send "reject" or "error" packet.
>> 
>>   <error condition>
>>   packet:         git< "0000"       (flush packet)
>>   packet:         git< reject\n
>> 
>> Should there be a place for an error message, or would standard error
>> (stderr) be used for this?
> 

