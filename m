Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2A41F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 02:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfJ1Cdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 22:33:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54552 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfJ1Cdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 22:33:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8902712C;
        Sun, 27 Oct 2019 22:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2KROE/MTYUvYEFR4fZo8YXuCsWo=; b=BHcJAA
        rPuG3JdZ17JFFNqhilsW+6A5lNhAgVUW/a/S2iXOJJD3d2XOjgIk3kWNa5Wubimk
        Gov2XsIt8LnZlpQo0nI1yfZL5nWffQhx664RthBwSjC/EhTD2k5TB0sYULPJXn5u
        7tWQsyCpQ3fQ+aqUopg5f05uICPzruwKQOHwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uDzG/QS0HT3ImxS8nxbSrOiAx3BHtm8v
        MJV/UrEb1EyzhUw7k+v4ouveNDVuW2Z9Hw23epy+jrMDEMDzf1Dhc0NWJURA86M5
        xOST7R7QRm9t6cvACaUis3zLOGV1eQDZK4AnIl15k6/ounNZ9OT26Yh8rnStilmz
        TSMiD+HBXYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B5F2712B;
        Sun, 27 Oct 2019 22:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24C312712A;
        Sun, 27 Oct 2019 22:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix git stash with skip-worktree entries
References: <pull.355.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Oct 2019 11:33:35 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 27 Oct 2019 22:05:30 +0100 (CET)")
Message-ID: <xmqqpniha9a8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57B14434-F92B-11E9-880D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 26 Sep 2019, Johannes Schindelin via GitGitGadget wrote:
>
>> My colleague Dan Thompson reported a bug in a sparse checkout, where git
>> stash (after resolving merge conflicts and then making up their mind to
>> stash the changes instead of committing them) would "lose" files (and files
>> that were not even in the sparse checkout's cone!).
>
> I only realized _now_ that this patch has not made it anywhere.

Yeah, I do not recall seeing any of the patches in the topic (nor
the cover letter).  It is not clear to me what "lose" above means,
which is an indication that I didn't read the topic a month ago X-<.

Did it even get any review by skip worktree bit experts back then?
