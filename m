Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E6620401
	for <e@80x24.org>; Tue, 13 Jun 2017 01:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdFMBdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 21:33:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35891 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdFMBdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 21:33:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so15878817pgb.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1erValUGlYU5/rybyQUCi7GgQpwd3bPSWS14XTnGyQ4=;
        b=mafEUqCWvuze1CLqV5buj/R61RFClIpC/Ovfszc/Dgvz+w+/w/E6xbdBdRJ02H4/1k
         ukaNFxHBBkpTGztN+8caTvNza4N7rkReepDNua1QAsZAo4zZxU+btSusKmiMhmH5+cFf
         yLQIAUbxixw1WEwBTXMKJk6gxtuwnJpSizDfSQne/7MfZR/OXQdlDxstickCAIHyLIwt
         I06m8iFmcVU2P2oBpXtErXlr4RQhkmr57kNqQ1PqwnurYxSRmRUJqy5PemgnrqFhaUIk
         RDF7d1dHJAe+uNesRtZiIZwtWG8Yw0zra3PmLZzJvwZL6Rqo7fBVaVCMfTQlEcM43KPE
         tq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1erValUGlYU5/rybyQUCi7GgQpwd3bPSWS14XTnGyQ4=;
        b=pXAjh7uCL2GQEkVX1DN7gWXawgeACj8+RHyPZZvgf67s2WI3T4sKNnFA+LQKTkbi5d
         czrmKuWpKc1y7V6VQbB0q4X2je5pNTySMNhHJmTu0qBIU8vjR1tAM8gTfFxMMdTkCiKF
         wVaTODN6BoB7HrxACcqjowU6spQpOzJ8guGynTvJKByRxP1syhWMe5UzDWJRbxn3qyKP
         IGVZ+AnRVUVkhybLbfK/I4zrNV6Z7pogKIjm8sPp28/nC3buneU/j3a7AC79qPVXZFdD
         e+1Qsym8PurHxXCW+DJwj5ckcrF/a7IHF5a42/hJxaEk0qED8KPKjidh+GfBZBtH33XX
         Vxeg==
X-Gm-Message-State: AODbwcDeyyYzWPHueWqgx/FZl2xctAaFeoEgI7FHV6oNFUSU/EkxinzG
        OtVBUo2eaRtH1g==
X-Received: by 10.99.42.20 with SMTP id q20mr31342569pgq.175.1497317633715;
        Mon, 12 Jun 2017 18:33:53 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id 84sm19551504pfq.125.2017.06.12.18.33.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 18:33:52 -0700 (PDT)
Date:   Mon, 12 Jun 2017 18:33:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613013350.GD133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613012337.GH154599@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 06/12, Jonathan Nieder wrote:
>> Brandon Williams wrote:

>>> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
>>> not set up) added a 'git_dir' field to the config_options struct.  Let's
>>> use this option field explicitly all the time instead of occasionally
>>> falling back to calling 'git_pathdup("config")' to get the path to the
>>> local repository configuration.  This allows 'do_git_config_sequence()'
>>> to not implicitly rely on global repository state.
>>>
>>> Signed-off-by: Brandon Williams <bmwill@google.com>
[...]
>> Unlike the previous 3, this one makes me pause for a moment: it means
>> that "gitdir:" includes and .git/config discovery would stop working
>> if the caller does not remember to set git_dir in their
>> config_options.
>>
>> So we have to inspect callers.
[...]
>> nit: because of the context, this 'if' can be "if (!nongit)".
>
> Will do.

Thanks.

[...]
>>> +++ b/config.c
>>> @@ -219,8 +219,6 @@ static int include_by_gitdir(const struct config_options *opts,
>>>  
>>>  	if (opts->git_dir)
>>>  		git_dir = opts->git_dir;
>>> -	else if (have_git_dir())
>>> -		git_dir = get_git_dir();
>>>  	else
>>>  		goto done;
>>
>> I wonder if this should have a sanity-check:
>>
>> 	else if (have_git_dir())
>> 		BUG("caller forgot to set opts->git_dir");
>>
>> Alternatively, could this patch rename git_config_with_options?  That
>> way any other patch in flight that calls git_config_with_options would
>> conflict with this patch, giving us an opportunity to make sure it
>> also sets git_dir.  As another nice side benefit it would make it easy
>> for someone reading the patch to verify it didn't miss any callers.
>
> That kind of defeats the purpose of the patch.  The point is to not rely
> on global repository state and with the BUG statement we still are
> relying on global state.

By "that" are you referring to the BUG()?  I agree --- I'd prefer
renaming the function over adding a BUG() to catch mistaken old callers,
so I shouldn't have mentioned the idea.  I mentioned it to give another
example of how to make this kind of change safely.

> And I don't know if I agree with renaming a function just to rename it.

It is not renaming just to rename: this is approximately the only safe
way that the Git project has to make a significant breaking change to
the API of a function.  In a project where people push directly to the
repository in a fast-forward way, it may be possible to make such a
change by announcing it loudly and relying on patch authors keeping
track of what is happening in the repository.  But in a project like
Git that juggles multiple patches in flight, some more explicit
coordination, for example by renaming the identifier, is needed.

Sorry.

Do you have another method in mind?

Thanks,
Jonathan
