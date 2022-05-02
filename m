Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855CFC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387470AbiEBUnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387387AbiEBUnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 16:43:13 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDDDEB5
        for <git@vger.kernel.org>; Mon,  2 May 2022 13:39:42 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nlcpX-0000c4-5S;
        Mon, 02 May 2022 21:39:39 +0100
Message-ID: <225433fb-d5ae-fc92-8d50-03162e75780e@iee.email>
Date:   Mon, 2 May 2022 21:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clone: plug a miniscule leak
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
References: <xmqqlevl4ysk.fsf@gitster.g>
 <5e8eff95-d768-439d-e2df-d575a0038ffd@github.com>
 <xmqqzgjzzwnd.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqzgjzzwnd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CC'ing Elia as per the mention. Thread
https://lore.kernel.org/git/xmqqzgjzzwnd.fsf@gitster.g/t/#u.

On 02/05/2022 18:12, Junio C Hamano wrote:  <xmqqzgjzzwnd.fsf@gitster.g>
> Derrick Stolee <derrickstolee@github.com> writes:
>
>>> -	if (option_origin != NULL)
>> This technically wouldn't hit your rule, since "E" isn't just the
>> variable name, as we typically do with our style. Is that something
>> that Coccinelle automatically simplifies?
>>
>>> +	if (option_origin != NULL) {
>> Do you want to take this opportunity to drop the "!= NULL" here?
>>
>>> +		free(remote_name);
>>>  		remote_name = xstrdup(option_origin);
>>> +	}
>>>>  	if (remote_name == NULL)
>> Or do you want to keep similar style from the surrounding code?
> I think that it is better to leave that particular clean-up to
> the equals-null.cocci topic started by Elia; I know having them
> separate would cause a merge conflict, but even if I change them
> here, it will result in the same merge conflict anyway ;-)

