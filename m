Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A541F461
	for <e@80x24.org>; Wed, 15 May 2019 06:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfEOGg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 02:36:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:16491 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfEOGg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 02:36:56 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QnX4hxBoKdraxQnX4hzzBn; Wed, 15 May 2019 07:36:54 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=ziHN62G_dDiyvSgrBlIA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: [PATCH] git.c: show usage for accessing the git(1) help page
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
 <20190514152450.15220-1-philipoakley@iee.org>
 <20190515001717.GA138048@google.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <78710149-4e0c-01a1-ccbf-592adadbfd08@iee.org>
Date:   Wed, 15 May 2019 07:36:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515001717.GA138048@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHzRsUDbg7I9T5O5ifc107GN1oJfgXgPRJirDUwZykO5UC15fyQs4+4Dy41a+IiJti+dcJWxPXvB9iHcW4rdWJW6hq6NNDJxh407+wncZd0UWzLy6vLc
 XUoZJVDjE8VRlhI9LAq7RNbEsHeaG3R1bN6kdSUPbE/QktPGSEAQfu7B8A6V3yVmYt1zDPdsng0dqPD7ilTxTlBygXWlPtKpUzvN8zND/urmSVGxWQFMiUze
 sJlc5ULlOW8D28XWaabvIdtVQGfXgImYQFcNjEyTUfuREgYuDxzG71Ea0HT2/APN1u+c8q5AAMpAQFs2seeiDSL0HgIJNeeUuvDBT5aXxHU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On 15/05/2019 01:17, Emily Shaffer wrote:
> On Tue, May 14, 2019 at 04:24:50PM +0100, Philip Oakley wrote:
>> It is not immediately obvious how to use the `git help` system
>> to show the git(1) page, with all its background and ccordinating
>> material, such as environment variables.
>>
>> Let's simply list it as the last few words of the last usage line.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> This follows from the discussion <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
>> ---
>>   git.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git.c b/git.c
>> index 2324ac0b7e..9a852b09c1 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -33,7 +33,7 @@ const char git_usage_string[] =
>>   const char git_more_info_string[] =
>>   	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
>>   	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
>> -	   "to read about a specific subcommand or concept.");
>> +	   "to read about a specific subcommand or concept. Or use 'git help git'.");
> I'm not sure the wording makes sense here. It sounds like you're saying,
> "Or use 'git help git' to read about specific subcommands or concepts."
> which isn't really what I think you're trying to say.
True.
>
> What about, "Or, use 'git help git' for a detailed guide of the Git
> system as a whole."
I had thought about a longer sentence, but was squeezing it in, given 
that we (I) had to add in the other parts of that help footnote...
>
> (I'm still not sure that's quite it - since `git help git` mostly
> details the flags you can pass to git before invoking a subcommand. But
> I'm not sure that `git --help` is the place to say that...)
It's more that we are updating the system's response to a misunderstood 
command, hopefully with something that includes a link to our putative 
top level man page. It's tricky to get to without already knowing it's 
there.
>
>>   
>>   static int use_pager = -1;
>>   
>> -- 
>> 2.21.0.windows.1.1517.gbad5f960a3.dirty
>>
Philip
