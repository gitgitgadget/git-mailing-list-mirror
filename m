Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6081F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeFFT04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:26:56 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44166 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeFFT0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:26:55 -0400
Received: by mail-ot0-f194.google.com with SMTP id w13-v6so8611127ote.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WSzUU0CFXd8R46arq4cISv8bMX9akfBFB4JxWLPE7no=;
        b=RFGJJZw8xZsd2Jv/mrlBOHWIZYemeEChe+xnU4JbE5x4t3arN5T+QcuNbOUm8Ww1jP
         /Ik9H7DOO0NB2GLGgw8IFu2nhOdmrkiPCFSlUPqVuacnCybHqJWkIlzFdZEvJPMaq/Eb
         TaxTzFdUXo3NIuHwCHlhFYLufTvphiHht6Qz/Q+BXFKzk3cjii+rIQfHBgYsdacQGDzh
         a30pSwDC/FyjOV90alWSLcojq+2QmaZGK95AlK2InkvfI+0YaB612dKq1UslK7JJmMpY
         LexUXHxWKAwmT/KPass6eDnVL+kSY/mb/PUAmr2Xit1vlzJmYOwfcsTpfz3MvWai3E5C
         mdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WSzUU0CFXd8R46arq4cISv8bMX9akfBFB4JxWLPE7no=;
        b=ei4/cvkEwz54V8AYDILqTVKX9jXwaemBnWbuH7jq06LbDTmG4945AUwkdtELpOW5bT
         iy+lgT/pjsyiqdtb8+Y7mTPXKtyDRXa8qkfLrPs68vP+1p0dYuR/WptVo0/8/yOWHlwp
         qYCDma+MDbU2OskXy6VaiK7FIRaO5gVuOFQy1YmkwOgXA9C4IYHwpcdN2nCc9kpR2dCw
         uYM8nCYOCXNtPwA7Y12Kb/R/K607hVXGrf946GLANLrkcECJ1bSzWli/zAi0W8xCgKLw
         zFMN7O6KYA7COK9we+nMnhnDNqhyCMgKD7jPeCyA4bR7zEXNnJacN/I62ATE5L2vkX0D
         J4fg==
X-Gm-Message-State: APt69E3QUO3Xrif8ahJYbr+7ltC/mbbY3SjQtjyE8yewyo7zmt1RAj+x
        rO+DkIPx/wsSOt9luCoEAY15muILG4YSCC7r/Ic=
X-Google-Smtp-Source: ADUXVKLH1p6NGr33U+QGG/U8WjCTTHalpLeLW6Q+XQ+tFkbe8gE2aBMbBpB9gWHpfAZ0t3zQ5CRVMkRCohS1vxIg9Yo=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr2941919otb.14.1528313214848;
 Wed, 06 Jun 2018 12:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:26:24 -0700 (PDT)
In-Reply-To: <20180530004810.30076-8-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-8-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 21:26:24 +0200
Message-ID: <CACsJy8Daj2yvZ6FHJJSrjMuYsy7sUqW2o4XtUqEh0r=o6cjJew@mail.gmail.com>
Subject: Re: [PATCH 07/35] tree: add repository argument to lookup_tree
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:47 AM, Stefan Beller <sbeller@google.com> wrote:
> Add a repository argument to allow the callers of lookup_tree
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Add the cocci patch that converted the callers.

I don't see the cocci patch in diffstat. I don't need to see it, but
this sentence probably should be dropped.

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/am.c        | 6 ++++--
>  builtin/diff-tree.c | 2 +-
>  builtin/diff.c      | 3 ++-
>  builtin/reflog.c    | 2 +-
>  cache-tree.c        | 3 ++-
>  commit-graph.c      | 2 +-
>  commit.c            | 2 +-
>  fsck.c              | 2 +-
>  http-push.c         | 3 ++-
>  list-objects.c      | 2 +-
>  merge-recursive.c   | 6 +++---
>  object.c            | 2 +-
>  reachable.c         | 2 +-
>  revision.c          | 4 ++--
>  sequencer.c         | 2 +-
>  tag.c               | 2 +-
>  tree.c              | 4 ++--
>  tree.h              | 3 ++-
>  walker.c            | 3 ++-
>  19 files changed, 31 insertions(+), 24 deletions(-)
-- 
Duy
