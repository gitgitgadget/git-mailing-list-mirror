Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84369C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352EC2224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oa9P3QvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgKCBIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:08:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgKCBIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:08:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A3B81036B8;
        Mon,  2 Nov 2020 20:08:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X1ibmi210jfniKZNbwJFymY4N04=; b=oa9P3Q
        vNCjr7tAV2THeAET1cdw4dxt2i/A/72e0W4Y/EOc0jMMaP+YDMBS3YzEVGihELqg
        SM6WzB3HtCaTSjkI2hlgWVmtadK33USRmpPN/IWEDKUo6NpdBNkdvQBWQH3o0d9Z
        9c+wVumYPg2cMTbd+upNWCue5d0NmbIm+tKDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0HJMaf4qSwoFtnNIfvzraQ5aNiI6T/H
        KcUIki/SSXvuJvEVr5XezfmUeVGhx9OE4nT2UhIdf8pzpTh1E3j7mIO3Rr3W+AD2
        UV/gomcBb34BXP4V2S1zFpYt//yCblNnWIePdaOJVTJ5AKDWqDUHwBe07o/ppwiR
        qpgZIHUh2xo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22D061036B7;
        Mon,  2 Nov 2020 20:08:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 489511036B2;
        Mon,  2 Nov 2020 20:08:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4]  Adjust t5515 for the upcoming change of the
 default branch name
References: <pull.761.git.1604361307.gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 17:08:32 -0800
In-Reply-To: <pull.761.git.1604361307.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 02 Nov 2020 23:55:03
        +0000")
Message-ID: <xmqqlffjp7qn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 186B8512-1D71-11EB-BEA6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> To allow for switching the default of init.defaultBranch to main, we adjust
> the test script t5515 and its friends in t/t5515/. This is a large chunk of
> modifications, but happily, most of them are a totally trivial
> search-and-replace.

Thanks.  I see at the beginning of part #1 the same trick as the
other series is used to protect the under-construction tests.
Nicely done.

Will queue.
