Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D15C1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeHOCpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:45:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37164 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHOCpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:45:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id j205-v6so36905302oib.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4dTzv202JNf/cafMV8HxwaUmf528RSVDk8R82zweeE=;
        b=Ktn3vGzNj5z/WvpZXia+rOcnSM9JWAtv1fyQ0iMQ5AONXlYz5YVhx93VEWQGv30RPM
         4t7bfcyR0ztQxsWru7Y2VYUgCUMBcxcyVWoTZkL4WYsw61draSrMGfUwK/j6u9sS5BOJ
         LPTNBHwziE3MHt3YtgKkOsRPV7OUNC2Arf00bi2m6Mi7r54cjDtaoTowaJeLDQkLDU+d
         5iSA9TBmr1bFfUymSLr8ssyVxBPjiiICdLS5T2jZ9NoZ6I2BBv05XP+/xi0/6uJmB9cl
         cT1VdI/Yt3cARhVlpbRg1LoDuyZx/p4+MzUU4vD4ctQt7BiO9/j6r+GmP+llpzcyVPG1
         oP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4dTzv202JNf/cafMV8HxwaUmf528RSVDk8R82zweeE=;
        b=OGEMBDi/SYUc88/uBQG2F3M47vNHNQpT81ZyoqFGnJqVMvuO+IYKowfDsmVfScvhpx
         XNam2rM1sr/QdwRVqyYUCm1oybSykmzS4uGNUuGdonfoVB2euwl5oJMTRTcH5EftJfl1
         G7S2dg6p5KVKKwIee6AAwBSCuoBCn7bbFnsrlRAxOifbhUfHK/9VRUjYqDqsFnW597K5
         EJfhbLhgIqgHRFE67Qf8TIdCaXWN7/TcyGfheT+IbGsu749jn4ZxhXfCeS7R/K+jtKsO
         lzbzZkEg8eufIO3S7w5GXLHSzvrfOXDo6RAN8nlP5R6B+6ajfwP4geosFzarC7B4kZuD
         oCPw==
X-Gm-Message-State: AOUpUlGw3D2FnkqNsOANu//cc/w48O5CrTRrrafC+ObRR92hFm6fKMfC
        YWnoqHEU2jHGvSRUo5d6ycdMAVbJLzwfmktegW8N
X-Google-Smtp-Source: AA+uWPxlwRaLCVtjE+XHjeeC+2xfb0ALNLJa3f0qKDktiKHPpGlp360t6O+64ylOAtij5V8VwYOtPIrH/qHDbOxEyH0=
X-Received: by 2002:aca:c351:: with SMTP id t78-v6mr23044809oif.338.1534290946194;
 Tue, 14 Aug 2018 16:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
 <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com> <20180814200154.GF28452@sigill.intra.peff.net>
In-Reply-To: <20180814200154.GF28452@sigill.intra.peff.net>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 14 Aug 2018 16:55:34 -0700
Message-ID: <CAMfpvhJM2hUXTfTgY9jA4aB+bgx44xbCktCacpy_yWacyjk00w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 1:01 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 14, 2018 at 10:28:13AM -0700, Matthew DeVore wrote:
>
> > The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
> > would filter out all but the root tree and blobs. In order to avoid
> > confusion between 0 and capital O, the documentation was worded in a
> > somewhat round-about way that also hints at this future improvement to
> > the feature.
>
> I'm OK with this as a name, since we're explicitly not supporting deeper
> depths. But I'd note that "depth" is actually a tricky characteristic,
> as it's not a property of the object itself, but rather who refers to
> it. So:
>
>   - it's expensive to compute, because you have to actually walk all of
>     the possible commits and trees that could refer to it. This
>     prohibits a lot of other optimizations like reachability bitmaps
>     (though with some complexity you could cache the depths, too).
I think what the user likely wants is to use the minimum depth based
on the commits in the traversal, not every commit in the repo - is
this what you mean?

>
>   - you have to define it as something like "the minimum depth at which
>     this object is found", since there may be multiple depths
>
> I think you can read that second definition between the lines of:
>
> > +The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> > +<depth> from the root tree. Currently, only <depth>=0 is supported.
>
> But I wonder if we should be more precise. It doesn't matter now, but it
> may help set expectations if the feature does come later.
>
Makes sense. I changed it like this -

diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index 0b5f77ad3..5f1672913 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -732,8 +732,10 @@ the requested refs.
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
 specification contained in <path>.
 +
-The form '--filter=tree:<depth>' omits all blobs and trees deeper than
-<depth> from the root tree. Currently, only <depth>=0 is supported.
+The form '--filter=tree:<depth>' omits all blobs and trees whose depth
+from the root tree is >= <depth> (minimum depth if an object is located
+at multiple depths in the commits traversed). Currently, only <depth>=0
+is supported, which omits all blobs and trees.

 --no-filter::
  Turn off any previous `--filter=` argument.


> -Peff
