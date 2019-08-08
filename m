Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31F91F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404175AbfHHV2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:28:18 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45051 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfHHV2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:28:18 -0400
Received: by mail-qt1-f170.google.com with SMTP id 44so62729342qtg.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxnlemOnI3/hY8/j0qFF165FGa8O7c1wIlWuQHb+378=;
        b=pwJ7Lv0Z5kTQ1ek9QKS/6YsLnRg8G9k+HtUmk58mohBE7NBo9udp5hokKaZA+VKvoA
         nSjER/Qi/shRL4R95YkyfUfD2BjztZGZZqPmPz0n200U2glligmbT5caJns8472FzgWu
         HQ9uyeCHe7UL7ZmR0AW8UeATlpgN+tTuRTZqbm45jNsevUmdq/CZxsyTi2rzsx/GWD8n
         xNykmRC7/I4GoZ0M9CS2XuTB/Fep4yyUbuI0j9OFq3eDZDSBFsA4N/E2qfrCrCUndL0Z
         A+k4FaSn6MFPPcGzi4qDP7nfzICa9qkCkHf+yx3BE0MTyDf3WUgh7MPgoMJXhQLk8DKW
         vH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxnlemOnI3/hY8/j0qFF165FGa8O7c1wIlWuQHb+378=;
        b=sFRFvchR//9BQpBPfSs5S+Yzf/bP4axq1mLdOzG5UPQZsRoZtc01erUygUuFFWP5ij
         QLIFrdxq1CXH5BOX+p3ZxLEgyspejqQIIYbSGe0sUgljoYT2maLUQKLTzkARPsHIEObl
         4nYJhHElJmWCt5h33wyfhsuQ1AmVl09VxeeDdcC65s1YFnpT0NQy2mtEGCZqkWaxYF3N
         cb+0zI5yC5jaArzpbup5dpPiA1UJzfHEaHDmBI1FZTKEoxTCDC/Z6PR71mpiD+m9dojV
         X90bZytB9JazfWOBTV28fzy54u2b0f+KQ14Y9k/VfEWyC57fYfl84n9eWzyABL9kGS7A
         5qOw==
X-Gm-Message-State: APjAAAXot/RnWPlFkwvxKRwOugieVk0EP/ltlPRKKoHpXrvcrGwVZsDy
        k3Zye59wrC2Eh+mFrybTMncy/VBUTBPjdr2cFhPdVw==
X-Google-Smtp-Source: APXvYqx61KaIwFZFKDJF81aCXaaLD9ZNolidaP/QOqGw6z+pn+8aViEugdG1VT5LS6uaZOmIF4Dju6qS/QmXFOppV1M=
X-Received: by 2002:ad4:41d0:: with SMTP id a16mr5841069qvq.160.1565299696674;
 Thu, 08 Aug 2019 14:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
 <CAGyf7-FUsfKpr+HzOpS9TqE+x7GTnsVKki94gXzMVRwnnweC9g@mail.gmail.com>
In-Reply-To: <CAGyf7-FUsfKpr+HzOpS9TqE+x7GTnsVKki94gXzMVRwnnweC9g@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 8 Aug 2019 14:28:05 -0700
Message-ID: <CAJoAoZ=K0LhCmnEUk1rsan2J5APzcye7+RryjBG+mKgjGf6qzA@mail.gmail.com>
Subject: Re: $> git branch splat response considered harmful
To:     Bryan Turner <bturner@atlassian.com>
Cc:     jim.cromie@gmail.com, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 2:20 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Thu, Aug 8, 2019 at 2:08 PM <jim.cromie@gmail.com> wrote:
> >
> > fwiw,
> >
> > jimc@frodo:~/prj-1/capnproto.git$ git branch -l
> > * master
> >
> > I find the splat in the response unhelpful
> > when wrapped in shell for loop, the splat expands into everything in
> > current directory
> >
> > jimc@frodo:~/prj-1/capnproto.git$ for b in `git branch -l`; do echo $b; done
> > appveyor.yml
> > c++
> > CMakeLists.txt
> > CONTRIBUTORS
> > ...
> >
> > it would be nice if some flag combo would suppress that splat.
> > save me from fugly brittle sh $IFS fiddlery and incomplete workarounds
>
> Have you tried "git for-each-ref --format="%(refname:short)"
> refs/heads/"? That's going to provide short names for branches without
> any indicator for the default branch, and without any special
> ordering.

More generally, I think you should take a look at `git help git` and
check out the difference between "porcelain" and "plumbing" commands.
The former, of which `git branch` is one, are intended for interactive
use and not really meant for scripting or piping. You can usually come
up with an equivalent from the plumbing commands, which Bryan has
suggested for you with `git for-each-ref`.  Git project tries very
hard to maintain output format of the plumbing commands so as to not
break folks' scripts, but such promises aren't usually made for
porcelain commands.

-- 
Emily Shaffer
