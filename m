Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BED7211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 23:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLFXyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:54:55 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55651 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFXyz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:54:55 -0500
Received: by mail-pf1-f201.google.com with SMTP id s71so1665976pfi.22
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bYZ+t9cgTN1CDeYVvkcZPirNTEe8ROGTisk8kvR1RnM=;
        b=aaQ0NjagJTWFdSjZTJ1G/UBbFIJbsDjiGrgDA8q1yXyH7iQQ4sQvRzRAohWH5ir1Xl
         Cl73ocr3jzVAbv2W0Cp844ElIueW+v2jo4CzpcdnTT4trlc4qxkM5i755M5HMcnFYnr1
         vn1Yag3WW2G3B1zY5BzvwqEnYLui0XkYVi/P6PT0Pvp48h+cLZ6V3JWqSIcaPv8316KH
         MjvPddbQcEkzbKIosAZ6jd5RAjRH+Y1Pnce8Ct3KrOqu9NU6sbF5V01x+tv+VoX4+0Yf
         AbRNfZOoSsav5fR5GeYFvkV+bnsnSN+hG9us+lx3HE33Z1T00dJmRyJNmkrj0EXo2Tpt
         P40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bYZ+t9cgTN1CDeYVvkcZPirNTEe8ROGTisk8kvR1RnM=;
        b=kTencQkaJHTCQoIj3YRvNgawf89hTF9R2JdkVkuVCzZNKT9R2tsLa9+X4XP/QO8vve
         PSgKISr6F/mDFMqdtHOk4gMe6XaO3XMl0hCFAtFiWtv5hVpXtCJUj1t6nv8QRKQiswJE
         m+UH5pVYnv52GkhzT1V7GMjizMgEGYZBZVP6Qm73+tzJ1enzzjkHMBui/Dg3DtRVelfN
         NnPFrQb1TwqS5UqAt1y/oUuGKGE25ozBol2+5y25bBDMiEDOwJ5clDGmVZDb/HI4yrHP
         66kI2Tm+HYdEoLY6hPwH69Fbw7S26kvSNO8FJz2SJ+1hK6LNuLiMrvaKczM4wl7HBK+m
         BbMg==
X-Gm-Message-State: AA+aEWYI2iv3f+aWH4m2EJXE64415aTKsBkq4geg2UYg1lPOd0VLkcBA
        NVfHs2TioF3Hl54Bzuz/3fjDloYnoYGVvNXRoRfI
X-Google-Smtp-Source: AFSGD/WNBxgUxgm4Sz3F4Xy4ITriGfgz2j0iDpDKprMot6mvh4notveCPhSkszFYUAeqEQsOIKXjTLzoobjbA5eulMPj
X-Received: by 2002:a65:5087:: with SMTP id r7mr14432196pgp.141.1544140494030;
 Thu, 06 Dec 2018 15:54:54 -0800 (PST)
Date:   Thu,  6 Dec 2018 15:54:46 -0800
In-Reply-To: <20181205045416.GB12284@sigill.intra.peff.net>
Message-Id: <20181206235446.147173-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181205045416.GB12284@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also CC-ing Stolee since I mention multi-pack indices at the end.

> This seems like a reasonable thing to do, but I have sort of a
> meta-comment. In several places we've started doing this kind of "if
> it's this type of object, do X, otherwise do Y" optimization (e.g.,
> handling large blobs for streaming).
> 
> And in the many cases we end up doubling the effort to do object
> lookups: here we do one lookup to get the type, and then if it's not a
> commit (or if we don't have a commit graph) we end up parsing it anyway.
> 
> I wonder if we could do better. In this instance, it might make sense
> to first see if we actually have a commit graph available (it might not
> have this object, of course, but at least we'd expect it to have most
> commits).

This makes sense - I thought I shouldn't mention the commit graph in the
code since it seems like a layering violation, but I felt the need to
mention commit graph in a comment, so maybe the need to mention commit
graph in the code is there too. Subsequently, maybe the lookup-for-type
could be replaced by a lookup-in-commit-graph (maybe by using
parse_commit_in_graph() directly), which should be at least slightly
faster.

> In general, it would be nice if we had a more incremental API
> for accessing objects: open, get metadata, then read the data. That
> would make these kinds of optimizations "free".

Would this be assuming that to read the data, you would (1) first need to
read the metadata, and (2) there would be no redundancy in reading the
two? It seems to me that for loose objects, you would want to perform
all your reads at once, since any read requires opening the file, and
for commit graphs, you just want to read what you want, since the
metadata and the data are in separate places.

> I don't have numbers for how much the extra lookups cost. The lookups
> are probably dwarfed by parse_object() in general, so even if we save
> only a few full object loads, it may be a win. It just seems a shame
> that we may be making the "slow" paths (when our type-specific check
> doesn't match) even slower.

I agree. I think it will always remain a tradeoff when we have multiple
data sources of objects (loose, packed, commit graph - and we can't
unify them all, since they each have their uses). Unless the multi-pack
index can reference commit graphs as well...then it could be our first
point of reference without introducing any inefficiencies...
