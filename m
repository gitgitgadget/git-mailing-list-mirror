Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DDC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE620730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yJUAKnKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDGVbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:31:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57501 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGVbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 17:31:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9656AF2EF;
        Tue,  7 Apr 2020 17:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GpSUxDUKiO1CA2gyEaE/bLKUKQs=; b=yJUAKn
        KAYsDFIISx+2QMkufeFBrFvq/LabKirHEaxVtjC6PLEvBi1bNpMLoo1ywk0/r79H
        tFy/hPb+ANTRgp4SmlO9dLzgPZdVtridXRY6/4GYaRBHKfQOl8iRu3BCbMfGkz2e
        HH9AXuYsjpA5A0QuASZaKbp0JkTs8tYtYExy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WJTZLCdByva62Zx8SDN++l0i3oe3XLlm
        cMjJav0Y6z2dDtcMYvsg8m0MBSFFpuVhu7HZJ7sDqKqJm0nI1CuchSk3ryWDdJH/
        56ea4lJassBvuaWJfPxvY5GTi3/IpoYPaLi7RALZXc52QXMbM1Q/BDisGELnU1JZ
        vUIsEPY1DQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0A6BAF2EE;
        Tue,  7 Apr 2020 17:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 991D4AF2EC;
        Tue,  7 Apr 2020 17:31:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200407141125.30872-2-phillip.wood123@gmail.com>
        <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com>
        <xmqqv9mbroqw.fsf@gitster.c.googlers.com>
Date:   Tue, 07 Apr 2020 14:31:13 -0700
In-Reply-To: <xmqqv9mbroqw.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Apr 2020 14:04:55 -0700")
Message-ID: <xmqqlfn7rnj2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C6E7718-7917-11EA-80C5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> This reverts commit 4d924528d8bfe947abfc54ee9bd3892ab509c8cd.
>>>
>>> This is being reverted to enable some fixups for
>>> ra/rebase-i-more-options to be built on this commit.
>>
>> This makes sense to me, but it will be only the second 'Revert
>> "Revert..."' commit in all of git.git and I'm curious if Junio will be
>> unhappy with it.
>
> Nah, there isn't much to become unhappy about.  
>
> I however suspect that the alternative would certainly be much nicer
> and easier to understand, which is to rebuild the 7-patch series
> c58ae96fc4..d82dfa7f5b but bugs already fixed, instead of doing this
> patch to take us back to a known buggy state and then fix the result
> with 5 more patches.  Is that what you meant?

After looking at the conflict resolution while merging the result of
applying these patches on top of the older codebase, I would have to
say that the approach """I've opted to add some cleanup commits on
top of Rohit's work rather than reworking his patches.""" may not
have been particularly a brilliant idea, not because the conflicts
arising from an older codebase are unpleasant to resolve (they seem
to be reasonably contained), but because it resurrects other
unwanted cruft we have cleaned up since then, and worse yet, it does
so without triggering conflicts.  For example, we'll end up seeing
mentions of "'am' backend", which have all been updated to "'apply'
backend", in the documentation, and patches [2-6/6] do not fix them.

[5/6] is an example of one more "unwanted" thing the reversion
resurrects that needed to be fixed, I guess?

The result of applying all these patches and merging it to 'master'
and/or 'pu' may be more or less right, as far as the new features
added to the "rebase -i" by the series are concerned but there may
be many small "unwanted cruft" we may be resurrecting with [1/6],
so...



