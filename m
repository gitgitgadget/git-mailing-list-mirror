Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB3B1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfGISzz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 14:55:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43977 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGISzz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 14:55:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id n205so4942462ywb.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smfDyWf/zTF+AMJ+fnARgcPnuM8PFC7mhdFbNvGBB1A=;
        b=y8Z2sZDxAJ35RMsJmitFHkB29QA/A6Ni54stLg0S3bgZlWA/OX47TvwFqmm+/Yb9PT
         b9kziRvxX9t1nDDZY9IHkNYglZciFRbNT6qYVUa56o3gn4/EY/pytY8r2q/JAd0lpvu7
         VHP+OEUe28Kp42lw055WxQDT6xwsiVk+yhtCQxzbRTb1qECEGPWl+qiKt2XmL6cpvIL6
         wzDOQ6M4qI8blECQWIz2OPwNakqUf2ixA26OW3s+CfDKVJ44z0vyOuKqM/M1VXAN3M9/
         U2glAZAqhPzi8RrclECYLyilrAKCVY0nYNwCtZALmrMB9+jQ4qOjPDTa9FrntHVRYYTk
         JXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=smfDyWf/zTF+AMJ+fnARgcPnuM8PFC7mhdFbNvGBB1A=;
        b=f1LUPQwYr7J1qOougBNgTgdPetBJLXfT5xCpu2sOmdDQAjp+s4SenNhVCej+YBXEHE
         QhG8Tg86DKRlbTwbckOEAJLyjNzbkU6lxHsCrAhhSO0zMDINmbAnMNqqCXgygrSs3AQA
         SXVs1i4Y75HsdCznga9W0yipHlGLSqNSu9Kw/0N2QOdUmUoQUDdwgtb/vT3H4JPLfwQu
         6+GgMeaJyrMhTNEc0rdIL59kvCvhR22pB/jruVwZJk6Y48UIx5XgAivEXMBCXBi80nKj
         +ITmiBcsOduRPtXK+ZpPDvYrzyYmSnkhp/KE5lOvqv3yqtTYCV2Xe64Cw4uyhPx+E24W
         vQbQ==
X-Gm-Message-State: APjAAAWEUzMWRMX3FxPvo6IZ1gwIDN39C184Fvm6yB5ukqgaCFv6xoJQ
        PgQRjfq1EM04OHmsxUChaOTItA==
X-Google-Smtp-Source: APXvYqx6EE+i5ayOqHfkp5GcC1mBgJE+UvhiKmL8/HRUpj6YdJ76jxk+4J7ApwxBW4W3wtHeF0UxAQ==
X-Received: by 2002:a0d:fb83:: with SMTP id l125mr2837508ywf.43.1562698553866;
        Tue, 09 Jul 2019 11:55:53 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:2c87:56eb:7a09:3754])
        by smtp.gmail.com with ESMTPSA id d124sm3816389ywc.100.2019.07.09.11.55.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:55:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 9 Jul 2019 13:55:52 -0500
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting
 to update config defaults
Message-ID: <20190709185552.GA84865@TaylorsMBP6986.attlocal.net>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
 <pull.254.v3.git.gitgitgadget@gmail.com>
 <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

I'm a little bit late to the part, but I think that this is a really
interesting feature with a lot of really interesting discussion so far.

I hope you don't mind me throwing in my $.02 as well :-).

On Mon, Jul 08, 2019 at 03:22:49PM -0400, Derrick Stolee wrote:
> On 7/1/2019 10:29 AM, Derrick Stolee via GitGitGadget wrote:
> > Here is a second run at this RFC, which aims to create a "meta" config
> > setting that automatically turns on other settings according to a user's
> > willingness to trade new Git behavior or new feature risk for performance
> > benefits. The new name for the setting is "core.featureAdoptionRate" and is
> > an integer scale from 0 to 10. There will be multiple "categories" of
> > settings, and the intention is to allow more granular levels as necessary.
>
> (Adding people who contributed feedback to CC line.)
>
> It seems that this "Feature Adoption Rate" idea was too simplistic, and
> had several issues. Time to take a different stab at this direction, but
> with these clear goals in mind:
>
>  1. We want intermediate users to be able to take advantage of new config
>     options without watching every release for new config options.
>
>  2. The config name should match the general effect of the implied
>     settings.
>
>  3. There are orthogonal settings that may not apply beneficially to
>     all repos.

I think that this is a clear representation of the initial reaction I
had to the 'core.featureAdoptionRate' idea. I had drafted a response to
advance these concerns before realizing that this subsequent RFC
existed, which does a nice job highlighting the concerns that I had.

> With this in mind, I propose instead a set of "feature.*" config settings
> that form groups of "community recommended" settings (with some caveats).
> In the space below, I'll list a set of possible feature names and the
> implied config options.

I think that 'feature.*' configuration settings are a good idea. They
address each of the above (3) concerns, since they are:

  1. Can be easily adopted by even novice-level users. Perhaps
     novice-users will not be setting 'feature.manyFiles = 1', but they
     can easily opt-in to organization-level features that have been
     defined to handle organization-specific concerns.

  2. This one is straightforward: I think that setting
     'feature.manyFiles = 1' is clearer than 'feature.adoptionRate = 3'.

  3. Right. Windows developers may have a different set of what features
     are interesting to adopt than, say, every-day users, and likewise
     for kernel developers, too.

> First, the main two categories we've discussed so far: many commits and
> many files. These two feature sets are for when your repo is large in
> one of these dimensions. Perhaps there are other settings to include
> in these?
>
> 	feature.manyFiles:
> 		index.version = 4
> 		index.threads = true
> 		core.untrackedCache = true
>
> 	feature.manyCommits:
> 		core.commitGraph = true
> 		gc.writeCommitGraph = true
> 		(future: fetch.writeSplitCommitGraph = true)

I think that for this *feature* (pun mostly unintended) to really shine,
we ought to adopt Junio's suggestion in [1] that we allow users to:

  * use pre-baked features that are defined within and shipped with
    Git itself.

  * define their own features and second-order features that can
    reference both pre-baked and user-defined feature groups.

I think that this will let, say, folks at Microsoft to define a set of
features that are interesting to Windows developers, that are separate
from the features that core Git thinks will be interesting to every-day
users.

>
> <snip>
>
> Thanks,
> -Stolee

Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqqftonsr6a.fsf@gitster-ct.c.googlers.com/
