Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66081F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 05:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfJKFaH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:30:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57328 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJKFaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:30:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1961F99274;
        Fri, 11 Oct 2019 01:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8AnCIkZ049QJ0HZNIJmG7ifzlM=; b=ffBxtc
        LtvkNg/C/2nHPGEvyuo0Fj481fnYhjX4x1aBQosTCzMDo9pzm3lbK9gHz2XzxIpu
        4z/Ms4U54zlf07kQCv8npAUgawcs0DLAJWRLemQWtSXC86bo5qdg1aXmlpKYp/Nc
        4xf3K1k0v6AhBUJ5IuBzsND4jbRtNX8vigdKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vTtBE3PHC1GtPhu7lFPXW/WOMAEJcrcm
        arQYOmgIMhsj8WeU9ZICgBCd0DWSrcq+odRbyj+UEHqYRrcr8jfb5LOeUpChrboj
        yJ0ggHSXwg/QmH3cn9NTCu4oH0zi2RZfO5BT275pCQN5IReVfpLi8yqd6BsIusnS
        3IHVJhm9pYE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05A1D99273;
        Fri, 11 Oct 2019 01:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC28799271;
        Fri, 11 Oct 2019 01:30:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] doc(stash): clarify the description of `save`
References: <pull.384.git.gitgitgadget@gmail.com>
        <572c7d0c51ffc68dc4603752d05fa7a418dbdd71.1570702000.git.gitgitgadget@gmail.com>
        <20191010102828.GA12497@cat>
Date:   Fri, 11 Oct 2019 14:29:59 +0900
In-Reply-To: <20191010102828.GA12497@cat> (Thomas Gummerer's message of "Thu,
        10 Oct 2019 11:28:28 +0100")
Message-ID: <xmqq36fzj1d4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C4EEF12-EBE8-11E9-BD5B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 10/10, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> The original phrasing of this paragraph made at least one person stumble
>> over the word "from" (thinking that it was a typo and "from" was
>> intended), and other readers chimed in, agreeing that it was confusing:
>> https://public-inbox.org/git/0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com/#t
>> 
>> Let's rewrite that paragraph for clarity.
>> 
>> Inspired-by-a-patch-by: Catalin Criste <cris_linu_w@yahoo.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks for picking this thread up again, I had already forgotten about
> it.  The updated wording sounds like an improvement to me.

To me too.  I would have just done s/form/become/ out of laziness
and aiming for conciseness, but the new and separate sentence is
good, too.

Thanks, both.

>
>> ---
>>  Documentation/git-stash.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
>> index 8fbe12c66c..53e1a1205d 100644
>> --- a/Documentation/git-stash.txt
>> +++ b/Documentation/git-stash.txt
>> @@ -87,8 +87,9 @@ The `--patch` option implies `--keep-index`.  You can use
>>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>>  
>>  	This option is deprecated in favour of 'git stash push'.  It
>> -	differs from "stash push" in that it cannot take pathspecs,
>> -	and any non-option arguments form the message.
>> +	differs from "stash push" in that it cannot take pathspecs.
>> +	Instead, all non-option arguments are concatenated to form the stash
>> +	message.
>>  
>>  list [<options>]::
>>  
>> -- 
>> gitgitgadget
