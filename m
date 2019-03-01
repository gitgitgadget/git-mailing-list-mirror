Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9099C20248
	for <e@80x24.org>; Fri,  1 Mar 2019 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfCAUur (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 15:50:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34619 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAUur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 15:50:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id o10so9620081wmc.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M48I3lsH56zvIP31QWi2HDmNPM/fWu7ljcwtsyL/ZbE=;
        b=tefXroGS8hRI3IW28nlOhAO1U6TavHzuWzq3u35l81Gqbz3fCHVyZhAK6o1eAWPRiB
         9rUYggRODgU7poBVcIUWSBqCp19wvEYDqZeNbJqD3FUJaxnKMTzPveBeYZWi7DWBBXSU
         hzlUSYm7FUXClgIMHH2QovYnSH06GzZs3l35cbIbhRR679UpGJYZv6eGLS30o+XEc8BP
         /vyDxxJjq+U0FX6Ys3NO1jh1DupGVj1AuOI8kXVAg8QxNjIg41yLOreneBrpHwZ9hMDK
         p1rEPPukRGZlrgWH90bhJ9r8dxF1uXLGcYXTE3/6Vj4PWWcpXw+BLI/1oNCmEOX7zKef
         anDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M48I3lsH56zvIP31QWi2HDmNPM/fWu7ljcwtsyL/ZbE=;
        b=e2xTzgsncdZHybnlwjHuxq3b5NlgJ9FwPV6XMEl7eKrVOpzcI+mrlyZE6SF3I2dHv/
         eJwP42QK5J8Qfi5/b8t7bCZQsy1gEboV00KaIUBWsjMXol9AK89LYR4r/oHu6SPDxs/C
         ph+76Bbz7FNMhIpCC+J2CZyft/cjVugvIXsZlp1coZP3SdCG002z4C7Q500IhH2nhEtb
         v3TLgzi112ZKybDsLLsqz9PSgFwBohr1fgN6oNRj7/UK5q2qwRIqFGZROFbV+kmxSTKs
         Z47ogYpb1A6LhgjBVo115I7/d/h7W35cgafu4P9WfrNRTg1R4WGogMk4B3m6DSvrOKFj
         NdDw==
X-Gm-Message-State: AHQUAuZB7YrHq6yrPfzwU4qE6jVOZZ2tnx9WAclGI8HMbFUgQZndSyF2
        78KiRR5OmxlTRJCK+6/iRtw=
X-Google-Smtp-Source: AHgI3IY2aTfhEoryHybdSPiJ+OlcuJDJQkMvPEWqlYZORmw6AQ8/KxCNLbHS7nokIXX+0RDO6GmWsQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr4115553wmc.94.1551473445006;
        Fri, 01 Mar 2019 12:50:45 -0800 (PST)
Received: from szeder.dev (x4db512ea.dyn.telefonica.de. [77.181.18.234])
        by smtp.gmail.com with ESMTPSA id y5sm49567085wrd.97.2019.03.01.12.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 12:50:44 -0800 (PST)
Date:   Fri, 1 Mar 2019 21:50:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] t9902: test multiple removals via completion.commands
Message-ID: <20190301205041.GM19739@szeder.dev>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-3-tmz@pobox.com>
 <CAPig+cTQG+yLGs1Ur2awhLyrpSWj0QyrDpuxCnMNOqc2bBz3pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTQG+yLGs1Ur2awhLyrpSWj0QyrDpuxCnMNOqc2bBz3pQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 01:22:52PM -0500, Eric Sunshine wrote:
> On Fri, Mar 1, 2019 at 12:35 PM Todd Zullinger <tmz@pobox.com> wrote:
> > 6532f3740b ("completion: allow to customize the completable command
> > list", 2018-05-20) added the completion.commands config variable.
> > Multiple commands may be added or removed, separated by a space.
> >
> > Demonstrate the failure of multiple removals.
> >
> > Signed-off-by: Todd Zullinger <tmz@pobox.com>
> > ---
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > @@ -1483,6 +1483,14 @@ test_expect_success 'git --help completion' '
> > +test_expect_failure 'completion.commands removes multiple commands' '
> > +       echo cherry-pick >expected &&
> > +       test_config_global completion.commands "-cherry -mergetool" &&
> > +       git --list-cmds=list-mainporcelain,list-complete,config |
> > +               grep ^cherry >actual &&
> > +       test_cmp expected actual
> > +'
> 
> We normally avoid placing a Git command upstream of a pipe. Instead,
> the Git command output would be redirected to a file and then the file
> grep'd.

Indeed.

> However, in this case, you might consider simplifying the test
> like this:
> 
>     test_expect_failure 'completion.commands removes multiple commands' '
>         test_config_global completion.commands "-cherry -mergetool" &&
>         git --list-cmds=list-mainporcelain,list-complete,config >actual &&
>         grep cherry-pick actual

This wouldn't check what we want.  The point is that the command
'cherry' is not listed, so it should be '! grep cherry$ actual'.

Furthermore, I think it would be prudent to check that 'mergetool' is
not listed, either.

