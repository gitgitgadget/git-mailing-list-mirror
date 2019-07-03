Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660251F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGCROi (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:14:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45741 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfGCROi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:14:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so3667968wre.12
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUJSciUcJgnGqqTkf4OJ3V4P5USuPSrWzsPkc9fKnrc=;
        b=H/AJwz0MT3mJtdLqZP5zjjPbgw91AlrhQExffX488w5I/sC2POXFzVozRtmcvUF9df
         yoK7hXpMLe3fCmzeDqQ47I+Qb+vHFkLR4bJmX+nYAyGb6bnmWq6sVBErsyaQG/l4k0Wj
         PznAxfIVmmOp8ZpLroct7kFuwII144oa0gk2VIc+cR96apWxDHJCvnj2fR8HoZ0tRabA
         ptV1NSdj9egJKLeH9MVLsuEY7rlxEjM+lLdzdyXTIVY65YHvcayf9g/SoKEnSAD6dDi3
         qdO1Q3IOuVmEDEwNTiNbCTLjo1bTqpWDxtmohD2Z5KXR8AxadUPeB2R8qfSCsvS0A6Jb
         pW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUJSciUcJgnGqqTkf4OJ3V4P5USuPSrWzsPkc9fKnrc=;
        b=VVaIXrddiW9sjMMd/XttQCjdPnrmJnTrElIiBcIcdJ6u1SrKP+Zgg1p24yC1qTEXRh
         7TC/TyonOU7mzC2Gw1hZV/ZTIq4ybDTZvCwcRk83p5wQe9oWJG1biTuVZKVHlbzdaAKS
         /tJH1cuG6Yeuro68l1y29JNHmr6hj/tC1kgv6F5OiA6n0RGEhp0PgghxO8PFw1vI0a+z
         xf5EvH7Co3jE56mGkWzHrZGQZx5BmcXXprXUozgEjVR6FqMS5SPsxglo1mP7o3UzGREa
         AD+K6rcqJuidx7zZtQ9YrzlbGbx3ngyWQXdg1ifUUU57RU49EBauq63AeA+ZArTMX23+
         RkXQ==
X-Gm-Message-State: APjAAAVTLzF/rnkJ/cepOPLy9xoT2oF8OwN6WBUJs9BMU4AiU8qb8EmG
        J/qEvhVkbdZzEbr+lkaBdYE=
X-Google-Smtp-Source: APXvYqyXgFsM65J+GUZfl/G9t5pAyVy68KwSp8OPUH7cDE2g2pmyS1TFDSmz+GgymZmMfaDeltw1lQ==
X-Received: by 2002:adf:a514:: with SMTP id i20mr26234479wrb.281.1562174076150;
        Wed, 03 Jul 2019 10:14:36 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id a64sm7060773wmf.1.2019.07.03.10.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 10:14:35 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:14:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/14] completion: add default merge strategies
Message-ID: <20190703171433.GT21574@szeder.dev>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-15-felipe.contreras@gmail.com>
 <xmqq5zouj3rl.fsf@gitster-ct.c.googlers.com>
 <CAMP44s0y_3Ltv_hnoVByTRwZrDU0+PfRo3R=Lxm6wDk+=sypJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s0y_3Ltv_hnoVByTRwZrDU0+PfRo3R=Lxm6wDk+=sypJg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 08:11:40PM -0500, Felipe Contreras wrote:
> On Mon, Jun 24, 2019 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> > > In case the command fails.
> >
> > It is unclear what you wanted to say with this.  What command?
> > After "git merge" fails?
> 
> Yes. The command that __git_list_merge_strategies() uses.
> 
>  % cd /tmp
>  % git merge -s help
> fatal: not a git repository (or any parent up to mount point /)
> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

If that command behind __git_list_merge_strategies() fails, then 'git
merge -s <TAB>' won't simply list any merge strategies.  However,
that's not a big deal, because the command won't work without a
repository anyway, so I don't see the point in adding a hard-coded
list of merge strategies.  And in this case $__git_merge_strategies
will remain empty, so the next time the user attempts to complete a
strategies while in a repository, then it will Just Work (unlike the
undesired caching of options without a repository that is fixed in
69702523af (completion: do not cache if --git-completion-helper fails,
2019-06-12).

