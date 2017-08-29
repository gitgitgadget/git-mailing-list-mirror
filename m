Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62C51F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdH2SaO (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 14:30:14 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32953 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdH2SaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 14:30:11 -0400
Received: by mail-pf0-f171.google.com with SMTP id r62so12537547pfj.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LNqBW8KvwH+Qa1HiBIOClKDO+HkOUjSskUd+jG0Gvk=;
        b=oFf4SVPMSq9+Wuw2gGQYYDWSaCNfNXskkYr5kf8XTtS6VxUWof+BweSgHlKj7dN1ho
         MhjzMHhGPJ/dK1ejahfCwr9TZM4wBSqOmQ0revXj/9hB9T17fFa8NljBlhb+mPUcz8Cx
         rrsDvdEE1aU+by9RlcCAWxnSOr+TH4TITYTO72GtfQY9lS2UO5SDGEhOTg/xkcstALjd
         fIhzGdDr7JymiE7SfRnr8hGxLq6koh26im5JgjC5sOowZCU2cW7e9+mORZs6SeyXbeUE
         RvbvTiFGhw2uvdNDD2jnweoHVdAatHp0rsZOVNmzeUBL1xhVzB6yXL3GJBvNu3jrpSZc
         Ekog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LNqBW8KvwH+Qa1HiBIOClKDO+HkOUjSskUd+jG0Gvk=;
        b=dZHghBa6tzoHVvO+PiuwAyW69OG3Y4rPCGoGjfH3KNwdxYNYxtHnjmTZo7CtKqLaRT
         qUWor193n77zGCdm8G0L5Av7lRVK37+nDRuBujK2wwBc+hELVdZwQ02mO5a92UsCafFu
         84Am6PP36Rf8ZnMThqqHA1A6VE78VTc8aRG56EzzTVmN6MMKLLIQEEz1vV1gEfhMp+Eh
         vW+8CJseZUjn/FpbW7FKXbMGb0uoEL3VeRzpN4bLz1s9qYGyhnYq8xlMawoJNlpX19gF
         lFVKmdR6g/UZVkjw5+ww7qsVivGtwWlfq4CASC6jrqDZgEm1dsS8F0sRU9Ah7TCQYi8F
         DcEg==
X-Gm-Message-State: AHYfb5gqx6G6wYhha2kr/d+SyGiSd/z8TsWyDI7LhMp0jrdOoFGTp61P
        6a8o2H7pqXDCIIhF
X-Google-Smtp-Source: ADKCNb6cWo9w0OtSGC5UYjM44P0It26f2HfGA6Z/ZFdULUcRJPIqk26U2GXeTKFcrQInyns+wpGP1A==
X-Received: by 10.99.108.136 with SMTP id h130mr1195206pgc.317.1504031410817;
        Tue, 29 Aug 2017 11:30:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:7c99:20b:3f53:fc88])
        by smtp.gmail.com with ESMTPSA id o17sm4786654pgc.88.2017.08.29.11.30.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 11:30:09 -0700 (PDT)
Date:   Tue, 29 Aug 2017 11:30:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/10] Implement transactions for the packed ref store
Message-ID: <20170829183008.GC131745@google.com>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Michael Haggerty wrote:
> This should be the second-to-last patch series in the quest for
> mmapped packed-refs.
> 
> Before this patch series, there is still more coupling than necessary
> between `files_ref_store` and `packed_ref_store`:
> 
> * `files_ref_store` adds packed references (e.g., during `git clone`
>   and `git pack-refs`) by inserting them into the `packed_ref_store`'s
>   internal `ref_cache`, then calling `commit_packed_refs()`. But
>   `files_ref_store` shouldn't even *know* that `packed_ref_store` uses
>   a `ref_cache`, let alone muck about in it.
> 
> * `files_ref_store` deletes packed references by calling
>   `repack_without_refs()`.
> 
> Instead, implement reference transactions and `delete_refs()` for
> `packed_ref_store`, and change `files_ref_store` to use these standard
> methods rather than internal `packed_ref_store` methods.
> 
> This patch series finishes up the encapsulation of `packed_ref_store`.
> At the end of the series, the outside world only interacts with it via
> the refs API plus a couple of locking-related functions. That will
> make it easy for the next patch series to change the internal workings
> of `packed_ref_store` without affecting `files_ref_store`.
> 
> Along the way, we fix some longstanding problems with reference
> updates. Quoting from patch [08/10]:
> 
>     First, the old code didn't obtain the `packed-refs` lock until
>     `files_transaction_finish()`. This means that a failure to acquire the
>     `packed-refs` lock (e.g., due to contention with another process)
>     wasn't detected until it was too late (problems like this are supposed
>     to be detected in the "prepare" phase). The new code acquires the
>     `packed-refs` lock in `files_transaction_prepare()`, the same stage of
>     the processing when the loose reference locks are being acquired,
>     removing another reason why the "prepare" phase might succeed and the
>     "finish" phase might nevertheless fail.
> 
>     Second, the old code deleted the loose version of a reference before
>     deleting any packed version of the same reference. This left a moment
>     when another process might think that the packed version of the
>     reference is current, which is incorrect. (Even worse, the packed
>     version of the reference can be arbitrarily old, and might even point
>     at an object that has since been garbage-collected.)
> 
>     Third, if a reference deletion fails to acquire the `packed-refs` lock
>     altogether, then the old code might leave the repository in the
>     incorrect state (possibly corrupt) described in the previous
>     paragraph.
> 
>     Now we activate the new "packed-refs" file (sans any references that
>     are being deleted) *before* deleting the corresponding loose
>     references. But we hold the "packed-refs" lock until after the loose
>     references have been finalized, thus preventing a simultaneous
>     "pack-refs" process from packing the loose version of the reference in
>     the time gap, which would otherwise defeat our attempt to delete it.
> 
> This patch series is also available as branch
> `packed-ref-transactions` in my fork on GitHub [1]. A draft of the
> patch series to change `packed_ref_store` to use mmap and get rid of
> its `ref_cache` is available as branch `mmap-packed-refs` from the
> same source.

Overall the patches look sane to me, though I don't believe I'm
qualified in this area to give you a complete thumbs up since I don't
understand the refs code super well yet.  I do like reading patch from
you as you do a great job of laying out what you are doing in code,
comments and commit messages, something I'm trying to get better at :)

-- 
Brandon Williams
