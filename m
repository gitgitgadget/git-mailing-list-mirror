Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261621F454
	for <e@80x24.org>; Thu, 31 Oct 2019 19:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfJaTxY (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 15:53:24 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42106 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfJaTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 15:53:23 -0400
Received: by mail-wr1-f44.google.com with SMTP id a15so7583614wrf.9
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQWoOMdPRAmEMIRlgMHjh0IvtSKJ4NakxbO/atVTkww=;
        b=joNC/fviqFgzMfmvhX/u1dSTjARwMC/Nedr4ASRWezMZAgLtlYdRC1Vh9tM5tS5YUm
         zDL3/72ER4mLu1XpaNDC5duzPvj6FbnzKE2I9q5lRfuqJh06V/9b15CBf2/EJus33fij
         DEghcyB8PSOaoub9fFiU9jSLs7gAkWKeTEujcZDPzHDAj7E7w4N7mxZ2wVKkn08eLC68
         PwnPdsWMWAdimpVSU3SUrIsKHj5ng41cAhlUzYmbifk12NrVPrZaR8hokJ4esejXFlDd
         w8REDjYNnPkVzjeU2GoQowS4V3q2dOi/+Lw3qdZjUeghiQ+2whhyVOPIkJJ0dKxUwGQf
         VqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aQWoOMdPRAmEMIRlgMHjh0IvtSKJ4NakxbO/atVTkww=;
        b=KAqqQ5PAErn4qcuTXXFp1RZGIrU78zCRkcnLMmIyK8OUV+hOOoh2npL/ssUGju3AjA
         mFvEKKxBkjKeeYuPZqIs3vvo870IKGIL1fW8KAuik54tWpYo/tGg+vSMDg0Gb1noHJUg
         h/9T0zWmRnhdiRu8yzmzMJuwUv1BwJFQibz/bGIugoRgXVqLCOrzi69/9bFUhUyM6QPn
         w6/uWL9znLqG+FJ2c/50wdXqveGyS8KqYf6+cd//y9hUTeUDMXF5NjcKNfwxD7QbZ895
         CA9gzVGdZhMixeqailh6cggiqIoLcOyAMUvlppFRObcjwfjFMKyTY3X6Tt/oEEV5RImD
         Z1Ug==
X-Gm-Message-State: APjAAAUlfqk1xYh6OihM0Ie7HGfEd/hgoCGbgPbyqM0OikcjR0kGh6M6
        90nHE1LIaHtkH9hO2y0tLrU0cnyy
X-Google-Smtp-Source: APXvYqw0r84ojXAR2FIPx5SBhnJJNPFzZ+xfs4fEMS/i31N9sbhrGVcnhLn+FJ4LZXgdQ99SfUvmqA==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr7118968wrp.282.1572551600663;
        Thu, 31 Oct 2019 12:53:20 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id d4sm6846315wrc.54.2019.10.31.12.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 12:53:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git branch --edit-description a custom file
To:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <20191031181920.GB70819@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
Date:   Thu, 31 Oct 2019 19:53:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031181920.GB70819@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton & Dscho

On 31/10/2019 18:19, Denton Liu wrote:
> Hi Dscho,
> 
> On Thu, Oct 31, 2019 at 11:22:16AM +0100, Johannes Schindelin wrote:
>> Hi Peff,
>>
>> On Thu, 31 Oct 2019, Jeff King wrote:
>>
>>> On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
>>>
>>>> On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
>>>> Dscho brought up in the GGG thread[1] that perhaps we want to treat
>>>> branch descriptions like notes and have them all under something like
>>>> `refs/notes/branches`. This would certainly solve my problem of
>>>> having versioned descriptions and it would probably do it in a much more
>>>> general way than having a versioned included config.
>>>>
>>>> Anyone see any potential problems with this approach?
>>>
>>> I don't think it would be `refs/notes/`, as that is assumed to contain
>>> mappings of object ids (and if I understand correctly, this would be a
>>> mapping of branch names to data.
>>>
>>> You could just have "refs/meta/descriptions/foo" pointing to a blob
>>> which contains the description of "refs/heads/foo". That makes it easy
>>> to edit descriptions, even if you don't like using "git branch
>>> --edit-description".
>>
>> The only problem with this is that it's not really versioned, as it
>> would be hard to go back to previous versions and/or share the history
>> via pushing to a remote repository.
>>
>> But I guess that a very simple pseudo branch would do it, where
>> `refs/meta/<branch-name>` would point to a commit that has a tree
>> with a single file in it: `description.txt`.
> 
> So how would you envision the workflow for this? Would it be something
> like,
> 
> 	$ git checkout feature-1
> 
> 	$ git branch --edit-description=ref # instead of =config

Personally I'd prefer a config setting that meant --edit-description 
stored the description in a ref instead of the current config key (or 
perhaps as well as so format-patch can just get the latest branch 
description from the config key)

> 	# editor opens up, :wq
> 
> 	# is it find to have an autogenerated commit message?
> 	$ git show refs/meta/feature-1
> 	commit 80dfea1dc4492aaabc80d23fbaffe86da55ee098 (refs/meta/feature-1)
> 	Author: Denton Liu <liu.denton@gmail.com>
> 	Date:   42 seconds ago
> 
> 	    Update ref description
> 
> 	diff --git a/description.txt b/description.txt
> 	new file mode 100644
> 	index 0000000..ed03a4b
> 	--- /dev/null
> 	+++ b/description.txt
> 	@@ -0,0 +1 @@
> 	+this is a description
> 
> I have some open questions about this, though:
> 
> * Since we're planning on sharing these descriptions with the outside
>    world, how would the ref layout look like? If we're not using the
>    refs/remotes namespace will it make fetching and merging notes harder?
>    I know that collaborating with notes is a pain so how do we avoid
>    making the same mistake?

I'd love to see a consensus around putting remote versions of refs/foo 
under refs/remote/<remote-name>/foo. To share notes I add a refspec that 
fetches to refs/remote/<remote-name>/notes. It is a pain that 'git pull' 
wont merge them for me though.

> * On the above point, what if local descriptions are at
>    refs/meta/heads/feature-1 while remote descriptions are at
>    refs/meta/remotes/*/feature-1?
> 
> * What would a merge workflow look like? Would we have wrapper commands
>    for it or do users just have to checkout the description branch
>    themselves?

Teaching 'git pull' to (configurably) merge things under 
refs/remote/<remote-name>/foo to refs/foo would be a useful addition, 
then it could merge notes and any other refs people are sharing.

Best Wishes

Phillip


> Thanks,
> 
> Denton
> 
>>
>> I now like that idea a lot better than my original notes idea.
>>
>> Ciao,
>> Dscho
