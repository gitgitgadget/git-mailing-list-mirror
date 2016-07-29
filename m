Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728411F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 07:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbcG2HlJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 03:41:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32865 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcG2HlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 03:41:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so14467210wme.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 00:41:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sP6o20uV1ScG7vLP/evw6DoEdIzSRJ20fPkyqJ9cKXY=;
        b=gnizKp1CYd4S6pdnkSpn9XyWqox3StR8DVrq2d0w+K9YaPKC219UOl3c3/pVB9ytZF
         V9hNqBDeupx+10tsHJm8a/XXQR66v2egm+ASlLFIsehPv7QXVzX4T1J7PmlpRtV0gtTT
         +7axli45JEHjyHTbZ9H+/lLGjxfnZIZFFZ/tboX8XryxWk4C/+Y0mbDaIB1+gZhD2YAR
         yRGUUwhPbXb2si22+QoZQgE0GsnZjL/REDdStjK4fjsH1UhRGr73XZrtJPv1Bsf/xj3y
         xT9tWFV8ihOwS1TaFuxnQ8b0AkOIvXDq471zf62ZobTfNLxqQY4mklVCVwdbyrBHzGQO
         FkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=sP6o20uV1ScG7vLP/evw6DoEdIzSRJ20fPkyqJ9cKXY=;
        b=AsY6V477gJeaB9nlG8cbJRyf2TucSO6QD0zjTFZ0YIIkZR2ocympTgnNsjJW9RTSbN
         S1BrXv1UUDLI1g2kKxuto5hfpKHTAm4CFzI0v4zGbMaJgXp1b0MCZ7RpMjLH3g19r1iZ
         /FUftiy0aYZw6wqbGI3L1LP3KJYg17bwhcZSbENB4lEa8vwTLGsKpY2ZUoj0QQjv76aA
         bvNFajwzPIoOTasB2GpTogutw4lhfFL+MAALXnntll1IfXcQiqcdyIDXLZITCDISCyql
         1p5qVNTGt0lsTVjGb3sPKRtnb8vIe77bk/5Z0SlLkbxUhz5AWwR0cSfbwgNTxSLjiwmp
         7McQ==
X-Gm-Message-State: AEkoousmE+NjIUjFSF1vFa0Mu993ZwzaHYbl9DRaz9nV93vrhOnFWPtAwmdPpJqppI3z9Q==
X-Received: by 10.28.61.11 with SMTP id k11mr43202723wma.34.1469778064754;
        Fri, 29 Jul 2016 00:41:04 -0700 (PDT)
Received: from [192.168.1.26] (ewj64.neoplus.adsl.tpnet.pl. [83.20.233.64])
        by smtp.googlemail.com with ESMTPSA id c10sm15194914wjk.22.2016.07.29.00.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2016 00:41:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Git filter protocol
To:	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <579906C5.1050809@gmail.com> <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
 <20160728132906.GA21311@sigill.intra.peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579B087F.7090108@gmail.com>
Date:	Fri, 29 Jul 2016 09:40:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160728132906.GA21311@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-28 o 15:29, Jeff King pisze:
> On Thu, Jul 28, 2016 at 09:16:18AM +0200, Lars Schneider wrote:
> 
>> But Peff ($gmane/299902), Duy, and Eric, seemed to prefer the pkt-line
>> solution (gmane is down - otherwise I would have given you the links).
> 
> FWIW, I think there are arguments for transmitting size + content
> (namely, that it is simpler); the downside is that it doesn't allow
> streaming.

And that it requires for the filter to know the size of its output
upfront (which, as I wrote, might be easy to do based on size of input
and data stored elsewhere, or might need generating whole output to
know).

I don't know how parallel Git is, but if it is parallel enough,
and other limits do not apply (limited amount of CPU cores, I/O limits),
without streaming new filter protocol might be slower, unless startup
time dominates (MS Windows?):

Current parallel:

   |   startup   | processing 1 |
    |  startup    | processing 2  |
   | startup |  processing 3 |
     |  startup  |  processing 4  |

Protocol v2:

   |  startup  | processing 1 | processing 2 | processing 3 | processing 4 |

> 
> So I think there are two viable alternatives:
> 
>   1. Total size of data in ASCII decimal, newline, then that many bytes
>      of content.
> 
>   2. No size header, then a series of pkt-lines followed by a flush
>      packet.

    3. Optional size header[2][3], then a series of pkt-lines followed
       by a flush packet[4].

[2] Git should always provide size, because it is easy to do, and
    I think quite cheap (stored with blob, stored in index, or stat()
    on file away).  Filter can provide size if it is easy to calculate,
    or approximation of size / size hint[5] - it helps to avoid
    reallocation.
[3] It is also a place where filter can pass error conditions that
    are known before starting processing a file.
[4] On one hand you need to catch cases where real size is larger than
    size sent upfront, or smaller than size sent upfront; on the
    other hand it might be a place where to send warnings and errors...
    unless we utilize stderr of a process (but then there is a problem
    of deadlocking, I think).
[5] I suggest

        <size as ascii decimal>
        "approx" SPC <size as ascii decimal>
        "unknown"
        "fail"

> And you should choose between the two based on whether it's more
> important to allow streaming, or more important to make the filter
> implementations simple[1].
> 
> Any solution that is in between those (like sending a size header and
> then using pktlines anyway) is sacrificing simplicity but not getting
> the streaming benefits.
> 
> -Peff
> 
> [1] I haven't thought hard enough about it to have a real opinion. My
>     gut says to go with the streaming, just because we've had to
>     retrofit streaming in other areas when dealing with blobs, so I
>     think we'll end up there eventually. So choosing a simpler protocol
>     like (1) would probably mean eventually implementing a next-version
>     protocol that does (2), and having to support both.
> 
> PS Jakub asked for links, but gmane is down. Here are the relevant threads:
> 
>    http://public-inbox.org/git/20160720134916.GB19359@sigill.intra.peff.net
> 
>    http://public-inbox.org/git/20160722154900.19477-1-larsxschneider%40gmail.com/t/#u
> 

