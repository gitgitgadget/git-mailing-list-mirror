Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7EB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdAWUKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:10:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750821AbdAWUKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:10:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39B2863703;
        Mon, 23 Jan 2017 15:10:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5YsKkRwvdstOp7XuiOLzFi0gkCU=; b=Ypc7DO
        V/wCRmBI2XhxIN5E2RPrPNoKfI2laCdUve9EXl4bqtkrmXbBNPPHnWf4ol/t2VIQ
        u++a1N6bcudxxbQr5pvncQHP+fqQTMUPthErVOlEM6SVBszzjdX6hYPu9gfcV+MP
        vQhsLO5R+IIpRlCYQ/XpRou29WFy7y2ECrVc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V42F9E9Anf4muLEHOPmhp2MWGpldktIM
        tvgFHwcwXgqthQmic0W5vFscgTvwqh36yS6wvb5DLzjCvB7ZWFFSP5x7X5QmTdLg
        k7m6DLPfHwqk82ZduDgiX0o7E215D4fyDHKQGvtnoARjb4n6bRXgj3KN4wcgzhJa
        u5Nu/xDFWQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D74E63702;
        Mon, 23 Jan 2017 15:10:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F39863700;
        Mon, 23 Jan 2017 15:10:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
        <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com>
        <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
        <xmqqd1fdtzgv.fsf@gitster.mtv.corp.google.com>
        <CAOxFTcxRjWS-=wyGBVOtg-tfCHrqqAr9rVOcvkyxXwJHonN_Tg@mail.gmail.com>
Date:   Mon, 23 Jan 2017 12:10:27 -0800
In-Reply-To: <CAOxFTcxRjWS-=wyGBVOtg-tfCHrqqAr9rVOcvkyxXwJHonN_Tg@mail.gmail.com>
        (Giuseppe Bilotta's message of "Mon, 23 Jan 2017 21:05:36 +0100")
Message-ID: <xmqqfuk9r0zw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBFB2076-E1A7-11E6-9F43-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> ... I still don't see how to force a complete reread of the index
> after running a git reset (which I need for the --skip command), ...

Do you mean discard_index() or discard_cache() followed by
read_index() or read_cache(), or do you mean something more
elaborate?
