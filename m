Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D4CC2D0C8
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599B620733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 17:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVRr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 12:47:28 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58715 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 12:47:28 -0500
X-Originating-IP: 42.109.194.222
Received: from localhost (unknown [42.109.194.222])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D6DE51C0002;
        Sun, 22 Dec 2019 17:47:25 +0000 (UTC)
Date:   Sun, 22 Dec 2019 23:17:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: Low prio: feature requests for git-gui
Message-ID: <20191222174718.nb3noztxo64g7jl3@yadavpratyush.com>
References: <20191220104258.1110d00e@pc09.procura.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191220104258.1110d00e@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Merijn,

On 20/12/19 10:42AM, H.Merijn Brand wrote:
> • Right click context menu on file-entry in Unstaged Changes list

It is something on my TODO list.

>   - Reset changes → git checkout this file
>     I see the current changes need to be reversed, are bogus or
>     invalid

I'm not sure what this means. When you hit Ctrl-J or choose it from the 
menu bar, current changes can be reverted by checking the file out from 
the index.

>   - Restore this file → git checkout this file
>     it was accidentally removed. Like the first option

What constitutes as "accidentally removed", and where do we restore the 
file from? If it needs to be restored from the index, then Ctrl-J should 
do the trick. If it needs to be restored from an older revision, well as 
of now git-gui doesn't have many features that deal with things like 
this. But maybe something like this can be added.

>   - Remove this file from disk
>     Somehow an invalid restore, a misplaced output or other reason
>     (core dump, debug output from other tools) made this file appear
>     and I don't want to add it to .gitignore

This feature was recently added in fa38ab6 (git-gui: revert untracked 
files by deleting them, 2019-12-01). You can hit Ctrl-J on the untracked 
file to delete it.

>   - Add to .gitignore
>     Like above, but this file will re-appear more often

A naive implementation of this shouldn't be too difficult. I'll see if I 
can find some time to do it.
 
> Does this sound reasonable enough to make it a ticket/issue?

-- 
Regards,
Pratyush Yadav
