Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810DA2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbcHZS1Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 14:27:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753286AbcHZS1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 14:27:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F5FC37DFB;
        Fri, 26 Aug 2016 14:27:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cr5IGPlhxuOrXtJDfz6Vqi0vL2Q=; b=Q/AkEH
        slb/hHoB7oPfuWNT3nvMmLhR1e7vG/YmtLpKLgT3i72wRmpaKgFrRg0NxGGF62Id
        RPpnuz3LiD6yMfZf7HWCU430c40/r9J9DXtd4efUO3dSt7LhlDbx0GKHy+GePGQE
        igPzGSAWCegBRGl9rYlCHcCoyo6iJbpfpy0ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZsKI5P4TMHscAtiN9CRiJNEnJuUxt+Nx
        rudFL8Y5evsOErSYRl9XEnyH0YlJ8gR3kTW1UHBqqIOdL1zHZ6OyEID4Hu43qSD6
        M7RT4zRWBdBmX2sRWuVaaCbyMzeZfWxIbSnzupZqkC00foQ3RhK6mvcF2z5viFDB
        SkEG0sJElRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8641337DFA;
        Fri, 26 Aug 2016 14:27:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07E5637DF9;
        Fri, 26 Aug 2016 14:27:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] SubmittingPatches: hint at gitk's "Copy commit summary" command
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
        <1472230741-5161-2-git-send-email-dev+git@drbeat.li>
Date:   Fri, 26 Aug 2016 11:27:21 -0700
In-Reply-To: <1472230741-5161-2-git-send-email-dev+git@drbeat.li> (Beat
        Bolli's message of "Fri, 26 Aug 2016 18:59:01 +0200")
Message-ID: <xmqqk2f3gzcm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB37C714-6BBA-11E6-911D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> @@ -124,7 +124,8 @@ archive, summarize the relevant points of the discussion.
>  If you want to reference a previous commit in the history of a stable
>  branch use the format "abbreviated sha1 (subject, date)". So for example
>  like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> -noticed [...]".
> +noticed [...]". The "Copy commit summary" command of gitk generates this
> +format.

(continuing from my 1/2 review)  And if people agree that the format
gitk already uses is better, this text should probably read more
like:

    If you want to reference a previous commit in the history of a
    stable branch, use the format "abbreviated sha1 (subject, date)",
    with the subject enclosed in a pair of double-quotes, like this:

        Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
        noticed that ...

    The "Copy commit summary" command of gitk can be used to obtain this
    format.
