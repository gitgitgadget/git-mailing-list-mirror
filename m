Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8102620281
	for <e@80x24.org>; Fri, 29 Sep 2017 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbdI2XVd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 19:21:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:60591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbdI2XVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 19:21:32 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLNeQ-1dxWd72tgA-000fOu; Sat, 30
 Sep 2017 01:21:23 +0200
Date:   Sat, 30 Sep 2017 01:21:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Wesley Smith <wsmith@greatergiving.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Is finalize_object_file in sha1_file.c handling errno from
 "rename" correctly?
In-Reply-To: <07c6a131ef4b4a92859d59d1dc2cde86@APEXC04.auctionpay.com>
Message-ID: <alpine.DEB.2.21.1.1709300120300.40514@virtualbox>
References: <c9b3bc17110048f0b7943704cfbd8f68@APEXC04.auctionpay.com> <xmqq4ls4xxok.fsf@gitster.mtv.corp.google.com> <07c6a131ef4b4a92859d59d1dc2cde86@APEXC04.auctionpay.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WYJDDrcZ52Mdflf42nsuANJTwlXeTLcXhIQ8/LXOAG4wdSSVcl5
 GtjbV6pEanHXNQ7pt8LCim/BY97aapqQArMR3iSuITtj9ZjdnoYsVzZDRNGvFWzGSCdxvik
 PCpvd0UNOjFg8OVr35COyR1+y/fFAtOctBfGqQPkC2Gkq7r5vgDDvxseGkpHrZEgzfAA+eA
 VvXWSmH744APHKD9pWg4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F0i7KnlRZOI=:r6xgcL/ocY53pvgbFLbSS0
 BBAIwb+zpiNeMXGafGuR1JQ2UI4VXHaMIuGOHus5cpxlNJj+pXCLl3Y1WJif2n/QSixvbXT/7
 mU7TpC5di4Z8a+MjeXIifIbPwCuxsSruMlECirSfVvFOHLbfcZYisqowuZEp07Ai4UEL0+zEc
 R7E1BeDUaq9YGBzcv37ftbKapYURi/xOXNarchf5Yj5P8lDjv48uwcKWwCb0CLOff7VdgQvea
 nQYek2GvihcyBvMkMybNT3tM6H7jbUlZ6K8MU/Kj05ixGbCk6p69W2S29o/0oPae5aYBQWCHf
 MlaSg9LvCnp+aonUvzd11M+nta14BzuIGGbVXozZUbLhGbm1yblb3aLDFBQDkqf9lSYDZwjGj
 b0ER1SXDU+ePQm7rJpewqQIeMy6pVJu/Rk9hIHTrXVKcworxc6tBRO/YqR8IuLmXJ4T5Rkx98
 geAg48h9azdRTu30X6D4OScpIgfr91vgDNskD4T8D96eC8GKj1ixDHib91KU/ObvDK/UttYxk
 Syg49Oc0iSySgDu0LJ5NVq3NjlCiq46Sk/TfRjliisoXiu4q+4TybkIG2aECH8V4DHVd4Qk0i
 fP8F6e9GGhok4TMrNc2KM4KwYHi0zYEMtd6XpATSpmEArrDDg4rkdMNOPeqOcSKbVoEL/Pr7h
 /lYKiZ+e0QFr89XFaIkTtl1jPsAJXmLI0Hp5qojndzhtieXYTYjjjqz2qtEkITnH9YsOxnM5v
 ImkTzGcsdki2/+weLOQe9+5Z6Bu/sSjkByDc/t1L6HZmXG1p79yEdHm5110Wt/A8KkuFlEFwS
 hpFCYDsaoi5ZJcnqKscpyhUCLwiLGWu9ESbxKDvz0Y4mrLqvT4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 15 Sep 2017, Wesley Smith wrote:

> Thanks for your response.  I'm glad to see that you've been able to understand the problem.  I'm working with the Windows git team to properly return EACCESS when "rename" fails due to access permissions, but it also sounds like there will need to be a fix to finalize_object_file to better handle the case of an existing file when renaming.

The Windows part of the problem was fixed in v2.14.2.

Ciao,
Johannes

[ leaving the rest of the quoted mail intact intentionally, to give
readers a chance to read up on the context ]

> Wesley Smith
> T: 503.597.0556 | WSMITH@GREATERGIVING.COM
> 
> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: Thursday, September 14, 2017 11:51 PM
> To: Wesley Smith
> Cc: git@vger.kernel.org
> Subject: Re: Is finalize_object_file in sha1_file.c handling errno from "rename" correctly?
> 
> Wesley Smith <wsmith@greatergiving.com> writes:
> 
> > 1) This bug is triggered because "git fetch" is causing a pack file to 
> > be written when that same pack file already exists.  It seems like 
> > this is harmless and shouldn't cause a problem.  Is that correct?
> 
> The final name of the packfile is derived from the entire contents of the packfile; it should be harmless when we attempt to rename a new file, which has exactly the same contents as an existing file, to the existing file and see a failure out of that attempt.
> 
> > 2) It seems that finalize_object_file is not accounting for the fact 
> > that "link" will return EEXIST if the destination file already exists 
> > but is not writeable, whereas "rename" will return EACCESS in this 
> > case.  Is that correct?  If so, should finalize_object_file be fixed 
> > to account for this? Perhaps it should check if the newfile exists 
> > before calling rename.  Or, should the Windows mingw_rename function 
> > be modified to return EEXIST in this case, even though that's not the 
> > standard errno for that situation?
> 
> The codepath that is triggered by OBJECT_CREATION_USES_RENAMES ought to behave correctly even on non-Windows platforms, so bending the error code of rename() only on Windows to fit the existing error handling would not be a smart thing to do.  Rather, the rename() emulation should leave a correct errno and the caller should be updated to be aware of that error that is not EEXIST, which it currently knows about.
> 
> Thanks for spotting a problem and digging to its cause.
> 
> This is a #leftoverbits tangent, and should be done separately from your "OBJECT_CREATION_USES_RENAMES is broken" topic, but I think it is a bug to use finalize_object_file() directly to "finalize"
> anything but an individual loose object file in the first place.
> 
> We should create a new shared helper that does what the function currently does, make finalize_object_file() call that new shared helper, and make sure finalize_object_file() is called only on a newly created loose object file.  The codepath that creates a new packfile and other things and moves them to the final name should not call finalize_object_file() but the new shared helper instead.
> 
> That way, we could later implement the "collision? check" alluded by the in-code comment in finailize_object_file(), and we won't have to worry about affecting callers other than the one that creates a loose object file with such an enhancement.
> 
> 
