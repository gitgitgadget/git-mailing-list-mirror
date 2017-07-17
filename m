Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4796F20357
	for <e@80x24.org>; Mon, 17 Jul 2017 18:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdGQSD2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 14:03:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34999 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdGQSD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 14:03:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so20329492pfq.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wq1ZkbXL/DOspuOd5CRtfWkGlIjan/8UC+ywridV8c=;
        b=EkA1ChrutJDskGHejgVcSnQCip/s4rFnCocpMDuyeWKg//tP5HjNCtsR08bEnD5vYa
         tJxQ7kP1IMwO0Gd4i1jcoX5RUGWf2UFmAOwUSHNg07FaHHUghLrYdgC5bRaCu0cdJTU8
         QMxlriZmgYo+xCZSBTE8aIcpSef761mX6HzL0gD5axCvBuKCYD/gq4ge11Gmx4TID13l
         7I3Kcx8ndRooxu8h4LsitcedTSZXyrEV0tClLHUhLrWyj7it1/twWFnEB0DsTyARcpyG
         27qeq+2FUJ6UoMrq4UPLoHHRRWbEtgS1yrM2uHHpZA3HT87C3k1Eme0lj8JYcdlP6KOb
         X9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wq1ZkbXL/DOspuOd5CRtfWkGlIjan/8UC+ywridV8c=;
        b=sN0qHWhsHwbwLhy3SWUc4GUtx4hSghLkxFySIm62+s9D08DvUftqKQBeT+W4o+GNRm
         gdbw73G44X1W2tsjCXjtrI4JY3cLvI3WHlGFAzZ65cNbUBNsC+Ky5wzPEeqtVf5o/P/t
         dhOKm11Xx5oXwzfWd4QaMFdL4ejg1QlgeGvwsYyYQZlEjEPjT4cpvHVjDp/oIJLGXbfX
         CRJnxA/1sSIhM+CkWWkZk+vL6UJRd4wKUZL4cdmZ+w5kRUSwLt5FSKxEHVqV8HwuUfff
         e9msn2iGGw7BICuxG+eY2ikk2ybvbE3G6+A2VcqkG6IrgANS30Ojr88PclC3q64acz4S
         6foA==
X-Gm-Message-State: AIVw110Bj33vpLBlYuvuxJRXuqIvpAPjH1ZZL2kgKik+4JVtngWw/clj
        RuoiynUKr9BQYA==
X-Received: by 10.84.237.8 with SMTP id s8mr31216004plk.163.1500314606816;
        Mon, 17 Jul 2017 11:03:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8ce8:54ee:549a:2508])
        by smtp.gmail.com with ESMTPSA id b8sm40538198pfd.65.2017.07.17.11.03.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 11:03:24 -0700 (PDT)
Date:   Mon, 17 Jul 2017 11:03:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing
 blobs")
Message-ID: <20170717180322.GM93855@aiede.mtv.corp.google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

Philip Oakley wrote:
> From: "Jonathan Tan" <jonathantanmy@google.com>

>> These patches are part of a set of patches implementing partial clone,
>> as you can see here:
>>
>> https://github.com/jonathantanmy/git/tree/partialclone
[...]
> If I understand correctly, this method doesn't give any direct user
> visibility of missing blobs in the file system. Is that correct?
>
> I was hoping that eventually the various 'on demand' approaches
> would still allow users to continue to work as they go off-line such
> that they can see directly (in the FS) where the missing blobs (and
> trees) are located, so that they can continue to commit new work on
> existing files.
>
> I had felt that some sort of 'gitlink' should be present (huma
> readable) as a place holder for the missing blob/tree. e.g.
> 'gitblob: 1234abcd' (showing the missing oid, jsut like sub-modules
> can do - it's no different really.

That's a reasonable thing to want, but it's a little different from
the use cases that partial clone work so far has aimed to support.
They are:

 A. Avoiding downloading all blobs (and likely trees as well) that are
    not needed in the current operation (e.g. checkout).  This blends
    well with the sparse checkout feature, which allows the current
    checkout to be fairly small in a large repository.

    GVFS uses a trick that makes it a little easier to widen a sparse
    checkout upon access of a directory.  But the same building blocks
    should work fine with a sparse checkout that has been set up
    explicitly.

 B. Avoiding downloading large blobs, except for those needed in the
    current operation (e.g. checkout).

    When not using sparse checkout, the main benefit out of the box is
    avoiding downloading *historical versions* of large blobs.

It sounds like you are looking for a sort of placeholder outside the
sparse checkout area.  In a way, that's orthogonal to these patches:
even if you have all relevant blobs, you may want to avoid inflating
them to check them out and reading them to compare to the index (i.e.
the usual benefits of sparse checkout).  In a sparse checkout, you
still might like to be able to get a listing of files outside the
sparse area (which you can get with "git ls-tree") and you may even
want to be able to get such a listing with plain "ls" (as with your
proposal).

Thanks and hope that helps,
Jonathan
