Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6FC201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbdEOPr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:47:58 -0400
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:59791 "EHLO
        smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933006AbdEOPr4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 May 2017 11:47:56 -0400
Received: from smtp29.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp29.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5D5A225114;
        Mon, 15 May 2017 11:47:55 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 313172519B;
        Mon, 15 May 2017 11:47:55 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 May 2017 11:47:55 -0400
Subject: Re: [PATCH] tag: duplicate mention of --contains should mention
 --no-contains
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170515122331.17348-1-avarab@gmail.com>
 <28535adf-5f8f-a43d-82e9-2ada398637e2@xiplink.com>
 <CACBZZX4VDphESS1bt8w4A2GGCnXgj3DRwQLtC+o2ngTQz9=CZA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <bf600222-757d-5b7d-7908-d08caa411eca@xiplink.com>
Date:   Mon, 15 May 2017 11:47:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4VDphESS1bt8w4A2GGCnXgj3DRwQLtC+o2ngTQz9=CZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-15 11:01 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 15, 2017 at 4:20 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> On 2017-05-15 08:23 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> Fix a duplicate mention of --contains in the SYNOPSIS to mention
>>> --no-contains.
>>>
>>> This fixes an error introduced in my commit ac3f5a3468 ("ref-filter:
>>> add --no-contains option to tag/branch/for-each-ref", 2017-03-24).
>>>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>  Documentation/git-tag.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>>> index f8a0b787f4..1eb15afa1c 100644
>>> --- a/Documentation/git-tag.txt
>>> +++ b/Documentation/git-tag.txt
>>> @@ -12,7 +12,7 @@ SYNOPSIS
>>>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>>>         <tagname> [<commit> | <object>]
>>>  'git tag' -d <tagname>...
>>> -'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
>>> +'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
>>
>>
>> I think
>>
>>         [--[no-]contains <commit>]
>>
>> is the usual pattern...
>>
>>>         [--points-at <object>] [--column[=<options>] | --no-column]
>>>         [--create-reflog] [--sort=<key>] [--format=<format>]
>>>         [--[no-]merged [<commit>]] [<pattern>...]
>>
>>
>> ... like with --[no-]merged, there.
>>
>>                 M.
>
> Thanks for the feedback, this was discussed earlier in the series and
> we decided on the current format I'm submitting here.
>
> Saying --[no-]merged is the convention we use for options where the
> two are mutually exclusive, as is the case with the --[no-]merged
> options:
>
>     $ git tag --merged v2.12.0 --no-merged v2.13.0
>     error: option `no-merged' is incompatible with --merged
>     [...]
>
> But in the case of --contains and --no-contains you can provide both:
>
>     $ git tag --contains v2.12.0 --no-contains v2.13.0 'v*'
>     v2.12.0
>     v2.12.1
>     v2.12.2
>     v2.12.3
>     v2.13.0-rc0
>     v2.13.0-rc1
>     v2.13.0-rc2
>
> So they don't use that convention, since it would imply that they're
> mutually exclusive, rather than both being optional.

Ah, thanks.  My mistake!

		M.

