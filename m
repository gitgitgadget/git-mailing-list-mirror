Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2751C4332D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EDA64F0A
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 08:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhCDIOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:14:55 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53283 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhCDIOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 03:14:50 -0500
Received: from localhost (unknown [180.94.32.211])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 80912100004;
        Thu,  4 Mar 2021 08:14:06 +0000 (UTC)
Date:   Thu, 4 Mar 2021 13:44:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.31.0-rc1
Message-ID: <20210304081403.vmtpxfi75jimxlmx@yadavpratyush.com>
References: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
 <CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8USnoyQ7Aw@mail.gmail.com>
 <xmqqmtvje993.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtvje993.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/21 10:14PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Mar 3, 2021 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Pratyush Yadav (1):
> >>       git-gui: remove lines starting with the comment character
> >
> > Is there some way that this can be removed from v2.31.0 before final
> > release? It badly breaks git-gui on macOS[1,2] to the point of making
> > it unusable (Tcl throws errors at launch time and when trying to
> > commit, and committing is 100% broken).
> 
> Thanks.
> 
> I could revert the merge with the problematic changes to git-gui,
> i.e. 0917373 (Merge https://github.com/prati0100/git-gui,
> 2021-03-01), but if possible, I'd rather merge a revert made on the
> git-gui side.  If b1056f60 (Merge branch 'py/commit-comments',
> 2021-02-22) is the tip of git-gui repository, and b9a43869 (git-gui:
> remove lines starting with the comment character, 2021-02-03) is
> what breaks, perhaps 
> 
>     $ git checkout b1056f60^2 &&
>       git revert b9a43869 &&
>       git checkout b1056f60 &&
>       git merge @{-1}
> 
> would be what we want to have at the tip of git-gui until the
> breakage gets sorted out.
> 
> Pratyush?

I will send a follow-up PR with the patch reverted. I'll then apply 
Eric's patch to fix breakage on MacOS and let it simmer till the next 
release. Let's not risk any breaking changes close to release.

-- 
Regards,
Pratyush Yadav
