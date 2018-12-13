Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0669F20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeLMV7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:59:33 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35080 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbeLMV7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:59:32 -0500
Received: by mail-ed1-f53.google.com with SMTP id x30so3357994edx.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3g9N596AmB8rcWsPWoytBf7UoavIYQcX5dx5UgPhDM=;
        b=OaeNAZRe0H8AtGCaGovnYz2F8BhkvfduJwOLpAiO2b1d38+NCiOlctg2xI4hOU5YAv
         42M+psYOnFEgVLV2ZrMbO5pU37Iorc/kzeq3Wlb4fxdTbGQe+r5rXUls+6NjDQs+v/Bt
         JKEyw6NLWSEYgHoD3k6NTrwBo5toCXjlf2Ei5TerATMD/i6qPX0tG/xun2ArBR9ejuYR
         +3iduWr71ojaC45hSAgxS5LcV378vqIuRSd3htRvLZa5qOqf7LWYVMB0d+BvBERdLDKI
         0ff2V5sYlwCmLjimlVCQlhRseM9ssgdGNU2N1nmQKvjN3jJb6liXykC3dYqcL3dsNSBK
         HBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3g9N596AmB8rcWsPWoytBf7UoavIYQcX5dx5UgPhDM=;
        b=e/zgZWZLCPbAtokkjUs9w98+WljbVvZexL9qCQY39opGzxDnZnyDJsiBY1pL7Kf8em
         +b/H8Y7+RsUTml5FwFW4V1FPj7nCq5GPo53eyGFgtz7vnXj9f7OUYauxRZvbriwSM2AU
         qonOqYQuDd3R6CtqJ73fpR5Ysy+0JP/ua9fHc/jDze17OzU2u3GMWVan74KkMTQ/o1p5
         G/SCNI9XKJkOmAX/NzY82KlZt5Ru7la0eghM7nb6yOG8RmOLCZtDhl0t1tLKY7iV59wr
         zybzJnVSNeYS6wJHEuQC5mUQatzRhe4vfC5suP/TLmWkwcan9TEA67zc1vhlGm/6JYGt
         06Og==
X-Gm-Message-State: AA+aEWawnm+QNibEGddMTQkxFtGICNKtOq5k7VbX7WdD97Z+6RVo/Hw7
        2hbfzuEclrkNsLEQZpb617uzGAR4pQlFRxM0AS2+zhpJ8Lwx/w==
X-Google-Smtp-Source: AFSGD/XciAkIwG2d/9+brnQZNqpLdlinvxKctdVdnIE3VthMpQI7qchUyN0YfLV2WlxuV+/+goPOpgNJfdmjZvWKfz0=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr750595edd.215.1544738369723;
 Thu, 13 Dec 2018 13:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20181213171917.GC4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181213171917.GC4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Dec 2018 13:59:18 -0800
Message-ID: <CAGZ79kYMULBBDBt6Sx___m37TNkruYmpKto5ZGG7u7X1jHuKig@mail.gmail.com>
Subject: Re: [wishlist] support of cloning recursively from non-bare submodule hierarchies?
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 9:19 AM Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> Example - on http://datasets.datalad.org we have a few hundred datasets
> organized into a hierarchy as git submodules.  Each  git submodules carries its
> own .git/ directory so they are "self sufficient" and we could readily assess
> their sizes, and "cut the tree" at any level without looking for the
> supermodule somewhere high up in the tree.
>
> .gitmodules typically has relative paths for the url and path for the
> submodules there, the form which I think we chose because it used to work (I
> could be utterly wrong! but I think it was done in an informed fashion)
> for git clone --recursive:
>
>         $> curl http://datasets.datalad.org/labs/gobbini/famface/.gitmodules
>         [submodule "data"]
>                 path = data
>                 url = ./data
>
> and possibly outside:
>
>         $> curl http://datasets.datalad.org/labs/gobbini/famface/data/.gitmodules
>         [submodule "scripts/mridefacer"]
>                 path = scripts/mridefacer
>                 url = https://github.com/yarikoptic/mridefacer

So far so good.

> But unfortunately git doesn't even consider such (valid AFAIK) situation
> while cloning where url has to have .git suffix but repository is not bare and
> a relative "data" path (or "./data" url) is referring to the worktree.
>
>         $> git clone --recursive http://datasets.datalad.org/labs/gobbini/famface/.git
[..]
>         Submodule 'data' (http://datasets.datalad.org/labs/gobbini/famface/.git/data) registered for path 'data'

and here it goes wrong, and you would have expected to see
.../gobbini/famface/data, eliding the .git ?

I just checked and this did not work neither in v2.18.0 nor v2.0.0 of
Git, so it is
either a real old regression in submodules, or something else.
Is it possible that the clone worked once without the additional .git
in the superproject URL?

> on the server I use the "smart HTTP" git backend, but not sure if that is the one to blame, since
> I do not see in the logs any attempt to get the /data from not under .git/:

If we want to strip off "/.git" of urls to make submodules work,
we'd want to look at builtin/submodule--helper.c::compute_submodule_clone_url
that was recently introduced.

I wonder if we'd just want to cut off the "/.git" and assume the submodule
is there in the worktree. Or if we need to see if the submodule was
absorbed into .git/modules/<name> on the remote side. (But if the
submodule is checked out both would work)
