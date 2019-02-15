Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592E71F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403765AbfBOSwH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:52:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39473 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387731AbfBOSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:52:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so5201330pgp.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PbXf3nQI4e4tjeJcRoJjBi3P3RF3blsvYHi1rY1prec=;
        b=L55zEKbkIjsUnuoC8nIFE/OroNMp4cbWlZTHlcQKmHT1PkV9sLT37L8I37Do+moq8R
         If4csi8pJ6MRUPwFfsEVdkfhguDSWu8v/e/dKRCO4qzVDiRFRqhHpo+v+bX1Kx5Cp0qn
         cJgaT3o0vVen80t7MOTgJPmagiLDPZn3CgpUb3vI69s4y4ScUSlUU+YkEkKLZShthTQK
         oi96EOcKGEC3L61W4Nrwa7APCtVL1Va+/h4WgaNhKARXu35azJSk3NglPjRYbw4h+DIa
         PWw+nbmzvOqKpjGBffmg7FIfEMcGUzEpE+BRQTSiOLlZpzWLLau8to/2QqvD3o8RaVIn
         Lbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PbXf3nQI4e4tjeJcRoJjBi3P3RF3blsvYHi1rY1prec=;
        b=idfp0B0sDaiKi8JXiXhulCTJ1ej6FfgRnKXi9+i395XP1v82p8bogijJHaoP/qwLn9
         mBEMAdnXO7BGzAkpfCMuaTtknNCldvvr2kTyQgRpWu6i26xWkqs2F1Er78mU61DmArm/
         tLWnMWq3/Brz2A6yUwGX05hI0fRZnitJWbYkfFtOLWMOWwxAaqfxVYhfIH5RgVbUYZ8T
         Ra4BK3Wd7ob43Y+6Cfc3OMWGBxBg0cZROpvHS8mJsCV7JIqa8372Gh2d5Dam8HGhYJ1a
         UdtXWcl//eGE3O15KZOGjPgaK7C7HlURHREr2Ks5XVChtj54zzql3WbBQbDnv/Hq4hdR
         popQ==
X-Gm-Message-State: AHQUAuYcEcD7fcpYRwMyvAmPlqQ+rPj/z3zuEYNsnbu8Ho+P/M7vD8Xy
        oinK0gJEU5QcijRh+64Vacg=
X-Google-Smtp-Source: AHgI3IZTjXNWZ1KukCoL80i3bwmXAac70Zm5n4ZxReTOgrHwRQnKoDpUFeX16Ni3FWjBRF57AgFlQg==
X-Received: by 2002:a63:360b:: with SMTP id d11mr6554292pga.156.1550256725819;
        Fri, 15 Feb 2019 10:52:05 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k65sm2483013pge.74.2019.02.15.10.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 10:52:04 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:52:02 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
Message-ID: <20190215185202.GA28019@dev-l>
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
 <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 02:10:53PM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > The only thing I seem to be able to retain is the following:  "git
> > diff D..E is totally useless and should be an error because (1) it
> > doesn't do what I expect and (2) for folks that want the behavior
> > currently gotten with that syntax can instead just use a space instead
> > of a double dot."
> 
> That sums up pretty nicely.  diff is fundamentally an operation
> between two endpoints, so the range notation a..b does not work
> nicely with it at the conceptual level.
> 
> When we realized that we can take advantage of the above fact, and
> reuse a range notation to mean something that is generally useful in
> the context of diff, such as 'one end of the comparison is the merge
> base between a and b, and the other end is b', it was too late to
> use "a..b", as an early adopters of Git was already used to the fact
> that "a..b" happened to mean the same thing as "comparison of one
> end is a, the other end is b", pretty much implemented without much
> thought.
> 
> It might be _possible_ to spend a year (i.e. 4 cycles) to start
> warning when two-dot notation is used for "git diff" (only, not any
> plumbing like "git diff-files") and tell the user to use the more
> logical two-end notation "git diff A B" and then eventually error
> out when two-dot notation is used, while retaining the three-dot
> notation throughout and to the eternity.  I am not sure if it is
> worth the deprecation cost, though.
> 
Instead of outright deprecating it, would it make sense to include a
configuration option, say "diff.sensibleDots", that would enable a user
to set the dots to the other form if they desire?

This has bugged me for long enough that if there's a desire for this
from others, I'm willing take on the effort of making this change.

Thanks,

Denton
