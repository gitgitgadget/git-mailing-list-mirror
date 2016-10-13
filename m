Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2134120989
	for <e@80x24.org>; Thu, 13 Oct 2016 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbcJMUgk (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 16:36:40 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:2022 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753764AbcJMUgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 16:36:36 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3sw2ZC3Rhsz5tvL
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 22:36:19 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sw2Y108gwz5tlD;
        Thu, 13 Oct 2016 22:35:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F1CA25329;
        Thu, 13 Oct 2016 22:35:15 +0200 (CEST)
Subject: Re: [PATCH v3 25/25] sequencer: mark all error messages for
 translation
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de>
 <d24a3823-1ed0-ad97-f02d-febab7a97590@kdbg.org>
 <xmqqlgxt2rch.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610131518220.197091@virtualbox>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4f283639-7cca-c62a-b8dc-5e7dbcf8315f@kdbg.org>
Date:   Thu, 13 Oct 2016 22:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610131518220.197091@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.2016 um 16:56 schrieb Johannes Schindelin:
> On Wed, 12 Oct 2016, Junio C Hamano wrote:
>> You have at least two independent changes relative to Dscho's
>> version.
>>
>>  (1) Show line breaks more prominently by avoiding "\n\n" and
>>      breaking the string at "\n"; this matches the way how the
>>      result would be displayed more closely to how the source looks
>>      like.
>>
>>  (2) Ignore the usual indentation rule and have messages start at
>>      the left end of the source.
>>
>> Which one are you saying "makes sense" to?  Both?
>>
>> I guess both can be grouped together into one theme: match the way
>> the final output and the source code look like.

Yes, that summarizes it pretty well.

> I agree with that motivation, but I decided to go about it in a way that
> is more in line with the existing source code:
>
> -- snipsnap --
> diff --git a/sequencer.c b/sequencer.c
> index 8e10bb5..1cf70f7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -483,6 +483,20 @@ static char **read_author_script(void)
>  	return env;
>  }
>
> +static const char staged_changes_advice[] =
> +N_("you have staged changes in your working tree\n"
> +"If these changes are meant to be squashed into the previous commit, run:\n"
> +"\n"
> +"  git commit --amend %s\n"
> +"\n"
> +"If they are meant to go into a new commit, run:\n"
> +"\n"
> +"  git commit %s\n"
> +"\n"
> +"In both cases, once you're done, continue with:\n"
> +"\n"
> +"  git rebase --continue\n");

Much better! Thank you.

-- Hannes

