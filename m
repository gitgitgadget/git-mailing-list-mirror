Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD7B1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfHUWcE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:32:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfHUWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:32:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so3522927wrr.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fqf5WgQeahYZrQ80pWM06aZJrvjkxXfL2EGMVC40+34=;
        b=eFXUW8Be3Nm6md/QP52oreqU4PHfuiwCVcZGsSQpRll3ml2lhzzzcNjenVmaf7z1iB
         4SSAK/jUNJ7jckLIyrmLs4MxAShuULKlasPtgbf+QOzChf2co87BfhqKW1c7V5vQZbt9
         WJV3YVOyqxtry/qmriFwoNTwyuGkP2iyO11bjejD5RAYFcommnG8Z8tcxRg1Asua2OE2
         d0PQX1FirSjl//QQ0Hu6vY/oRO7mpjVPen78f9R5ljlGE4g2/BjZ5CAL24UHuI4cMhX0
         KFxAGNhgMPGummwNo+qoiHyp2jcl/en2hZsViMV1c6uhxH+gcVSj9st0seE4Mr9reIXT
         rtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fqf5WgQeahYZrQ80pWM06aZJrvjkxXfL2EGMVC40+34=;
        b=q3pewBqHUupuENmXlUxz3h5qgIQnRJEvnya0cZsUQ7AgahDFNBnr25nlFkspnOQWRK
         WaKOBn4XiaJm+OBOcLa5Z+VeswFI8ImKEPBuIz553CmaeicvdWsZyEu6kbng4p5rxzS7
         kPLu74MZeBt8FCLbmOUUryGL+KRUiiNcis8BjQhjjSckY+bQ14eF/JlH/9Dmoi6wXFlg
         R4m1R8K9FqN97tffQASZvsKIHB84qY1awrqaV/6NoWnmit33N1aL0sn6k70Ve2c4r9gu
         8BR4gGkuI/b9WtuxLbVwUnjoIVfmOJ3nVsgJL195eHzvZyvfI56ThTRonZqsQKEnUuOg
         SrQw==
X-Gm-Message-State: APjAAAUaXhpsVcXs74OTTNPDD8Pe+FfFFYoKpGwCuD7DvcrkHOyih4Vd
        b228PDaJaM/lIKBKkRwQues=
X-Google-Smtp-Source: APXvYqyRoUneBL4siKmFlnzSWIiIdZbm/+JS2EtTmGh3WNhfAzNaQblWjZcCfhwOReXJCLAl1p8zug==
X-Received: by 2002:a5d:6a12:: with SMTP id m18mr43575464wru.306.1566426721735;
        Wed, 21 Aug 2019 15:32:01 -0700 (PDT)
Received: from szeder.dev (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id s19sm32388921wrb.94.2019.08.21.15.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 15:32:00 -0700 (PDT)
Date:   Thu, 22 Aug 2019 00:31:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git
 checkout -b'
Message-ID: <20190821223158.GB20404@szeder.dev>
References: <pull.317.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.317.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 12:18:32PM -0700, Derrick Stolee via GitGitGadget wrote:
> As we were integrating Git 2.23.0 into VFS for Git, we discovered that "git
> checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo.

Does this slowdown only affect the Windows OS repo with VFS for Git,
or other biggish repos without VFS for Git as well?

> This series does the following:
> 
>  1. Reverts the change that makes 'git checkout -b' slow again.
>  2. Creates a warning that recommends users start using 'git switch -c'
>     instead.

'git help switch' says loudly and clearly that "THIS COMMAND IS
EXPERIMENTAL. THE BEHAVIOR MAY CHANGE."  It's too early to recommend
it this aggressively, and to deprecate any parts of 'git checkout'.


