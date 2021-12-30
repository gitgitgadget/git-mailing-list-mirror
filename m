Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbhL3QT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 11:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbhL3QT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 11:19:56 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F8C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 08:19:56 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id j6so19229496ila.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j5p+8zs2BrbQfFL3JN6ZboLvkXNtiASkZPxYfXRIVnA=;
        b=bWlv3z6lz4vvuiYZo863iMOUXfvXERudisUT5SOe/TKZ0nYQwruwIyuZYyfsDGBqiN
         15ZAXD1ivyRqS+/NGXClbcKpH8YPNi1mX31/UZHuisSew2o++FD+nDwvfd8kS04im6/V
         FAdJsiHKJMWLs0l1S5MM+040HEtqpufkowXZY019mJiFB4f0dOWWlaexoqNFDwlggYU/
         UHNGDHbjwOPmsiWvOjibWtUZsG3ifO0zp0THNUNWg0tjSDVTpl8fBpnml79FadHtWATJ
         qVHw6wFRgIHIhK2SMW70vyJRXdU2sHfKIYNmpGFkhNl5OsjBkWTh0LM3Ikl7rnEotkHq
         qj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j5p+8zs2BrbQfFL3JN6ZboLvkXNtiASkZPxYfXRIVnA=;
        b=CcLevLrtJMZgT+cFKLfcV1DS6RffkAC0d4Nla7hOKPGyqS0SnAhk+LLKw3tFhZwMOJ
         bSntEi9pNyrBLjoh94m4aWH6lgjse3/+D1WPgWqYJzWiXIlSOE/SanK3vXIahjg0+oOx
         uHRU101ggpCNXUxlZuD6gGWaHo4uqX+0wpjqqnsLycaySvg/C0mjiVIWtJI18wIM6FFd
         tJbzod+vzAhNv5ZidYzTX4sBJNNqW2CMabuFI68GJ0zQgXrl1S6Of6q0pA/uqLWDmIHo
         +7k0RzaPsUtAq5mQsLf5lVX8Mu2+hyMsiOpn7zj7Z+k5FkckGEa8O31eD9srXxFZ/dJ2
         K0LQ==
X-Gm-Message-State: AOAM5323kkzK1thlVd5PoTmOG5G36QotJWD/kFuxwTdUgbg8kdyVLu7q
        ivYa6v+pnjou+76xSyEyISE=
X-Google-Smtp-Source: ABdhPJzv2YIMS3WLL9B2WvCX+4mWSV8rxbZufaAvT2cyp5gBIiGnlIH+rFe+nK2MHrraxL6uOAXHFQ==
X-Received: by 2002:a05:6e02:20e1:: with SMTP id q1mr13245532ilv.210.1640881195906;
        Thu, 30 Dec 2021 08:19:55 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id o6sm11351569iou.27.2021.12.30.08.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 08:19:55 -0800 (PST)
Message-ID: <e6728ed1-52c6-05eb-e816-a9d919d3e9d1@gmail.com>
Date:   Thu, 30 Dec 2021 10:19:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
 <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/21 7:43 AM, Derrick Stolee wrote:
>> +test_expect_failure 'sparse-checkout completes subcommand options' '
>> +	test_completion "git sparse-checkout init --" <<-\EOF &&
>> +	--cone Z
>> +	--sparse-index Z
>> +	--no-sparse-index Z
>> +	EOF
>> +
>> +	test_completion "git sparse-checkout set --" <<-\EOF &&
>> +	--stdin Z
> 
> In en/sparse-checkout-set, the 'set' subcommand learns the options
> for init, including --cone, --sparse-index, and --no-sparse-index.
> I think technically, --no-cone is in there, too.
> 
> Further, the 'reapply' subcommand learns these options in that
> series and I see you do not include that subcommand in this test.
> 
> You might want to rebase onto en/sparse-checkout-set and adjust
> these tests for the new options (plus change the next patch that
> implements the completion).
> 
Ah great point - I was going off of the sparse-checkout docs and
forgot about Elijah's changes. I will do the rebase and make your
suggested corrections in v2.
>> +	git -C sparse-checkout config index.sparse false &&
> 
> I'm guessing that the implementation actually requires this, but
> I'll take a look in the next patch. It might just be slow to expand
> the full list of directories in the sparse index case.
> 
I'll plan to remove in v2 per your comments in [1].>> +	# test tab completion
>> +	(
>> +		cd sparse-checkout &&
>> +		test_completion "git sparse-checkout set f" <<-\EOF
>> +		folder1 Z
>> +		folder1/0 Z
>> +		folder1/0/1 Z
>> +		folder2 Z
>> +		folder2/0 Z
>> +		folder3 Z
> 
> This tab-completion doing a full directory walk seems like it could
> be expensive for a large repository, but I suppose it is the only way
> to allow the following sequence:
> 
> 	fol<tab> -> folder
> 	folder1/<tab> -> folder1/0
> 	folder1/0/<tab> -> folder1/0/1
> 
> (Hopefully that makes sense.)
> 
Yes, it does.
> It would be more efficient to only go one level deep at a time, but
> that might not be possible with the tab completion mechanisms.
> 
When you say one level deep, do you mean that from the sparse-checkout
directory, tab completion would only show the following?
	
	folder1
	folder2
	folder3

-Lessley

[1]: 
https://lore.kernel.org/git/c79ccf4a-4da9-1c60-32eb-124d3fa94400@gmail.com/
