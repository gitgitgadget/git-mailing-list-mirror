Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C9D1F858
	for <e@80x24.org>; Sun, 31 Jul 2016 23:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcGaW76 (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 18:59:58 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38771 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcGaW74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 18:59:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id o80so220230022wme.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 15:59:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lQSTZxEPnfFDtBLRE4UYgEykBf5FByVgtWrXBd63shw=;
        b=CPNrepRtNx2/aC4QB9A9qvJeDFTv/9JujRUkLaIEy23HW44btrrBtGR6PCgOI9XP32
         kSb9WNv8LvVr9OwifHqzQW0/xgB1CcIyg0nW9Iw2StGMQRV4dzFqifRIf6UI4B4rGt96
         EAmlWMvJfzc0Ug1m5VHuWgT4ro9iG8cIIRxIH9/rqbjBjxBIJxw+q1x5DoRoiunOA048
         IEH/Re3MtZqGm1Rk8b5h6+A9xUEIUX3Nc1NEEHgJSgTvPDr4XJWPgaTdoT9uFsXLNR7n
         vb7nnU5kNlWM+SW85n0TjRE790tXjExDiOBsJJ6uyseUfg0JZyv4oSOfyp3IViSNzWgf
         c51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=lQSTZxEPnfFDtBLRE4UYgEykBf5FByVgtWrXBd63shw=;
        b=ZjfEaw1JweICDRsPmznv/MMYQxZW1PbDgSOnASZ5tksiid+Wg6V+EEmDJVjPno0m/3
         fQ0hfQA3a0I661utxOBY3Zaa6DMegKyoXMTbDDPi6/rGhFLZx1S90O4mAVqwTHs8Mryi
         3ICEZLgFUxCobe/82S1U5Ho55EEBHALCdnsmV75DqusbmQQ7KkWARqZdCFZktAmf5Eci
         2VpcV4wcTfBdyOkxULUTJ4bN9sCu57QVCPLTA+X+GbuziEqoRZNGzWMGS4jYWi/RulX+
         v0Xtmni/bdNXpHUIAoJ0pQvXgLrClfSLJz8Iw1wSH5lqSZb46fcQesqxCJoStH5V9UZi
         K79Q==
X-Gm-Message-State: AEkoousIxb+ilCJGcM0jpiNeYUcqZJt2OZnUWlwzukNm2eYLuZv99Yac6c5Tmy1W0F0tgQ==
X-Received: by 10.28.50.199 with SMTP id y190mr10403036wmy.61.1470005993635;
        Sun, 31 Jul 2016 15:59:53 -0700 (PDT)
Received: from [192.168.1.26] (afq96.neoplus.adsl.tpnet.pl. [83.25.146.96])
        by smtp.googlemail.com with ESMTPSA id a21sm14081357wma.10.2016.07.31.15.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2016 15:59:52 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
 <69988611-06ec-048d-12e7-7b87882ddc6a@gmail.com>
 <6765D972-876A-4F94-A170-468002498296@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <7255ef06-a9a0-91b7-b6da-a90322de926b@gmail.com>
Date:	Mon, 1 Aug 2016 00:59:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <6765D972-876A-4F94-A170-468002498296@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 31.07.2016 o 21:49, Lars Schneider pisze: 
> On 31 Jul 2016, at 11:42, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 31.07.2016 o 00:05, Jakub Narębski pisze:
>>> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
[...]
>>> I think it would be nice to have here at least summary of the benchmarks
>>> you did in https://github.com/github/git-lfs/pull/1382

This would be nice to have in the commit message: real benchmarks.

>>
>> Note that this feature is especially useful if startup time is long,
>> that is if you are using an operating system with costly fork / new process
>> startup time like MS Windows (which you have mentioned), or writing
>> filter in a programming language with large startup time like Java
>> or Python (the latter may have changed since).
>>
>>  https://gnustavo.wordpress.com/2012/06/28/programming-languages-start-up-times/
> 
> OK, I will add this. Is it OK to add the link to the commit message?
> (since I don't know how long the link will be available).

I don't think it is needed.  Perhaps only a sentence or half to notify
where you could get most from this feature, but even then it is not
necessary.

I'm sorry for the confusion.

>> See below for proposal with two places to signal errors: before sending
>> first byte, and after.
> 
> Right now the protocol is implemented covering the following cases:
> 
> ## CASE 1 - no stream success

It is less "stream", more "size unknown".  Real streaming is interleaving
reading and writing, which is currently not supported due to lack of
start_async() - I think.

> 
> packet:          git< size=57\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< success\n

Right.  What happens if either length(SMUDGED_CONTENT) < size,
or length(SMUDGED_CONTENT) > size?  It could conceivably happen,
e.g. due to an error in size calculation.

NOTE that without using flush packet to signal end of contents,
we would be not able to signal a situation when filter encounters
an error (per-file, or long temporary) when it have written some
content already.  For example this may happen for git-LFS filter,
if the server hosting artifactory (or even whole network) gets
down during cleanup / smudging.

Well, unless we would use other special packets:
 - empty packet, that is "0004" pkt-line
 - invalid packet, that is "0001", "0002", "0003" pkt-line
to signal premature end of SMUDGED_CONTENT.

> 
> 
> ## CASE 2 - no stream success but 0 byte response
> 
> packet:          git< size=0\n
> packet:          git< success\n

Why there is need to special case 0 byte (empty file) response?

  packet:          git< size=0\n
  packet:          git< 0000
  packet:          git< success\n

is perfectly fine.
  
> ## CASE 3 - no stream filter; filter doesn't want to process the file
> 
> packet:          git< size=0\n
> packet:          git< reject\n

Why not simply
 
  packet:          git< reject\n

Or, if we are going success/reject/whatever route

  packet:          git< size=0\n
  packet:          git< 0000
  packet:          git< reject\n

> ## CASE 4 - no stream filter; filter error
> 
> packet:          git< size=57\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< error\n
> 
> CASE 4 is not explicitly checked. If a final message is neither
> "success" nor "reject" then it is interpreted as error. If that
> happens then Git will shutdown and restart the filter process
> if there is another file to filter. 

This should be documented.

> 
> Alternatively a filter process can shutdown itself, too, to signal
> an error.
> 
> The corresponding stream filter look like this:
> 
> ## CASE 1 - stream success
> 
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< success\n
> 
> 
> ## CASE 2 - stream success but 0 byte response
> 
> packet:          git< 0000
> packet:          git< success\n
> 
> 
> ## CASE 3 - stream filter; filter doesn't want to process the file
> 
> packet:          git< 0000
> packet:          git< reject\n
> 
> 
> ## CASE 4 - stream filter; filter error
> 
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< error\n
> 
> --
> 
> I just realized that the size 0 case is a bit inconsistent
> in the no stream case as it has no flush packet. Maybe I 
> should indeed remove the flush packet in the no stream case
> completely?!

That's what I wrote about SPOT (single point of truth), of using
either size or flush packet, but not both.  But...

As I wrote, you need some mechanism to signal premature end
of contents, and start of an error description.

> 
> Do the cases above make sense to you?

Except for the inconsistency of the size 0 case.  This what
I meant to say.

> 
> Regarding error handling. I would prefer it if the filter prints
> all errors to STDERR by itself. I think that is the safest
> option to communicate errors to the users because if the communication
> got into a bad state then Git might not be able to read the errors
> properly.
> 
> See Peff's response on the topic, too:
> http://public-inbox.org/git/20160729165018.GA6553%40sigill.intra.peff.net/

Actually it looks like Peff is slightly against using stderr.

JK> Git-LFS sends to stderr because there's no other option. I wonder if it
JK> would be nicer to make it Git's responsibility to talk to the user,
JK> because then it could respect things like "--quiet". I guess error
JK> messages are generally printed regardless of verbosity, though, so
JK> printing them unconditionally is OK.

I think it should be O.K., and it makes writing filter drivers
simpler if we don't have multiplex channels.

>> NOTE: there is a bit of mixed and possibly confusing notation, that
>> is 0000 is flush packet, not packet with 0000 as content.  Perhaps
>> write pkt-line in full?
> 
> I am not sure I understand what you mean (maybe it's too late for me...).
> Can you try to rephrase or give an example?

Compare

  packet:          git< 0000

with

  packet:          git< success\n

The former as pkt-line is

  git< 0000

the latter is

  git< 000csuccess\n
       ^^^^
           \-- packet header

-- 
Jakub Narębski

