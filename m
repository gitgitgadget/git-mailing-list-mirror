Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBAD1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeAJUu0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:50:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63708 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbeAJUuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:50:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 396F6D240C;
        Wed, 10 Jan 2018 15:50:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tfT4cd8CeUJlN8NtvQ3d4/OHffw=; b=tzXfP0
        MOFlkbgWFspRF4jW1NZTmtg3Ug9f50NcdI45kSRPpbRCgrK/FeRAPSthGQG/SJ+B
        s1uKIOaPvHJpAktYzOLfi/lRDH7HRmo8Lo3p2ht4pEtqWlcCLVRUQRm4CYHd9t6+
        eWDW3/RJMhOUL4jfFmVH2O0Rz7qF+reNOjtFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bruuAbBT6QUNHhXsoFsu+gbt+KcADFR5
        bkb+4Il8CpWXxJ5RP9hOQwtzEXfTsNaiLJWiwefyxuQiZaG7IuW55mlOMREhogSs
        I3KKVKszSnw0nLsPggqTkbH0wOgp1Hq8Ng/PadirC4DWIs6ryJdQY8wVC8DK7Q3a
        x63KhitbqAQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 326C9D240B;
        Wed, 10 Jan 2018 15:50:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5264D240A;
        Wed, 10 Jan 2018 15:50:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] the cat-file -e option doesn't work as documented
References: <20180110125554.12582-1-avarab@gmail.com>
        <xmqqbmi11m2l.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 10 Jan 2018 12:50:22 -0800
In-Reply-To: <xmqqbmi11m2l.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 10 Jan 2018 12:43:46 -0800")
Message-ID: <xmqq7esp1lrl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10C96B8-F647-11E7-A3AF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am kind of confused.  
>
> When the doc there says "no output", I read it as "no output", and
> no other restriction (like suppressing an error diagnosis, which is
> not even sent to the standard output stream).

Ah, OK, so you were saying with 1/2 that "output" could mean
"something sent to standard error stream" as well and can be helped
with a more explicit clarification.  Makes sense to me (sort-of).

