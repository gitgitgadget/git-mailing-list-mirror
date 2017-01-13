Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451C520756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdAMRup (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:50:45 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36552 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAMRuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:50:44 -0500
Received: by mail-io0-f195.google.com with SMTP id q20so6267781ioi.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MYvAeg049I8SLgxVCrlDnqNsMhcsmLEvsZy0LQFXBmM=;
        b=uRi5Q44oRTyNaHJvsqFOm/AetDsZGg8fWs0Qv9T4q4ebgPgssrZl5g4PmBzEGNFJuD
         wFPijD/93Yh5ycbxkQM5eTqvYVCH0wGxRxuIOorxtJgAvxmsqpI42HE+Str0JW5dwoE0
         tRkaXRdoY3It+WBkOEoIIoEinIV0qOTJHSMSdYGCFb0CuzUGvxwJeMYHieI26LdmIPDJ
         TPiG3iK1piQ71INc8P7ZoXhPHYiTSmKP8HJdLEBPznjKGJz1bp5l9DEq3iPjX5WFA8Ib
         WjsBgSSe00461Y9/ohX9oTEXhaaug1WFs2e9MuG6ON6Rz09Fz5vGBdaSLecCg4vBrTxt
         K7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MYvAeg049I8SLgxVCrlDnqNsMhcsmLEvsZy0LQFXBmM=;
        b=IEgFCpScb5pj+K/+84oxcGblXytTptN5PwaCakL3ytN//QfLCC1CDKmiofGVdAdKOJ
         wSNJsQKfrIGWzB8HWMLBxxCz27pEqCBf+xXmS8gdNH+P6T8ZmmPkPkhJUh9RdJIy5SMM
         xsBogS49crADjDrEzr/Ai222BSWVmPY8bv+GAdHieO7JtLNIRCvk9Ho1UH4vSh25WlaV
         XGh5zuXJn8lIjh0Kn0jKyuao5/uyfpf+TKhqAd9leYC0Ih9Lris6lkIwJ2i0Wn6HgYX3
         bw7bLaXAupdCASn+3iZvqlr/4JgfwWReNgTNA4VOCUsPDdedK4Z+EIWJDTMoiTKJFcOg
         l2Og==
X-Gm-Message-State: AIkVDXKq/XGKzhFf8RmRUNgd2ZWtoydXjRUQ7fb4K2x/RoUWbX48OzvU5Y3xcXi6HzNopQ==
X-Received: by 10.107.174.219 with SMTP id n88mr15990223ioo.132.1484329790369;
        Fri, 13 Jan 2017 09:49:50 -0800 (PST)
Received: from [192.168.1.180] (h69-129-206-25.mdsnwi.broadband.dynamic.tds.net. [69.129.206.25])
        by smtp.gmail.com with ESMTPSA id g186sm1230362itb.4.2017.01.13.09.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 09:49:49 -0800 (PST)
Subject: Re: [RFC/PATCH 0/4] working tree operations: support superprefix
To:     sbeller@google.com
References: <20170110014542.19352-1-sbeller@google.com>
 <152c0fbf-084c-847f-2a30-a45ea3dd26f2@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, novalis@novalis.org
From:   "Brian J. Davis" <bitminer@gmail.com>
Message-ID: <295f0f45-e5ba-f6fd-57e4-6bf684617f13@gmail.com>
Date:   Fri, 13 Jan 2017 11:56:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <152c0fbf-084c-847f-2a30-a45ea3dd26f2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending original as plain text as git@verger.kernel.org rejected HTML 
encoding as potential virus.  Apologies for dupes in inbox. Hopefully 
this works.

In response to a post at:

https://groups.google.com/forum/#!topic/git-users/BVLcKHhSUKo

I was asked to post here to explain a potential problem with current 
modules implementation.  Apologies if I am posting in the wrong place... 
so good bad or otherwise here goes:

+-------------------------------
With:

git push origin branchname

or

git push server2 branchname

I can push or pull from multiple servers so no problem as git supports this.

Now the problem with use of submodules

submodules are listed:

submodule.directory_to_
checkout/proj1_dir.url=https://git.someserver1/git/proj1_dir 
<https://git.someserver1/git/proj1_dir>

but if say I want to pull from some server 2 and do a

git submodule update --init --recursive

what I would get is from someserver1 not someserver2 as there is no 
"origin" support for submodules.  Is this correct?  If so can origin 
support be added to submodules?
+-------------------------------

So above was post from google group.  Maybe above is enough to explain 
the problem that can result, but if not here is a discussion as to why 
this can be confusing resulting to pushing or pulling from the incorrect 
server.

Lets say projects starts at origin on https://server0.org. Project is 
then brought in house to server https://indhouse.corp by developer A.

Developer A then changes the submodule projects to point to indhouse and 
changes submodules in super project to point to indhouse so everything 
is great.

Then Developer B clones from indhouse makes changes to submodule1 and 
submodule1 and pushes them to indhouse.  Dev A tells Dev B hey thoes 
changes are great why don't you push to public server0 so every one can 
get thoes changes.  Dev B then git push origin branch_name on submodule1 
and push origin on submodule 2 and superproject.  And everything is 
great ... right?

Yes by now those who know git know what dev B  forgot or more to the 
point what git does not support in a "clean" way.  For those who don't 
enter the life of dev C

So dev C clones from server0 and performs a git submodule update --init 
--recursive.  Now Dev C is on the www and can't see indhouse.corp and 
... kerpow... Dev B and Dev C just experienced one of the many SW mines 
on the battlefield.

I ask that git devs first see if I am correct with this assessment as I 
could be wrong... maybe there is a way of doing this... and if not add a 
feature to git to handle submodules and multiple origins cleanly.... and 
yes beating dev B with rubber chicken might be a solution though I am 
looking for a slightly better option.
