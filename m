Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CF11F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeEaT3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:29:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37304 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbeEaT3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:29:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id h141-v6so758691ybg.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sUONfJoRp8kJMi5Zl8HzBrXK8uVjxV/UJuyZ1qJPrrg=;
        b=OyG3XvZaku/KLMLja0P/phbXHwiXXUaCyOC8pTFseM8pEaE053dkKYNPUqB18pu8Mr
         ZxkGrmiDTzYm1PkktaY/6WbITDIRmsIFDTOdv6dfzkrFADgryVtLeXT5yduD3PCWq2I2
         oMUGpT6FsCVsmtMDDAS25uEMHIT5fKXTV0ZN9thmsV8F7To4CBFYFtG9YXKoribSK3JL
         pvFrShGiK/AxB+hltsOiSptU/75cuy9qFN9AMlwoiTDlZp6bbFvY9xe3NBffPApipZbv
         KT7fS7uNdE4E6fwnQJ8528lgvG/NCJDD9LQB/H4UsLdYuE7xhPzvBrtJJVXTXX3PmMAw
         UMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sUONfJoRp8kJMi5Zl8HzBrXK8uVjxV/UJuyZ1qJPrrg=;
        b=biib5m9XMmBrvwR34QQJEMeZUo+1eg0KQATgIvV+a+6Q/RmxOpWE7CXJ1kjiFCHQlb
         XJqfDupNmNRzdeivSvSzXVqYdhM/xPi/bD/h11FIO4RyCzQJKTF5DBMpOrayEElIOPZy
         SRmYg5d6FGZzNbkuC/pz7SAve7D8VCCGZwi9pjxIFku/WbsgeZXLs1O0wSg+9p5IHwMJ
         DoUWTwaTG9XXuabASHF9x+WyqrYgm5/yZc9p5rEwI5+r4oBvEV9IDle2yZYscr1Q3269
         77AZwXA7penflPc+st9u0Ae+W/Lyi6hgicaPpw8vzgZlPNcIAtdQ19aNL9Sn9iBQOcSV
         y8MQ==
X-Gm-Message-State: ALKqPwesq2tZHJQYR+127JnHkqd2oQ+OkiEebgOiDKd+XTnLdwSrVexb
        3Bz0rMS83F0ldu0tpE2g25YbJncUTlcChR/+3jnZAw==
X-Google-Smtp-Source: ADUXVKIcA+TzXh5nlCEEE0rKLUW4Yg3xGLzpQ6pcPg1pngpgAv92zfnnFZaVu2USgK9BN79DB+kg4WmBhIOoSmaE9tw=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr4603773ybx.352.1527794987984;
 Thu, 31 May 2018 12:29:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 12:29:47 -0700 (PDT)
In-Reply-To: <20180531174024.124488-6-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com> <20180531174024.124488-6-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 12:29:47 -0700
Message-ID: <CAGZ79kZp3SG8D_aap7k7TDUaGsA7_8ufhkiJK7VR4nGQohVDDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] fetch: destroy commit graph on shallow parameters
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 10:41 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> The commit-graph feature is not compatible with history-rewriting
> features such as shallow clones.

I associate "history rewriting" with changing objects in the history.
For example interactive rebase or the BFG cleaner[1] / filter-branch
to remove certain commits from other commits as parents.
This history rewriting leads to different sha1s, and the commit
graph feature is compatible with that in the sense that you can
add all the new sha1s /commits to the graph and prune out the
old unreferenced commits.

Shallow clones are not rewriting history IMHO, as the sha1s do
not change. What changes is the assumption of presence of
the parent commits (which makes it hard to compute the
generation number), by the grafting trick, that "overlays" (?)
history.

This is more of a nit, though.

[1] https://rtyley.github.io/bfg-repo-cleaner/

> When running a 'git fetch' with
> any of the shallow/unshallow options, destroy the commit-graph
> file and override core.commitGraph to be false.

We do that *before* the actual fetch happens such that
the improved negotiation of the future cannot even try to
benefit from generation numbers?

We do it at fetch time instead of other local operations
as that is an entry point to commit-graph incompatible
features. Would this also be needed in clone?

I was about to ask if a more fine grained inclusion to
lookup_commit would make sense, but that is explicitely
called out in the cover letter as 'too hard for now'.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/fetch.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index af896e4b74..2001dca881 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1452,6 +1452,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>                 }
>         }
>
> +       if (update_shallow || depth || deepen_since || deepen_not.nr ||
> +           deepen_relative || unshallow || update_shallow || is_repository_shallow()) {
> +               destroy_commit_graph(get_object_directory());
> +               core_commit_graph = 0;
