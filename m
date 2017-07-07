Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A537120357
	for <e@80x24.org>; Fri,  7 Jul 2017 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdGGT7J (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 15:59:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35210 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGT7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 15:59:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so5808708pfq.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lU8tjOzZvyjsVsc7oxDy0HDqb7/G+ES14IUCXGacREY=;
        b=uApY2pHA1jxUI/Tl3j8Sasw+SJbDZ82Iu3RsLLXRi9kbkt4vriG5Ifjf5LKIGt1QKl
         uKHpSwBBsRn4gisvFt+eyzlzFT1ILR3Y1vV7+89CZ7HmaC0+RbyUv/245MgUdPZ0BT4C
         vADb6zVwYa46pGb3HZMhARO2+Brkmp2W+abQBt3QoRali5dFiAkZ++HFsQwkmkHPe3Qb
         n/9XUZWDmyhvocz60g9xC5A9Fnsv433cHumJ33jX1J7E5JE98fhvhgKhsEyK+eRrECPK
         3JWNjn65mGVYnzwxDyE539f3dZyhbdhJYkZi3QQEXY+LJgjPaUX/YgSHWHcGYeHJInjU
         2fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lU8tjOzZvyjsVsc7oxDy0HDqb7/G+ES14IUCXGacREY=;
        b=KfGiwvYQkFoxlUKOfzAvg52WlLvEyKUG/DCMzfGFAFVn/g9+2PUYcur5WL0igDGY8m
         +DmB/BRE3DihIuFi1PGoyGti+0YEEmwW3aAcKw72t8NvtgirUKzzBmhqto+Aia5kEiF/
         15eFfqi59g8Vjn2MJfvMr+ZtiUt8TYdCFVWPu7im5x1frNFGdEnHxRrkjYmTUgRO3Jzs
         5aGGHb2CmnGwJtTKA/gWxi3gGMhC/QCfZ0PXW8x4xgIfgk4qaITqUjKkIHaTSRb9hquR
         CViz25ArGQXWQ3G/F00PHQjYSeq+ES1eEnRfCiEzTGMarBEPP6MGwrVNnGj8xFFpPMjm
         0vYg==
X-Gm-Message-State: AIVw113GIt/lX5hLDZ4+/VRSZOREfhIpCX9uILx5Rawik0kk2uQ+PbBX
        Az2WpuLmyUK3oc8ksG4=
X-Received: by 10.99.42.141 with SMTP id q135mr3050816pgq.175.1499457547752;
        Fri, 07 Jul 2017 12:59:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id g7sm10313691pfj.29.2017.07.07.12.59.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 12:59:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Fabulich <dan@fabulich.com>
Cc:     git@vger.kernel.org
Subject: Re: Why does git-checkout accept a tree-ish?
References: <EA993AC0-022C-423D-ABD7-4747FA09E7FE@fabulich.com>
Date:   Fri, 07 Jul 2017 12:59:03 -0700
In-Reply-To: <EA993AC0-022C-423D-ABD7-4747FA09E7FE@fabulich.com> (Dan
        Fabulich's message of "Wed, 5 Apr 2017 16:51:40 -0700")
Message-ID: <xmqq37a8auig.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Fabulich <dan@fabulich.com> writes:

> Prior to this commit, git-checkout would only switch branches; you
> could use git-checkout-index to copy files from the index to the
> working tree. But in this commit, git-checkout not only subsumes
> the functionality of git-checkout-index but also learns the
> ability to copy files from an arbitrary branch (now an arbitrary
> tree-ish) into the working copy *and* the the index. (That was
> important because git-reset didn't accept <paths> in 2005.)
> ...
> P.S. I would make a similar argument about adding <paths> support
> to git-reset, rather than creating a separate command like
> git-unadd.

I do not have a habit of crying over spilt milk for too long, but if
we did not have "git reset <paths>..." and adding an equivalent
feature today, I would guess that we would not have done it as a
different mode for "git reset".  We probably wouldn't have added an
extra command "unadd", either.

"git checkout --cached [<tree-ish>] <paths>..." would have been more
in line with the CLI convention for a command that can act on the
index and/or the working tree files ("--cached" is the way to make a
request to act only on the index without affecting the working tree
files).

As to why "git checkout" started taking <paths>, the thread referred
to in my previous response seems to give a better story than I could
remember ;-).  We were unhappy with checkout-index and the
suggestion that was first made publicly reused "git checkout".
While I initially showed my reluctance by calling the hypothetical
command "xxxxxx" instead of Linus's suggested overloading of
"checkout" in my response in the thread, I think the end-result
turned out to be not too bad, given that our users understand the
difference between 

 - checking out a branch to work on advancing the history of the
   branch; and

 - checking out a set of paths out of a <tree-ish> to modify the
   working tree contents while working on advancing the history of
   the current branch.

just fine.  When doing the former, you would of course want to
preserve local modifications in your working tree.  When doing the
latter, you are asking to overwrite the named paths (checking them
out of a tree-ish or the index is often done to wipe the mistaken
attempt to modify it and giving you a clean slate).
