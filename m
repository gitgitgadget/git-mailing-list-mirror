Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383A120D14
	for <e@80x24.org>; Tue, 31 Jan 2017 07:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbdAaHqN (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 02:46:13 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35850 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdAaHqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 02:46:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id c85so248151361wmi.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 23:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EhBIA6Bl6yWsk2p3kMgz9yzfX8DiAR6IfVDG41N3qjM=;
        b=NVAByxvsVt8N/WzAaYQJVepz1dAvCORTeUgyR/qtLYhX7yzEUdKsIsqBM+lEP3THnF
         1sI7IH5mvrrMXqOxT7Vs2khoVOBWHnq+tOnqmGmqEAW+sJkR7ngfB0IBLUdZmOgItk5S
         /BnymBiZlgvzPXCaACi4HX12HzJbNpPF8qEQnf48fFiwjfyDVJOw4Uct4+vok0Hq+8jr
         PMualhm1bGWK1BheOFuiDNBBbeuXryj+twBD6BirIV9QMbxgF7PJKFPWdf38j5VHqbby
         4p4khTPp5YJ7QIETiqjLtDcfkjcvoe3v97kykaq5FWnxl/9mCLbvYrSPgv9BfwPwhKYe
         zrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EhBIA6Bl6yWsk2p3kMgz9yzfX8DiAR6IfVDG41N3qjM=;
        b=o2FGOC2WPTWZLKzm+7moTAiNqkoZWIEVc9CYN3gBvfQaNT+0MgN1x6qUMBWCGVCXv3
         LAJDBl2iYDjq/t7Xut2A08HPH3krd4JCYcKhovcUV9onBz4aWOzX3lPc4M6FGg3MTX3b
         wbEfIp25Qsi3tQY5omX7Juxi2O9g+nYKv7Ezly3gIyzYOLeVqb5U+hM+II7FHNxiOfWF
         +c3QRXUOUVS6s5tUQQJCCACKi5nmEkIdCWGMOPuvoKkVolWh6EeRklZpJdB8aq9yly8W
         XlLd1Eqcq8wOyhvwLqTINo3zdETXSK+yAZbOB1CcWJ0EHHukQRJh0qEjp0MvzOwImWwq
         3rDQ==
X-Gm-Message-State: AIkVDXI5d2JEjRF0Qw5W5uveK/xZ49IXPK7GA2hTNGUc8pXmJb8QrNbZmf/Oy/zWmuMI1Q==
X-Received: by 10.223.170.70 with SMTP id q6mr22077588wrd.103.1485848770269;
        Mon, 30 Jan 2017 23:46:10 -0800 (PST)
Received: from [192.168.141.122] (27.21.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.21.27])
        by smtp.gmail.com with ESMTPSA id 17sm26878507wru.16.2017.01.30.23.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 23:46:09 -0800 (PST)
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
To:     Brandon Williams <bmwill@google.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
 <20170130175118.GA35626@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
From:   Benjamin Schindler <beschindler@gmail.com>
Message-ID: <b614a44a-fbc6-b5fe-ae40-ccf43dd9fcfb@gmail.com>
Date:   Tue, 31 Jan 2017 08:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170130175118.GA35626@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon

I did try your suggestion, so basically:

git checkout branch
git submodule init
git submodule update

Unfortunately, I still have two entries in my git config this way. It 
seems that git submodule update only considers submodules listed in 
.gitmodules.

The background of my question is this - we have a jenkins farm which 
needs to switch branches continuously in an automated fashion and this 
needs to work even in when submodules are around. I did however, just 
now, find a reliable way to switch a branch, keeping the gitconfig in sync:
The basic workflow for switching a branch is:
git submodule deinit .
git checkout branch
git submodule init
git submodule update

Because the .git folder of the submodules are not within the submodule 
directories, this is, while still quite heavy-handed, reasonably fast 
and robust. At least it is better than deleting the entire repository 
every time a branch switch is issued.

Regards

Benjamin Schindler

On 30.01.2017 18:51, Brandon Williams wrote:
> On 01/30, Benjamin Schindler wrote:
>> Hi
>>
>> Consider the following usecase: I have the master branch where I
>> have a submodule A. I create a branch where I rename the submodule
>> to be in the directory B. After doing all of this, everything looks
>> good.
>> Now, I switch back to master. The first oddity is, that it fails to
>> remove the folder B because there are still files in there:
>>
>> bschindler@metis ~/Projects/submodule_test (testbranch) $ git
>> checkout master
>> warning: unable to rmdir other_submodule: Directory not empty
>> Switched to branch 'master'
>>
>> Git submodule deinit on B fails because the submodule is not known
>> to git anymore (after all, the folder B exists only in the other
>> branch). I can easily just remove the folder B from disk and
>> initialize the submodule A again, so all seems good.
>>
>> However, what is not good is that the submodule b is still known in
>> .git/config. This is in particular a problem for us, because I know
>> a number of tools which use git config to retrieve the submodule
>> list. Is it therefore a bug that upon branch switch, the submodule
>> gets deregistered, but its entry in .git/config remains?
>>
>> thanks a lot
>> Benjamin Schindler
>>
>> P.s. I did not subscribe to the mailing list, please add me at least
>> do CC. Thanks
> submodules and checkout don't really play nicely with each other at the
> moment.  Stefan (cc'd) is currently working on a patch series to improve
> the behavior of checkout with submodules.  Currently, if you want to
> ensure you have a good working state after a checkout you should run
> `git submodule update` to update all of the submoules.  As far as your
> submodule still being listed in the config, that should be expected
> given the scenario you described.
>
> If I'm understanding you correctly, A and B are both the same submodule
> just renamed on a different branch.  The moment you add a submoule to a
> repository it is given a name which is fixed.  Typically this is the
> path from the root of the repository.  The thing is, since you are able
> to freely move a submodule, its path can change.  To account for this
> there is the .gitmodules file which allows you to do a lookup from
> submodule name to the path at which it exists (or vice versa).  The
> submodules that are stored in .git/config are those which are
> 'initialize' or rather the submodules in which you are interested in and
> will be updated by `git submodule update`.  So given your scenario you
> should only have a single submodule in .git/config and the .gitmodules
> file should have a single entry with a differing path for each branch.
>
> Hopefully this gives you a bit more information to work with.  Since
> Stefan has been working with this more recently than me he may have some
> more input.
>

