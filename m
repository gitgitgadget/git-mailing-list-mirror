Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717021F461
	for <e@80x24.org>; Wed, 15 May 2019 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfEOUQE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 16:16:04 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:35460 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEOUQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 16:16:03 -0400
Received: by mail-qk1-f182.google.com with SMTP id c15so864448qkl.2
        for <git@vger.kernel.org>; Wed, 15 May 2019 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TA/3DVokvCvVKdkwLm8JTvTrcgK6eGjoGW5GYgdhFOY=;
        b=dHA+tGpsDzVqTWMBblRg+KKxPkYdbKHWjMimxN1ElVZnxUK6MtVZyz3EPBn8HGiVGb
         VItNEIGRnJKQk1x06ppfg6MeyLOL/mIYp29HYzyRWomFCivnkC7bKgMM9vrcnMxr7drK
         nmJosMoCkXYTGnyB5GXxo3tfWQLrEzyDvRFAS17diJw5y1W9sQD/OqA1/7/aYjjSjmob
         fsv2gnA3LWFNX7XC3L+UgXY07b/GOPFfbFtaSRASmpvKaMcp8QdQc+736a4JPXUTllBO
         0OnYHjpedXpnW3TtJa6ezO+bl+yJHi/Royd71YdBsZ0fJPVR+h7CPkPQT1IlBz3cJKTJ
         08ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TA/3DVokvCvVKdkwLm8JTvTrcgK6eGjoGW5GYgdhFOY=;
        b=qm0BPPDNnus+ptoXhKKahzhSRmctUIl9STtNR+MQwnsWR3vAzSsGmqAbeFbqvhfAH1
         ahjxXBsIKQpqjGPahVFwvKyThD2/ShMCKzeCu60occ8MkbdnRPR9HerJulsC/qSrYi9j
         p0RHLmDqMeKnL3BU+CbtZlA1IEAEX7t/zuKBWzRVtIZBuUUVezJ8I1qsN8mBAEfdYLMh
         b8F6KgvvGRDA1HqN6Z/mzuY6kEponCbuPTthLBi3YSAkB7VYvPOlCLWIfZ0QHz1LjmIH
         PO/FBQaK9DR5/4V6wla7vpKLtIUkkk51tJZ19lM77korcbn7ElOdb+mKuijXhIoctTX2
         io3A==
X-Gm-Message-State: APjAAAXvYgSBeAlMKE9o+ILYwq6HXzv5xe4yz/ATqbUn/F6eW+DVfohM
        eLYG5GZAN5fy7KLVZSfbj7lly81JCdU=
X-Google-Smtp-Source: APXvYqymf+jUxu5LWLiJ0DlXsL/sxbrVs6oFuxFW/AVeEwCtGmkyqDIlypNBL4hNWIIxuYQw33bFeA==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr27842146qkj.82.1557951362382;
        Wed, 15 May 2019 13:16:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eca6:557e:6c46:8ae8? ([2001:4898:a800:1010:9ddc:557e:6c46:8ae8])
        by smtp.gmail.com with ESMTPSA id z11sm1270110qki.95.2019.05.15.13.16.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 13:16:01 -0700 (PDT)
Subject: Re: Finer timestamps and serialization in git
To:     "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
References: <20190515191605.21D394703049@snark.thyrsus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
Date:   Wed, 15 May 2019 16:16:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190515191605.21D394703049@snark.thyrsus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2019 3:16 PM, Eric S. Raymond wrote:
> The deeper problem is that I want something from Git that I cannot
> have with 1-second granularity. That is: a unique timestamp on each
> commit in a repository.

This is impossible in a distributed version control system like Git
(where the commits are immutable). No matter your precision, there is
a chance that two machiens commit at the exact same moment on two different
machines and then those commits are merged into the same branch. Even
when you specify a committer, there are many environments where a set
of parallel machines are creating commits with the same identity.

> Why do I want this? There are number of reasons, all related to a
> mathematical concept called "total ordering".  At present, commits in
> a Git repository only have partial ordering. 

This is true of any directed acyclic graph. If you want a total ordering
that is completely unambiguous, then you should think about maintaining
a linear commit history by requiring rebasing instead of merging.

> One consequence is that
> action stamps - the committer/date pairs I use as VCS-independent commit
> identifications in reposurgeon - are not unique.  When a patch sequence
> is applied, it can easily happen fast enough to give several successive
> commits the same committer-ID and timestamp.

Sorting by committer/date pairs sounds like an unhelpful idea, as that
does not take any graph topology into account. It happens that commits
can actually have an _earlier_ commit date than its parent.

> More deeply, the lack of total ordering means that repository graphs
> don't have a single canonical serialized form.  This sounds abstract
> but it means there are surgical operations I can't regression-test
> properly.  My colleague Edward Cree has found cases where git fast-export
> can issue a stream dump for which git fast-import won't necessarily
> re-color certain interior nodes the same way when it's read back in
> and I'm pretty sure the absence of total ordering on the branch tips
> is at the bottom of that.

If you use `git rev-list --topo-order` with a fixed set of refs to start,
then the total ordering given is well-defined (and it is a linear
extension of the partial order given by the commit graph). However, this
ordering is not stable: adding another merge commit may swap the order between
two commits lower in the order.

> I'm willing to write patches if this direction is accepted.  I've figured
> out how to make fast-import streams upward-compatible with finer-grained
> timestamps.

Changing the granularity of timestamps requires changing the commit format,
which is probably a non-starter. More universally-useful suggestions have
been blocked due to keeping the file format consistent.

Thanks,
-Stolee

