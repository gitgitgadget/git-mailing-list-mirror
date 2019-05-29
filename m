Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA26E1F462
	for <e@80x24.org>; Wed, 29 May 2019 18:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2SD7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 14:03:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54755 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2SD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 14:03:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8881D152428;
        Wed, 29 May 2019 14:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4Kpbt/UW6Qdy
        XksP+4ZWBHrFrWo=; b=xDxQPjiKOQgnc+hypBIzvh66C017jbS1NLG2sOu1LAMg
        P9l/TjY6N824RAscjxil7+dbJQ5/YjDWgW/G2NfjdZjYbL5g7P2DKgLQYfA+ZghZ
        wG9DykwxB6sWrKg6o4G8/LbTmMLYyC1cw9lLlQESdp32WbDStjzuxUebV2JTujQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K/11AE
        QUNRcdFlcwKJm/OD+wF8hiHUH5O5hpMNapWoimQ5KX1JhlVwFHQtFGxaqMjz4Nzy
        kz5XF74pgiHon2dHaN50YD6LUWRusIx+NDdkFIcpSFDLxt7rAavQLV/kEDHscadc
        FcGBjAWzqDxQqeQHaEj+D+L7RFlSaJEYJeMug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FE93152427;
        Wed, 29 May 2019 14:03:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECB62152426;
        Wed, 29 May 2019 14:03:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        tmz@pobox.com
Subject: Re: [PATCH v2 0/3] fix diff-parseopt regressions
References: <20190524092442.701-1-pclouds@gmail.com>
        <20190529091116.21898-1-pclouds@gmail.com>
Date:   Wed, 29 May 2019 11:03:56 -0700
In-Reply-To: <20190529091116.21898-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 29 May 2019 16:11:13 +0700")
Message-ID: <xmqq8supyw6r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 214CF098-823C-11E9-BC3B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v2 reduces diff noise. My C is rusty (and probably holey too). For some
> reason I remember "unsigned" is equivalent to "unsigned short", not
> "unsigned int".

FWIW, I do not mind s/unsigned ident/unsigned int ident/ to make the
type more explicit as a clean-up at some point.  But I do think it
is a good idea (and I like this v2 because of that) to do that as a
separate step, and not mix with the real fix we see in the v2 1/3
patch.

Thanks.
