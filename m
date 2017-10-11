Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B52A1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdJKPKc (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 11:10:32 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59597 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdJKPKb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 11:10:31 -0400
X-Originating-IP: 50.39.160.18
Received: from x (50-39-160-18.bvtn.or.frontiernet.net [50.39.160.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 23CD4FB8C4;
        Wed, 11 Oct 2017 17:10:26 +0200 (CEST)
Date:   Wed, 11 Oct 2017 08:10:23 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
Message-ID: <20171011151021.o6f4l7kcd3azdmiu@x>
References: <20171006222544.GA26642@sandbox>
 <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
 <20171010130335.GB75189@book.hvoigt.net>
 <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 11:39:21AM -0700, Stefan Beller wrote:
> On Tue, Oct 10, 2017 at 6:03 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > but in the long run my goal
> > for submodules is and always was: Make them behave as close to files as
> > possible. And why should a 'git add submodule' not magically do
> > everything it can to make submodules just work? I can look into a patch
> > for that if people agree here...
> 
> I'd love to see this implemented. I cc'd Josh (the author of git-series), who
> may disagree with this, or has some good input how to go forward without
> breaking git-series.

git-series doesn't use the git-submodule command at all, nor does it
construct series trees using git-add or any other git command-line tool;
it constructs gitlinks directly. Most of the time, it doesn't even make
sense to `git checkout` a series branch. Modifying commands like git-add
and similar to automatically manage .gitmodules won't cause any issue at
all, as long as git itself doesn't start rejecting or complaining about
repositories that have gitlinks without a .gitmodules file.

- Josh Triplett
