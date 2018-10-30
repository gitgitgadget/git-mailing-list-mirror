Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323CA1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 16:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJaBRJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 21:17:09 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:38085 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeJaBRI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 21:17:08 -0400
Received: by mail-qt1-f169.google.com with SMTP id v1-v6so9941443qtq.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i12Fr+ezd/Xwplv1V8XMJ+eRrUgLkqPZwMPMf2Mz8mc=;
        b=us2wqNscny1k7twOSv4mcy/xQz5pdGFAwB39W5ASDgl1rbCYdEKaXOZcyCFvmNiDnF
         Nil+3aiwQ+0kOpe2I0THyvx/A2w08zoHCxdnNYIM33mmkb0jRGwTa8Ai0Nnqo4/WIFdd
         RPf6hgv+Zf8WovKRSf87bwyigSBATZyoWPVPNGejRWucZcG6ZstQ+ErfxsZSw1oPL+/5
         jAX9wrO2U+APA4BDD41QTc6ERKIDSOgGCYTGqzJLhb0J/T4Qbvf+xTy88GffAKzB1fbN
         Nn8VmG3s+OxZi0ao2z1fTv02+eFu2XVc+geJlj8OI0Uk8kPKsVMPfL2avUESKi5pcTOh
         aFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i12Fr+ezd/Xwplv1V8XMJ+eRrUgLkqPZwMPMf2Mz8mc=;
        b=tpED5HjsU8SCC4n53HShBScMpRANYlZTrkbbRDHhAhRLqjAGqCO5EiPlXZFbXnnth6
         7nyJtBifsAMIHJrHG9RqmXMh4l0a5m2f61vfRW3gVdMYaY5oQPGlL9nBlbokbb6UluFx
         mOHTURgBd5DiIwfjrb/DbWmR4PEx8gvpnsgh609jHNWaxm3fq+c50o4BYUHDm0+licdq
         gnYkfv4Ylmop5gWXiUJVgvdK8XvecOF28uoFed3a9EnTVd38JvsHxtc/nQDg02E/O5EC
         suIGU7ZGOD/tN6gc6D5YxCwgUR0zVnQsbucgwm6873a2Hf3Zs30EcJyNoFhJ5ge7Z4uV
         XhXw==
X-Gm-Message-State: AGRZ1gIDFOgiK650HKOwXuPKP1gJ1dJW9t9rzsRpp4EjFMKVIxjLwU9V
        xjvkHApLcS6VoX+y8G35+lkl8swaBqiM0gYCBlY=
X-Google-Smtp-Source: AJdET5fCJlO3+/YshhXiN3ptij3Fb9sUTQnAi13K2+Ev+pbljCH3BLQc9DtNe7AM4jmtl6UvekXxs+RmGplJMJvHAtA=
X-Received: by 2002:ac8:2875:: with SMTP id 50-v6mr2806197qtr.54.1540916579950;
 Tue, 30 Oct 2018 09:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
In-Reply-To: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 Oct 2018 17:22:48 +0100
Message-ID: <CACBZZX5=CGvYqe07a5yzxc-=U92oSR5u7tpzJDEBEMzY6NDovA@mail.gmail.com>
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 8:41 PM Elijah Newren <newren@gmail.com> wrote:
> (And in the mean time I gave the user a one-liner to nuke his
> local-only tags that I suspect he doesn't need.)

Just a note that you can usually set 'fetch.pruneTags=true' these days
to make that happen.
