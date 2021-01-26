Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA21C4332B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28C02067B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbhAZWDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59965 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390710AbhAZTNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 14:13:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC1BB1149CF;
        Tue, 26 Jan 2021 14:12:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Lq878IovWzYm4yr9V18zb6K8is=; b=GN2zpp
        i8VCO72QCJea9pqNiuwGbNsqSGh7e05o6GEfcUZy3+z6lF5Zt3JzzPl5Cg2AsNmS
        PqBUy50KDeRep5vquZGCbDfHt3NBSeMNfEuNnwUSCQjPZzuoxXrEmwlke0kuzwhR
        TzWXSuBEhPhVm9kl9co5E+ZOWwz6ro4inf1Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kRP8VnG4+v2RhIoayVZWheegJjVAqPkY
        10Uj6Hiol+zPudsFOCwE6Ogv6svRZXcaySlkM5Lmj3WEdSodY5bSQAfc7xAqeFOg
        ivqNWJUNlW95/g9fJS5T3NbLKCRveGKO5phdbQX1hdQ9TZ4Pcebr8nwP85lrUZjM
        GcWdxGeQl20=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A61871149CE;
        Tue, 26 Jan 2021 14:12:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DBCD1149CD;
        Tue, 26 Jan 2021 14:12:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] Finish converting git bisect to C part 3
References: <20210123154056.48234-1-mirucam@gmail.com>
        <xmqq8s8gwjaq.fsf@gitster.c.googlers.com>
        <CAN7CjDAsRcLSZPjtJxcjyunSErer8DWKqnMcNNo2rxad7xA+Cw@mail.gmail.com>
Date:   Tue, 26 Jan 2021 11:12:24 -0800
In-Reply-To: <CAN7CjDAsRcLSZPjtJxcjyunSErer8DWKqnMcNNo2rxad7xA+Cw@mail.gmail.com>
        (Miriam R.'s message of "Tue, 26 Jan 2021 15:18:48 +0100")
Message-ID: <xmqq4kj3342v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D10B6E2-600A-11EB-8FC6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

>> cf.
>> https://github.com/git/git/runs/1766239699?check_suite_focus=true#step:5:814
>
> I have seen that is "t3415-rebase-autosquash.sh" the test that fails in CI jobs.

Sorry, a false alarm.  This I think was caused by another topic,
cm/rebase-i, and not the bisect topic.

