Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CEC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 02:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B085722243
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 02:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="I/8UJYta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgKCCEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:04:48 -0500
Received: from avasout02.plus.net ([212.159.14.17]:48478 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgKCCEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 21:04:48 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id ZlgjkJ04p0K1OZlgkkcFGl; Tue, 03 Nov 2020 02:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604369087; bh=I9kl4RCWX0/ZhBIhg/4e5mCO6m7mK+2mztC1KCUEzgA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I/8UJYtamAWnvaW8KyD00RZGWQYR/VpDRZaVQ6HHW+IcxseT2u+xBJrVFIkafbp2x
         ElDJX/xAJhuwvvEsscAyZEOY5cmlMJRaP5NqSExw3lYD3Up59B1PzKFwAktEebv0fz
         IgBjE3xLqLCrpIXAUHIuFF84240KyI5l1r2OF7GWiw6YB/YgAEwPH4ELNqQdzweiqQ
         MuTUSarjNDtDDxUsSyRjB+a3KImuJ5MH6+RSSnbBcHB2bRLPgjb5Zbt1lW4dm56UGW
         MlFcMozcd1LqKG+8sRITS0VVmbqpkEDxq1v6wCsVvJyB1hz3cx/Pb3GE6/fjDlvMAS
         FX48+T4J7krTg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=xfwwfTuGfYbOt6VpxPAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
 <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
 <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
 <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
Date:   Tue, 3 Nov 2020 02:04:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFZ1zhOSEY7jYL7pA59tBloaMG7oTal1qS9473Jdvw2X0YmCFO8Tf2BEbpBQ1BPzJ7yKlBGOAAvHqD2KJOfAolA+bjWySgtE91fmYTPStJCzJkmTXRAS
 w6lZESji3h7IO0jEu6QmLTOGA+SRRGWg9bzxdkFSrgfeNaef6HHzHvlqpemLiZMLvHNIMSXjnMD04w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/11/2020 18:55, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Yes, anybody who just does 'make sparse' will notice the failure, so
>> that would be a definite improvement. (How many people run 'make sparse'
>> though?).
> 
> At least, I was planning to add one to the number when I wrote the
> patch, so that I would start using it as part of daily integration
> build before pushing day's result out.

Great! :-D

How are you installing sparse? (I am using Linux Mint 20, based on
Ubuntu 20.04, whose sparse package version is 0.6.1-2build1 - which
is to say too old; you require version 0.6.2 or greater. Building
from source, I am currently using v0.6.3-76-gf680124b).

[I seem to remember you saying you used Fedora, which usually has
more up-to-date software than most distros].

>> I guess it would be most useful on a CI build, but I don't know what
>> would be involved in setting that up.
> 
> CI builds already have enough stuff around invocation of "make test"
> etc., and it would be trivial to pass SPARSE_FLAGS from the command
> line when adding "make sparse" invocation to one of the scripts in
> ci/ directory, so from that point of view, this patch is not needed
> for them, either.

My concern was more about how the CI system obtains/installs/builds a
sufficiently new version of sparse. Otherwise, 'make sparse' won't do
very much. ;-)  As I said, I don't know what's involved in getting
that to work.

ATB,
Ramsay Jones

