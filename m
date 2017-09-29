Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE74520281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdI2UgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:36:17 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:43338 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdI2UgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:36:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id y29so367429pff.0
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9HrwFBj5v6EkJW98b2joL9NPEA+Uy6/ncsJoetGfsk=;
        b=VtjE5y23yjxHxfhFgrNLTFuwiU4cur+4/yk1cKVZViEb4fPkLSlBJ5IBuaI0chcgZA
         1JL2pLLape6vWzmwoGpd5aFglR0BQRowezBTdwquKU9Div9ytyiQs2CDuixSl4PI5b3Y
         F033a0Ce2PSrKlbJwb3nJ8htR9sB9pJK7/bpvxB/dK083x+V+Oy2cQgtP1Jwsc7b/CkV
         D62/DmSsaudwrSXSQMXdlOkQJdMMgQ72DNC4Cp5jZ74U0jwJP370fAIhjoDMgiThLNGa
         MyPp3aoNzEc8ZhvBNtAWIHqnp4zldNok03jfId87+M36PNOC6qJ0W4hASHlr/ouj5OOU
         1oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9HrwFBj5v6EkJW98b2joL9NPEA+Uy6/ncsJoetGfsk=;
        b=N2niHsfBXAgnDrLCHpiPwxt5QaasAnd0RIhgDYxmrBUiamhGJeq/qR/08ImGL1qPHl
         biX2MYFUjSfcDqyRryqsjxclSaDW2j8JxfFxW7RLvD0ruI0HwvdqrQOkalTk14QMA9Ux
         gMKpkTiXPdp42oH9VvfSXLSWnG+OIeQrjQCczrqq6LnaStWbvYpGRdSA8L6DgPnfqx5z
         J57dauq+yqsz30pUmoBg6cP7r0/iqEvopILLHhtP6iuXzf/lM60aIqaRGWNv9qaN03sY
         gtZtsWe6tOXrY3DIFImhsLXSNoH0njBCen+8GzRy17kEUrNQrtpsgPIwYFvfJmZFpd7s
         BIJA==
X-Gm-Message-State: AHPjjUjf8r0y1rmdwdfkymQhzyP5ls80mJYd6OsqM4+0kHApFP35v3wV
        aIV06nw4+Ys0M7gVyPXw+OOLwA==
X-Google-Smtp-Source: AOwi7QAtIfXSj3r5Q5fnqaIuwBbmstd0XxM/p51easbhG7Ehayfw+5oCQ0wu79nxYtJrQVtOQtyrGg==
X-Received: by 10.159.252.201 with SMTP id o9mr8382655pls.135.1506717375815;
        Fri, 29 Sep 2017 13:36:15 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:95f1:13e:dc22:c4e5])
        by smtp.gmail.com with ESMTPSA id d69sm8261246pfl.50.2017.09.29.13.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 13:36:14 -0700 (PDT)
Date:   Fri, 29 Sep 2017 13:36:14 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 09/40] Add initial external odb support
Message-Id: <20170929133614.1c0cd68ad80139fafdf68b86@google.com>
In-Reply-To: <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
        <20170916080731.13925-10-chriscool@tuxfamily.org>
        <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
        <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2017 18:46:30 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> I am ok to split the patch series, but I am not sure that 01/40 to
> 09/40 is the right range for the first patch series.
> I would say that 01/40 to 07/40 is better as it can be seen as a
> separate refactoring.

I mentioned 09/40 because this is (as far as I can tell) the first one
that introduces a new design.

> I don't think single-shot processes would be a huge burden, because
> the code is simpler, and because for example for filters we already
> have single shot and long-running processes and no one complains about
> that. It's code that is useful as it makes it much easier for people
> to do some things (see the clone bundle example).
> 
> In fact in Git development we usually start to by first implementing
> simpler single-shot solutions, before thinking, when the need arise,
> to make it faster. So a perhaps an equally valid opinion could be to
> first only submit the patches for the single-shot protocol and later
> submit the rest of the series when we start getting feedback about how
> external odbs are used.

My concern is that, as far as I understand about the Microsoft use case,
we already know that we need the faster solution, so the need has
already arisen.

> And yeah I could change the order of the patch series to implement the
> long-running processes first and the single-shot process last, so that
> it could be possible to first get feedback about the long-running
> processes, before we decide to merge or not the single-shot stuff, but
> I don't think it would look like the most logical order.

My thinking was that we would just implement the long-running process
and not implement the single-shot process at all (besides maybe a script
in contrib/). If we are going to do both anyway, I agree that we should
do the single-shot process first.

> > And another possible issue is that we design ourselves into a corner.
> > Thinking about the use cases that I know about (the Android use case and
> > the Microsoft GVFS use case), I don't think we are doing that - for
> > Android, this means that large blob metadata needs to be part of the
> > design (and this patch series does provide for that), and for Microsoft
> > GVFS, "get" is relatively cheap, so a configuration option to not invoke
> > "have" first when loading a missing object might be sufficient.
> 
> If the helper does not advertise the "have" capability, the "have"
> instruction will not be sent to the helper, so the current design is
> already working for that case.

Ah, that's good to know.

> > And I think that my design can be extended to support a use case in
> > which, for example, blobs corresponding to a certain type of filename
> > (defined by a glob like in gitattributes) can be excluded during
> > fetch/clone, much like --blob-max-bytes, and they can be fetched either
> > through the built-in mechanism or through a custom hook.
> 
> Sure, we could probably rebuild something equivalent to what I did on
> top of your design.
> My opinion though is that if we want to eventually get to the same
> goal, it is better to first merge something that get us very close to
> the end goal and then add some improvements on top of it.

I agree - I mentioned that because I personally prefer to review smaller
patch sets at a time, and my patch set already includes a lot of the
same infrastructure needed by yours - for example, the places in the
code to dynamically fetch objects, exclusion of objects when fetching or
cloning, configuring the cloned repo when cloning, fsck, and gc.

> >  - I get compile errors when I "git am" these onto master. I think
> >    '#include "config.h"' is needed in some places.
> 
> It's strange because I get no compile errors even after a "make clean"
> from my branch.
> Could you show the actual errors?

I don't have the error messages with me now, but it was something about
a function being implicitly declared. You will probably get these errors
if you sync past commit e67a57f ("config: create config.h", 2017-06-15).

> > Any reason why you prefer to update the loose object functions than to
> > update the generic one (sha1_object_info_extended)? My concern with just
> > updating the loose object functions was that a caller might have
> > obtained the path by iterating through the loose object dirs, and in
> > that case we shouldn't query the external ODB for anything.
> 
> You are thinking about fsck or gc?
> Otherwise I don't think it would be clean to iterate through loose object dirs.

Yes, fsck and gc (well, prune, I think) do that. I agree that Git
typically doesn't do that (except for exceptional cases like fsck and
gc), but I was thinking about supporting existing code that does that
iteration, not introducing new code that does that.
