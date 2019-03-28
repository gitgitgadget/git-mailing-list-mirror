Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D952920248
	for <e@80x24.org>; Thu, 28 Mar 2019 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfC1Vty (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 17:49:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfC1Vty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 17:49:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so407283wmi.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TLluyZdBmFSQRRTfeGhYBdWjWsvrW3z65v0dARYrtoM=;
        b=F7y1qqYyJQxavi2a6vqHxtxFISVHjrKj9mUJnua8XhO8T3x5n7zK6VuGFdNzo/owH4
         3SXpcsopIig3vo1xbWz1LOEmeRMpv9sr3WPuAGR2YSeTy265GKwNJsLCpjemJOfaDPpl
         SWYH6upv7p5Yx9v+44SONHKAiZo2MsQsq/3JQI9JgUDwRGGyVXOzuKHSaP67OB+2U0rV
         En3eL+le+HbKwKV/W/Rp6/UmL+wM46gb3MkQL5Iz6NXOpdTHvhYoptKyOuIkpnWWBixA
         4V2TpyC0wwWA9hreN8KNAU4kTJl0vSv4HTY0fNExK048fTFHfbBz4Y6GzY2o9tUZ5WIA
         cb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TLluyZdBmFSQRRTfeGhYBdWjWsvrW3z65v0dARYrtoM=;
        b=kPCv6AQgJH3dlPqJZF/ZzVE+QOb29GnMNZwx3jyEHJcC9Bwm6J39lf7p+dIaO5uzbg
         5LEFP2syI0COz4F+D/zAWpWW6VOwPy1KJ0fd+HcEsFppA0rmzIN6oLzNNQGtC51O6MOo
         9mVjNS+Gn5iUQz9HmVk1+GljwmCxI9aJociadyAKConT8w+RuWLI7azzWGROKeuC4qz5
         UdbMh+KPNMMaK+YMopeTBC9imxiVxM2Q9fJ6Ga+HgA1m4VVExXfeHRlzuegfzlwUYyj2
         3ouxh5t20l35njGOALNNLodLZ3mc1STWibwFX+gwJL5gUeFN2kdHmMmHKs9b7s3B+3P+
         U4qQ==
X-Gm-Message-State: APjAAAVTYD1ZcDK7Yx3QIb7vq/ems5QWdzqvSSsv0lBfi9n/71YO4atA
        htAwIwb8bprK9okJ4d6twW0=
X-Google-Smtp-Source: APXvYqxpkRuAs4I4zTgg0HkQt9MHcrA7WcVzYo/Owuz3CftkbmEQeaMuKquKtTJ6Njel3XHbbg/9mQ==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr1319262wmk.137.1553809792804;
        Thu, 28 Mar 2019 14:49:52 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id y125sm313855wmc.39.2019.03.28.14.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:49:51 -0700 (PDT)
Date:   Thu, 28 Mar 2019 21:49:50 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com, Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
Message-ID: <20190328214950.GJ32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322232237.13293-2-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Matheus Tavares wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Add tests for what happens when we perform a local clone on a repo
> containing odd files at .git/object directory, such as symlinks to other
> dirs, or unknown files.
> 
> I'm bending over backwards here to avoid a SHA1 dependency. See [1]
> for an earlier and simpler version that hardcoded a SHA-1s.
> 
> This behavior has been the same for a *long* time, but hasn't been
> tested for.
> 
> There's a good post-hoc argument to be made for copying over unknown
> things, e.g. I'd like a git version that doesn't know about the
> commit-graph to copy it under "clone --local" so a newer git version
> can make use of it.
> 
> In follow-up commits we'll look at changing some of this behavior, but
> for now let's just assert it as-is so we'll notice what we'll change
> later.
> 
> 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Helped-by: Matheus Tavares <matheus.bernardino@usp.br>

The trailers should be in the order things have happened usually.  So
having Ævar's S-o-b first makes sense, but the Helped-by should come
before your S-o-b, as you made the changes first before sending out
the patch series.

When sending someone elses patch in a slightly modified version, it
may also be useful to add which parts you changed, as it was done in
e8dfcace31 ("poll: use GetTickCount64() to avoid wrap-around issues",
2018-10-31) for example.

Iirc, the test that is added in this patch does not work on some
platforms, notably MacOS.  That would mean that we would break
bisectability at this patch on some platforms if we were to introduce
it here.  Therefore I think it would be better to squash this patch
into the next one which fixes these inconsistencies.

Note that I can't test this at the moment, so this concern is only
based on previous discussions that I remember.  If that's already
addressed somehow, all the better!
