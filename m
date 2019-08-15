Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13CD1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 13:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfHONrW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 09:47:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfHONrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 09:47:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so2288188wrt.4
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B6Vica61osdLEl/BZ2euD6K9FHkKB7+x2nBaDmYSZDc=;
        b=QymhVR59ujBLIszFpK+ulZdtL2n7fWxCwHVQfGZxRsTV/sCLe8D9Vs2AOi9Y6zZMQM
         RjQm6+MSjIFnRAU3C9N4+oxDq+ObTp+WtfGQYFWm66+Iqh9t5I/lFj/W3sAZmfJirBf9
         fKF3wfPycvSWU1n97maKEBrRHTvvC985gIlUEHJNWYJ58+mN0ep1kEvcIDO/UrvvGVLX
         flNb9CJHwOm7GTdI5I8rvqd6GroMukzE0SSLHKe5Ib0SCz7NXS2vp6pAluDYVuzRxT6I
         /L/HaEjk0rc5yQvSFsw1U5yhhkcctrDFh2OPGeMEqxR6M0lqnpxdK0kJtG3X6SjBEeah
         toLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6Vica61osdLEl/BZ2euD6K9FHkKB7+x2nBaDmYSZDc=;
        b=rYRQ95APSwhIqCQtqrJGsISPWA7sEMpoWaiVyNR8rNQjlkY87/Rsf+ys3luGZ315M4
         +ACZbYbVLY2kQl6qDV8NClPjnTi46h1VHr2f9trJslwgEFmC9ht3Mb0/GD9Ef6/hRQ7s
         aYCgtAYaSyWysVKLDhfCok4WpIeNqxBJM6yrFsRxpS9/0uyAFyr7lpi3DN/XuU1z5XsC
         a9xEyUVbIovdNjJLX0x7t7/NJofRshwjearTEougCqnpM0CP6RWJ3wU6GPmLP9XdiZCf
         54gYJyyTOC3UrbfcujCJ/d9c1LFZTa+NTwjqPhxM5jZGYKS0PFBm5PI320nzY+g5DgJB
         c2JQ==
X-Gm-Message-State: APjAAAVSzE349h4kXCY8XN1Wo8H4Jj7q2YqCctlt8QQiln6ggDu1Bq1a
        hyaCphs8sy7/fJq/m//YdSs=
X-Google-Smtp-Source: APXvYqz40zXmt9Utg792gxCaNhsovrHvp+7SBGhDqATXXQiBNoLpXoXv/RnVkFuYkCLJUHq/HvHxUQ==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr5727853wro.288.1565876839712;
        Thu, 15 Aug 2019 06:47:19 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id f24sm1195950wmc.25.2019.08.15.06.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 06:47:18 -0700 (PDT)
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190812175046.GM20404@szeder.dev>
 <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
 <20190814212036.GQ20404@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <026d6615-3420-eb31-8c93-a6245f3be503@gmail.com>
Date:   Thu, 15 Aug 2019 14:47:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814212036.GQ20404@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/2019 22:20, SZEDER Gábor wrote:
> On Mon, Aug 12, 2019 at 09:28:52PM +0100, Phillip Wood wrote:
>>> Save the updated commit message, and after the editor opens up the
>>> third commit's log message, check again where HEAD is pointing to now:
>>>
>>>    ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG
>>>    third
>>>    ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
>>>    c3db735 (HEAD) second - updated
>>
>> As second has been updated the sequencer cannot fast-forward to third so it
>> cherry-picks third and then passes --edit when it runs 'git commit' to
>> commit the cherry-pick. HEAD is updated once the reworded commit has been
>> created.
>>
>> I think the scripted rebase always ran cherry-pick and then ran 'commit
>> --amend' afterwards if the commit was being reworded. The C implementation
>> is more efficient as it avoids creating an redundant commit but has the side
>> effect that HEAD is not updated before the reword which was surprising here.
> 
> I'm not sure about this more efficient thing.  I mean, 'git rebase' is
> about to launch the editor to let the user type something...  Compared
> to that the time spent in creating an extra commit object is surely
> negligible.

I changed the sequencer to always commit the cherry-pick and then run 
'git commit --amend' for rewords [1]. Running

	time env GIT_EDITOR=true GIT_SEQUENCE_EDITOR='sed -i s/pick/reword/' 
../bin-wrappers/git rebase -i --root

over 100 commits I cannot see any real difference in the timings between 
master and that branch. Any difference is within the variation of the 
times of multiple runs. The change also fixes a bug when rewording a 
re-arranged root commit.

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/commits/wip/rebase-reword-update-head
