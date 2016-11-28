Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEC41FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbcK1TGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:06:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50649 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751307AbcK1TGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 950B65420D;
        Mon, 28 Nov 2016 14:06:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9PHjnZkex5R/9EDrHRDfPuF/HwE=; b=FYcgx7
        wLqR2Lmsrmud3l+25LpksRy2QHmOPxBqkVe2/YlSMVCqkxFChS4yfSODefcAfvgG
        srzEt4zT/IUuPwWOOzAO70mbVcLeWsg1d9md9HmdbdFAknXAYkXKjJ0aqIEDyRf1
        Lk/uI2KZsafFI5+7jzrkPyektbl/AHutTxjso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ew9GLZ4tLe92FSURbE0uWDhzunrkPVR5
        nY+RygnTEUm++HPoBtfbAS9yw+W5HTXwm2Eunw6ie4ARBck3qbu7DpAWSq/GboLJ
        hdCZCLrxTcUP6ra3RHvX/sljF7ufCC1LQyHBNH4OCj8QhBR1WHgut2+/+g5sGr+u
        5vV+SZA3Xgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E1B25420C;
        Mon, 28 Nov 2016 14:06:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14EF55420A;
        Mon, 28 Nov 2016 14:06:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] allow git-p4 to create shelved changelists
References: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
Date:   Mon, 28 Nov 2016 11:06:05 -0800
In-Reply-To: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
        (Vinicius Kursancew's message of "Mon, 28 Nov 2016 09:33:17 +0000")
Message-ID: <xmqqeg1vjug2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B74AA900-B59D-11E6-8238-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinicius Kursancew <viniciusalexandre@gmail.com> writes:

> This patch adds a "--shelve" option to the submit subcommand, it will
> save the changes to a perforce shelve instead of commiting them.
>
> Vinicius Kursancew (1):
>   git-p4: allow submit to create shelved changelists.
>
>  Documentation/git-p4.txt |  5 +++++
>  git-p4.py                | 36 ++++++++++++++++++++++--------------
>  t/t9807-git-p4-submit.sh | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 14 deletions(-)

Thanks, but I am a wrong person to review this change, so I'll
summon two people who appear in "git shortlog --since=18.months"
output to help review it.


