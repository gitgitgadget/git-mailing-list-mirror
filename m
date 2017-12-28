Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1FD1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbdL1WsU (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 17:48:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55963 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751169AbdL1WsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 17:48:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18170CCD73;
        Thu, 28 Dec 2017 17:48:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lqRwQRfdpvoN
        5WusilgfeN5xCXk=; b=ZtTm+jJ+9yDTTQg/HcZSMWUZMIDTov6vGKp6RDNmeV1p
        BQNqM42vaQli/OCYsiCabpSRRzhE/Esmoc+Sw3cYCIK+f2epenZmhb/VLDhnkRtQ
        ymu9jIl7Hc8RHiurdWbaLdf0nPU3SwlCajAsVZhLk24zwY62s3CJJOG4nMtXLlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dRSEor
        vNEXeuHmiw9MLSpmTarhN3I4qldFQhKw+RDuuzSou3RKZBtzgHg1BammcpdVoqIR
        D5AvN4zIFqgPbjR/Y8U+4aFURcWdmHxGF9Tao7GtUxPtyWSoM6SShSkeQ1/zXgUY
        uWPWDJ0qi4mq3BTqHZxJyLZHXBFNc59SvNc5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FFEACCD72;
        Thu, 28 Dec 2017 17:48:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89598CCD6F;
        Thu, 28 Dec 2017 17:48:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] increase wildmatch test coverage
References: <20171223213012.1962-1-avarab@gmail.com>
        <20171225002835.29005-1-avarab@gmail.com>
Date:   Thu, 28 Dec 2017 14:48:17 -0800
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 25 Dec 2017 00:28:28 +0000")
Message-ID: <xmqqr2reii4u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32A4364C-EC21-11E7-84A4-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This v2 addresses comments by Johannes Sixt in
> <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org> and there's osme other
> cleanups as noted below.

One thing I found "interesting" (because it is usually the other way
around) is that about two dozens of the tests in this fail when your
shell is bash and all of them pass when your shell is dash.

