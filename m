Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B0F1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFOAYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:24:16 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:40302 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:24:16 -0400
Received: by mail-lf1-f53.google.com with SMTP id a9so2842814lff.7
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23A9yeslBn/c3QGtF4bbzd04unIbZ/zPq0xCB3L/Oko=;
        b=faIBphBDuenYY8hKibXevIJQTrNGu6gFTlwGQdctTvQ5C0YUxI4gBkMj7RfCoathOl
         IzsBU93Ligrp+qKqZWuo5mm7GoS2XbIcOG58hlxocejhl2yfyIdx4cWY0UW5BxHjQb7k
         TeBAovRu1Sd3CM8ocF6eao/AH4Pt2C4Vm7+sKPn+UPGmPb/s93Cw/Quz8WEwn0UfxdlP
         aVUb2QI8Jny0FP4/jt2HeWLEHFnmcERnxsVjNZHwqpmM+a/5x9TpRpSI4HdTEBfsEUxb
         5bzT3JVY7wASy/zrUipaczc7Y/5nkXe65B5BwZNY0BpZqtR78rVgHqUF+A8C3TVfHIkS
         XRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23A9yeslBn/c3QGtF4bbzd04unIbZ/zPq0xCB3L/Oko=;
        b=Zoo2okVw8orjC/YTKKGYC+FiD1w77ZwqrGHshKZCEwZzHWfGTrxYe5WaD+TUNMrt94
         xxNvnT1o0iedOV1hBQ1CTRc5tFUr3YGnHDLGIsjftp+kJQG0ubbECeRnzzi+bfUUTgny
         W8uoitSCj8zZRHrtx+YQutDcCTWn/8xUeob96L3TRc6ycZyCGDvEwOdAA87+8Lqi6ZmP
         356pkj8DLLQxIRPgA9xhLFZSm9phsbeKyCbDJn+dcuw0bJ9w8NyN9kRdw3T9v98lZHpK
         qFX1o7ADYUn16FogsokXKQugjHEKuPoFlzTviZ3hTXIDwuGpTOCrXeGXR04+pWBciI7V
         9eSA==
X-Gm-Message-State: APjAAAVXJXbldpUwFTJTI62G914derBfoYELCmnuaY0f3AFx2ocu9BnV
        0oivj1WwXz4xNe1NrQzlcuVTE5w9w/6IHaa5WpI=
X-Google-Smtp-Source: APXvYqy5nzRoKSqHMoFpyvMFgENeHyJLl4be6NW51MlHuEUj1raibT9p/4FsdMrSZJTn7JXG1zHdlK81WgFx9srbUsQ=
X-Received: by 2002:a19:bec9:: with SMTP id o192mr27722937lff.78.1560558253770;
 Fri, 14 Jun 2019 17:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=ohKw8o0R3mtcr5E0fAeEX_OMo5qCiVx3EWwp5B3BKU9Q@mail.gmail.com>
 <CABPp-BGQ0frtOk7ZF4vnLdfeYCXibUaC4zUV1coTz=AzOvy8Lw@mail.gmail.com> <CAEwRq=qufzNg_fBNPgSkV++VRHE2jE8q_iNBB1Fn=BQjTFRLEw@mail.gmail.com>
In-Reply-To: <CAEwRq=qufzNg_fBNPgSkV++VRHE2jE8q_iNBB1Fn=BQjTFRLEw@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 14 Jun 2019 17:24:00 -0700
Message-ID: <CABURp0p3iwizpZNR+aeAK3_sj7v2mu487AD57PiZG4fgne+tww@mail.gmail.com>
Subject: Re: cherry-pick strangeness
To:     Vincent Legoll <vincent.legoll@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 12:29 AM Vincent Legoll
<vincent.legoll@gmail.com> wrote:
> On Fri, Jun 14, 2019 at 12:56 AM Elijah Newren <newren@gmail.com> wrote:
> > When you cherry-pick a commit, it reapplies its diff on top of a
> > (usually different) commit, preserving the author name/email/date, but
> > throwing away the committer name/email/date -- instead using your
> > name/email and the time of the cherry-pick for the committer.  Since
> > you are transplanting on the same commit, and you created both the
> > original commit and the cherry-pick, the only thing that can be
> > different is the committer timestamp.  Git records timestamps down to
> > 1-second resolution.  If you run in a script, odds are that the
> > original commit and the cherry-pick both run within the same second
> > (though not always), and thus you end up with precisely the same
> > commit.  When you run interactively, you take longer than a second
> > between commands, and thus have a different committer date which
> > naturally will have a different sha1sum.
>
> Thanks for the thorough explanation.
>
> Looks like this has nothing to do with "--[no-]ff" at all.
>
> Shouldn't something about that be added to the man page to avoid
> people scratch their heads ? (I can try to cook something if this is
> deemed acceptable)

Patches to documentation are welcome, but I'm not sure what you'd say.
Is it just a note to point out that the HEAD resulting from
cherry-pick is not guaranteed to be unique?  That seems too noisy for
something which is inconsequential to most users, to me.  But others
may disagree.
