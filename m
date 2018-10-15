Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD49F1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 16:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJOXvm (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 19:51:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOXvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 19:51:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so18369588edd.2
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Bv+sc+3hao5Shu7CfDDeJ37PlNbTTuyt1TkcxJRvy8k=;
        b=Yf/IGY4HEABD5Gfcv+fSSftmCgVySsk37vBjHUvJs0td7NijKzF4zXq/B9nvAZomAN
         Z+ZdoMYDoQxogDOT3Mvd/xQE0j7sfuhDwBQvVl5TaptJEnrXUdi8n73XVLN9nAF6fqrf
         JAP3QB/xZw8ONADTfR4Y0cdEaB29b7Gp41ebfW8vEKWlzTanR+cNM+nZboCEBMxECADw
         Szsm5q8PvKnEzVfQMQMim7Txk7cBLiInNw1TDGZC5qgSRlBt9+AnrZLddwfDj3VpsxK9
         m0V42c2eFRsp9GDxcdQDxiLOPZawum1wIbC19A9M/JfNiYtN/Gntgh9o/VQwwpKZaCCg
         Mr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Bv+sc+3hao5Shu7CfDDeJ37PlNbTTuyt1TkcxJRvy8k=;
        b=Ydf8gbxPjH7vaYpqseyeqoUkc+At347hXnzgUcCGTf+2iWB/0NiauWrrG3+RwKQMnf
         Wjk3gSgmGYlJMcwtngyux+VC4xCrTnttB0cAg+DJhZlKlB4KE/Jb9xlq1mj0e3EUHQ18
         66DIs4lC25WhjXJiSriBFDNwz4xCh4STRKsTtVaFh0GB4wv93PFxSvIkAI8Gnr3/aNiu
         nNF9Vt/PLBdGs1hqWqKXoe5N0PVnxR7MA8BThDRyhJ/lTZN5sCaskF58DjNt/j304hlH
         g9b6V9KP+Uy4K+47CKEyZj/5/5GVnomuWaB9m3yzMeGsYWEun9kP8IULBjAOIBa12QXf
         4pkw==
X-Gm-Message-State: ABuFfojZK5oWoiNo3mb4F2VvN0GVKd6X1eMJ416+ZlNgMTwoR6578CMr
        dDr/nOUoJQ1TWk3F+tjSX0U1rlzE
X-Google-Smtp-Source: ACcGV60CEinfukHC0p3ex7uMnBlMXtndzXoIMK423gBNxe4P7f95/J7GEPw2OGfImmd1Zdj3WQpr7A==
X-Received: by 2002:a50:d78b:: with SMTP id w11-v6mr26468159edi.19.1539619549346;
        Mon, 15 Oct 2018 09:05:49 -0700 (PDT)
Received: from szeder.dev (x4d0c894f.dyn.telefonica.de. [77.12.137.79])
        by smtp.gmail.com with ESMTPSA id v30-v6sm4923921edc.21.2018.10.15.09.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:05:48 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:05:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
Message-ID: <20181015160545.GG19800@szeder.dev>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com>
 <20181010203738.GE23446@szeder.dev>
 <87pnwhea8y.fsf@evledraar.gmail.com>
 <20181010221951.GG23446@szeder.dev>
 <87murle8da.fsf@evledraar.gmail.com>
 <87a7nke5gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7nke5gq.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 07:52:21PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 10 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Wed, Oct 10 2018, SZEDER Gábor wrote:
> >
> >> On Wed, Oct 10, 2018 at 11:56:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>> On Wed, Oct 10 2018, SZEDER Gábor wrote:
> >>
> >>> >>  	for (i = 0; i < oids->nr; i++) {
> >>> >> +		display_progress(progress, ++j);
> >>>
> >>> [...]
> >>>
> >>> > This display_progress() call, however, doesn't seem to be necessary.
> >>> > First, it counts all commits for a second time, resulting in the ~2x
> >>> > difference compared to the actual number of commits, and then causing
> >>> > my confusion.  Second, all what this loop is doing is setting a flag
> >>> > in commits that were already looked up and parsed in the above loops.
> >>> > IOW this loop is very fast, and the progress indicator jumps from
> >>> > ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
> >>> > progress indicator at all.

> Hrm, actually reading this again your initial post says we end up with a
> 2x difference v.s. the number of commits, but it's actually 3x.

Well, it depends on how you create the commit-graph and on the repo as
well, I guess.  I run 'git commit-graph write --reachable' in a repo
created by 'git clone --single-branch ...', and in that case the
difference is only ~2x (the first loop in close_reachable() has as
many iterations as the number of refs).  If the repo were to contain
twice as many refs as commits, then the difference could be as high as
4x.

However, I think I might have noticed an other progress counting issue
as well, will get back to it later but first I have to get my numbers
straight.

> The loop
> that has a rather trivial runtime comparatively is the 3x, but the 2x
> loop takes a notable amount of time. So e.g. on git.git:
> 
>     $ git rev-list --all | wc -l; ~/g/git/git commit-graph write
>     166678
>     Annotating commits in commit graph: 518463, done.
>     Computing commit graph generation numbers: 100% (172685/172685), done.
