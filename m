Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A8F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfJ2C13 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:27:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53354 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfJ2C13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:27:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 451902D508;
        Mon, 28 Oct 2019 22:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYRoiSa8Y9Czz546GLQjy19CaZY=; b=aN7Qlb
        eV+GDoQoXOtHb1MAusSSWs9LIDMdBdgY65CVKFrcKpz302YY2dM1lIhHHyDL9xTo
        KKV6kckL1ilaD1bZbuWhJ6rgXp6rbdf9eJ2dO7yOYKJCZdQcY0JObbPgwBFGQyHb
        jOFiGI62pq8fCYfFs6fz+6f1AFaPaBnNF344k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MwNLkFh2bYYrZ3Us3LNQyxPUR9toIsFG
        oFfqVJ42H3BmuSBtwbw1zD5Uf8IA/IOOtfMWO2PCGs5iOhDD33X/AihZvNyPaA+T
        /3YvbY5eb24UYMsByLnO4Q52v/enGU+bo7MqfVjh2TAJKxpWJBxpZd/ngmJel/7V
        +Nv+6qBRejc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CFB02D507;
        Mon, 28 Oct 2019 22:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D9C52D503;
        Mon, 28 Oct 2019 22:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/2] update-index: optionally leave skip-worktree entries alone
References: <pull.355.git.gitgitgadget@gmail.com>
        <c263eb54b30b3e93abb74662d120d8bb882322bb.1569483748.git.gitgitgadget@gmail.com>
        <xmqq36fda3i8.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910282206081.46@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Oct 2019 11:27:25 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910282206081.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 28 Oct 2019 22:07:15 +0100 (CET)")
Message-ID: <xmqqr22w70c2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5C91886-F9F3-11E9-8309-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Isn't this something reasonably easy to guard against regression with
>> a test or two?
>
> I sent out a v2 with tests added to 1/2.

Good; that way, not just "stash" but anything that relies on update-index
would be protected from regressions.

Thanks.
