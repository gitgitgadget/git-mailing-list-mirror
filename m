Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5331F406
	for <e@80x24.org>; Fri, 22 Dec 2017 22:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756171AbdLVWGZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 17:06:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63318 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755934AbdLVWGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 17:06:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A43FCBDAB8;
        Fri, 22 Dec 2017 17:06:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GT5KRo+59Zg2
        bFDBjQ6resncwYk=; b=uB4IheexTmBmE3TmEgBsp7GHxrfBuTIociGo9RZNdaoW
        IkLRDMPiXmsrB2tJji4LMAGx4MP++tZClNB7Yx9nYCBMeERY7G/2lVE5DFrMv2iP
        1oMbtn7Es14wASGpY+1SWQnBfK1yvqrJqkbMdXNtGnb9vXvPi7H3m2Zgu/fOeZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HA7EsH
        ZrPHpKxzTGE+qoxLTap1Cb4qmiE386ylBvVLJYCIzo82sNkyZ5EwxjEA/oQBpe86
        iRs6btLR2t3zIUQpQHwgMT67L+s1GY7SE8+DQloiX13Urq0NyWsKPAxQsIo2hAd6
        Eb2BEPjFNTXLyS4hFFqwzPF/NePhWjPTDmrIM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C038BDAB6;
        Fri, 22 Dec 2017 17:06:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6B7BBDAB5;
        Fri, 22 Dec 2017 17:06:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
        <20171222204152.4822-1-avarab@gmail.com>
        <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com>
        <87h8sis9w5.fsf@evledraar.gmail.com>
Date:   Fri, 22 Dec 2017 14:06:19 -0800
In-Reply-To: <87h8sis9w5.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 22 Dec 2017 22:58:02 +0100")
Message-ID: <xmqqfu82pgdg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57820834-E764-11E7-B318-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't agree that git as a tool should be so opinionated. You can edit
> these --fixup messages right now with --edit, and I do. That it doesn't
> work with -m"" as it should is a longstanding UI wart.

I think you missed the point.

I was expressing my opinion, not an opinion of Git as a tool, that I
think one of these two "use case" scenario was a bad way not to be
encouraged.

That is totally different from allowing --fixup and -m working
together.  That is a good thing that helps the other "good" use case.
