Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB65D1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 22:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeAJWlO (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 17:41:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:54485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbeAJWlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 17:41:13 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4VE-1eiEju2sYS-008neu; Wed, 10
 Jan 2018 23:40:54 +0100
Date:   Wed, 10 Jan 2018 23:40:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 8/9] sequencer: try to commit without forking 'git
 commit'
In-Reply-To: <20180110205351.GA73826@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801102332350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171211141330.23566-1-phillip.wood@talktalk.net> <20171211141330.23566-9-phillip.wood@talktalk.net> <20180110205351.GA73826@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cpkdPjlRtyldtT9ptQ+K3de4vhlRMbm8X51lHGclDaCagQzTKjT
 rS3fZk/UfmibO/ourr50FC+RoRAiDBQJTJK8MDbSRbGfu9LA8g1GC/XCKAjlGzBxkKh0Zdv
 okXmQnYt/tayRjeJ4boa3WLQSB37sZJ1ZtS5ZA24MhTpSio0PlJlR6PuXxnSl87fzeFvOMq
 rzNIaO+AZ3X4kCdNJnBwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1qKmCzxH/OU=:8/ed457VlzLc2Wp160a8fu
 5wXWitSldhM3VfyW5PjvGqITmynru21/O1hB3GqqewgqjR5upF2L8Qi8il6NQZoYJUnn7FGkz
 h/COPGxNDx5aJ6yAbYgzb9MpPeNJegsiKOdxemn61t9147inLDK5D5kO8ju9ZTfpOtzqxtAUE
 U1z2rPJzKIIGkB/UoEKbyqcLCmn9oBnf6Ln8pbeZxcT5NIVaG9IZmvc4IS/Eh7mlNSuwu9oI+
 MI6AS+lrHRCedrOBa+A/UJ6kQYtj36oJ2eE/nIGWBrDohSD7pJVOg7qsvvKDFHVILNYWhzZn5
 tRZUKZ2ET7PV89YGPFmFIlNUObGpYCz79AsMTUe6/uZowVtF7D1wF1Xp75q+TzW7lOle3BsKe
 XDiyQFvzA2drVI9YC/G/tPqkLiN7R/lNWoN5A/Y+zNuk+AmdY7PUSsLDwr7ZPB2t5+p4Qijax
 Seh+gZW635QEA2fXUW5TWfPnqRR7OsVh5IpwuMnIph2peaFlTHQOYs7YnHsQewX0dVgvVjxm3
 vStJxPMmyYSwk6j9uDmIB87qF6Au3Y6AfzA2+/qVsF+ku86/AryIIib4XEm0AWOIb+eOrGdSS
 Yow86EEP+H53HkiiygXbv+CCdMDvE4cqNQyeHCnIywLZdMLAv3dWEZYI6vtLc2H6VgdjpbAwg
 sO+SIHCtIsT2Z1dKQWHDHk7Y79GhnkjVIwAXOnahXasi4dM16nG/A6EK99aqTGpEwYcNiEyts
 S88WsmldnzPB0Hqim+BH5QrLH+xjegea0u7kKdL2J7fZNPJU9R16lYEU2j2dknUxk5OaWvKhe
 hH2pO56vQuExx/RNRGUV9vemlhoeIaG3zgVFKP/ULnXILbybT0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 10 Jan 2018, Jonathan Nieder wrote:

> Phillip Wood wrote:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > If the commit message does not need to be edited then create the
> > commit without forking 'git commit'. Taking the best time of ten runs
> > with a warm cache this reduces the time taken to cherry-pick 10
> > commits by 27% (from 282ms to 204ms), and the time taken by 'git
> > rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
> > my computer running linux. Some of greater saving for rebase is
> > because it no longer wastes time creating the commit summary just to
> > throw it away.
> 
> Neat!  Dmitry Torokhov (cc-ed) noticed[1] that this causes the
> prepare-commit-msg hook not to be invoked, which I think is
> unintentional.  Should we check for such a hook and take the slowpath
> when it is present?

We could also easily recreate the functionality:

	if (find_hook("pre-commit")) {
		struct argv_array hook_env = ARGV_ARRAY_INIT;

		argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s",
			get_index_file());
		argv_array_push(&hook_env, "GIT_EDITOR=:");
		ret = run_hook_le(hook_env.argv, "pre-commit", NULL);
		argv_array_clear(&hook_env);
	}

(This assumes that the in-process try_to_commit() is only called if the
commit message is not to be edited interactively, which is currently the
case.)

Ciao,
Dscho
