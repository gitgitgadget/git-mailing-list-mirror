Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04963C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390680AbiEFJo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390733AbiEFJoj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 05:44:39 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23D27149
        for <git@vger.kernel.org>; Fri,  6 May 2022 02:40:55 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nmuSC-0000zw-8H;
        Fri, 06 May 2022 10:40:52 +0100
Message-ID: <5fcf56ee-8da9-c4b0-a23f-661bbb727077@iee.email>
Date:   Fri, 6 May 2022 10:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Email External to GFS] Re: Git status extremely slow if any file
 is a multiple of 8GBi
Content-Language: en-GB
To:     Jason Hatton <jhatton@globalfinishing.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
 <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
 <9b6b7ad0-df90-62e0-abb1-c23862ded4ac@iee.email>
 <CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/2022 01:22, Jason Hatton wrote:
> I believe it would be best to only change the behavior of files that are
> multiples of 2^32 exactly. Changing the behavior of all files larger than
> 4GBi may not be good. I like the idea of using 0x80000000 instead of 1.

I think, having had a further think, that the 0x80000000 would be a
better balance as it would, as you say, only affect exact multiples of
4GiB, and fix the 'racy' confusion.

> I have a patch file, but I'm not sure how to actually submit it. I'm going to
> attempt using outlook.
>
> Jason
You maybe able to use the `git format-patch` to generate an easily
applied patch, and `git send-email` to post it to the list without
damage from outlook/gmail/whatever.

Se the bottom part of
https://public-inbox.org/git/CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com/
which has "Reply instructions:"

or just start with a simple .patch or .txt attachment (or in-line) of
the diff to get a good visual.

The full discussion about submitting patches is at
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
(and other hosts), but don't let perfect be the enemy of useful;

--
Philip


