Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE681F453
	for <e@80x24.org>; Wed, 17 Oct 2018 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJRBuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 21:50:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46376 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRBux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 21:50:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so25677339edg.13
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGS5RjgETaZ6vFdtIGrneD/z7V/ar5VopUsbYBBkq7s=;
        b=pSYhPU8xME5zweQAXmaVKqBNHekRJtWzhoMVnxUpECoETUTBMiyrpNVQVLz0YvKP1Z
         RDM525Yjqlb7C0A7EuDQX33N0c8UCdl0BiQxbU2sT5TuLta+oTOPxF6OAz3LYHykep3X
         Z0xOQ3onsivFEa42fgBxVZsyus8xV7H2NU8KG5NE2KFKQZssXeklzx82VEnBofBLAu+C
         PQUOlmQOV69BIIpLyb0i52owXGjKPUgGfRIvkcpHwC+Gj+Xf2fJnzonLXbnb8aeJN+Ue
         6LNSgnsjJlwHSLHJFw2RZmMPxTLUG7hKbFt/cuRXTJ8DVMyAu9OOnRL8Hz5blHOmwMJD
         2vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGS5RjgETaZ6vFdtIGrneD/z7V/ar5VopUsbYBBkq7s=;
        b=HFSl7eAgk/8pE3yP77hH+WCnnZ7Xa56hLw9cwBjNjyCQle8ZPLCqZQgRyPwkDknVAy
         G38Mc/OcX/t8FkE3yH7fd+QH1K6RWm791jq9nwuXQuUv8k9LH8TESPM9FBmgdahw0VrY
         N3THRMcoYJ/h0I8VbTs+1IVPyyBPNUWoaiBs0LCEdPMAeGBLCJnNC28wdVTVauBH9grf
         zktEHlyYE0EsoEddaoQlfNW9JNft+zR3iR2mipBGP/URW92NeXmXYtI/P3070Y0lSFim
         BlDb0SOeLxj8YaMc34bQK3eZ5hU1ZXlHcWLXYbxCadQJp41M/+DFjDITTHtlUpU5yftT
         yrqQ==
X-Gm-Message-State: ABuFfojyblCpNWGg3/NY6emOoHX/Ljm8UJkXIzpi0jTclZI71+9rLdHl
        UhVBMDTOQEg8JGAJWPM5AtNyJjiNaZStGYr6Ut+IekvYLPePZw==
X-Google-Smtp-Source: ACcGV63+tBH/Kxikaf/+BWSFJzSYgLNAQWX7liDbKabKBp9JjUFPZW49LBL3sbrRIOYUgSvT8SklOBnH4Ep1V+HR3nE=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr1302544edh.154.1539798844978;
 Wed, 17 Oct 2018 10:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <feef12c7-e609-dc6e-104d-7381471afb9c@gmail.com>
In-Reply-To: <feef12c7-e609-dc6e-104d-7381471afb9c@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 Oct 2018 10:53:53 -0700
Message-ID: <CAGZ79kbpXQURMsZY15_k3rJ-dyH0i4qAGDv8umM8Hmx10ZdMMA@mail.gmail.com>
Subject: Re: [PATCH 00/19] Bring more repository handles into our code base
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 5:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/16/2018 7:35 PM, Stefan Beller wrote:
> >
> >      This series takes another approach as it doesn't change the signature of
> >      functions, but introduces new functions that can deal with arbitrary
> >      repositories, keeping the old function signature around using a shallow wrapper.
> I think this is a good direction, and the changes look good to me.
>
> >      Additionally each patch adds a semantic patch, that would port from the old to
> >      the new function. These semantic patches are all applied in the very last patch,
> >      but we could omit applying the last patch if it causes too many merge conflicts
> >      and trickl in the semantic patches over time when there are no merge conflicts.
>
> The semantic patches are a good idea. At some point in the future, we
> can submit a series that applies the patches to any leftover calls and
> removes the old callers. We can hopefully rely on review (and the
> semantic patches warning that there is work to do) to prevent new
> callers from being introduced in future topics. That doesn't count
> topics that come around while this one isn't merged down.

For those topics still in flight, I added re-defines, e.g.

#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
#define get_merge_bases(r1, r2)
repo_get_merge_bases(the_repository, r1, r2)
#endif

so the base function still keeps working, and we can cleanup
multiple times, until eventually, we can get rid of the base function.

> I had one high-level question: How are we testing that these "arbitrary
> repository" changes are safe?

I did the bare minimum in conversions in this series, such that the
submodule code tests successfully. So if we'd revert some parts,
the submodule tests would break.



> I just remember the issue we had with the
> commit-graph code relying on arbitrary repositories, but then adding a
> reference to the replace objects broke the code (because replace-objects
> wasn't using arbitrary repos correctly, but the commit-graph was tested
> with arbitrary repositories using "test-tool repository"). It would be
> nice to introduce more method calls in t/helper/test-repository.c that
> help us know these are safe conversions.

Or instead we could accelerate the long term plan of removing a
hard coded the_repository and have each cmd builtin take an additional
repository pointer from the init code, such that we'd bring all of Git to
work on arbitrary repositories. Then the standard test suite should be
okay, as there is no special case for the_repository any more.

> Otherwise, we are essentially
> waiting until we try to take submodule things in-process and find out
> what breaks. As we discovered with the refstore, we can't just ensure
> that all references to the_repository are removed.

Yes, that is correct. We had a similar case with partial clone,
as laid out in the cover letter for the RFC.

I'll explore both the test tool approach as well as
repository-fication of the code base.

Thanks,
Stefan
