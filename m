Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9800A1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfH3JMc (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 05:12:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53259 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3JMc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 05:12:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so6481418wmp.3
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S4g46HjNiQWjzILIOj8UI6Vv2WhMhL4GZfH5NG6Kb4Q=;
        b=DQrD7VjrV36zT+uWzq4BDpNxwKQwetD7dBT1SUWuWjsRSjnTtd5/Bp9A3WQE8z3Men
         dUFqCUf9LtG4gucFBSh0zLAi14NPnyKkEFrCs2Z3KHpB2werxDCOQgFROkqWvCFnyC5e
         U29hp5I/X2J+aC9Ts8Qxe/l3gl2QIYhFSQxMyDeOBhrIFsIXdJeVF/5naJtPDo21895z
         Lqt3tPK+rIUyxh2fO4CNdXwB/UdzUn+XQO03dp6idU5+KxXtEfvkTRLcinXkUTHbmikc
         ptEuH+zSEd+sJP9Rsbh1iqfy1mYNi0oe9PeolNsJKsaMlODJQbsGLprceWqtg99M87XY
         dQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S4g46HjNiQWjzILIOj8UI6Vv2WhMhL4GZfH5NG6Kb4Q=;
        b=knpIjlmJcaKT4G7YUg9d40ku94SVramFjYsqbBaMFQ+RVYknTQm4HjJLgD/3b+ZuGn
         xfHXFv19mgs8uSmQWCrUWvv1avmlMuIoX1HQQpR37dBJsispxsq6gLu3bj6RElzcg6a9
         raBQA1Wi9NWT9N3BZ7osMpn5Cveql7rSrMex9PRt2xy7RkAMwh5lSZEPjtgLWe9oxV2S
         VA84Dh39qYUZgMIGVqItUfjkQziir57FwN1+JVaGBNTdfNUKrVhdLc8vy1uIDFooVQsp
         PTTpF/R/ZqQLpoBnLY6ZNn4EO9K1DT/8WRdx8dEWOqj2Gz9+BudAQt31gXjoDm3VTW/n
         GRzw==
X-Gm-Message-State: APjAAAX56zNKf04aoldmMlW4Fmq3Zc8deUsASDjX+ty3zC4Pt33cOF5C
        ROk+ZOV77iL5DwX7pnQZLJ5wV3lW
X-Google-Smtp-Source: APXvYqxgQk5jyV/sE2+jdHCdg1muAbYbNsirDDb3VWZU86kmK/VCwln63SU+a6CnykwtxM5yC7bhuQ==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr7386511wmm.75.1567156349769;
        Fri, 30 Aug 2019 02:12:29 -0700 (PDT)
Received: from localhost ([185.53.225.150])
        by smtp.gmail.com with ESMTPSA id d19sm7762128wrb.7.2019.08.30.02.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 02:12:28 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:12:27 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "van den Berg, Kasper" <Kasper_vandenBerg@reyrey.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git range-diff <range1> <range2> throws Segmentation fault
Message-ID: <20190830091227.GD48344@cat>
References: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, van den Berg, Kasper wrote:
> Hello,
>
> `git range-diff <range1> <range2>` prints "segmentation fault" to
> the console and nothing else.  It happens in git version
> 2.23.0.windows.1 and only occurs for some branches in my repository.
> I have not exactly determined when it does happen and when it does
> not (I'm not familiar with git's codebase).  These are my results:

Thanks for your bug report.

I guess this is probably related to my patch series aiming at giving
nicer output in 'git range-diff', which probably introduced some bug.

> Status	Version			Config												Result
> ✘	2.23.0.windows.1	64-bit, local											Segmentation fault
> ✘	2.23.0.windows.1	64-bit, local, different ranges related to my current work					Segmentation fault
> ✔	2.23.0.windows.1	64-bit, local, different ranges completely different from my current work			Expected range-diff output
> ✘	2.23.0.windows.1	Remote connection to same workdir								Segmentation fault
> ✔	2.23.0.windows.1	64-bit, local, fresh clone, different ranges completely different from my current work	Expected range-diff output
> ✘	2.23.0.windows.1	32-bit, local											Segmentation fault
> ✔	2.21.0.windows.1	64-bit, local											Expected range-diff output
> ✔	2.21.0.windows.1	64-bit, remoteconnection to same workdir							Expected range-diff output
>
> Both <range1> and <range2> comprise between 213 and 270 commits; git
> gc counts 140394 objects (Total 140394 (delta 110638), reused 137275
> (delta 107799)).  I have not preserved the offending branch names.
> However, they contain 2 or more slashes and perhaps an at-sign
> (e.g. 'feature/'<featurename>,
> 'tmp/old@{'<i>'}/feature/'<featurename>, 'develop', and
> 'tmp/project-base').

I don't think branch names would cause this, but rather some diff that
range-diff doesn't handle correctly.  Would you be able to gather a
backtrace from the segfault (not sure how to do this on Windows), or
share the repository where this segmentation fault occurs? 

> To avoid the problem I returned to using git version 2.21.0.windows.1
> 
> I there something I should take into account when doing `git
> range-diff` on a workdir or on a ranges of commits?  What things
> should I look for?  How can I repair the broken ranges?  Why does
> version 2.21.0.windows.1 work while version 2.23.0.windows.1 does
> not?

I don't think there's anything you should do here, this sounds like a
bug in Git that should be fixed.  It would be great if you could help
with some more details per above though, otherwise it's going to be
hard to track this down.

> With kind regards,
> Kasper van den Berg
