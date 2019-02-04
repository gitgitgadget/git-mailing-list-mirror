Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01AB1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbfBDVw4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:52:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54884 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfBDVw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:52:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1510241wmh.4
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0ynsrur5voPvE3ovhPaOAe344SMIuYV+BJbJKXYKRU=;
        b=ZCpe92l9yLWS+hYDZOksKkc/jR2ZIVyBFX7NUZgYTjTjcL/jIXMfi0GuAv99/nyIRi
         Klu3TwNXe1hkmqKmPHgZSG2HKKH5ZRg+TnE57KuUge571gp2EqIit97xWjbnAelZW5pF
         Cz2xr4Ndt/nmOfsQmQizWSu6gAXR10Vd/iZTK7f3Nk6M6EeyYaPM62dGIiFZyXgQzkuI
         A0dEqcODurfn9WmIT2CPMMHJ+6g1XcKHPE8850pZ3kqx9mhgd/EpsgXXG1uM/p81BrSj
         rKno7YiBqRVhnm4k2ETMJwIwrh3XrPVy4EQgzG1iHvL4dBdnQlC8rmmlzOMF0BPjj/dr
         3cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0ynsrur5voPvE3ovhPaOAe344SMIuYV+BJbJKXYKRU=;
        b=gHHvsqdE/bWsLFZ+Xb6l3g75KlhdE3lzRDuOIECy+yqW2fJ5Rf2O6aDldkTYcDuuuI
         s3rx3/G6162jhGsQJXhb64YTbkq637ug5rDNTKjaqDRE0n8r1qq3d0DGNw2lM3VbfHTr
         d9H3Ee0bVcWMiK0m/iNX8u/Q+gWcMT8hDwZehi+LsdthwC6LPDcDzTEZA83CEPbEM3S2
         x8ZZPK58zFrTdKYH6y7gcPfib6VabW/Ibrco83SY11Iq50hVcFz9UZ95e7r4SwzzHEQ9
         NKLzDFn6rewKIkt5++YTSf8XBVIP37lVeL3wy4NY4TtSdubwGkrMK5310bNGvA+0KCZo
         EzlQ==
X-Gm-Message-State: AHQUAuZb/uQJEqcyGSGX3V10uAoHKgYvbbrwySnh/yZtMTr0esqgQMtT
        6QEgeEWrPRb1Vn6v8DwAo3c=
X-Google-Smtp-Source: AHgI3IbGWgyU5TwjmpcfXEQI4OFUG4aWmeY9zAmQj5eYSR6SNFj+wwPqPc8ppttQoHt3L2R21mWARA==
X-Received: by 2002:a1c:488b:: with SMTP id v133mr1101106wma.31.1549317173380;
        Mon, 04 Feb 2019 13:52:53 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id o9sm9261332wmh.3.2019.02.04.13.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:52:52 -0800 (PST)
Date:   Mon, 4 Feb 2019 21:52:51 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190204215251.GB6085@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/04, Christian Couder wrote:
> Hi everyone,
> 
> There are now ideas, micro-projects and organization application pages
> for GSoC 2019 on https://git.github.io/
> 
> It would be nice to have a few more project ideas.
> https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> projects:

Thanks for putting this together.  I'm going to have a look at the
project list over the next couple of days.

> - Unify ref-filter formats with other --pretty formats (which is new)
> - git log --oneline improvements
> 
> as I didn't feel that the others were still relevant, though I might be wrong.
> 
> As Olga and Thomas told me at the Git Merge that they could be ok to
> co-mentor with me, they are listed as possible mentors for both of
> these projects.

Yes, I am indeed happy to co-mentor a student with you, or someone
else experienced in mentoring.

> Anyway feel free to comment and suggest improvements on those pages,
> especially the micro-projects and ideas one. Pull requests on
> https://github.com/git/git.github.io/ are very much appreciated.
> 
> The application has been submitted on
> https://summerofcode.withgoogle.com, but it will not be complete until
> someone else volunteers as an org admin. I volunteered, but they
> require "at least 2 and at most 5 Organization Administrators".
> 
> So another org admin is needed before Wednesday February 6th, as this
> is the deadline. Invitations have been sent to Peff, Thomas, Olga and
> Matthieu, but anyone can do it and it requires a very low amount of
> work.
> 
> Thanks,
> Christian.
