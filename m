Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EB51F855
	for <e@80x24.org>; Sun, 31 Jul 2016 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbcGaJme (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 05:42:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36323 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcGaJmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 05:42:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so21875090wma.3
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 02:42:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JPRNJQsxaiGVjybnTtzmJ5NfDIAioMMU+AwevNzR4+A=;
        b=eipB9NKde+rUAmLYOYPucM0N8dKBq6rbXTek3fQnmHw6P3lm2PY8TqzX61eWeW5jcx
         uT5BZzVHQkwsX6mvaA5T6zwfqH6aKPmV0UP+gXH5g0VQsJchJGsu3aMz8HfXldegpgJ5
         kaMolcXZjsfSu5i4eefWztun3v3/n8coWmLvFGEdLUG3Ki0cDwvwScI0UXZJMJlYoWRw
         AGWfdOggIHiXP6+IJvrfI3D1XjzqNpWKASA9d2Yhx4Hx23V6qeQgQcbvijaPm+gpzbl2
         byv0bAHKB4LnvsI4HvYAhw5NJgNOv5b6/LV59DhRsap47P86GtOeWQpDo9tOOtT8kNsI
         W7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=JPRNJQsxaiGVjybnTtzmJ5NfDIAioMMU+AwevNzR4+A=;
        b=CknMdyA9aFVJPl05M2rYnGl3mDO/MivqJ0Toj6/fEAOd9lxDv0OHEES8KS7bn8bz+2
         yxdxh+j5FS9a2S7+0LjutEk6AGNz2iWyMwW89bJbNdR8KIaiYFTJ2XL3bY9YRRRTHlLP
         bnZRbA24eORs4UaLWKe43ISQuNuhkuhTvfHAqSsuvYhMi+BCt7Kra+52Nv52lFovCsBY
         YHHxR2rNeIrud4zwSlJbpZ3xp5q8V0p8G9TFlJxXKjH6KJiAkpwVfmAFqbWqu4e17IVL
         miWYOCbK9dr5Iazg+3DMj1TrIBv0FOga4Bp6/zq0j3y9sEVE0ETQkXp3hrIzdResDhG+
         FYSA==
X-Gm-Message-State: AEkoousBejST+aIXqYFtAAYVLotYtGcSx5e6dNVaZUCDL5lMPZJuSE4u61QPfDMsH4/jjg==
X-Received: by 10.194.61.205 with SMTP id s13mr44859799wjr.86.1469958150532;
        Sun, 31 Jul 2016 02:42:30 -0700 (PDT)
Received: from [192.168.1.26] (dad247.neoplus.adsl.tpnet.pl. [83.23.3.247])
        by smtp.googlemail.com with ESMTPSA id u72sm11426409wmf.5.2016.07.31.02.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2016 02:42:29 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <69988611-06ec-048d-12e7-7b87882ddc6a@gmail.com>
Date:	Sun, 31 Jul 2016 11:42:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[Excuse me replying to myself, but there are a few things I forgot,
 or realized only later]

W dniu 31.07.2016 o 00:05, Jakub Narębski pisze:
> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
>>
>> This patch adds the filter.<driver>.process string option which, if used,
>> keeps the external filter process running and processes all blobs with
>> the following packet format (pkt-line) based protocol over standard input
>> and standard output.
> 
> I think it would be nice to have here at least summary of the benchmarks
> you did in https://github.com/github/git-lfs/pull/1382

Note that this feature is especially useful if startup time is long,
that is if you are using an operating system with costly fork / new process
startup time like MS Windows (which you have mentioned), or writing
filter in a programming language with large startup time like Java
or Python (the latter may have changed since).

  https://gnustavo.wordpress.com/2012/06/28/programming-languages-start-up-times/

[...]
> I was thinking about having possible responses to receiving file
> contents (or starting receiving in the streaming case) to be:
> 
>   packet:          git< ok size=7\n    (or "ok 7\n", if size is known)
> 
> or
> 
>   packet:          git< ok\n           (if filter does not know size upfront)
> 
> or
> 
>   packet:          git< fail <msg>\n   (or just "fail" + packet with msg)
> 
> The last would be when filter knows upfront that it cannot perform
> the operation.  Though sending an empty file with non-"success" final
> would work as well.

[...]

>> In case the filter cannot process the content, it is expected
>> to respond with the result content size 0 (only if "stream" is
>> not defined) and a "reject" packet.
>> ------------------------
>> packet:          git< size=0\n    (omitted with capability "stream")
>> packet:          git< reject\n
>> ------------------------
> 
> This is *wrong* idea!  Empty file, with size=0, can be a perfectly
> legitimate response.  

Actually, I think I have misunderstood your intent.  If you want to have
simpler protocol, with only one place to signal errors, that is after
sending a response, then proper way of signaling the error condition
would be to send empty file and then "reject" instead of "success":

   packet:          git< size=0\n    (omitted with capability "stream")
   packet:          git< 0000        (we need this flush packet)
   packet:          git< reject\n

Otherwise in the case without size upfront (capability "stream")
file with contents "reject" would be mistaken for the "reject" packet.

See below for proposal with two places to signal errors: before sending
first byte, and after.


NOTE: there is a bit of mixed and possibly confusing notation, that
is 0000 is flush packet, not packet with 0000 as content.  Perhaps
write pkt-line in full?


[...]
>> ---
>>  Documentation/gitattributes.txt |  84 ++++++++-
>>  convert.c                       | 400 +++++++++++++++++++++++++++++++++++++--
>>  t/t0021-conversion.sh           | 405 ++++++++++++++++++++++++++++++++++++++++
>>  t/t0021/rot13-filter.pl         | 177 ++++++++++++++++++
>>  4 files changed, 1053 insertions(+), 13 deletions(-)
>>  create mode 100755 t/t0021/rot13-filter.pl

Wouldn't it be better for easier review to split it into separate patches?
Perhaps at least the new test...

[...]
> I would assume that we have two error conditions.  
> 
> First situation is when the filter knows upfront (after receiving name
> and size of file, and after receiving contents for not-streaming filters)
> that it cannot process the file (like e.g. LFS filter with artifactory
> replica/shard being a bit behind master, and not including contents of
> the file being filtered).
> 
> My proposal is to reply with "fail" _in place of_ size of reply:
> 
>    packet:         git< fail\n       (any case: size known or not, stream or not)
> 
> It could be "reject", or "error" instead of "fail".
> 
> 
> Another situation is if filter encounters error during output,
> either with streaming filter (or non-stream, but not storing whole
> input upfront) realizing in the middle of output that there is something
> wrong with input (e.g. converting between encoding, and encountering
> character that cannot be represented in output encoding), or e.g. filter
> process being killed, or network connection dropping with LFS filter, etc.
> The filter has send some packets with output already.  In this case
> filter should flush, and send "reject" or "error" packet.
> 
>    <error condition>
>    packet:         git< "0000"       (flush packet)
>    packet:         git< reject\n
> 
> Should there be a place for an error message, or would standard error
> (stderr) be used for this?

