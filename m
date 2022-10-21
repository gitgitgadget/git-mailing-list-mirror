Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC7C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUABk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUABg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 20:01:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B7222F33
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 17:01:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 497C61B838C;
        Thu, 20 Oct 2022 20:01:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P7PUa7QG/cHduNkRIS5MgsPdxguFyNi/vfEkfC
        Xylks=; b=fvYAevV1TvfNmk8jaToclU8YfOueDcbDWHz49L9YpxKC4X/AoisRnG
        LEP+btRdpno6t8c5EGfmgkt1RvWd++kiiRNTdYIb9i5HTD5HZm5Hi3xSyVLTJ9rW
        j5tESqmrr8XWRQmwoB/Ov0lKIUMSDVTGVxDMgAu7lLtDINIqJLVc8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 418941B838B;
        Thu, 20 Oct 2022 20:01:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6155A1B838A;
        Thu, 20 Oct 2022 20:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/7] clone, submodule update: check out submodule
 branches
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <xmqqh6zyqftv.fsf@gitster.g>
        <kl6lh6zyxdb2.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 20 Oct 2022 17:01:28 -0700
In-Reply-To: <kl6lh6zyxdb2.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 20 Oct 2022 16:53:05 -0700")
Message-ID: <xmqqedv2oxif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8392F18A-50D3-11ED-89CC-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Thanks for your patience. For future reference, do you have a preference
> either way? I suppose choosing a later base might make it easier for
> reviewers who don't have the bandwidth to remember what "master" used to
> look like, ...

That cuts both ways.  For brand-new reviewers who starts from v2
without ever seeing v1, and when the two iterations are far apart in
time, it may be true.

But reviewers who helped you with earlier rounds hopefully know what
they saw and commented on, and keeping the same base would help them
to see what is different in the updated iteration, without having to
see distracting changes in the surrounding area brought in by using
the newer base.

> but it's just churn to you, since you're already rebuilding
> "seen".

To me, it does not make too much of a difference (unless it is
clearly a fix for a grave issue that should eventually merge down to
older maintenance tracks, and this one is clearly not).  If you
rebase, I would double check your rebase by rebasing the new
interation back to the old base and then merging the new base in to
see how the result compares, like I just did this time, before
replacing the topic with the application of patches on the updated
base, so it is a one-time extra cost to me, but other than that,
what I do would not change all that much and it hopefully will make
it easier to queue later iterations.

Thanks.

