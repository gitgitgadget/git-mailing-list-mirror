Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6531C203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbcG0TJO (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:09:14 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37433 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbcG0TJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:09:10 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so76242809wmg.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 12:09:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Qi11yvhx15HIOIo1dcqiVHZ7k2k6h7ZCM30+fLa92jg=;
        b=j3K4CNbtljEH28IDmJz10X7IHE0xRGaY6eZMnM+tCVrHIND70cDY7ksM0ZapqKqVgl
         rMPWoQvktyHZzUsjLqTSSnSk5iG/ImlaFH9G64sHxCfQGTurmvp/ijo7051oznGDYTiA
         jebgdyC4moyajaYgLgG605th2+GX/eU1UOQRK8qhHrLqU2mPa18hURPtZchz4ur4Vtpd
         Y6xtXEB5ptJeycalioAa0FPxF83MTdjuI6OksX8qajH6yWouBaKj0pyMsStXAUIOfChB
         3U7hj7k50gZbzh7L4GpzPvPCzUwm1ZBwg0LXkAbTorDBtl5t4f31W+3eOwzItCzvDmXO
         fVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Qi11yvhx15HIOIo1dcqiVHZ7k2k6h7ZCM30+fLa92jg=;
        b=HeKZMhSOHh2gpPdY/Qeh2BJS2t7DRW8F/OQFtoMflkqQ0Z51Tp3ttcrTzpxQcAS8HY
         Y/7GgE+eH6I0Jb6jlR1eZo4jxZcEAG4+b63/14BOorEQGFToToeAnLarqMdL5p+XvdFT
         ji/oT/I2v2+3LRrsOcYh61hG2ujjhSXq5RfUlPR35mISItlAbH1PDDKuz+JuhaZuXChE
         poPGzs5HIeh5m5ROAL/7gUNHZPQFo6EvDD5zcxVIbJnFAy2zJn7SjXFXoKu4BqNlnGvH
         iK915n3G2U7SLUwuVrHg5yjlb0iBxAMLaDN/Ovo2BNPG41fZL3hxItu8BqCauQFxKS0e
         9wFg==
X-Gm-Message-State: AEkoout03PoYipX52nKH0n5xpVyM/XcQcy5e8tx9MBDKNU5n4TzsKIykNFgTCBzsIKjYcw==
X-Received: by 10.194.40.166 with SMTP id y6mr29022311wjk.171.1469646549024;
        Wed, 27 Jul 2016 12:09:09 -0700 (PDT)
Received: from [192.168.1.26] (epw206.neoplus.adsl.tpnet.pl. [83.20.64.206])
        by smtp.googlemail.com with ESMTPSA id c139sm39738662wme.4.2016.07.27.12.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 12:09:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Git filter protocol
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579906C5.1050809@gmail.com>
Date:	Wed, 27 Jul 2016 21:08:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160727000605.49982-1-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Hi,
> 
> thanks a lot for the extensive reviews. I tried to address all mentioned
> concerns and summarized them below. The most prominent changes since v1 are
> the following:
> * Git offers a number of filter capabilities that a filter can request
>   (right now only "smudge" and "clean" - in the future maybe "cleanFromFile",
>   "smudgeToFile", and/or "stream")
> * pipe communication uses a packet format (pkt-line) based protocol

I wonder if it would make sense to support both whole-file pipe communication,
and packet format (pkt-line) pipe communication.

The problem with whole-file pipe communication (original proposal for
new filter protocol is that it needs file size upfront.  For some types
of filters it is not a problem:
 - if a filtered file has the same size as original, like for rot13
   example in the test for the feature
 - if you can calculate the resulting file size from original size,
   like for most if not all encryption formats (that includes GPG,
   uudecode, base64, quoted-printable, hex, etc.); same for decryption,
   and from converting between fixed-width encodings
 - if resulting file size is saved somewhere that is easy to get, like
   for LFS solutions (I think).

For other filters it is serious problem.  For example indent, keyword
expansion, rezipping with zero compression (well, maybe not this one,
but at least the reverse of it), converting between encodings where
at least one is variable width (like UTF-8),...

IMHO writing whole-file persistent filters is easier than using pkt-line.
On the other hand using pkt-line allow for more detailed progress report.

> * a long running filter application is defined with "filter.<driver>.process"

I hope that won't confuse Git users into trying to use single-shot
filters with a new protocol...

> ## Torsten:
> * add "\n" line terminator after version in init sequence
> * prepare big file for EXPENSIVE tests once
> * set "#!/usr/bin/perl" as shebang for rot13.pl to mimic other Perl test scripts
> * add test_have_prereq PERL to t0021
> 
> ## Ramsay:
> * use write_in_full(process->in, nbuf.buf, nbuf.len) to avoid unneccesary strlen call
> * use read_in_full to read data that exceeds MAX_IO_SIZE properly
> * fix test case to check for large file filtering
> 
> ## Jakub:
> * use standard input/standard output instead of stdin/stdout [in description/documentation]
> * replace global variable "cmd_process_map" with a function parameter where possible
> * avoid "strbuf_reset" after STRBUF_INIT
> * align test_config_global
> * rename rot13.pl to rot13-filter.pl
> * make Perl style consistent
> * describe hard coded filenames in test filter header
> * improve docs
> * add filter capabilities field (enables cleanToFile, smudgeFromFile, and/or stream later)
> * explain that content size in bytes is encoded in ASCII
> * consistent line ending for die call in Perl (without "\n")
> * make rot13 test filter die in case of failure (instead of returning "fail")
> 
> ## Eric:
> * flush explicitly in Perl test filter
> * do not initialize variables to NULL if they are set unconditionally
> * fix no-op stop_protocol_filter
> * use off_t instead of size_t
> * improve test filter int parsing ($filelen =~ /\A\d+\z/ or die "bad filelen: $filelen")
> 
> ## Peff:
> * use pkt-line protocol
> * do not use Perl autodie
> 
> ## Remi:
> * remove spaces after '<'


