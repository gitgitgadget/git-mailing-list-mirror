Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D1D2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 11:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbcGLLZI (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 07:25:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:41570 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbcGLLZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 07:25:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bMvoG-0003Yw-H6
	for git@vger.kernel.org; Tue, 12 Jul 2016 13:25:04 +0200
Received: from host109-148-68-207.range109-148.btcentralplus.com ([109.148.68.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 13:25:04 +0200
Received: from rsanchez.saez by host109-148-68-207.range109-148.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 13:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ricardo =?utf-8?b?U8OhbmNoZXotU8OhZXo=?= <rsanchez.saez@gmail.com>
Subject: Re: Submodule's .git file contains absolute path when created using 'git clone --recursive'
Date:	Tue, 12 Jul 2016 11:22:07 +0000 (UTC)
Message-ID: <loom.20160712T131832-33@post.gmane.org>
References: <loom.20160505T140253-275@post.gmane.org> <CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com> <CAK1enhO-2Ne4XVqRNXz+6Jd7uEEHde8-_xzwWzXh=b01bZhj0g@mail.gmail.com> <CAGZ79kYjw6vzf7rf_-bOiMmm0VtAwO03vpk67QP4u2m_N_Mm4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.148.68.207 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/602.1.39 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.5)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller <at> google.com> writes:

> 
> On Thu, May 5, 2016 at 12:20 PM, Loet Avramson <loet <at> forter.com> wrote:
> > It happened on 2.8.1, also reproducible on 2.8.2.
> > Haven't had the time to dive deeper into the code but my guess is that
> > relative_path() returns different results in those 2 cases or maybe
> > the way git-submodule.sh handles it.
> >
> 
> Then you found a new bug, congratulations. ;)
> Thanks for reporting.
> 
> The shell script uses relative_path() only for displaying paths,
> not for writing them to the .git file.
> 
> it really boils down to different environments
> "git submodule update --init --recursive" is called from
> (either manually or from `git clone`).
> 
> Apart from that there are no immediate bells ringing,
> are you doing any weird stuff with the file system (soft/hard
> links) ?
> 
> Thanks,
> Stefan
> 

Hi,

sorry to awake an old thread. Has this been fixed? In which git version?
It's hitting me on git version  2.7.4 (Apple Git-66) (default git client on
 OS X 10.11.5 (15F34)).

I think all submodule .git files should contain relative paths. Otherwise,
 duplicating or moving the cloned  repository folder breaks the submodules.

Best,
Ricardo

