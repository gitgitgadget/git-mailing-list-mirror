Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977F41F453
	for <e@80x24.org>; Tue, 12 Feb 2019 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfBLUZH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 15:25:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40014 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBLUZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 15:25:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so9584wmc.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 12:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oyOvFzgpAXiFH0EhMWnSdFU8FA+PUaaXIcQHYdrnxtY=;
        b=DpT8QQryODAbjlBVQJM9ghVDsH6c8t3cWw6DWCBpU1TVTusjfniVVr+jTvsMgyeB8l
         xs0+JX2Q9k/WSW94l8EEkcwmh55i21eZo6AgnDCspHIpzDIkYy0zLbNFSwyhQHLe2Zl7
         76kT1BL7tFNS9NiDVfYv99UaOcZ4yfQ3N8nhzB0SrAhEQH3v8sFGolWSJY+EaGBkqT+q
         CbW9zK5s3KA8k1nknNApj/WscIr2T58+uAVxDZZtBpvnQ9F44M9Sym8OvVc0cpYpi/FA
         cJDyV6XQNwf2JRhLvCKrYCiKj+2eCsYq9s5EtWdYsAVMvL2JswuryQ2ioSWe9KV6i2fa
         BirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyOvFzgpAXiFH0EhMWnSdFU8FA+PUaaXIcQHYdrnxtY=;
        b=ZBPzSRmGUQVkMhq5szxSayE8t5xMNKpnipb/JWFLPRW1qTSeCtGZDa6MNqJ66TSvh+
         opn+SvQqAHJXcgMg3V+DRmAS7Txwo0nFfMUvP6EcLZUJJC8v/EMDBcyNlqKpAVzB9vXv
         vSEfmAVvqY+DJ0+lF9l2sflDlvfZVi34nOOiM3NxXmATFFdQHUwKvGksRN2/PQLkR93Y
         7FGJuqhmx1xyE3rphvVGqUoo4Tm8KdRS04ay1URp1rJXkjTik4RfXjaB0R/UOmh8xbQD
         iiEnQHSjvCLmBWT8xge13j+oKD+2UphlbEwkT00A8Djcc3MxXgWHPIPc1LvNncSX5eax
         GCSg==
X-Gm-Message-State: AHQUAuZcX9bwY5s3jZxCTl91r5YK21D4+aydjpa7lhgNhet7SLRVIsiP
        X27MNDpm1+/CIjuArI117zw=
X-Google-Smtp-Source: AHgI3IYCowKbY8KAAC7dm7vWoTO4ZiXM1NL6zirSyEVFh+VuIZ4X9eX6xyTdSQFCx8vHjy1k07t5MA==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr472240wme.137.1550003103718;
        Tue, 12 Feb 2019 12:25:03 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id n26sm1468554wmk.29.2019.02.12.12.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:25:02 -0800 (PST)
Date:   Tue, 12 Feb 2019 20:25:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190212202501.GA17681@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com>
 <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com>
 <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
 <20190211221827.GG6085@hank.intra.tgummerer.com>
 <CAP8UFD3s3-mR528FqV3yuMEZBqT0uP+Mp5hGDcN_a1LfAsR0bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3s3-mR528FqV3yuMEZBqT0uP+Mp5hGDcN_a1LfAsR0bg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Christian Couder wrote:
> On Mon, Feb 11, 2019 at 11:18 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/11, Christian Couder wrote:
> 
> > > Historically though we have always been very optimistic in what we
> > > thought a student could accomplish in a GSoC. And we are very likely
> > > to find more ideas for improvements during the GSoC, in case
> > > everything is "finished" before the end. I actually think that it has
> > > never happened that a student both "finished" the project before the
> > > end, and that no idea for improvement on top of the work was found.
> >
> > Fair enough.  I think there's still a number of things that could do
> > with some refactoring in 'builtin/stash.c', e.g. use more of the
> > libgit.a API, instead of using the run_command API, or potentially
> > other improvements that could be made.
> >
> > Another thing that may be useful to do is to write down some actual
> > technical documentation on the format of what a stash commit looks
> > like.
> 
> Yeah, using more of the libgit.a API, instead of the run_command API,
> and writing technical documentation on the stash commit format look
> like good ideas to me. I think I will add those items to the project
> description if you don't mind.

Sure that sounds good, thanks!  I think using more of the libgit.a API
should probably be an optional endeavor, but writing the technical
documentation may be a good thing to include in the project.

> > > So after all if you are willing to co-mentor such a project, I would
> > > be ok to co-mentor it with you, and we should add it to the list.
> >
> > Ok, I'll submit a PR to add it to the list.
> 
> Great! I merged your PR.
> 
> I also resurrected the "Convert scripts to builtins" idea as I think
> there might still be shell scripts that could be converted, like
> perhaps git-merge-octopus.sh, git-merge-one-file.sh and
> git-merge-resolve.sh.

These all look quite small, but yeah perhaps converting a few of them
over the course of the summer might be an alright project.

> So I think we should be good regarding Google requirements.
> 
> Thanks,
> Christian.
