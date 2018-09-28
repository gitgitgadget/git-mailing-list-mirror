Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75331F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeI2AdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:33:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54767 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeI2AdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:33:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so3086092wmb.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XBaMzLHu5D6+rnicC/YeZhdPIgMJ1HpFdcxU5yC5bRk=;
        b=cDrX/VWY6PwrcAd87hZq6AsUMA5AUcaM98f2ciFIq/oNh3bn9cn59U7NYK/3BHrWwK
         Y/qu0HeLKg5QG8qAt/xnCkxXOq++02zbsMgNTQMpL2F79yiSDZVkQPVlcYxcSSeIj5xT
         /Jh7WVsqIM3WXFPZEVMqgKLUTaChfVynSBjwMhnptQk+XBL3s5QDXWq31iO3NGLTrgGA
         Dfcdn8ubLdAlTIliFFJ4YnVvIuAHXaK32p/WppdwNE+9y5/QWqvflykBZoUGeOuytGhE
         o/Er9pqK3XLH/FFtl/112U9kYEAohFm1OtD5OUwqDe8THCOK+D52sseT3Y5peF6+PMHl
         /16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XBaMzLHu5D6+rnicC/YeZhdPIgMJ1HpFdcxU5yC5bRk=;
        b=GMRSPi6Oalhq1AUanc45Zbx36nuMo9zSK4RHbB42QQI0dt09MJuqzkVf6DKNJINJq0
         c5xkUgIVOotyFjGcMWGg/FvmI0WR1Yz8HsNa/j9Eufn7RkiCcaDjlAXOCVmPUFrkT4wy
         H4APrUi02fcYzRRWqoF8AyOC+01tu0hi91qgTf2lYxJkezGbQ/Uc/4WUIGRU5Nd2gaRg
         L6cgt/JDMayjBxYW1mP4A/qDus7NvJzGtHDiuQIQOBAVAQ9p3MLA+XHKEWRfgLy41RZH
         zpFH+zOx9FRErkffLHAevoB+fXt+9HiCNwjQvK7+cEp4VOQSJKGWLI0I9Jz95O9oVIU6
         Jprg==
X-Gm-Message-State: ABuFfojOQQHmzw6yban771gEm1fAkFP7GjOg6Og4PLjerQxxtwavpvNQ
        TcgD35fUXMKNQG3keJHSq9M=
X-Google-Smtp-Source: ACcGV61G6y26jGZH2YuJ8noFcbgN6rSo+ysdgQxWfbbH8eXrIgnHOBKPBz9g49du/9yqH7gGKX2jYQ==
X-Received: by 2002:a1c:6744:: with SMTP id b65-v6mr2654296wmc.98.1538158085924;
        Fri, 28 Sep 2018 11:08:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v10-v6sm6714037wrp.0.2018.09.28.11.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 11:08:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
References: <20180927221603.148025-1-sbeller@google.com>
        <20180927222728.GD193497@aiede.svl.corp.google.com>
Date:   Fri, 28 Sep 2018 11:08:04 -0700
In-Reply-To: <20180927222728.GD193497@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 27 Sep 2018 15:27:28 -0700")
Message-ID: <xmqqbm8hcx6j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> (dropping cc-s to my internal address that I don't use on this list
>  and to git-core@google.com which bounces)
> Hi,
>
> Stefan Beller wrote:
>
>> Internally we have rolled out this as an experiment for
>> "submodules replacing the repo tool[1]". The repo tool is described as:
>>
>>     Repo unifies Git repositories when necessary, performs uploads to the
>>     Gerrit revision control system, and automates parts of the Android
>>     development workflow. Repo is not meant to replace Git, only to make
>>     it easier to work with Git in the context of Android. The repo command
>>     is an executable Python script that you can put anywhere in your path.
> [...]
>> Submodules can also be understood as unifying Git repositories, even more,
>> in the superproject the submodules have relationships between their
>> versions, which the repo tool only provides in releases.
>>
>> The repo tool does not provide these relationships between versions, but
>> all the repositories (in case of Android think of ~1000 git repositories)
>> are put in their place without depending on each other.
>>
>> This comes with a couple of advantages and disadvantages:
>
> Thanks for describing this background.

Thanks for this.  I probably won't be reading this before other
topics, but I've often found that changes from google were lacking
the backstory to make sense of them as a coherent whole.  

For example, a patch that says "Instead of detaching at the commit
recorded in the superproject, check out the branch with the same
name, even if it points at a different commit.  Here is the write up
of what it does in the Documentation/ and code" is hard to judge
beyond checking if the code does what it claims to do and if the
docs describe what the code does---without backstory like this that
talks about how individual small pieces fit within the plan for the
whole thing, judging if that "what it claims to do" is even sensible
is impossible.
