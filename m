Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B71B203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbdGUUdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 16:33:14 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34580 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbdGUUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 16:33:13 -0400
Received: by mail-pg0-f42.google.com with SMTP id 123so32968020pgj.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2YIfWtd+BnmpgVQj1wDe+L8Jxv9oWQxjl3zslOshkE=;
        b=WDt6wwoN/Qi8Afh/j5DTNieT6LhOVz0UqLYquB/49L3wtrDLRgmyFDhXuNPBPGm9Em
         ohteLw24Q4YTguS5vYkYpiVxisElMjGiD74cUn6SIzAG0Kqavwd+KMf/Ow8vs1UCU39s
         4ttjNxtIJVRpkkq+lrtO/J5oPNv1ejvIVY1wtioKQV48EL2f0qvzJ8/HWx0qvydu3vDj
         1EuiIrSXOHrBRT98/wLA3lsBlo9oWKOoCokE76hfA/pelaCd2JwUKc2G5vFXnpXqU/vk
         7tq2E8QLhaQc/lu4h3D3shaVDxzGMXaMVaRExgpP35+uhP/slqmf/NM6OF0SsP1Ihfdj
         RCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2YIfWtd+BnmpgVQj1wDe+L8Jxv9oWQxjl3zslOshkE=;
        b=L2wUU4sZ+P1QICeLz1kOGm14Dk54ZED0z21Y7mhdFLz9ovp0q83qnD48wkNIvJKS9Q
         W20HAbwbfa6cTVqekZkbXREHY/wyWdwGjQr/BDFUvIVY03448/EOTwHOcJzbo5E2LhZn
         Qm5iJcNojtASuWB4z7g2dvzua40Z/O+dmU8AKIIQFsGmffz8yo0WrP/ttLNsVru9uvBo
         utC2c8RCX6wRe+oz/oH1Kw612Fa12OJWxkkqvEJm49RpGbjvAgS4rupqCnF+fezUrr+k
         NO3nT+ksr21KqZjXy24MEtA22m2rillVBYCFX2iWNAgY5J/Zr51J6Tc05uW/53J4EALU
         xjcA==
X-Gm-Message-State: AIVw113D6PXSztuUgxW0PJi+ynaEpVUDZlmdoGu/P5PrVFHW9uPnEAAv
        7A5ya4XUXHLKwhLz
X-Received: by 10.98.212.27 with SMTP id a27mr6593574pfh.157.1500669193203;
        Fri, 21 Jul 2017 13:33:13 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:d494:1bfb:cc5c:cb29])
        by smtp.gmail.com with ESMTPSA id w82sm5301324pfa.39.2017.07.21.13.33.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Jul 2017 13:33:12 -0700 (PDT)
Date:   Fri, 21 Jul 2017 13:33:08 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        git@jeffhostetler.com, philipoakley@iee.org
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
Message-ID: <20170721133308.422e736d@twelve2.svl.corp.google.com>
In-Reply-To: <d014682f-66a5-c3c1-cf66-ef4bb28de076@gmail.com>
References: <cover.1500508695.git.jonathantanmy@google.com>
        <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
        <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
        <20170720141342.6a89aace@twelve2.svl.corp.google.com>
        <d014682f-66a5-c3c1-cf66-ef4bb28de076@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 21 Jul 2017 12:24:52 -0400
Ben Peart <peartben@gmail.com> wrote:

> Today we have 3.5 million objects * 30 bytes per entry = 105 MB of 
> promises. Given the average developer only hydrates 56K files (2 MB 
> promises) that is 103 MB to download that no one will ever need. We 
> would like to avoid that if possible as this would be a significant 
> regression in clone times from where we are today.
> 
> I'm also concerned about the performance of merging in promises given we 
> have 100M objects today and growing so the number of promises over time 
> could get pretty large.

After some thought, maybe a hybrid solution is best, in which it is
permissible but optional for some missing objects to have promises. In
that case, it is more of a "size cache" (which stores the type as well)
rather than a true promise. When fetching, the client can optionally
request for the sizes and types of missing objects.

This is good for the large-blob case, in which we can always have size
information of missing blobs, and we can subsequently add blob-size
filtering (as a parameter) to "git log -S" and friends to avoid needing
to resolve a missing object. And this is, as far as I can tell, also
good for the many-blob case - just have an empty size cache all the
time. (And in the future, use cases could come up that desire non-empty
but non-comprehensive caches - for example, a directory lister working
on a partial clone that only needs to cache the sizes of frequently
accessed directories.)

Another option is to have a repo-wide option that toggles between
mandatory entries in the "size cache" and prohibited entries. Switching
to mandatory provides stricter fsck and negative lookups, but I think
it's not worth it for both the developers and users of Git to have to
know about these two modes.

> >> I think we should have a flag (off by default) that enables someone to
> >> say that promised objects are optional. If the flag is set,
> >> "is_promised_object" will return success and pass the OBJ_ANY type and a
> >> size of -1.
> >>
> >> Nothing today is using the size and in the two places where the object
> >> type is being checked for consistency (fsck_cache_tree and
> >> fsck_handle_ref) the test can add a test for OBJ_ANY as well.
> >>
> >> This will enable very large numbers of objects to be omitted from the
> >> clone without triggering a download of the corresponding number of
> >> promised objects.
> > 
> > Eventually I plan to use the size when implementing parameters for
> > history-searching commands (e.g. "git log -S"), but it's true that
> > that's in the future.
> > 
> > Allowing promised objects to be optional would indeed solve the issue of
> > downloading too many promises. It would make the code more complicated,
> > but I'm not sure by how much.
> > 
> > For example, in this fsck patch, the easiest way I could think of to
> > have promised objects was to introduce a 3rd state, called "promised",
> > of "struct object" - one in which the type is known, but we don't have
> > access to the full "struct commit" or equivalent. And thus fsck could
> > assume that if the "struct object" is "parsed" or "promised", the type
> > is known. Having optional promised objects would require that we let
> > this "promised" state have a type of OBJ_UNKNOWN (or something like
> > that) - maybe that would be fine, but I haven't looked into this in
> > detail.
> > 
> 
> Caveats apply as I only did a quick look but I only found the two 
> locations that were checking the object type for consistency.

I haven't looked into detail, but you are probably right.
