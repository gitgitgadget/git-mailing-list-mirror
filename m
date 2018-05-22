Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6872C1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeEVS3M (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:29:12 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39929 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeEVS3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:29:11 -0400
Received: by mail-yw0-f195.google.com with SMTP id w125-v6so1787ywa.6
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I7/Te0dGFFOPn/eyDOq9ssHfzTdMaM2sxhgHwHcQRJM=;
        b=HT3+cFQsIHpnTGiYHd5OAr6MNc7xvDuP0QQ+lH9ZvjZd13lgf9ngA1m7t/7Ywl59jb
         5wdbxvr0q4XNb1lGhPQJhgBrtJgVBStSrCqUFlv6hzpuoDX5pNmKaw8nvzfFwoOwQxUo
         q2BckpzlHfoY1dU45W19TwVGWyqhAyN1mHCB2HCvPl3aFC1/sXLNQ/LBQAbCziRzHHpd
         ymMT8vR6nOQbOdjvJpwkQuRsALRePoi+v7WgSyJTPgWpwZvGRcdErkgJQTIrjWbyceXJ
         nSPFsZ3dGsCh6QKl4DRF872WsokFB1q0FeTLdc7QnN+lJHNqKZ6a4qyXaIF34AS7vI2V
         3m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I7/Te0dGFFOPn/eyDOq9ssHfzTdMaM2sxhgHwHcQRJM=;
        b=hgn1lL8c+HrzSBpjmnTCz2e7fTj1wYPKDPB/KfFt/CSNDe4SK018wxvOrfAfqq0/3c
         WRITC+V7RmVTThmc97XwCwlTOTv3xNCsj4g2tjiCmOuGvLxbqeY2WEltdDamiHoq9r1t
         CCWlV1hF7DNf43PvXW0YuV+0LQm7U/yktJboeS3kIr4k3xLlC6g0MHCLdUTZx67Osimg
         Hs81sxKMsQlEtPKGUovlfoBAt+ChlraerfibOi+GpOMGKxQgEmjI7Rq9GfwQb2u7eTfk
         7DZfjs+BnMvn761M5dwLp0oZPMYe+SWgRNn9b6LWcxK6jNvCTDNnD75gNSzxHMbBwcSY
         0zKA==
X-Gm-Message-State: ALKqPwfSNd3Z/jGs23qMdJImNPwuDtu6j4Atw1wJeCvGeuYPCJcCfFfF
        fIt2SL2XDd0gYa/YPdnm94IlA504n3pjroPQfbDWUw==
X-Google-Smtp-Source: AB8JxZpjgprCGGIBeKXBOErMUwlCtJmg3y6MBUGXOOBZQ00WL4xlQaYgC+RBnxV9p5k9jXvCRnkK9qVCrUL3qU9BXYI=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr108508ywg.345.1527013750464;
 Tue, 22 May 2018 11:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:b189:0:0:0:0:0 with HTTP; Tue, 22 May 2018 11:29:09
 -0700 (PDT)
In-Reply-To: <20180522133110.32723-1-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 May 2018 11:29:09 -0700
Message-ID: <CAGZ79kbiCE1CDMYN+aV8s9Ev2joCZJqroN3wBkoRvZZLHqOFww@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/4] rebase: split rebase -p from rebase -i
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 6:31 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This splits the `rebase --preserve-merges` functionnality from
> git-rebase--interactive.sh. This is part of the effort to depreciate
> preserve-merges. The new script, git-rebase--preserve-merges.sh, should be left
> to bitrot. All the dead code left by the duplication of
> git-rebase--interactive.sh is also removed.

... and I thought the original motivation was getting the rest of rebase
into a shape that rewriting it is easier, the potential bit rot of
--preserve-merges
is rather a side effect, but not the main goal.

I commented on patch 1, as I don't quite understand the changes,
the other patches look good to me.

Thanks,
Stefan
