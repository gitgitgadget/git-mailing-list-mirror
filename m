Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA3C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiF3Ry0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiF3RyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:54:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE837A9F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:54:24 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 2so392093qvc.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emABBXQf8eD8t8JGORMXDnrzAK4kIThU1JEg+4TZy5g=;
        b=dYPDeOmA8OlIKtlzyRLrB5i3EIcHQ9lJedXLiA+dAz+GakXTzq45urjl6N+uAjfQ35
         cHNlbvc9TQ8i5zsaok7OSSYFDlVsvBLF97VgI3vldMirDnmbaO6rSUqWSSxJkbz2Odi9
         aA7/LZlDQiXQpFv28zHzi5tCSv+aSNeBEEYY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emABBXQf8eD8t8JGORMXDnrzAK4kIThU1JEg+4TZy5g=;
        b=sepfxsIOMNFw9a1Xj+0YXBHI1j8HNvkVKQXkKcZxuiS1KafxmLUgCTmFuHT+Q1O/+2
         QAKHLlbmKb1QVsf6BrJPpjOHH2fJRlXiQBSR5T7jGFGPoxx9Dx3YWYUfmB/mR4SVTrT3
         UDidg39bhKsu2JW08w0RTHShuUo8yjjviCaYFwsa2wvdsCrjsyY7ySprZVncLjhQHqib
         NMPuEqC/9XmB2k0dwUwIJIhoARiZQpx84HGm9nArUpY3P7kQbz1APAlLOXTcBkVJQ6wv
         Rsg8NDSAswFlSdECxDmseXp9GMC31WLskwewEzwae4wWgSIWVQTkGafH+kEgBoxKaKk7
         eLNA==
X-Gm-Message-State: AJIora+9Ze4dCtou9fI4COnwyVZYop/3CIpL4bDp5vFrDpbTiGaSya+t
        CQTEiJjL1jCIRNNlxKGOJflekIFaGl60hQ==
X-Google-Smtp-Source: AGRyM1u/zIxZt8QmwLKPMfQ3s8oTm8kp4RIy3vBIjGq67gwal0Kw5LG7LVLGoEwUx/h8IFBAViH4xg==
X-Received: by 2002:ac8:5cc9:0:b0:304:e03b:5964 with SMTP id s9-20020ac85cc9000000b00304e03b5964mr8565083qta.433.1656611663395;
        Thu, 30 Jun 2022 10:54:23 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id v123-20020a379381000000b006a6c230f5e0sm7358366qkd.31.2022.06.30.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:54:23 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:54:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Non-interactively rewording commit messages
Message-ID: <20220630175421.wbgqnmym7ioazdzo@meerkat.local>
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
 <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 07:34:54PM +0200, Christian Couder wrote:
> > Hello, all:
> >
> > What's the best approach to non-interactively rewrite specific commit
> > messages? In this particular case, I am trying to automatically retrieve code
> > review trailers sent to the mailing list and put them into corresponding
> > commits.
> >
> > For example, I have a set of commits:
> >
> > abcabc: This commit does foo
> > bcdbcd: This commit does bar
> > cdecde: This commit does baz
> >
> > They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
> > to the second commit. In a usual interactive rebase session this would be:
> >
> > pick abcabc
> > reword bcdbcd
> > pick cdecde
> >
> > When the edit screen comes up for the bcdbcd commit, the author would manually
> > stick the new trailer into the commit message. However, I can automate all
> > that away with b4 -- just need a sane strategy for non-interactively rewriting
> > entire commit messages at arbitrary points in the recent history.
> >
> > Any pointers?
> 
> Have you tried `git interpret-trailers`?

I'm aware of interpret-trailers, but unless I'm missing something large, it's
just a way of analyzing standalone text files to retrieve or insert trailers.
What I'm looking for is a way to amend arbitrary commit messages within recent
git history.

-K
