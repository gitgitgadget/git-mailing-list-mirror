Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFF21F597
	for <e@80x24.org>; Sat, 28 Jul 2018 10:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeG1LeO (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 07:34:14 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:50475 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeG1LeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 07:34:14 -0400
Received: from [192.168.2.201] ([92.22.29.59])
        by smtp.talktalk.net with SMTP
        id jM90fBQ1XdJAejM90fMpCa; Sat, 28 Jul 2018 11:08:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532772495;
        bh=tnMGFLV5vRw12/ZkjKOycOhVlE/GJegn7+xGUVUYjbg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eFomCiWcCx47mfIuEtfKTK+SpKJeDFEveMPVTnVM4xRPdvIcoXKAYopKtXEmGOtkX
         cJbMH4eNlWDh8g89asKL4h58FKjw8QZ3n7ZXvTZKBYb8GSJo0Be/qSTZr71KFXMaiH
         oknS89goJoxPyAM0DqNqmyX+p42WPh5jGKMloQxo=
X-Originating-IP: [92.22.29.59]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=OmzqbFWWvC/aSYX+a7e/kQ==:117
 a=OmzqbFWWvC/aSYX+a7e/kQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=NEAV23lmAAAA:8 a=CaKN4qTwRLajUGutG8kA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
 <87effo5ybv.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e3d5f5a7-b173-5fa3-d007-f07013d554c8@talktalk.net>
Date:   Sat, 28 Jul 2018 11:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87effo5ybv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBDxtJrKYioCgP7nEUcMPV30z5Knj+MS5fAAXzxNs69dfEg3mAXolb98nIfBzzI7yN8hhEvbF+qE1YxprFP7/5ojUR089c/L0pbjOaC6uAI1umpzDh6+
 gp0cvBFVjlQkm8Zjo8tbIJvRiS3BrgtEedXErbiNyq6ZMzj0TQFjS9KqjQeYTFQsiWDi3koYxRvKmNtFkkhVxZJZrBI+8IPUQh/MV1shNG+f+ah77YG9E66y
 fVMH4FSp9L8FbGSiIu9lsprLDPLVNzcQz/Eyn7qO4Tr+N1FCFecHqrnLXBNM2/PTyIYnnEc3QfER+OPkD8QvaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/18 19:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 26 2018, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Unfortuantely v4 had test failures due to a suprious brace from a last
>> minute edit to a comment that I forgot to test. This version fixes
>> that, my applogies for the patch churn.
>>
>> I've updated this series based on Ævar's feedback on v3 (to paraphrase
>> stop using '$_' so much and fix staging modified lines.). The first
>> patch is functionally equivalent to the previous version but with a
>> reworked implementation. Patch 2 is new, it implements correctly
>> staging modified lines with a couple of limitations - see the commit
>> message for more details, I'm keen to get some feedback on it. Patches
>> 3 and 4 are essentially rebased and tweaked versions of patches 2 and
>> 3 from the previous version.
> 
> I was going to review this, but can't find what it's based on, I can't
> apply 1/4 to master, next or pu. It seems to be based on some older
> version of master, e.g. 1/4 has this hunk:
> 
>     +			elsif ($line =~ /^l/) {
>     +				unless ($other =~ /l/) {
>     +					error_msg __("Cannot select line by line\n");
>     +					next;
>     +				}
>     +				my $newhunk = select_lines_loop($hunk[$ix]);
>     +				if ($newhunk) {
>     +					splice @hunk, $ix, 1, $newhunk;
>     +				} else {
>     +					next;
>     +				}
>     +			}
>      			elsif ($other =~ /s/ && $line =~ /^s/) {
> 
> Which seems to conflict with your 4bdd6e7ce3 ("add -p: improve error
> messages", 2018-02-13). I could have tried to manually apply this, but
> figured I'd bounce this back to you...

Yes, I wasn't sure whether to rebase or not and in the end I didn't. The
line below where you cut the cover letter message says it is based on
f4d35a6b49 "add -p: fix counting empty context lines in edited patches".
So you could just apply it there and test it. You can fetch it with

git fetch https://github.com/phillipwood/git add-i-select-lines-v5

> Having just skimmed through the patches themselves I agree with this
> approach of handling the simple case (as discussed before) and leaving
> the rest for some future change, but let's see about the details once I
> have this running.

Thanks

Phillip


