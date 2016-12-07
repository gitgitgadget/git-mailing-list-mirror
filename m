Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9B020259
	for <e@80x24.org>; Wed,  7 Dec 2016 20:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbcLGUP0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:15:26 -0500
Received: from mout.web.de ([212.227.17.12]:59980 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932784AbcLGUPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:15:25 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lb29N-1cusrE2Zk9-00kcl1; Wed, 07
 Dec 2016 21:14:13 +0100
Date:   Wed, 7 Dec 2016 20:14:09 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161207201409.GA19743@tb-raspi>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:sFYc4PXpK25mnIbMNGVq5xogHiWgA8ZepWbILfryagi8zBTpXBP
 BV+ZTSFTeJcJRZKnvtgj6apIwmPlcxqmhirKrDCtXlcOP9ePYcCA4obOorQVVzLwcBLJNoH
 9t/R7UiIrQ/xixDzkNIxVNfuuKoe2ZtLFt5Q5K6BqHAM0GA5baF/ugBVE9U97+9oARd6Ii4
 WyL4u9XgGDU/7U8UMO0/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQZnZX3pAvQ=:LoUImetSv3BTh76u14xtej
 FQ/k7xVcsrSEswVfpkka3COpias43X4owqYqu3WAQ4GQu0EeBbAtpd4PfRCAvqDeEj5OyqRVd
 sRByjXONHIv+fKEie/IGySgECoso7pUuZtfJQw9qGwQM/cs5meEtYjFzhwEpaKqMihSmIY4S8
 QXfuwYskIw/kh4dElSiaFiDYOri6d6JeJ7ZqRvcKTYckYIlkmmBgGX+Altx+xsBd52ciGiCDF
 7DZnGXziBQxphcOTBqYJ3bofyNsajfRsBYdhoX043IdYolxPSiwbxKr9tE0HBHXNpFpl4t9Zk
 YrYLXBmu/lnVO7a/OsLmPVfyrL8TMYTcz9BzZbPwhJVp4S2U0tO4ltYZFKRx2KZFrxBMAyvSI
 OBVcXaAsFtf3i93Yh+f6cQYNR4yocb68nur9xRCXfJ+pBLDQgi460v0Z8a+D+FkIHeev6Q7+B
 nK8cWqzSizUTptP+k57cSQwuOKM9c71wQg6pjFMZQF+SVUvNWbQKahmtsKZ99PhdqJSC9SRwt
 Kdsd3gPFwfKZ3dTfypNOYLQvzvvoBv14++fSf4DuWsFYMctKF3Jkh7xAjzR9GjkbvULRKny/x
 fTRsS/GBF/jhQfratC6MPMoNGn9qn2EnPfsRgdjmK5uRBj7Q+38xvIFyKJFA6TbP/8Rs2XrxJ
 NDTifP4BxMQajnzQfShFRzUvGOqI1UlJqkH2YVsqVm6MD193MTq54PgO9yWHF9UwiRyhVJ7Jy
 tcQp9gkzJtw8w0vXkzcswRFirnQGGUTFZjFusn4GbYEAhtLUgwcvnEUJ0XE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2016 at 01:12:25AM +0000, Ramsay Jones wrote:
> 
> 
> On 07/12/16 00:10, Brandon Williams wrote:
> > On 12/06, Junio C Hamano wrote:
> >> POSIX cares about treating "//" at the very beginning of the path
> >> specially.  Is that supposed to be handled here, or by a lot higher
> >> level up in the callchain?
> > 
> > What exactly does "//" mean in this context? (I'm just naive in this
> > area)
> 
> This refers to a UNC path (ie Universal Naming Convention) which
> is used to refer to servers, printers and other 'network resources'.
> Although this started (many moons ago) in unix, it isn't used too
> much outside of windows networks! (where it is usually denoted by
> \\servername\path).
> 
> You can see the relics of unix UNC paths if you look at the wording
> for basename() in the POSIX standard. Note the special treatment of
> the path which 'is exactly "//"', see http://pubs.opengroup.org/onlinepubs/009695399/functions/basename.html
> 
> ATB,
> Ramsay Jones

Please allow one more comment about UNC:
They are used under Windows, and typically wotk together with Git.
One breakage between 2.10 and 2.11 has been observed, saying that
pushing to \\SERVER\SHARE\DIRECTORY does not work any more.

It has been reported under
 "git 2.11.0 error when pushing to remote located on a windows share"
both here and 
here:
https://github.com/git-for-windows/git/issues/979#issuecomment-264816175

I don't have a Windows box at the moment, and I don't know if the
breakage was introduced by changes in real_patyh().

But in any case it seems that e.g.
//SEFVER/SHARE/DIR1/DIR2/..
must be converted into
//SEFVER/SHARE/DIR1

and 
\\SEFVER\SHARE\DIR1\DIR2\..
must be converted into
\\SEFVER\SHARE\DIR1




