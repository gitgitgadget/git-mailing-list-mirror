Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3092E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeDKUuN (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:50:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51002 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756076AbeDKUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:50:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id t67so6978897wmt.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wAUu9JghygXeNE8UNvpb0BDiLs/2dqHbjVxnc8bf2Sg=;
        b=CkrcRoZEFwmplo0ZptftXvioqiaiQMbIYaX1VWk0L24kacc27F1vprJ/Nzh2dzXRHt
         8KLx0QhyIAfIPxgDABWkAbO/LitdlpJDuzBDTSomm+Fd7k9bxYQPsK5UGlAToR4nPTWj
         dJ/8oCpWZ4221MMDC/lLBq4s/Mdrpht3WBcv1PXpaQ6snynnCtFFfHbs3mpHXc8e6QV1
         7Vo/9PYzzE547iD59+6r33FN86NVQb0RGCEl2/BNpM5WNba5/kcYZe/C1hmRSXPVxvRR
         sW+Y/vJVFRn+fhX94SRXGvPGpxP/IEOAw1c6IxsHckkZSwUwdvptoHH0jhbanh74L02H
         rTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wAUu9JghygXeNE8UNvpb0BDiLs/2dqHbjVxnc8bf2Sg=;
        b=ajS/BsDY+bFqlOug5ah+SJrOuAorQuOdrmZXc0C+pwjo14Al2Ao6UFdZ0vNRMD5nPv
         lNVv6V0Q/mKjvzpO0xamCX1q/Q7JaGEyGwmxFA/f1Yp6XookklVVXRvy/+7MPba4cLcY
         DFrR9qeAFIpaR86RtCCW4888HkgZ6JfHKoo2simCLe0jH8oN5aQWm6WZJzDt33KZvKAp
         974CjLCL+4HjUOaJem0ihdhjSPe8lCx6ooq4uMb612y1gtj0PgqAOmXkcavLHcFEyLl8
         jHSTv6sPav4Mct/EXFSzN9W40jUTK3fFYbKe1HSy+naSzt66BPQbEl5MrimPwIkoUcZ0
         thMw==
X-Gm-Message-State: ALQs6tDY2yhjqa1ZbIp34wa5VeHOBBJ+qjgMClwfCtY49+HBTjkfsWDe
        tZl2kNa4/u5KH8nqyvyq6I0=
X-Google-Smtp-Source: AIpwx485VCpY8IldYx9GevNE2zsD+yuySUT4ZVYFgqQwF+225AIWX9DgH7ru2EtZv0kNT2QghyJ9oQ==
X-Received: by 10.28.137.129 with SMTP id l123mr3858279wmd.160.1523479809681;
        Wed, 11 Apr 2018 13:50:09 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e8sm5095725wmf.15.2018.04.11.13.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:50:08 -0700 (PDT)
Date:   Wed, 11 Apr 2018 21:50:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180411205015.GP2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
 <20180409193007.GL2629@hank>
 <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
 <20180411200955.GO2629@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411200955.GO2629@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Thomas Gummerer wrote:
> On 04/09, Eric Sunshine wrote:
> > On Mon, Apr 9, 2018 at 3:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > On 04/08, Eric Sunshine wrote:
> > >> As with Junio, I'm fine with this hidden option (for now), however, I
> > >> think you can take this a step further. Rather than having a (hidden)
> > >> git-reset option which suppresses "HEAD is now at...", instead have a
> > >> (hidden) option which augments the message. For example,
> > >> --new-head-desc="New worktree" would make it output "New worktree HEAD
> > >> is now at...". Changes to builtin/reset.c to support this would hardly
> > >> be larger than the changes you already made.
> > >
> > > Something else I just noticed that may make this a worse solution is
> > > that this breaks the sentence in two pieces for translators.  I guess
> > > we could somehow get the "New worktree" part of the option translated,
> > > but that still means that if some language would require to move parts
> > > of the sentence around that would be less than ideal for translation.
> > 
> > Good point.
> > 
> > One solution would be to have the new hidden option replace the string
> > entirely: --new-head-msg="New worktree HEAD is now at %s", which would
> > allow translators to deal with the entire sentence. Even clearer would
> > be to drop "now", as in "New worktree HEAD is at %s". (Default in
> > reset.c would still be "HEAD is now at %s", of course.)
> > 
> > Another solution would be not to augment the "HEAD is now at..."
> > message at all. I realize that that augmentation was one of the
> > original motivations for this patch series, but with the upcoming
> > restoration of the "Preparing worktree" message:
> 
> My original motivation of the series was to just make the new dwim
> work :)  Because that's adding some magic, the secondary motivation
> became improving the UI, to help users see which dwim was used.  I
> felt like this was going to be one of those improvements, especially
> after we get rid of the "Preparing ..." line.
> 
> I do however like your suggestion of the "Preparing worktree (_branch
> disposition_)", as that doesn't add more lines to the output, while
> still giving a good indication of what exactly is happening.  At that
> point just showing "HEAD is now at ..." is fine by me, and doesn't
> require adding the hidden flag to 'git reset'.  So I'm happy just
> dropping the change in the message here, which will simplify things.

And just as I'm re-reading my commit messages, I guess there was one
more motivation for printing the "HEAD is now at ..." line ourselves:

    If the '--no-checkout' flag is given, the output of 'git worktree add'
    is just:
    
        Preparing foo (identifier foo)
    
    even though the HEAD is set to a commit, which is just not checked out.

I think I can live with that for now, I personally don't use
'--no-checkout', and we could fix this at some point in the future if
we desire to do so.  I think we can consider that out of scope for
this patch series, as its main goal is to introduce the new dwim.

> Thanks for the suggestion!
