Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C42C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F95D613B6
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhEIIkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 04:40:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58493 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhEIIkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 04:40:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E91A9127C42;
        Sun,  9 May 2021 04:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+THwl9Xk1ksrBe/1u0n/mdADvAM7i68K1Aic43
        Gc7D8=; b=Ga3CJZQhq4lGvUmy+9goFCdQ9ufVazWTJFug7uBiQKrN8vvCtTpz0u
        qfHMD4fC6T+CIplLVZ9La1OVARwl95L3oQvv9Cm666XQbK9qzrCgYfWPz1DCzOob
        OHgjmLxzmsh5DWrrnj8LcSytUqTGnGRui21nvwrMZp1SPCeD4guis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1825127C40;
        Sun,  9 May 2021 04:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2241F127C3F;
        Sun,  9 May 2021 04:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Reuben Thomas <rrt@sc3d.org>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: git-cvsimport documentation improvement
References: <CAOnWdogqShYMmZLAYvGnKVLdxPj8fYy4a2BZ-Mhe-kSKqQhv9Q@mail.gmail.com>
        <CAOnWdog6k04pPdK1+n45x=+dXpSsqC_FUZhCBJqcAEd=n4dZpA@mail.gmail.com>
Date:   Sun, 09 May 2021 17:39:07 +0900
In-Reply-To: <CAOnWdog6k04pPdK1+n45x=+dXpSsqC_FUZhCBJqcAEd=n4dZpA@mail.gmail.com>
        (Reuben Thomas's message of "Sun, 9 May 2021 08:30:31 +0100")
Message-ID: <xmqqczu0ti6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05AFF6AA-B0A2-11EB-964D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reuben Thomas <rrt@sc3d.org> writes:

> The git-cvsimport docs say:
>
> WARNING: git cvsimport uses cvsps version 2, which is considered
> deprecated; it does not work with cvsps version 3 and later. If you
> are performing a one-shot import of a CVS repository consider using
> cvs2git or cvs-fast-export.
>
> However, I can find no trace of cvsps version 3. The latest seems to
> be 2.2, which is marked as a pre-release, and cvsps 2.1 seems to be
> the most commonly packaged version.
>
> I understand that it's still better to use other tools than git
> cvsimport, but perhaps the warning could be better worded; for
> example:
>
> WARNING: git cvsimport uses cvsps, which is considered deprecated. If
> you are performing a one-shot import of a CVS repository consider
> using cvs2git or cvs-fast-export.

The text comes from this commit early in 2013.  Perhaps there was
cvsps 3 back then?


commit 1187ec99b93aefc3bfb6e360d285245745e1e390
Author: John Keeping <john@keeping.me.uk>
Date:   Thu Jan 24 19:18:45 2013 +0000

    git-cvsimport.txt: cvsps-2 is deprecated
    
    git-cvsimport relies on version 2 of cvsps and does not work with the
    new version 3.  Since cvsps 3.x does not currently work as well as
    version 2 for incremental import, document this fact.
    
    Specifically, there is no way to make new git-cvsimport that supports
    cvsps 3.x and have a seamless transition for existing users since cvsps
    3.x needs a time from which to continue importing and git-cvsimport does
    not save the time of the last import or import into a specific namespace
    so there is no safe way to calculate the time of the last import.
    
    Signed-off-by: John Keeping <john@keeping.me.uk>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 98d9881d7e..fd1e613d95 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -18,6 +18,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
+deprecated; it does not work with cvsps version 3 and later.  If you are
+performing a one-shot import of a CVS repository consider using
+link:http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
+link:https://github.com/BartMassey/parsecvs[parsecvs].
+
 Imports a CVS repository into git. It will either create a new
 repository, or incrementally import into an existing one.
 

Search engine found this hit for "cvsps version 3"

    https://archlinux.org/packages/extra/x86_64/cvsps/

which suggested that another place to be looked at, which was

    https://aur.archlinux.org/packages/cvsps/

which then led to

    http://www.catb.org/esr/cvsps/

In any case, at this point both 2 and 3 haven't seen any active
maintenance for quite some time.


