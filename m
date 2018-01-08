Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D471FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755982AbeAHStv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:49:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58156 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755932AbeAHSts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:49:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F399CD3EEA;
        Mon,  8 Jan 2018 13:49:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5nqdanZ8SHOR
        3knb63NqLA6guGc=; b=gcs2mprV0ZdFsoafMHRpCGEozyHgY57uBdvwlhr6Dour
        ey1SEKzhZR4JwhvJO6vsZaD2IDT5kYuYX+XyvV3YDdFeC6+mvLsijbCFukoSJwx3
        QOfsKk8N0bxZmQSCsco1UDT7A/gy2Ybhfvlihuii1vle+phMXp3/onoPphdvOzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OHtIuk
        3MSA58MmyovYiNZQQIK6Hzjf5CH2/XTNkk6Q7Et2kJeEFOIzw2+g0lSd4wGdUq9F
        x+AF+SkfTXL78Ndjg0FTCLP+HQKgRrIwGFeNC/BLfl9d+jbzEtDyNZDSvCTaH5L5
        wmoOhsAC1DlWYLw1fS41vQLHDw6AOokJsVA4o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA8F5D3EE8;
        Mon,  8 Jan 2018 13:49:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C0F4D3EE5;
        Mon,  8 Jan 2018 13:49:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on Windows proper
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <20180105221222.28867-1-avarab@gmail.com>
        <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <87mv1raz9p.fsf@evledraar.gmail.com>
Date:   Mon, 08 Jan 2018 10:49:45 -0800
In-Reply-To: <87mv1raz9p.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 06 Jan 2018 14:32:34 +0100")
Message-ID: <xmqqvagc89ti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B27F181A-F4A4-11E7-82E6-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I agree that there should be some prerequisite to skip this on Windows
> by default since 6 minutes is clearly excessive (although I think you'l=
l
> find it runs a bit faster in the branch above), but that should be
> something like:
>
>     test_lazy_prereq EXPENSIVE_ON_WINDOWS '
>             test -n "$GIT_TEST_LONG" || test_have_prereq !MINGW,!CYGWIN
>     '
>
> As the long runtime is not inherent to the test, but to excessive
> slowness caused by certain operations on certain platforms, or maybe it
> should be EXPENSIVE_ON_SLOW_FS or EXPENSIVE_IF_FORKING_IS_SLOW or if
> we'd like to generalize it.

We already do skip overly long tests everywhere unless explicitly
asked to run them, and the above sounds like a good way to go.
