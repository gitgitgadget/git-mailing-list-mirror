Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F57320A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 17:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdITRqS (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 13:46:18 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:49919 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdITRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 13:46:17 -0400
Received: by mail-pg0-f51.google.com with SMTP id m30so2080008pgn.6
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qutPxqIYhbBUptWi4QMCApX+hArEfjuoZJ4Mj9AuLaQ=;
        b=TqNz+ehTlUBqclMy1Z+5djqLp1/Q9QgjVSqzaFXFxdanFfMjJfFd/xP6/zpA4CcMFi
         pjTe1fI1uLN2fUEjdxwpcTlLh4KVtuZ0vqkB/Hwxza6XQvsJKMEdR2qnj4OPoH/lB0Lt
         8I1OAP2SVlIKf62HaGFtdFDlWs+rcO4bL1nbDQSxUNORWaQ9b9qJgLW86N0OrEGjiQwQ
         IVokl5P0RITyGjQxcdLdOzOx5nNi8Z4SXsAcD9YyWIm+ftGcrbTZsIVjlUhzz7XZieZ1
         1cxvmh22rV8E+AQH7pq4pn/vXUhgQjW2o88CS/bza/XhnTg3r3VTpl8Y3qKq9Wr0+Chm
         g6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qutPxqIYhbBUptWi4QMCApX+hArEfjuoZJ4Mj9AuLaQ=;
        b=hIgu8AwsREKWGcuFQRMim3WlBWj6cCe1zi7Rq4Xd1+5aFlFdzOX+xyu87oN5ih9yig
         hnBYxtxd548UnabqqeEd0w5E58E2fkSHVamQ/ZN16OIrENzgXdrOV83V0MjTcDkbY9aW
         qmawDRTMhv2IZU70eDMsHxagdr0tEiWJXXBGDu3dA+dG4TyxNkzKn1OcSH8HMF0BBtRv
         QjyfZHwdVSukuT6BIMswRz1O8yC0ZAwGnUBbW9Glvx5h/VI0Z+9Hj0wxKPbCiMNdvVn4
         Ks1TjI7c21X2uVz3g5znjCxZMsvY4wnpy+E/+jwLc5Oap1wIJXVo8peOtkBSyueF3ciM
         nKOQ==
X-Gm-Message-State: AHPjjUg5OaLBTCpJkfDo/2NudBYG2WounyM1s0Wtl48eQeLpg5MIO5jN
        6sItoWTN99N1LM7TxSILrCU=
X-Google-Smtp-Source: AOwi7QDqombLfRXJXQQVfGQWD0KbG8B77tUfXr2Wf9DKplB5crX23IDOeA9Yq67oEYwmnPt2X0V3uw==
X-Received: by 10.98.11.19 with SMTP id t19mr2955533pfi.212.1505929576572;
        Wed, 20 Sep 2017 10:46:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id x8sm8595154pff.104.2017.09.20.10.46.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 10:46:15 -0700 (PDT)
Date:   Wed, 20 Sep 2017 10:46:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, johannes.schindelin@gmx.de, pclouds@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v6 09/12] split-index: disable the fsmonitor extension
 when running the split index test
Message-ID: <20170920174613.GA27425@aiede.mtv.corp.google.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-10-benpeart@microsoft.com>
 <20170919204354.GG75068@aiede.mtv.corp.google.com>
 <43c9d3b2-2895-adcb-6f77-b6967aacf9c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c9d3b2-2895-adcb-6f77-b6967aacf9c8@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:
> On 9/19/2017 4:43 PM, Jonathan Nieder wrote:

>> This feels to me like the wrong fix.  Wouldn't it be better for the
>> test not to depend on the precise object ids?  See the "Tips for
>> Writing Tests" section in t/README:
>
> I completely agree that a better fix would be to rewrite the test to
> not hard code the SHA values.  I'm sure this will come to bite us
> again as we discuss the migration to a different SHA algorithm.

nit: the kind of change I'm proposing does not entail a full rewrite. :)

The SHA migration aspect is true, but that's actually the least of my
worries.  I intend to introduce a SHA1 test prereq that crazy tests
which want to depend on the hash function can declare a dependency on.

My actual worry is that tests hard-coding object ids are (1) hard to
understand, as illustrated by my having no clue what these particular
object ids refer to and (2) very brittle, since an object id changes
whenever a timestamp or any of the history leading to an object
changes.  They create a trap for anyone wanting to change the test
later.  They are basically change detector tests, which is generally
accepted to be a bad practice.

> That said, I think fixing this correctly is outside the scope of
> this patch series.  It has been written this way since it was
> created back in 2014 (and patched in 2015 to hard code the V4 index
> SHA).

Fair enough.

> If desired, this patch can simply be dropped from the series
> entirely as I doubt anyone other than me will attempt to run it with
> the fsmonitor extension turned on.

*shrug*

My motivations in the context of the review were:

 * now that we noticed the problem, we have an opportunity to fix it!
   (i.e. a fix would not have to be part of this series and would not
   necessarily have to be written by you)

 * if we include this non-fix, the commit message really needs to say
   something about it.  Otherwise people are likely to cargo-cult it
   in other contexts and make the problem worse.

Thanks,
Jonathan
