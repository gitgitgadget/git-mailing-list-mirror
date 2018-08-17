Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DF01F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeHRBdf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:33:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37347 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHRBdf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:33:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so4942690ywg.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjXBsRDv1tk4lvE9wCvmk+Qp18WBZAwOBHdHQdAP62A=;
        b=Y9tMIYMdrAqX6wXZhQ9Kwtl59BCLx/VZaoDt5NBQ4tsG0SGSRNpa3cuP5+dVGbO4PS
         bdjQLrh/DhzRCuGW9uJVnOSs1VGCLNFanoxN+EvK/Yr1ubtSwAY4rmGY9f9gxC5ScSwv
         vjjUZznAQRDjs2okFD/P+7Zb+PBR6OjbsQDGZHr4g4oRl8tD/nqIxh5L/5bEZo+GEWRK
         eAox6JjhIobMlBHgXzOcisxUV2SLPlDrqf+4GmQULi5hRIZygKB3ja3CBFBk0snRze67
         rxVSIRjsYlbd7QY4WwWFr9V7G6X0hcAvpohT9NCbrL+Yi8UMbkHzEtbGFHrThmhRtj0v
         QQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjXBsRDv1tk4lvE9wCvmk+Qp18WBZAwOBHdHQdAP62A=;
        b=ZheKmFKwyVgukDw9dsiBPY3zk5i1bqSOc3puX+z2+j5CRBJB2HYaWJbgrwHOtzFc5M
         V3p5G8jySfF44R46B0wUd5KwQtIhKbhMViY7t7T6sxDlbw79WBACcwlD5kIP0DlIX1EU
         r7sbgVOWzwfy/N9nb/Aq0sfVo4gJdBPagsJ2gLvxezcUNmfcWbM4DlyUmj6s7T+2QeHv
         b0oqJCK9VIbBr0zIk+bNyTFJ6rUxLZ9r5YCS3Uv7DFaMwhwn0KFb9+E+2aqyWmM/SAVP
         xyeY9bgsXIMkic3f/xsv0i7nfZRai8EfGf8d/kv82PyDmsmz4Ys6rCZfZ9a2gH+vxx3J
         3ChA==
X-Gm-Message-State: AOUpUlG8AFoykEHA/9NYtFrSIjZo8y4hnmWeEJHZqBXpOIW1DVzfXaMf
        EF1PygeGv5vRG34pQUvkx46bh7T2gSfXCtK+0Aj6UA==
X-Google-Smtp-Source: AA+uWPzxHceCjUTk4M/XUYQpqZ4C7BcJKcbtN3FRbkxyrwXi2R+N336FfbJfrVY7h26DEheh7cT8v6nyIKSHJSC/bsg=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr19598066ywh.238.1534544902993;
 Fri, 17 Aug 2018 15:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com> <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
In-Reply-To: <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Aug 2018 15:28:11 -0700
Message-ID: <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 3:20 PM Matthew DeVore <matvore@google.com> wrote:
>
> On Fri, Aug 17, 2018 at 2:42 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Wed, Aug 15, 2018 at 4:23 PM Matthew DeVore <matvore@google.com> wrote:
> > >
> > > Teach list-objects the "tree:0" filter which allows for filtering
> > > out all tree and blob objects (unless other objects are explicitly
> > > specified by the user). The purpose of this patch is to allow smaller
> > > partial clones.
> > >
> > > The name of this filter - tree:0 - does not explicitly specify that
> > > it also filters out all blobs, but this should not cause much confusion
> > > because blobs are not at all useful without the trees that refer to
> > > them.
> > >
> > > I also consider only:commits as a name, but this is inaccurate because
> > > it suggests that annotated tags are omitted, but actually they are
> > > included.
> >
> > Speaking of tag objects, it is possible to tag anything, including blobs.
> > Would a blob that is tagged (hence reachable without a tree) be not
> > filtered by tree:0 (or in the future any deeper depth) ?
> I think so. If I try to fetch a tagged tree or blob, it should fetch
> that object itself, since I'm referring to it explicitly in the git
> pack-objects arguments (I mention fetch since git rev-list apparently
> doesn't support specifying non-commits on the command line). This is
> similar to how I can fetch a commit that would otherwise be filtered
> *if* I specify it explicitly (rather than a child commit).
>
> If you're fetching a tagged tree, then for depth=0, it will fetch the
> given tree only, and not fetch any referents of an explicitly-given
> tree. For depth=1, it will fetch all direct referents.
>
> If you're fetching a commit, then for depth=0, you will not get any
> tree objects, and for depth=1, you'll get only the root tree object
> and none of its referrents. So the commit itself is like a "layer" in
> the depth count.

That seems smart. Thanks!

>
> >
> > I found this series a good read, despite my unfamiliarity of the
> > partial cloning.
> >
> > One situation where I scratched my head for a second were previous patches
> > that  use "test_line_count = 0 rev_list_err" whereas using test_must_be_empty
> > would be an equally good choice (I am more used to the latter than the former)
>
> Done. Here is an interdiff (sorry, the tab characters are not
> maintained by my mail client):

heh. Thanks for switching the style; I should have emphasized that
(after reflection) I found them equally good, I am used to one
over the other more.

So if that is the only issue brought up, I would not even ask for a resend.

Thanks,
Stefan
