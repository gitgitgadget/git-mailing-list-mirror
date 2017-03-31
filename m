Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D925420958
	for <e@80x24.org>; Fri, 31 Mar 2017 07:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbdCaH4V (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 03:56:21 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41376 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdCaH4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 03:56:21 -0400
Received: from tigra.domain007.com ([192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v2V7uE44018175;
        Fri, 31 Mar 2017 10:56:15 +0300
Date:   Fri, 31 Mar 2017 10:56:14 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     git@jessiehernandez.com
Cc:     "David Shrader" <dshrader@lanl.gov>, git@vger.kernel.org
Subject: Re: ttk error when starting git gui
Message-Id: <20170331105614.15746aadd7c3a51e1fda65b3@domain007.com>
In-Reply-To: <ff7628d7c69ecd3d212b29fec33f6ba1.squirrel@mail.jessiehernandez.com>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
        <916067befdc828e5d33dd3c1817989e7.squirrel@mail.jessiehernandez.com>
        <20170331103330.5d7c414b6a0273cefb8508f2@domain007.com>
        <ff7628d7c69ecd3d212b29fec33f6ba1.squirrel@mail.jessiehernandez.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Mar 2017 09:45:03 +0200
"Jessie Hernandez" <git@jessiehernandez.com> wrote:

> >> I also got this problem when I wanted to build and run git 2.10.x.
> >> I have added the following change to git-gui/git-gui.sh
> >>
> >> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> >> index 5bc21b878..5ce59ef94 100755
> >> --- a/git-gui/git-gui.sh
> >> +++ b/git-gui/git-gui.sh
> >> @@ -894,7 +894,7 @@ set default_config(gui.fontui) [font configure
> >> font_ui] set default_config(gui.fontdiff) [font configure
> >> font_diff]
> >>  # TODO: this option should be added to the git-config
> >>  # documentation
> >>  set default_config(gui.maxfilesdisplayed) 5000
> >> -set default_config(gui.usettk) 1
> >> +set default_config(gui.usettk) 0
> >>  set default_config(gui.warndetachedcommit) 1
> >>  set default_config(gui.tabsize) 8
> >>  set font_descs {
> >>
> >> If you guys want I can submit it as a patch.
> >> But i assume that 'fixing' this by disabling the feature is not
> >> really what we want.
> >
> > It's possible to have ttk with 8.5 as well (say, here on Debian 8.5
> > ships with ttk enabled).
> >
> > A proper patch would be
> >
> > -set default_config(gui.usettk) 1
> > +set default_config(gui.usettk) [namespace exists ::ttk]
> >
> > Could you please test it on your system?
> >
> 
> Yeah that seems to work.
> Thanks for this.
> 
> I have tried it with git 2.12.2

Please consider re-posting this as a proper patch, then. ;-)
