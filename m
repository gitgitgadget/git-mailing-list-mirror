Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D80C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A8061A4F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbhJACJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJACJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:09:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E590C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:07:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v10so29347789edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtiGo2+E5CAcjTYtU8Xt6WFAukCIJ2YMXVcTvU9DPW8=;
        b=WUIeHewh3ZjW2b6/QAqWjUW2a58UuoSFzF2QYS+Jg+r0O0kMddmHwYmMPr0hDzEcnW
         wjVO1kFjCpI4FqT65YVVrUpLICyVZcj+sBkU+CrdgeF+wmdqVYPMA4M5qL7plwYcQ97u
         EasBn7XZF9Dv2mZZUDZ719xmAn0VeRFXO3AfgOG6lDXKhWaLaOLuxJVuSXTbenYuKxq6
         hai+U7ThhKU1Uq03a2VJN7YJilnLFOD/09lqETu+pr23B+KmZRafRzLYy7URLlmiJQGD
         uK6pP1Pg9SUo52o+zSOznN1qdQMwbdd/mhU0lKEVyEOP5HUGM5PY7wFWKajnSDQSuczw
         9+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtiGo2+E5CAcjTYtU8Xt6WFAukCIJ2YMXVcTvU9DPW8=;
        b=Fks0rzi1eQAQZLU8jKVZf6izJxpg4smMRIfKD2Irnvnp4/HuUSrlR97d7GN0zLVd8m
         BDNJDO6qEmPVe9hriOTfHIuGm0W964ZyhwH2FzqoXWT9SLRVuJ6vqZ6KTaO/phDBIh8c
         WZKxyr11CA+khNSu3ASpp+bBAcS9uxviBngoncovnqyHXqmKvwbWocp6ooajO3VPNuNJ
         zfAIqHtIjlmWHCqBxfH68SEsBSoigWajP5NmVPR2hvbz4vyVYArsx5HReiOjsOg9E8rI
         4cVYbNnEj3sOQ6T8vzkoyDJnRxV4FV/TsYRIdugM8uTU3VxaRiKEh+bjsg0/Apb0SMdK
         Vtog==
X-Gm-Message-State: AOAM530pcbDCrUNVX/uvcKQm1DLA+KtPDDRXuKjRJf85UcbKyi6mJa2I
        W4Pulv80/WYaqQUFo0GW48Rd5lzCOGAqHv2KcIX6dAUGQx0=
X-Google-Smtp-Source: ABdhPJxtaM5bLsAjYZlUEu6y3k/gWi6G+TiFFrH17veNGXiuJ5eZLzqP3dVhGyksYN602KMqBILowIyf0icAasGp1gI=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr3221420eji.434.1633054053765;
 Thu, 30 Sep 2021 19:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net> <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
 <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
In-Reply-To: <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 19:07:21 -0700
Message-ID: <CABPp-BFimGLnP331aFqLx0x-uQG7wHwSoN25fcYrPzWU93fn6Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages in
 a file
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 12:58 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 28, 2021 at 11:25:20PM -0700, Elijah Newren wrote:
>
> > > Just brainstorming some alternatives:
> > >
> > >  - we have diff.orderFile, etc. Could we stuff this data into a less
> > >    confusing name (even just "$filename.conflict_msg"), and then provide
> > >    a custom ordering to the diff code? I think it could be done by
> > >    generating a static ordering ahead of time, but it might even just be
> > >    possible to tell diffcore_order() to take the ".conflict_msg"
> > >    extension into account in its comparison function.
> >
> > I can't just go on the ".conflict_msg" extension.  As you noted above,
> > this scheme is not sufficient for avoiding collisions.  So I need to
> > append extra "cruft" to the name in the case of collisions -- meaning
> > we can't special case on just that extension.
>
> Sure, but we can call it filename.conflict_msg.1, etc, and the sort code
> can pattern-match. It can never be fully robust (if you really did have
> a foo.conflict_msg, we'd sort it differently), but I think it's OK if
> the worst-case is that pathological trees get ordered slightly
> sub-optimally).
>
> That said, I think it could also make sense to annotate the conflict
> files by giving them an unusual set of mode bits. That would be easier
> to recognize (and while real trees _could_ have silly modes, we do
> complain about them in fsck, so it shouldn't happen in practice).

I tried giving things unusual mode bits in early versions of merge-ort
for other reasons.  It doesn't work: canon_mode() will "fix" the
unusualness so there's no way for the reader to know that they had
unusual bits.

But, as you said later, avoiding these pseudo-files is going to be
cleaner anyway, so let's just do that.



> > I also don't like how diff.orderFile provides a global ordering of the
> > files listed, rather than providing some scheme for relative
> > orderings.  That'd either force me to precompute the diff to determine
> > all the files that were different so I can list _all_ of them, or put
> > up with the fact that the files with non-content conflicts will be
> > listed very first in the output, even if their name is
> > 'zee-last-file.c' -- surprising users at the output ordering.
> >
> > This also means that if the user had their own ordering defined, then
> > I'm overriding it and messing up their ordering, which might be
> > problematic.
>
> Agreed. I do think it may be too horrible unless you teach
> diffcore_order() to actually understand your annotations in code.  But
> that wouldn't be too hard if it's done in the mode bits.
>
> But I do think anything that avoids these pseudo-files is going to be a
> lot cleaner overall.
>
> > >  - there can be other non-diff data between the individual segments. For
> > >    example, "patch" will skip over non-diff lines. And certainly in Git
> > >    we have our own custom headers. I'm wondering if we could attach
> > >    these annotations to the diff-pair somehow, and then show something
> > >    like:
> > >
> > >      diff --git a/foo.c b/foo.c
> > >      index 1234abcd..5678cdef 100644
> > >      conflict modify/delete foo.c
> >
> > A couple things here...
>
> I think Junio already indicated that we can pretty much make this look
> like whatever we want. As soon as any reader sees "conflict", it should
> happily ignore the rest as something it doesn't know about. And my short
> example here was just meant to be illustrative. I agree it probably
> needs more details (and the whole CONFLICT line that usually goes to
> stderr is probably the best thing).
>
> -Peff
