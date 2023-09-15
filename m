Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB94EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjIORwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjIORvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:51:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA8270B
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:51:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AEFF2CC5B;
        Fri, 15 Sep 2023 13:51:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TYc3YPj+fMsmj1r9+sC6DAKC8ozmNW78GRdbQx
        HYWW4=; b=E+JQeSqevA8AGH+SoVvwG1Svgjwv290RRBbXIy1RLrrdeIBMCfzBM1
        uTNB7uE93Q+dObIFF6HZib4OaLDHeoUY0S3lmwejQpiMv0dBrpg+oY/Or31lk4Sy
        6y4BEI7UyQqPm9eafSjgaPigUKdvdczqf9kOj+6S22RZ3imPz2q7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30FFF2CC5A;
        Fri, 15 Sep 2023 13:51:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BCD32CC59;
        Fri, 15 Sep 2023 13:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
In-Reply-To: <20230915112906.GA3125427@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 15 Sep 2023 07:29:06 -0400")
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
        <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
        <20230912082742.GB1630538@coredump.intra.peff.net>
        <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
        <20230915112906.GA3125427@coredump.intra.peff.net>
Date:   Fri, 15 Sep 2023 10:51:17 -0700
Message-ID: <xmqq5y4bfhpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79A5F8D6-53F0-11EE-8D8D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But having done so, the main value in re-rolling would be preventing
> somebody else from reading the code and having the same question.

Indeed.  It would be valuable to help future developers not to waste
time on wondering what we already know they may do so on.
