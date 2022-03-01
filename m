Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DBC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiCARlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiCARlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:41:22 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290158E77
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:40:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7F3316D5ED;
        Tue,  1 Mar 2022 12:40:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LhvB386/7huvpGGvIaNgrAfe736JBE4weV6o6r
        09H2o=; b=Ob7yEJVpknuCuiw45TvElyKMZcFFVjLolGt9SeL8SfH7tU1by3LqBE
        i5xnW46X6vwmlKJC1QPvZPMxfzLJTMhE539hGbBA3k8rYZinQaZxu62toRMyZJEX
        SO2ZDIRLO2GH22J05TZ/WMH5UPE0688WuskKmlLPzRNdyVg6xQ554=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0A5716D5EC;
        Tue,  1 Mar 2022 12:40:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F003F16D5E8;
        Tue,  1 Mar 2022 12:40:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Warnicke <hagbard@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: URI Scheme for git object ids?
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
Date:   Tue, 01 Mar 2022 09:40:27 -0800
In-Reply-To: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
        (Ed Warnicke's message of "Tue, 1 Mar 2022 11:35:52 -0600")
Message-ID: <xmqqy21tr2pg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEDC3DF6-9986-11EC-BF10-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Warnicke <hagbard@gmail.com> writes:

> Has there been any discussion of how one might represent a git object
> id as a urn or uri?
>
> It's clear that 'git:' is registered with IANA as a URI prefix for
> locations of git repos.
>
> I was wondering if there was any existing use of something like:
>
> 'gitoid:${type}:${hash type}:${hash of git object}' ?
>
> So for example:
>
> gitoid:blob:sha1:261eeb9e9f8b2b4b0d119366dda99c6fd7d35c64
>
> which could be used to communicate generic git object ids.
>
> Ed

I do not see why the object type should be there.  Once you locate
the object whose object name (in sha1) is 261eeb..., the object
should be able to identify itself as a blob (or whatever type it
is).

Aren't there already folks who are exchanging git objects over
torrent or something?  What do they use to identify what each node
offers and what participants want?

