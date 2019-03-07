Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A582320248
	for <e@80x24.org>; Thu,  7 Mar 2019 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfCGJql (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:46:41 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:40691 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJql (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:46:41 -0500
Received: by mail-it1-f169.google.com with SMTP id l139so14801040ita.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RImWkiGhzQ4VJQnfuE5x+hibx6ByLELEL+k96pfPREw=;
        b=WxtZCyyjJ1dhPj6w2nyxofkneEzXNiGv+JKdwje3i0pbc0VfqhOw4cH2FN7Mf+woE5
         BEs9MkxWXkYrrsczemDv79vHmYq1LEai+HCA9WfihS5+4a2rJROwL3V4kFeFQNhqlg78
         Jj1iEPkioPSu0+ibQhnpv+kl5EbfpDL64sZNpoX7uquld/BNer0qW9KcEJUNlLcQO+fO
         Z7aR/9szCbihu9tTuocQCP/Mna7na9xi/nDnhYaYBWDfh2vqOTKONOzivZ1K47yDryo4
         adjrIBnEnGSnmo5bmKR47AYtLucidWCq+fcXWNSqsApbhf8b6hLW+ouPQMDyHVe4nUIQ
         4SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RImWkiGhzQ4VJQnfuE5x+hibx6ByLELEL+k96pfPREw=;
        b=QoCk6Xn5ncBbDUrUKNNT7hSiMDSv+09BTNxaZetLgsoKyD2ZLhNyF+9pHOByRfIWux
         XC/OXg01TKzOGoYQYAi1m12QALGO0ZKhgmXUnrLU3ciyJCWuJc+snsjGJANMydWx01Jv
         hOrmfF1lWuLI4xSJquCbBPreeuqzBH0mlHuYLOuCqJRtTkEI0NsM8sXyvHAcwUNP1GaC
         y2imiAWJfZRkPQ4NulWGzvYCZwTKvqviogy7Zg39WpuwlQXCnSjVlVxNt9VU5wD27vPT
         jadj1ysZegJB5hKHCDpUHm4CxHqesg8jQf00Mo3OZJN/fHDLS9QwRxvO2qJe8inYiHFz
         LTFA==
X-Gm-Message-State: APjAAAUUH/FFlKosisgEA1gEmMy81hsJg/wLOpwPnIvaAee/hbwBdCnM
        bhK8/NqfuAh7cW/lfQhoUQ1EjZ219KlqV8IiZ+z9Nw==
X-Google-Smtp-Source: APXvYqxNNOIluWURTHV3yIWI3miPcNP7r8euf/yFunUgXXyzVXCb/LCB4XURb7NqhPtH5BKT71UzKhFkIe56yVTq6ZA=
X-Received: by 2002:a24:7542:: with SMTP id y63mr4777328itc.70.1551952000086;
 Thu, 07 Mar 2019 01:46:40 -0800 (PST)
MIME-Version: 1.0
References: <f6e197f2-886a-5e82-7fc4-c53737dd66cc@gmail.com> <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
In-Reply-To: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Mar 2019 16:46:13 +0700
Message-ID: <CACsJy8CrSGQt=_RK8cwc3AW_+gfGLf_M5UKAmjMZrm43Qu3Z8Q@mail.gmail.com>
Subject: Re: [BUG] worktree local refs weirdness
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 4:38 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 06/03/2019 15:57, Phillip Wood wrote:
> > When it is run in a worktree 'git for-each-ref' only seems to show refs
> > under refs/rewritten if that directory also exists under $GIT_COMMON_DIR
> > even though they are local to the worktree.
> >
> > Initially I thought this was due to $GIT_COMMON_DIR pointing to a bare
> > repo, but that is not the case. However while writing a test case which
> > cloned to a bare repo I noticed it was listing a ref for the HEAD of a
> > worktree in the repo I had cloned from, not the clone itself.
>
> Ignore that last paragraph, it's just showing the branch that got
> created when the worktree was created. The last part of the script is
> redundant, I've updated it below

Thanks for the test script. I could reproduce it and I think I see the
problem (update-ref creates per-worktree refs even though
refs/rewritten should be per-repo). Working on it...
-- 
Duy
