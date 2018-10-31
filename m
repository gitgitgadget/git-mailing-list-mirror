Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C3C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 10:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeJaTMB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 15:12:01 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:51875 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeJaTMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 15:12:01 -0400
Received: from [192.168.2.201] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HnW8gXoUnpXFjHnW9gCXoR; Wed, 31 Oct 2018 10:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540980870;
        bh=krtLUfWxUbDjL6XkgCfIRPFitJ0Mgs4ihIOOD1bwBkg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AbnukrmBbOVdh9FoW03l4qj93Eob/ApNU4koNttwfw9W3TgzYPGkN3BUisX1V582+
         P9/69o85MlqQ7ZDSW5Uaha8MESrDVG2U1Z4z+Xz3ZV5nABVOQ8I7i+j0inqIa/SKNo
         269eyvQzFNpGEliz7ePABrzcQS77K5wdW5BboYXk=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=Zxutbm4hZRnDf5dgABkA:9 a=pM1rdDucQ3Nm50mX:21
 a=ek73acu41ZVITykL:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/5] am/rebase: share read_author_script()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181030103916.6241-1-phillip.wood@talktalk.net>
 <xmqqbm7azv5r.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5f778c2b-6344-32be-91d1-65c50860032a@talktalk.net>
Date:   Wed, 31 Oct 2018 10:14:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm7azv5r.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ2J1JKASGw74Tm0Tz9iNJflIWS36CtlmkBeOzV61GQHDCIgkVmWyE8Q9l1TcwlKQRY5AxWUOmGuWaVWTfHxCG/6qI4rZJ8fjgpD6mLtWay3bw3giYol
 jEWLW5lNbOefHaWwss1UxMph+2Zq4TCyD68SAcPvqDp1nm2cSXNakan/cYsVS/teotMBOGGEPHjzSfWikEjvaDHIBeoDMVFj0lD5gzWNzbqj6lu8SJfslYMX
 aRR/kU2xZZ2FkasGRew2i2ScwKXXn8EORmBRGLHtpmqDHkWD5DD+ZWf4KWNH38mwzPsI+vk1/8MILqUUzuz1qA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/10/2018 02:50, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Thanks to Junio for the feedback on v2. I've updated patch 4 based on
>> those comments, the rest are unchanged.
> 
> Hmph, all these five patches seem to be identical to what I have in
> 'pu'.  Did you send the right version?

Oh dear that's embarrassing. I updated the patches on my laptop and
forget to sync before sending them from my desktop. I'll send v4 now.

Sorry for the confusion

Phillip

> 
>> v1 cover letter:
>>
>> This is a follow up to pw/rebase-i-author-script-fix, it reduces code
>> duplication and improves rebase's parsing of the author script. After
>> this I'll do another series to share the code to write the author
>> script.
>>
>> Phillip Wood (5):
>>   am: don't die in read_author_script()
>>   am: improve author-script error reporting
>>   am: rename read_author_script()
>>   add read_author_script() to libgit
>>   sequencer: use read_author_script()
>>
>>  builtin/am.c |  60 ++--------------
>>  sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
>>  sequencer.h  |   3 +
>>  3 files changed, 128 insertions(+), 127 deletions(-)

