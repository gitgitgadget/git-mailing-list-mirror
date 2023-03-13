Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682E5C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 23:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMXGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCMXGm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 19:06:42 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362507B9AC
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 16:06:05 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B05041F428;
        Mon, 13 Mar 2023 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678748107;
        bh=D7AMa4T96y/Ln0jOd5BBIb8Umk4TQOGfYYxru1XAuaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bntdo9JdS19ZDOruDJ3E9wGLjewtIBfead5I0W+wVUQOhKV7V+BGTqOcTdck5Kanb
         jQU25qQqY/dHqwtCwTT65TeJ1VHZjubHMWUhkM8xW4zW3t03V/XJ0qXp/Qs/ukBkp/
         mw8pi1eCd+ZqsPybojMu0pVZt0ulzwIlKg/bk0/c=
Date:   Mon, 13 Mar 2023 22:55:07 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: public-inbox.org/git to be downgraded
Message-ID: <20230313225507.M626677@dcvr>
References: <20230313215704.M573757@dcvr>
 <xmqqcz5cs3ze.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz5cs3ze.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > [1] https://80x24.org/lore/ dogfoods for lore.kernel.org and has
> >     the git.git coderepo wired up for blob construction if you
> >     follow diff hunk header links @ https://80x24.org/lore/git/
> >
> >     There's more stuff coming to dogfood with coderepo
> >     integration, too; but no guarantees it'll stay up since my
> >     SSD has a lot of wear on it, already.
> 
> Are you taking donations?

It's more the principle of refusing to go along with inflation
in the same way I refuse to go along with Moore's law.
(I haven't upgraded my HW since before I started public-inbox
in 2013 and have no plans to).

I also don't feel comfortable accepting donations for privacy
reasons, either.  Of course, I've never been comfortable at all
at setting expectations or providing guarantees for anything I
do...  **cues up "Lowered Expectations" jingle**

> Also, is there a plan to add that custom gmane:<number> query to
> lore archive?  That is one and only thing I still sometimes go to
> public-inbox.org/git

Fwiw, data's been easily downloadable for a while and documented
in the somewhat difficult-to-find
<https://public-inbox.org/git/_/text/config/raw>[1] config snippet:

  curl -d '' https://public-inbox.org/git/gmane.sql.gz | \
    gzip -dc

(I just noticed the sqlite3 invocation is slightly wrong
 in the generated example, will fix)


I could figure out how to add it to the extindex-enabled[2]
80x24.org/lore mirror I run, but lore.kernel.org is Konstantin's
domain.



[1] linked from <https://public-inbox.org/git/_/text/mirror/>,
    which is linked from the top of every page, so hopefully
    _/text/mirror is easy-to-find...

[2] -extindex is a newish mechanism used by lore and its mirrors
     to enable significant space and memory savings by combining
     the search indices across multiple inboxes; but that means
     per-inbox prefix handling like "gmane:" gets trickier...
