Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9978420372
	for <e@80x24.org>; Thu, 12 Oct 2017 16:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755591AbdJLQRl (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 12:17:41 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:50637 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755248AbdJLQRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 12:17:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id m63so5521363pfk.7
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=snFwV6MctphewURMLoZxxrbiW7d8zX499tEzIwV85l8=;
        b=SwqbhDAhpYgX7Jp09JjTYnvvndmg0xjXvlVFJdQZP6Wg9HJYq8JUSc8vBn+mzx1s0m
         kueUnCKoCXTDB2YI9M4damzVNMVsdzjHuLryE9ZeweEmS8Ixs+aJXxO7/J0MGUXT1PUY
         tPucnK9m8winpnaDNJeNGm8+xvWMO7WcgIwuGdRMCQt2bhuogyoXQJe9CwFZl8i2bx6J
         1VZhahda2YCL2RIu12Bx2EJYdkarA8ikaALvsXs6gyDKAunbEgy2p/sT9AHAxaK4cXG5
         fFOMXL1ErYeD73/8l95E++O5rV20pw3ZlLllScwMhFKKhRP0EYR1HGjq+ViqU9tEoT8w
         XR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=snFwV6MctphewURMLoZxxrbiW7d8zX499tEzIwV85l8=;
        b=HWe6ydBdeUceYdfmh8kxzYDEo4VIHescy7gFB9Oda+Q5XElGfvcB5HqRdhWMHD+Kgs
         L+kNMAPpJsS1LB+rMTRavzxvcz4HS2e7RI1vib42RujXDu2s/N/oLFpTb2NHtxxGKqs+
         jBBSJNHrK2lWR/MXj5H4+dDH8bAH6wkwgoHjeT0OiFskAwpop8xm3MJLgcCLsPJNqvyL
         PCo2VQ7JWQWza5xpr7AEX1ea9l5++W1ksl0XCvHM4YxpB7DadgBcsriBL0xU4uDfCd/L
         5f8fvjBIXFITjlrP5TPFjJ1uiv/Gia5fa7IVAml0pZGHEPDrJzUfDcFDgOJcRGnzGS6S
         MVOA==
X-Gm-Message-State: AMCzsaWzTA3y9lBX220bPsOrIN4uHu2mwAXs2DSgFCnpcHo9TrX3RGM9
        2ERD2A/pkQPh/cH5z+ENtZuPpQ==
X-Google-Smtp-Source: AOwi7QDD1ora+bdI7U4rZNXWH8hk+XBPoz7b7Z1HFi8M9IFD2ngkGoIdeJwy7KE3LJGkCJDFQc0ZhQ==
X-Received: by 10.84.136.135 with SMTP id 7mr663250pll.392.1507825051409;
        Thu, 12 Oct 2017 09:17:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f1ea:3c1c:3cdb:da7f])
        by smtp.gmail.com with ESMTPSA id e66sm29555680pfe.79.2017.10.12.09.17.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Oct 2017 09:17:30 -0700 (PDT)
Date:   Thu, 12 Oct 2017 09:17:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
Message-ID: <20171012161729.GA169880@google.com>
References: <20171006222544.GA26642@sandbox>
 <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
 <20171010130335.GB75189@book.hvoigt.net>
 <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
 <20171011151021.o6f4l7kcd3azdmiu@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011151021.o6f4l7kcd3azdmiu@x>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Josh Triplett wrote:
> On Tue, Oct 10, 2017 at 11:39:21AM -0700, Stefan Beller wrote:
> > On Tue, Oct 10, 2017 at 6:03 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > > but in the long run my goal
> > > for submodules is and always was: Make them behave as close to files as
> > > possible. And why should a 'git add submodule' not magically do
> > > everything it can to make submodules just work? I can look into a patch
> > > for that if people agree here...
> > 
> > I'd love to see this implemented. I cc'd Josh (the author of git-series), who
> > may disagree with this, or has some good input how to go forward without
> > breaking git-series.
> 
> git-series doesn't use the git-submodule command at all, nor does it
> construct series trees using git-add or any other git command-line tool;
> it constructs gitlinks directly. Most of the time, it doesn't even make
> sense to `git checkout` a series branch. Modifying commands like git-add
> and similar to automatically manage .gitmodules won't cause any issue at
> all, as long as git itself doesn't start rejecting or complaining about
> repositories that have gitlinks without a .gitmodules file.

That's good to know!  And from what I remember, with the commands we've
begun teaching to understand submodules we have been requiring a
.gitmodules entry for a submodule in order to do the recursion, and a
gitlink without a .gitmodules entry would simply be ignored or skipped.

-- 
Brandon Williams
