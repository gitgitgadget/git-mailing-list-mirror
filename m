Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09417C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiA2NSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 08:18:45 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:52802 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237017AbiA2NSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 08:18:44 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JmFJc6s4Sz5tl9;
        Sat, 29 Jan 2022 14:18:40 +0100 (CET)
Message-ID: <656d02d6-df00-bb75-584f-cf450a4f868b@kdbg.org>
Date:   Sat, 29 Jan 2022 14:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <xmqqee4rtnts.fsf@gitster.g> <f7468ea3-d9f6-96be-168d-de610d535e72@kdbg.org>
 <8789935.eFtBeim4Pn@cayenne>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <8789935.eFtBeim4Pn@cayenne>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.01.22 um 11:41 schrieb Jean-Noël AVILA:
> Le samedi 29 janvier 2022, 09:08:34 CET Johannes Sixt a écrit :
>> Am 29.01.22 um 00:58 schrieb Junio C Hamano:
>>> Also, isn't "if" in the name of the function misleading?  as far as
>>> I can tell, this function is not "check if these options are
>>> compatible and die if some are incompatible with each other", but
>>> the caller is convinced that these options are incompatible before
>>> it decides to call this function and there is no "if" in what this
>>> function can do.
>>
>> Good point.
> 
> I don't get the point: the function checks if incompatible options are present 
> on the command line and dies in such case. The caller does not know whether 
> the function will make the program die, it really depends on the result of the 
> check performed in the function. In case there's no or only one of the 
> options, the function does nothing.

The function call reads like

     die if options are incompatible

That sounds as if the caller were asking "are these options
incompatible?" But that is not what it wants to ask because it already
knows that the options are incompatible. It actually wants to ask "is
there any problem with these incompatible options?" The name Junio
suggested is die_for_incompatible_opts().

-- Hannes
