Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56AC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiGYVRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiGYVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:17:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01E20F7D
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:17:29 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u12so9255582qtk.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=frramBKz/SPzBAdKkDSowJdolooZDvAqz3wsg1TCWds=;
        b=DWmusN3aVQ46V0ijUFf9W3rsrAjUUIYClj9YiILD5Yxqk6CqVlxZvxW2OsvVe+Im/9
         VRgjMlFM127EUyQo74XuvkJn8Mk48IDLL8pc+qNYVHnPgy/KJlm395GadviEok7JP05e
         c4OWRO5f5z8yu4qJu1m6UQB/ZN53YpizbowPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frramBKz/SPzBAdKkDSowJdolooZDvAqz3wsg1TCWds=;
        b=NwXfodXEOd4vizRx/qP+LXtAlJrI2crSyl9fwPUGIWXEL0RMecZmVVF0EciGXLCXKA
         DOSETH8nXZZGjpRcC0fvYWnufYWYZrOTy2yB8H0qZD4wYE5BqJbZKZ0GQYK/TK6jVx0m
         cxSSgkawtBYUgQASDvyxUVWMjxtSbG2zLjqjrlO339POAKXhb2JUlGiQ5TZcWrN9gmFr
         DRNuRi8xTjg7TE6ICOSJcMwQLLt1xu8hSQvES5KQedU3+MaT3GG6wvppYB8ZB+fPpa85
         h1ROZcMDduMKFwTyCHrEmxfoG/fJObhd9tjqRXg8kDerTq0OCnNLQA9LZPfg60YSjWY9
         psOQ==
X-Gm-Message-State: AJIora9yRgr6+DJASMPpBXkXOQphI2wCmCNgX7DDjfOWDb5buE3zRXus
        qsgaBRNGJo4gJqaybSpvle4jRA==
X-Google-Smtp-Source: AGRyM1vboEju0bdJQo7lsoopxtF8KSfgKuwCi2sGH7bsKOMoj+jimNYEmwiyEc5Ez55JYmG821NsRQ==
X-Received: by 2002:ac8:598e:0:b0:31e:e390:29e7 with SMTP id e14-20020ac8598e000000b0031ee39029e7mr12149028qte.265.1658783848443;
        Mon, 25 Jul 2022 14:17:28 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a240400b006b64d36342fsm4722372qkn.68.2022.07.25.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:17:27 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:17:26 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [filter-repo] How to reorder commits
Message-ID: <20220725211726.tkmpvgetsh4fdfdv@meerkat.local>
References: <20220721151937.adgufwkj3uxkk3yb@meerkat.local>
 <CABPp-BE2391i7syZJUK1Nqjk9VZhSxqto0pb7xBLDZR_fY3FXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE2391i7syZJUK1Nqjk9VZhSxqto0pb7xBLDZR_fY3FXA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 04:18:48PM -0700, Elijah Newren wrote:
> > - keep the cover letter at the start of the series in order to cleanly
> >   delineate where their work starts (and thus avoid potential problems with
> >   rebases and finding fork-points with base branches, which tends to give
> >   newbies trouble)
> > - when the author is ready to submit their work, move the cover letter to the
> >   tip of the branch and tag it as "foo-bar-v1"
> > - when the author is ready to work on their changes, they run --reroll and we
> >   move the cover letter back to the start of the series, adding any necessary
> >   template "changes in vX" entries to it
> >
> > (or maybe it will go completely differently -- it's all very fluid right now)
> >
> > Basically, is git-filter-repo the right tool to reorder commits, or is it best
> > to go directly with fast-export/fast-import?
> >
> > Thanks in advance,
> > Konstantin
> 
> Generally, it makes no sense to reorder commits in filter-repo, nor
> does it make sense to do so using fast-export/fast-import directly.
> fast-export/fast-import don't "apply a diff" to get a new tree, they
> say "Make these files have these exact contents".  Perhaps an example
> would help to explain what I mean...

Thank you for the detailed reply, Elijah. You did convince that filter-repo is
not the right tool for this case, so I went with cherry-pick instead. Since my
case is very straightforward with simple ranges and a guarantee of no
conflicts, it's the most straightforward solution.

Cheers,
Konstantin
