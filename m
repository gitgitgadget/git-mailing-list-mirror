Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2071F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeJOWrz (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:47:55 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35717 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOWrz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:47:55 -0400
Received: by mail-vs1-f68.google.com with SMTP id c10so16438934vsk.2
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwY2311toJ+qufYkgWFPvF/0Rf0TFra9A0W02781aGI=;
        b=fIOMsuCoQlajvmwqFgTYgJ1rDBCj9elsdLNQiEbBEhUv2QE6rz3RfaSiFATKevexBK
         gEklEJk7CL/Gq/K8kEDF6ZBJ4j4lGPO8zEYLq2pNnWOZagrWuiPnwLIQbloyJKsb5LK0
         DQG7OZmpP2NKN6Ic2+IcE1SDFkB/XLqe4QfvJ6r8al6r0y87t+TdEvHqxtAqsaHUVsn9
         AHgG9pPaMA4Ru+rhgw0/NnVJ5kCpwRCloXu22mnXxdUxP9Pp7yxiw4vplr+OIpVALRRv
         VL5I4EImNdoKAG5xUEmDwQJfTOpXifHnET0N9cu9ZgWgRzBYIriyVPRv/dAFnHMyuEQ0
         ILBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwY2311toJ+qufYkgWFPvF/0Rf0TFra9A0W02781aGI=;
        b=NzJz4+gr6YH8I28vRIGgYi+yfDYKEDjL9+heUPqwXOND4AYW87aRwTKlbHqHxhDZ8M
         pFHqnfidTVSvCpOeKRKpZzqXGQP1NVYkoV0W+f5colJKJW/2ZGyYoUnv/KrizdBToYqs
         /aDVIaEZI5NoFQxtw4qyszWL+6Coyqx1nOYiprrdvPgUGaWF9RCO4Q8cRsOtmvHO88SJ
         3RG4zm9wKlejdf4w84EPdXkkxhWKzXah+hJG9fuyoAQLVOr570TSJyldeaAfkencTCzl
         OS5mjtNAZVGcWzF87oZPeN7cTnQvgqcYaAjfihn10R5ulu8Of9T98aDm+OnKjvH9Es7/
         HBnQ==
X-Gm-Message-State: ABuFfoiGaJxrVqLOSuBVo+RL7RSld2iO9yMWAfevLW/9zmQBHSlSA8kT
        vGZZ2/Ua/ZAlY4xAdc6HNuOirSizsCqseu2cvML4g6wt
X-Google-Smtp-Source: ACcGV633xWQuMzOmg+bAxysGrTe9kF6ja75gan8/NdMPM5AkeBkglbxkbpF4+QlJMrhLDDO5Mx/sQoPhTkSwtJVWd4Q=
X-Received: by 2002:a67:d199:: with SMTP id w25mr6793082vsi.53.1539615736590;
 Mon, 15 Oct 2018 08:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181012212551.7689-1-newren@gmail.com> <20181012212551.7689-3-newren@gmail.com>
 <xmqq8t2z6bem.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t2z6bem.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Oct 2018 08:02:05 -0700
Message-ID: <CABPp-BFJTFN1prCwkidnQiKNP=5wdAV0AdXEkTjCT3HTHyB=Mg@mail.gmail.com>
Subject: Re: [PATCH 2/4] merge-recursive: increase marker length with depth of recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 10:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > When using merge.conflictstyle=diff3 to have the "base version" be shown
> > in conflicts, there is the possibility that the base version itself has
> > conflicts in it.  This comes about when there are more than one merge
> > base, and the merging of those merge bases produces a conflict.
> > Since this process applies recursively, it is possible to have conflict
> > markers nested at an arbitrary depth; to be able to differentiate the
> > conflict markers from different nestings, we make them all of different
> > lengths.
>
> I know it is possible that the common ancestor part that is enclosed
> by the outermost makers can have arbitrary conflicts, and they can
> be even recursive conflicts.  But I fail to see why it is a problem.
> Perhaps that is because I am not particularly good at resolving
> merge conflicts, but as long as the common part of the outermost
> merge is identifyable, would that really matter?  What I would do
> while looking at common ancestor part with conflicts (not even a
> recursive one) is just to ignore it, so...
>
> Not that I strongly oppose to incrementing the marker length at
> every level.  I do not think it would hurt, but I just do not see
> how it would help.

Fair enough.  The real motivation for these changes was the
modification to rename/rename(2to1) conflicts (and rename/add
conflicts) to behave like add/add conflicts -- that change means we
can have nested conflict markers even without invoking the recursive
part of the recursive machinery.  So, I needed a way to increase the
length of the conflict markers besides just checking
opts->virtual_ancestor.  Just using a fixed extra indent seemed
problematic, because if I also had to worry about even one
virtual_ancestor, then I was already dealing with the possibility of
triply nested conflict markers and only one of them from a virtual
merge base.  See t6036 in
https://public-inbox.org/git/20181014020537.17991-3-newren@gmail.com/.

However, that series was long enough, so to try to simplify review I
split as much as I could out of it.  That resulted, among other
things, in me submitting this marker nesting change as part of this
series using a more limited rationale.

Would you like me to edit the commit message to include this more
difficult case?
