Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BEDC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE9820637
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y+7/ScPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLIWGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:06:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52185 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLIWGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:06:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53DD7229AC;
        Mon,  9 Dec 2019 17:06:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HOeauO8p0oQj+B334+IciKB3KWE=; b=Y+7/Sc
        PsCPFvmWlcixa+aDOkW7qP6irk6Ik9O6K88cSNpEMdj3i+1c1F3GDuHF59n2R/e0
        YpVXHj69OGR95UpLFTlpWsqAvTMjPvqO6AVI742JLOvffG1jZI7PO5VpojmrGj+P
        Oz3uT13TbJgUSbLfL2sD7V3Iga2WjKMvfHNZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FlELWFIQM1L5N2TLimQnkTKkcpYnWrhq
        n+aBrz/6NPQ7rO1FlceR+FtqStA/cUvYxdwPMl2pCTpE/fZQei+ZvWIhyKTodRli
        RIIi64yUxCx87RCvFjhK8bhHzwmmC+MQb5K1i6XQ7HycgXL/9LaUVzDL/80M50aG
        Da40P2MGoqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49FAE229AB;
        Mon,  9 Dec 2019 17:06:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADC0B229AA;
        Mon,  9 Dec 2019 17:06:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/3] git-p4: Usability enhancements
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:06:13 -0800
In-Reply-To: <pull.675.git.git.1575901009.gitgitgadget@gmail.com> (Ben Keene
        via GitGitGadget's message of "Mon, 09 Dec 2019 14:16:46 +0000")
Message-ID: <xmqqeexdtaqy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E032B8C-1AD0-11EA-B870-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Some user interaction with git-p4 is not as user-friendly as the rest of the
> Git ecosystem. Here are three areas that can be improved on:

Sorry, but I am not a git-p4 person and I barely speak passable
Python, so I am not a great reviewer for the initial round of any
patch in this area.  IOW it is not all that useful to Cc me, as
opposed to somebody who have been working with git-p4 code longer
and more deeply.

    $ git shortlog --no-merges --since=2.years git-p4.py

may be a good way to choose whom we would want to ask for an initial
round of review (and Luke, who I consider the de-facto git-p4 person,.
is Cc'ed).

Thanks.
