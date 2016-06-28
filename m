Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2311FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbcF1IJM (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:09:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50124 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbcF1IJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 04:09:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5S88pKT008751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 10:08:51 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5S88qh6014590;
	Tue, 28 Jun 2016 10:08:52 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/6] doc: typeset long command-line options as literal
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
	<20160627174623.11084-2-Matthieu.Moy@imag.fr>
	<20160627190422.GC9594@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 10:08:52 +0200
In-Reply-To: <20160627190422.GC9594@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jun 2016 15:04:22 -0400")
Message-ID: <vpqr3bhzqej.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 28 Jun 2016 10:08:52 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5S88pKT008751
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467706135.4885@8v21C7aHMHSBB5mFIKSkNA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 27, 2016 at 07:46:19PM +0200, Matthieu Moy wrote:
>
>>  grep.extendedRegexp::
>> -	If set to true, enable '--extended-regexp' option by default. This
>> -	option is ignored when the `grep.patternType` option is set to a value
>> +	If set to true, enable `--extended-regexp` option by default. This
>> +	option is ignored when the 'grep.patternType' option is set to a value
>
> What's going on in the second line here? We remove the backticks from
> grep.patternType (which is not even a thing that should be touched by
> your pattern).

Nice catch. What happened was that I initially wrote the series on top
of master, then rebased it on top of tr/doc-tt to avoid conflicts when
Junio merges both. I did check that re-applying the perl substitution
was leading to the same patch, but apparently I did something wrong.

I re-rechecked, re-found this instance and no other. Fixed in v2.

>> @@ -1916,7 +1916,7 @@ log.decorate::
>>  	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
>>  	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
>>  	specified, the full ref name (including prefix) will be printed.
>> -	This is the same as the log commands '--decorate' option.
>> +	This is the same as the log commands `--decorate` option.
>
> This one conflicts applying on top of master, but the resolution is
> fairly straightforward.

Sorry, I forgot to mention when sending the series: this is to be
applied on top of tr/doc-tt (in next, marked "will merge to master").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
