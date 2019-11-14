Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68BD1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNCbH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:31:07 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41263 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKNCbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:31:07 -0500
Received: by mail-pf1-f174.google.com with SMTP id p26so3034278pfq.8
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUGViTXEahxk7eDB2DaF+RbzFTp0hcS2DVqRG+bHsUo=;
        b=a2ihFjim72uCDZGBC9L9K9IAVM9qoa0jaNeilDfjX+V83ZDKAJHKbMmN9ivyORg4WC
         9atkmZjyv1yVFZvyLrkuLxqA/KRLV/V/9Rfse+X/8Lw6twADJBFT1jzwciSC3ebZoPOL
         9a7Pnr1jzFRSx2eKsHnUPhRFngdt//TKeqz53myxENX9/ZOYI5J6kV7V+vBG8J+ycBo/
         HD6u9kI84Hr/84VHDvKaTKhirqksv+UcNniIwFIK0x0v+sKK5gEDThYDxw9PTOH7N9ME
         UXtPHqQo7pCJQNDu60qeGWkzf2QxVHI2gJ2gbqoCNF390JMRENZaw7nj8q4K1FAMxMA1
         S84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUGViTXEahxk7eDB2DaF+RbzFTp0hcS2DVqRG+bHsUo=;
        b=s5UwiW2RgGQvOevnJ6eOC+5bBUGl5ebGQNayWOOEcIkgxEpJs9WmKphdpESu8Ag3YG
         KCwAJEC0XweaS/VBogy8Mes2ZLSEBZ3pr9v/JS2Fci16TsRng5DF+6lxyuxxE83ZCJFB
         w7KJBqIq82/MAKKd3ERW6u+AULRHUNCq6gy8+0uWbrStKDisaUiVsl6dZjOQT7OoYX2+
         MW5Xd1rsYnAHtY0UWnUzArF0U7xrXKg27cluzxc4LNB3NE7l6pDy4Cr4jceUPeTuU1yM
         jIfRgdS4XTSrj6QgJMp7WKEd6RxOTUZeY4CKLtTm0wm6B8Ae+5RsQde/JP5RjCHUI3Gf
         HdCQ==
X-Gm-Message-State: APjAAAUe+whwKoNQObTi+Ve06v9LZvurqaN0PXWVKxzDSXUXeiZSPAE3
        wcR9IeVz5kkkwQao/U6+v/Uwtw==
X-Google-Smtp-Source: APXvYqw6mv2Tr9llYvKJ7AGRQia+xBHJv56IBIDOhtVHDx6dMWI3PJj3V36bsyI5s2VTzO0BTJHU7A==
X-Received: by 2002:a62:e219:: with SMTP id a25mr8042982pfi.252.1573698666104;
        Wed, 13 Nov 2019 18:31:06 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z4sm4289431pfn.80.2019.11.13.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 18:31:05 -0800 (PST)
Date:   Wed, 13 Nov 2019 18:31:00 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20191114023100.GD22855@google.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <20191112184547.GA38770@google.com>
 <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
 <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
 <20191113150624.GC3047@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113150624.GC3047@cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 03:06:24PM +0000, Thomas Gummerer wrote:
> On 11/13, Christian Couder wrote:
> > On Tue, Nov 12, 2019 at 9:04 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 12 Nov 2019, Emily Shaffer wrote:
> > >
> > > > I'm still really interested in participating on a mentors list like
> > > > this; can we set one up?
> > >
> > > I would subscribe immediately to a Git mentors' mailing list.
> > >
> > > Thanks for bumping this,
> > 
> > I would also subscribe, and yeah I think it might be worth trying.
> 
> +1.  As mentioned in #git-devel during the last standup, I'd like to
> be on that list as well.

Christian's suggestion of a Google Group list was good enough for me.
For now, the permission settings are as follows:

 - Group visibility: Anyone. (So it can be easier to discover and
   advertise.)
 - View topics: Group members only. (Maybe we want to open this up so
   it's easier for non-member Git contributors to take a look at what's
   going on.... but maybe if they're interested they can just join the
   group :) )
 - Post: Group members only. (My thinking is that once you're asking for
   someone's time and effort to help mentor you, you can volunteer the
   time and effort needed to push the join button and optionally filter
   your inbox ;) )
 - Join group: Anyone. (Let's make the barrier to entry low.)

https://groups.google.com/forum/#!forum/git-mentoring/new

git-mentoring@googlegroups.com

 - Emily
