Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142CCC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF49820747
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lPcd4zy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgFNVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:06:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgFNVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:06:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 257FCB925B;
        Sun, 14 Jun 2020 17:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nTPh8FargZyX9hWhJWCrvwpRTf8=; b=lPcd4z
        y6D/BqCE8K4f7aNE7XcbU/4iCDLzHOCaNT5udgObGK4lJnqWup8GLyGtJFnceUvU
        G0Xf55Iim83IoMwQE4BrZzgoQUpI0Jq7YDMcQJFavpWt79PBRGrLz+28RLGsnGO6
        CwfReTsczqbyhgviPl1WvomFrKbzvFGtxBjG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=telj26+XcsrXnTf5EeI56mimKqEFPlqj
        +wq2vu9alLm1qbOtVsikCVER+yj5pAxQgyFH07QzUe54kKAV0JyykTc9yhyVJXn5
        24m+1eO62ecF1n9ui0f6wPMgejSu/1Gh/9w7Jn/e9gms2egjZhzHzfsxpzq0Ckcf
        9pCEobxC5uo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BD96B925A;
        Sun, 14 Jun 2020 17:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F364B9257;
        Sun, 14 Jun 2020 17:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, philipoakley@iee.email,
        Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
        <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
        <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
Date:   Sun, 14 Jun 2020 14:06:18 -0700
In-Reply-To: <20200614181906.u42tuny3eipvhd46@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Sun, 14 Jun 2020 14:19:06 -0400")
Message-ID: <xmqqmu55xsqd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E54AC344-AE82-11EA-B8F0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> - having a branch named "master" is already not required, so any 
>   existing software that expects there to always be a "master" branch is 
>   already broken and wouldn't get any more broken by the move away 
>   towards more descriptive terminology

The above is mostly true but not entirely, I have to remind you.

There certainly is the concept of the primary branch in each
repository.  With the current version of Git, it is hardcoded to be
the 'master' branch, and we are going to make it configurable with a
configuration variable [*1*].  There are a few examples that the
primary branch is treated specially:

 - When merging into the primary branch, the auto-generated merge
   message is different from a merge into any other branches.  This
   was because most of the merges, especially in early days of Git,
   were into the primary branch (there weren't many cross-branch
   merges made) and we did not want to see repeated "Merge X into
   'master'", "Merge Y into 'master'", etc.---we just say "Merge X",
   "Merge Y", etc. when merging into the primary branch.

 - "gitk" gives preferencial treatment to 'master' when there are
   too many references it has to choose which ones to make visible.

 - "git fast-export --anonymize" redacts the name of all the
   branches, but the name of the 'master' branch is left intact in
   its anonymized output (which is done in order to make the primary
   line of work identifiable even in the redacted output stream).

There may be others.  Software that assumes that 'master' is special
is *not* broken as you stated (we will break them when we allow
changing the default---that is the cost those of us who are working
on the transition plan thought worth paying).  The concept of "there
is one thing that is special among others" can serve useful purpose.

It of course opens a different can of worms ;-) Even though we can
please master-slave-haters by moving away from the particular word
'master', those who cannot stand the very idea of one thing being
special among others will not be satisfied (and we shouldn't even
try to please them, IMO).



[Footnote]

*1* There is a related but separate concept of the "default name"
for the primary branch in newly created repositories, which also is
hardcoded to be 'master'.  We are going to make it configurable,
too.  This controls the name used by "git init" (possibly we will
also add a command line override "git init -b name" to countermand
the configured default) and "git clone" (which tries to use the
name of the branch pointed at by HEAD of the other side but has to
fall back to something when it cannot figure it out).
