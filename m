Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072881F453
	for <e@80x24.org>; Mon, 24 Sep 2018 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbeIXUCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 16:02:14 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:35201 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeIXUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 16:02:14 -0400
Received: by mail-qt1-f171.google.com with SMTP id z14-v6so4478795qtn.2
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gP7YFlpStalN5d3non8XgIIOBFMB0/MJrw8oBNEtTU=;
        b=UV9CdLbBV7deJ7D3aNTzFE1IkVnYPC+zYHctE5npv1coajhAdMeTMK4ANP+Kl9gM+G
         nVC2CR1d5i7u7SOzkByYX7gZo+Id3JfxOic3P4LrXaY7j4uJtfApnH7EwRINT84TNtLU
         PFbquD93jFb9LvZz79fm8ADWdPGQQ2WeK+vSnbMT3eWHldToWlCsd/scHMGmzsRdtaFA
         HOgX0KwWYWYCZT+oJW/8YIWAl4tqFCQHgZD74mIPYQzqEnZEkJm/aeuaS1heqbbrGbR3
         DM6HRCz84XYB+VIRU1hwwTB7dEiUSyIW2hMDrrH3D+VFYNpVQkwfgALzbiZRY2n6+/az
         Tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gP7YFlpStalN5d3non8XgIIOBFMB0/MJrw8oBNEtTU=;
        b=l5sTV8pfPYT5S4EgA7n/NHF6Gu3zz57C0cVMSsJ9Tj8cTYubiZ0GKY72OxEejljeuM
         exvx/QKaj27Zubf4KsPdo7QUklgL61QSs0esVAEHaNhRp2oJE0LUiopUMVv4GKO4hc5A
         uyITaDGsCZwk1jNRbTA+97eDyicbPu0puMORAbyrg5TDEciT7q48diUduCEdxG6zIARl
         Wg403KzwyuJqtyXMW28qvN2tLqQFXapdFR8nXY6j6Ag4bZW/bSkGUOzpg0PjEOZzD2bE
         4mRSS4esc8zpfTFHjd52A5dC1Lm1NBDO7bBuCMY67I0IW4d48sr5iau3/AX5LrhPYnS2
         K/+A==
X-Gm-Message-State: APzg51C2Le+jE5H8CwnHJlQAefPlHWI7W9brSF6pYg0N86bx/LFIITE6
        FQIGKy8lOFXJY1kZE1zOebHcWA==
X-Google-Smtp-Source: ACcGV63/QL6kcwj1Kp4MN751yQfohZ03z9/hio2tvg7k4URHL0xHAG9DeLrjX80MmYEwDplWJXRw3w==
X-Received: by 2002:ac8:c86:: with SMTP id n6-v6mr8152352qti.324.1537797596074;
        Mon, 24 Sep 2018 06:59:56 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id k21-v6sm16855495qtj.11.2018.09.24.06.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 06:59:54 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 24 Sep 2018 09:59:53 -0400
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'John Austin' <john@astrangergravity.com>,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, id@joeyh.name, 'Taylor Blau' <me@ttaylorr.com>,
        git@vger.kernel.org,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Lars Schneider' <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180924135953.GB68796@syl>
References: <20180914190025.GJ55140@syl>
 <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl>
 <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net>
 <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501d45366$cf437060$6dca5120$@nexbridge.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 01:56:37PM -0400, Randall S. Becker wrote:
> On September 23, 2018 1:29 PM, John Austin wrote:
> > I've been putting together a prototype file-locking implementation for a
> > system that plays better with git. What are everyone's thoughts on
> > something like the following? I'm tentatively labeling this system git-sync or
> > sync-server. There are two pieces:
> >
> > 1. A centralized repository called the Global Graph that contains the union git
> > commit graph for local developer repos. When Developer A makes a local
> > commit on branch 'feature', git-sync will automatically push that new commit
> > up to the global server, under a name-spaced
> > branch: 'developera_repoabcdef/feature'. This can be done silently as a
> > force push, and shouldn't ever interrupt the developer's workflow.
> > Simple http queries can be made to the Global Graph, such as "Which
> > commits descend from commit abcdefgh?"
> >
> > 2. A client-side tool that queries the Global Graph to determine when your
> > current changes are in conflict with another developer. It might ask "Are
> > there any commits I don't have locally that modify lockable_file.bin?". This
> > could either be on pre-commit, or for more security, be part of a read-only
> > marking system ala Git LFS. There wouldn't be any "lock" per say, rather, the
> > client could refuse to modify a file if it found other commits for that file in the
> > global graph.
> >
> > The key here is the separation of concerns. The Global Graph is fairly
> > dimwitted -- it doesn't know anything about file locking. But it provides a
> > layer of information from which we can implement file locking on the client
> > side (or perhaps other interesting systems).
> >
> > Thoughts?
>
> I'm encouraged of where this is going. I might suggest "sync" is the
> wrong name here, with "mutex" being slightly better - I would even
> like to help with your effort and have non-unixy platforms I'd like to
> do this on.
>
> Having this separate from git LFS is an even better idea IMO, and I
> would suggest implementing this using the same set of build tools that
> git uses so that it is broadly portable, unlike git LFS. Glad to help
> there too.

I think that this is the way that we would prefer it, too. Ideally users
outside of those who have Git LFS installed or those that are regular
users of it should be able to interoperate with those using the global
graph.

We're thinking a lot about what should go into the next major version of
Git LFS, v3.0.0, and this seems a good candidate to me. We'd also want
to figure out how to transition v2.0.0-era locks into the new global
graph, but that seems a topic for a later discussion.

Thanks,
Taylor
