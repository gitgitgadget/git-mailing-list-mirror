Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D321F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHMR2M (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 13:28:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52697 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfHMR2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 13:28:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9654D170247;
        Tue, 13 Aug 2019 13:28:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KB+2Jfh8krgfR0b8DrauiAVe3f8=; b=qS9K9w
        QoJTl+WVfH6WcTDZI5bv2xW3wp6vucFAn8TJienM+VQ88fVZcjrGTis55ayb4d/T
        j3kV+aqLQVX8wKLiB6mN30l9DvbcdhvxTMCz6QqY/PDv1Ei/YOFn75gmNag3Qq+S
        C6ZEAsr81UqkC/MzWjpX5maIZdywVouTKjKS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XY5PsRnlan5FskUB9oh7COLxEliFgs+E
        IWhWozwiC6bt6Z3pxzeS3K5r+qZAvUY0g/ddcfgAa9VsE8Ngcdu+EqEZoQtbhMBu
        e5QGeM5QRT9mU4Bdf4TOdMfWxrTyWndrABU0PAcnhbbddACNH8hJ/NDeDafY2qBd
        J468mdwVx6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B55F170246;
        Tue, 13 Aug 2019 13:28:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3E80170245;
        Tue, 13 Aug 2019 13:28:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 6/6] rebase: add --author-date-is-committer-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-7-rohit.ashiwal265@gmail.com>
Date:   Tue, 13 Aug 2019 10:28:08 -0700
In-Reply-To: <20190812194301.5655-7-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 13 Aug 2019 01:13:00 +0530")
Message-ID: <xmqqk1bh7z6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85DE520-BDEF-11E9-9EC5-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> The previous commit introduced --ignore-date flag to interactive
> rebase, but the name is actually very vague in context of rebase -i
> since there are two dates we can work with. Add an alias to convey
> the precise purpose.

This sounds more like the existing "--reset-author" but only takes
over the timestamp part without taking over the authorship.

IOW, I am wondering if "--reset-author-date" is a better name.

