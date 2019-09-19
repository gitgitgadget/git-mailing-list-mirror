Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12091F463
	for <e@80x24.org>; Thu, 19 Sep 2019 05:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbfISFTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 01:19:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42849 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfISFTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 01:19:10 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so4700361iod.9
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 22:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKqPAoMA6ySBe5Z7sKyMVpaeQHRPED96nM776OZPOGE=;
        b=egELGCyxxovWaBY763GpREAG0gQXJF1YWB0vEUHPVfxSPqcioCN2OEtsp7gy0oERac
         4+HqUbb+slbK6dqu73castFBKiPv2cUixHo2p7oG9HCXEpwZmIlEqut9959o8cdwHJ9p
         uKAgq69T9dpkg/EA0VOL92WbcCCh9PtLA4xxR/1t6LjKWKACnLEx+Ob/cMe7fEYVSbk1
         KoHs86+A0LinBbssxXRcoLhlGEVlrShsLZksBRnTQN6EyFs0PoKqqDiLhbpwJysnQl+r
         NjZizhfXt9OUWuSLI1qnkYG2kffgycmKIDNQubsjFemOebWp6aoZ2CCSQNpN+0zn8Wyo
         7mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKqPAoMA6ySBe5Z7sKyMVpaeQHRPED96nM776OZPOGE=;
        b=gCsY30heegvrtWsDUcRE/na4UzuvUspoZQWWxiu/vKUjZ2ssnp3Nl65X2/Yt5GPOgy
         bjXXvZnqKX2XY9TBfD2u81Rk76pOdmGlpH89eFBjB+uWtPdCHN3LpKOYJ6nOxUXSQUgJ
         JCh4ksWRbEAN2ZdSdIQZdKlXJ8TFTDZJKLbFH4ni0AXEle8zoOBSD6owD6aZA+ytsW1P
         t4pvnIHcqJfRMlZ3673PhAWHrG7no4msxd0ezGqR5NLqwwXoqXs++kkeWptUewYNO/pb
         89KeuFOAQjYK3UeL/dbVUNuKDGWCGkF9RLfdVqn9Y9PWA+1GsFCatG7eC3RyPosfuF3R
         ijvg==
X-Gm-Message-State: APjAAAWAlXEMW1CH614Atx65j04U5AaKdTQhRZ0XKqf0RudtW9m4NHMC
        MjyvSjDPI7gLL3ksyJQrCZxUhxFxDX+AG8CYH+SeUKngotk=
X-Google-Smtp-Source: APXvYqx/ieIMbr9FazKeYkD57ZoJOYpkomxjE9OvFDOdxGrZDWkTnjGO8k5ojGA2DyLu5Eu5UGKSW1CfCMmCOXc6LcI=
X-Received: by 2002:a6b:1787:: with SMTP id 129mr9803573iox.140.1568870349111;
 Wed, 18 Sep 2019 22:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568771073.git.matheus.bernardino@usp.br> <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 19 Sep 2019 02:18:57 -0300
Message-ID: <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 4:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
[...]
> > - textconv cache is written to the_repository's object database even for
> >   submodules. Should it perhaps be written to submodules' odb instead?
>
> You mention "is written", but that is what happens upon a cache
> miss.  Before the code notices a cache miss, it must be checking if
> a cached result is available.  In which odb is it done?  Writing
> that follow the miss should happen to the same one, or the cache is
> not very effective.

Right. Both writing and reading operations on the textconv cache
always happen in the_repository's odb.

> Because you would want the cache to be effective, after running "git
> grep --recurse-submodules" from the top-level, when you chdir down
> to the submodule and say "git grep" to dig further, the answer to
> your question is most likely "yes".

OK, makes sense. To keep this series simple, I think I'll try to work
on this in a following patchset.

> > - Considering the following call chain: grep_source_load_driver() >
> >   userdiff_find_by_path() > git_check_attr() > collect_some_attrs() >
> >   prepare_attr_stack() > bootstrap_attr_stack():
> >
> >   * The last function tries to read the attributes from the
> >     .gitattributes and .git/info/attributes files of the_repository.
> >     However, for paths inside the submodule, shouldn't it try to read
> >     these files from the submodule?
>
> Yes, I think all of those would have worked correctly if we forked a
> separate "git grep" inside submodule repository, but in the rush to
> "do everything in process", many things like these are not done
> correctly.  As there is only one attribute cache IIUC, invalidating
> the whole cache for the top-level and replacing it with the one for
> a submodule, every time we cross the module boundary, would probably
> have a negative effect on the performance, and I am not sure what
> would happen if you run more than one threads working in different
> repositories (i.e. top-level and submodules).

Hmm, I may have gotten a little confused here. Are you talking about
the attributes stack (which contains .gitattributes and
info/attributes)? If so, isn't this stack already rebuild for every
path? I mean, by the previous call chain it seems to me that at least
these two files are reread for every path.

> >   * This function will also call: read_attr() > read_attr_from_index() >
> >     read_blob_data_from_index() which might, in turn, call
> >     read_object_file(). Shouldn't we pass the subrepo to it so that it
> >     can call repo_read_object_file()? (Again, for paths inside the
> >     submodule, read_object_file() won't be able to find the object as
> >     we won't be adding to alternates anymore.)

Just as a side note, I noticed another problem with this: in a
submodule with a non-checked-out .gitattributes, `git grep --textconv`
will successfully retrieve the file from the index. But running `git
grep --recurse-submodules --textconv` from the superproject won't. The
problem is that read_blob_data_from_index() doesn't have the
repository struct and thus cannot strip the subrepo_prefix from the
path (so it won't find it in the subrepo's index). I'll try to fix
this in this series as well.
