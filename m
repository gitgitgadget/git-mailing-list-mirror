Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE5A2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 09:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbcGEJ43 (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 05:56:29 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35661 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbcGEJ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 05:56:26 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u659uLt9019834;
	Tue, 5 Jul 2016 12:56:22 +0300
Date:	Tue, 5 Jul 2016 12:56:21 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	shawn wilson <ag4ve.us@gmail.com>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git List <git@vger.kernel.org>
Subject: Re: split directories into branches
Message-Id: <20160705125621.cfa55e07cedd2853377c4f08@domain007.com>
In-Reply-To: <CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
	<20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
	<CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
	<20160704212926.919a267706a6fa5791c47726@domain007.com>
	<CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 4 Jul 2016 17:03:46 -0400
shawn wilson <ag4ve.us@gmail.com> wrote:

[...]
> > I don't possess the official stance on this topic but AFAIK
> > user-level questions are fine on this list.
> 
> In that case :)
> ... still having issues w/ filter-branch:
[...]

I used something along these lines:

  git filter-branch -f --tree-filter \
    'test -e my/new/dir || mkdir -p my/new/dir
      find . -mindepth 1 -maxdepth 1 \
      -type d -path ./my -prune -o -print \
      | xargs -n 30 mv -t ./my/new/dir' master 

More background on how it works [1] if you want.

1. https://groups.google.com/d/msg/git-users/hxFmfUZpj_k/9IQAQq40BwAJ
