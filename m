Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1EB202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdKTAhB (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:37:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62000 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdKTAhA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:37:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96706A62E8;
        Sun, 19 Nov 2017 19:36:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cnTDOQnvYacb
        MmLmMmjH1w3wfUg=; b=NcnKokZlnhfhYVH1ieJdYr5Pkz+alWVgZnKsJL42xSzg
        gZhcJVzo3iYoNyDZ6A243Nz8mwIBHQLjwW76pHU7HZrVVTzBU4g3lo7pEUPEJPT0
        nkXWTFHif+91y9W1EzLOvixZi+8DlMK/YNxz1VU33e6hLbJv3i/87FjGICVzMmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Sy3QQz
        OFTjx7NTBXyrGTi03PS+GPV2mQ+r1/9SR2V4IblN2ooj7j2gWkLXpY65+Da1nKLn
        wszrBUD9Ht7W6s4ivX6TDC0kfTqU/7Sdhf8TdEKQayxfCrJBhUGjF+5UnIU8ph5i
        I5NiCpJcbzEaQ3NcorRUQKl/7cQ/1x4PEMtv0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6E6A62E7;
        Sun, 19 Nov 2017 19:36:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C45BA62E6;
        Sun, 19 Nov 2017 19:36:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/6] t4051: add test for comments preceding function lines
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
        <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
        <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
        <bde81d14-a955-4ea4-5799-2a95511d8215@web.de>
Date:   Mon, 20 Nov 2017 09:36:57 +0900
In-Reply-To: <bde81d14-a955-4ea4-5799-2a95511d8215@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 19 Nov 2017 11:02:49 +0100")
Message-ID: <xmqqine5okeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB0B707A-CD8A-11E7-A3E4-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> your suggested full-comment metric, i.e. more than nothing.  But more
> importantly it's the actual comment payload.  The leading "/*" line is
> included as a consequence of the employed heuristic, but a more
> refined one might omit it as it doesn't actually contain any comment.

I am slightly in favor of than against the above reasoning, but it
probably deserves to be recorded somewhere more readily accessible
than the mailing list archive.  The title of the test "context
*includes* comment" can be read to hint it by not saying that the
precontext shows the *entire* comment, but that is a very weak hint
that will be missed by anybody unaware of the reasoning behind this
decision.

    When showing function context it would be helpful to show comments
    immediately before declarations, as they are most likely relevant.  A=
dd
    a test for that.

... but without specifying the choice of lines too rigidly in the
test---we may want to stop before and not include "/*" in the
future, for example.

perhaps?
