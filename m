Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E251F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeJKFoG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:44:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32952 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKFoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:44:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id h13-v6so6419019edq.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SW5puKZbL9ZG7fNWFZo20Cs3PTgCWeK1Vbn6F9G3baQ=;
        b=tRjXYZhUBdQh4BUb7pHO+oUPjRe7XMdksCYoBOdjt5af/RNKkNONuGRCUWcZmHbtQb
         OFJfZ3ANn6jE+px0ZgfxJildOle3e2SAg5dhh5GixS0mjbAx+sj/KHIaDv3uwKr8zea2
         5upiJrAp2oOSmSjO6wDPinGpNebi+87Mlaz5HK6YK0uEChRFHRV4HLFT+j7bAPzbZ1Vt
         5Pa+YQnFf2jds44fCrN36IeFT+QEKiGEnoUCJbgUkNDxElHYaVP9dji53fYd4lWjKNba
         AeEEicmbyUrYuZqA4PCGmu12AfxoJjdxz7rS8coCdEeArjv1svywARWKx0DRCmnRxif2
         F5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SW5puKZbL9ZG7fNWFZo20Cs3PTgCWeK1Vbn6F9G3baQ=;
        b=XuA1VYcgdis8ChlzTgAGcMIU/DhGSacUBlstL18VjJMdRiKCa5fL+bXNfYLaX5hsNG
         fRbmKdw/sf7xSmZM9tV054vWndjfIwIDCC46LVOAahZK9yRWBLw44Qvkxgqtx25wKxr2
         OKl+Nhc3Hheq+xeVSjMaxKQrn5f8Gp8m90teIxewACa8/5O/FHdrZl36J1ufH7uFADfz
         kdSi8NS4y+ZZi2PX8HW2WbfJA4q/LgT0lT+QRnCFZhsnHS6vG4f5ALAwURURXihBA1fj
         91/vdFv6W1gbpJ3MC74suZmNOYReNndpolhqWLIK9QgloSc48/zW+75e4HLHCSzpjQVh
         y6Xw==
X-Gm-Message-State: ABuFfoh+ZHM2sQ38jMRBp4sZ06SvwjKtKrevouz2uhzcKxba2HWqwVym
        0phe0eLwc4OPbw+hOOS1w3U=
X-Google-Smtp-Source: ACcGV62ECFVsJjKLvrsS7Gq+obdWjV4xku6Tu1rLvYCPUE9gJTMD2Fh9xvQaHN2Ssc/NMjWTgeQ/3g==
X-Received: by 2002:a50:cf0a:: with SMTP id c10-v6mr44252725edk.242.1539209995334;
        Wed, 10 Oct 2018 15:19:55 -0700 (PDT)
Received: from szeder.dev (x4db070c3.dyn.telefonica.de. [77.176.112.195])
        by smtp.gmail.com with ESMTPSA id j15-v6sm8349452eda.74.2018.10.10.15.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:19:54 -0700 (PDT)
Date:   Thu, 11 Oct 2018 00:19:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
Message-ID: <20181010221951.GG23446@szeder.dev>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com>
 <20181010203738.GE23446@szeder.dev>
 <87pnwhea8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnwhea8y.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 11:56:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Oct 10 2018, SZEDER Gábor wrote:

> >>  	for (i = 0; i < oids->nr; i++) {
> >> +		display_progress(progress, ++j);
> 
> [...]
> 
> > This display_progress() call, however, doesn't seem to be necessary.
> > First, it counts all commits for a second time, resulting in the ~2x
> > difference compared to the actual number of commits, and then causing
> > my confusion.  Second, all what this loop is doing is setting a flag
> > in commits that were already looked up and parsed in the above loops.
> > IOW this loop is very fast, and the progress indicator jumps from
> > ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
> > progress indicator at all.
> 
> You're right, I tried this patch on top:

[...] 

> And on a large repo with around 3 million commits the 3rd progress bar
> doesn't kick in.
> 
> But if I apply this on top:
> 
[...]
> 
> I.e. start the timer after 1/4 of a second instead of 1 second, I get
> that progress bar.
> 
> So I'm inclined to keep it. It just needs to be 4x the size before it's
> noticeably hanging for 1 second.

Just to clarify: are you worried about a 1 second hang in an approx. 12
million commit repository?  If so, then I'm unconvinced, that's not
even a blip on the radar, and the misleading numbers are far worse.

> That repo isn't all that big compared to what we've heard about out
> there, and inner loops like this have a tendency to accumulate some more
> code over time without a re-visit of why we weren't monitoring progress
> there.
> 
> But maybe we can fix the message. We say "Annotating commits in commit
> grap", not "Counting" or whatever. I was trying to find something that
> didn't imply that we were doing this once. One can annotate a thing more
> than once, but maybe ther's a better way to explain this...

IMO just remove it.

