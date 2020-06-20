Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB5C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F167823F59
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vcptBdxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgFTQ7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:59:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57778 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTQ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 12:59:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0215DF615;
        Sat, 20 Jun 2020 12:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y8nSSS4LOermo8iLGEvqsgXrbg8=; b=vcptBd
        xTOQXAsmKG+8rlL3CWbq2SZRPVwJZt6i/lYEmLYuW122KIyaapeda0zhhEqU2wel
        hm61fpWO8UxbacwvYQR+WzIo/fZDOI0XSMDW4lNYTRkJUnWgynmr7eokmrA3vB2H
        wvvU7Z13WOu/2fOyVpnKPy7M8v0amdyOQnkuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d4lxwRExOPS1U2c1ap4Q2NfPxJjNdpP+
        94wOxFB9wCsxwC/IZC8Xbman0QlwiYAS2Dyjgc4vfStofU0yQ99QeT6jb9f6NSRa
        XzDrQ/rLucs6vPfKE/kGY59sX1CPl69Y7TMF+TH5+f20Xch/ddTlRafFHe+O0I2I
        v3258a26cZw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 987EDDF614;
        Sat, 20 Jun 2020 12:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E2996DF613;
        Sat, 20 Jun 2020 12:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Solomon Ucko <solly.ucko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: reset --merge documentation typo?
References: <CANtMP6qbX_U_0sWtUvNQVtMboMLJshsHc=n-5eA4_XXNGEnzLQ@mail.gmail.com>
Date:   Sat, 20 Jun 2020 09:59:37 -0700
In-Reply-To: <CANtMP6qbX_U_0sWtUvNQVtMboMLJshsHc=n-5eA4_XXNGEnzLQ@mail.gmail.com>
        (Solomon Ucko's message of "Sat, 20 Jun 2020 12:15:54 -0400")
Message-ID: <xmqqo8pdekqu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D691486-B317-11EA-9F8A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solomon Ucko <solly.ucko@gmail.com> writes:

> Oops, accidentally sent as HTML instead of plain text.
>
> The documentation for `git reset --merge` states:

It is talknig about `git reset --merge <commit>`.


>> Resets the index and updates the files in the working tree that are
>> different between `<commit>` and `HEAD`, but keeps those which are
>> different between the index and working tree (i.e. which have changes
>> which have not been added).

Correct.  The command makes this request to "git".

    I am on the commit at `HEAD`; I want to move to <commit> as if I
    did "git checkout <otherbranch>", updating the files in the
    working tree to that of <otherbranch> except that if I had local
    changes from `HEAD` for a path, and the path is identical
    between `HEAD` and <otherbranch>, carry my local changes along,
    but I am not flipping to a different branch---instead I am
    resetting the tip of the current branch.

It allows the user to pretend as if the user started making these
local changes _after_ "git reset --hard <commit>", on top of
<commit>, and that is only possible because the command makes sure
that the paths involved in these local changes are the same between
`HEAD` and <commit>.

> Where it says "`HEAD`", should it say "the index"?

No.
