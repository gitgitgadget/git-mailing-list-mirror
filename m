Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D67C20248
	for <e@80x24.org>; Sun,  7 Apr 2019 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDGWml (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 18:42:41 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:29157 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 18:42:41 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id DGUohSwi6gI7iDGUohT1Tj; Sun, 07 Apr 2019 23:42:39 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=c46EddwxbscEZnTfBL0A:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: git glossary --help ?
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
 <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
 <xmqqlg0mc4mk.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <3de9d8bc-f9d1-bf09-def6-71e5ed418225@iee.org>
Date:   Sun, 7 Apr 2019 23:42:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqlg0mc4mk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDKM7lT2Z1eQr+wnntQClkwiFmWYZZ/fsjzTx2rVSefdGzogazyqjOt2KopdeO2B+B9OMuVutPU4Ri5/9wI43xMqYOLEio9l0XnprkcYDpBiiweLPvKj
 kcVzCmH7VTF9lI2X2a9k+e+RH3zBHuivwMTfQcBT7mZYJASFJjZeGbCau/NLVT4Y+Wa+nbPkbi1ynm1rG2aA4/LVPIKy85RVqqcLaKcByrqgD1bVnSfoHrEP
 SFUOBMLLjBycbzjbcMJSiMpzFHmQiEhkeDkL4QvsT24=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 07/04/2019 14:43, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Phew... I didn't break anything!
>>
>> That behavior has been gone since 2c6b6d9f7d (help: make option --help
>> open man pages only for Git commands, 2016-08-26). Ralf did not
>> mention why he thought "git <concept> --help" was a bad idea. But it
>> was considered a bug by Junio [1]
>>
>> [1] https://public-inbox.org/git/CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com/
> I do not think you are reading me correctly.
>
> Yes, I do consider that "git foo --help" that does not say "there is
> no subcomand 'foo' in Git suite" is a bug.  But that is only for
> 'foo' that is clearly meant as a command.
>
> I do not imagine anybody labelling "git help glossary" as a bug.
>
> I am fairly neutral about "git glossary --help".  I personally would
> not ask git like so, as "glossary" is clearly not a command name,
> and the "--help" option is clearly meant as an option to the
> subcommand, which means that the request logically does not make
> much sense.
>
> But unlike "git foo --help", if the word that ought to name a
> subcommand instead names a known concept, e.g. "glossary", I do not
> think it is too bad if we DWIMmed what the user meant to say,
> i.e. turning "git glossary --help" into "git help glossary".
>
Given the earlier report that started the thread Duy linked, I guess 
there will need to be a balance between the two expectations.

The DWIMming  may need to both report that it's not a command, but then 
offer the concept guide as the primary target if correct, or perhaps as 
one of the alternate "commands" if closely named to a guide (e.g. 
revisions vs revision).

One of the issues back then was the lack of a complete list of 'guides' 
to check against, so the badly spelt command logic wasn't brought into play.
--
Philip
