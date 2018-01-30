Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5E31F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeA3UhF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:37:05 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43506 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeA3UhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:37:03 -0500
Received: by mail-yw0-f196.google.com with SMTP id x190so5780507ywd.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pzs8aV2yndhs3iGKuAQSAsfm3tyDmiudDhrBqapl8Yk=;
        b=PI+xv2nbkA0nq6/ZoxSG9SYNqZCAVqrcBBPyswv7f82wYNuegzl46HViLsmsg/WRqP
         ofQpXmmd1yJVBwizruJsmk0ijOpks0+XYk+Vo0hk/s/BjASHgWmlXQDigTunZM5a+nJI
         FHe6dlyG7lYzbYxS3Q8hUq+3iOsS/Ik7uVxOilOnJQAYEd5KWqy6ebGlFjLPPiq6B3Xq
         bmSdGtViBMg6HHFw2qHLzY26Mbh/J8qHLZVrZ4PGs12s3s/aqkBDFvv5QulZV9E015Mr
         MULO97BgZTL42tH1r8S10QGT3Yb/Td0AeMcac7e2WWIJhx5j27a3imX0IFhK3PJUyQKu
         gnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pzs8aV2yndhs3iGKuAQSAsfm3tyDmiudDhrBqapl8Yk=;
        b=GefPiiNQGITri6Mul81EdzuZ+xS2j4fToRhwUwA3Gae9L/ZHU8SYPRo/23154hbB0Z
         V+w6r99GCXXktY0re92ZmCIsUh+2Q0F8jepntY/1gTDm/AuBLpMZ+3AAuFj7V1D+hNAt
         LTxZiGwP9xRQTFtIZa0bEcGDWCF6D2OzT1co8FxAG6HXFFge5lGe11p1b3kI7oOrh6ut
         UgkeqfxAnJVtU0lsnsjSEKpFm84aXpdLcozy/c18dIw07H/lv1d6kM8exOaPrtF613Vr
         laVNFnT0EGQrjbhd0wCHIaMPYLLdhmPlVoiI22u54Ohmq6/brW0/ownELBFvphpH37WI
         Jb4g==
X-Gm-Message-State: AKwxytfVQVZ9vRTCsz1PzBS8DpzSFgWbQTFSUpfNBRvQqiGL7LG8BeBo
        TjPa9KqTJqzZHdwItwCi33fwDp9wo2JcRvncOWs9hg==
X-Google-Smtp-Source: AH8x2273NdtExXbmmptMlY/Fgr+5z7w4Ih/k62InA+6RYnRXcwG8Y2xVl4SxbPMK6X3GXNZOBsDg+yUVUuOaIpRajf4=
X-Received: by 10.37.163.198 with SMTP id e64mr20911591ybi.438.1517344622263;
 Tue, 30 Jan 2018 12:37:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 12:37:01 -0800 (PST)
In-Reply-To: <20180129193453.3438-1-pc44800@gmail.com>
References: <20180129193453.3438-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 12:37:01 -0800
Message-ID: <CAGZ79kbVbUQGx84ynhG6DnOMNy4Qv1Og3ykRGqCNbNAswwnBfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Incremental rewrite of git-submodules: git-foreach
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 11:34 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Following series of patches focuses on porting submodule subcommand
> git-foreach from shell to C.
> An initial attempt for porting was introduced about 9 months back,
> and since then then patches have undergone many changes. Some of the
> notable discussion thread which I would like to point out is: [1]
> The previous version of this patch series which was floated is
> available at: [2].
>
> The following changes were made to that:
> * As it was observed in other submodule subcommand's ported function
>   that the number of params increased a lot, the variables quiet and
>   recursive, were replaced in the cb_foreach struct with a single
>   unsigned integer variable called flags.
>
> * To accomodate the possiblity of a direct call to the functions
>   runcommand_in_submodule(), callback function
>   runcommand_in_submodule_cb() was introduced.
>
> [1]: https://public-inbox.org/git/20170419170513.16475-1-pc44800@gmail.com/T/#u
> [2]: https://public-inbox.org/git/20170807211900.15001-14-pc44800@gmail.com/
>
> As before you can find this series at:
> https://github.com/pratham-pc/git/commits/patch-series-3
>
> And its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: patch-series-3
> Build #202
>
> Prathamesh Chavan (5):
>   submodule foreach: correct '$path' in nested submodules from a
>     subdirectory
>   submodule foreach: document '$sm_path' instead of '$path'
>   submodule foreach: clarify the '$toplevel' variable documentation
>   submodule foreach: document variable '$displaypath'
>   submodule: port submodule subcommand 'foreach' from shell to C
>
>  Documentation/git-submodule.txt |  15 ++--
>  builtin/submodule--helper.c     | 151 ++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh                |  40 +----------
>  t/t7407-submodule-foreach.sh    |  38 +++++++++-
>  4 files changed, 197 insertions(+), 47 deletions(-)

Thanks for bringing this series up again, my review still holds.

Thanks,
Stefan
