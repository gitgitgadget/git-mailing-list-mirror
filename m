Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AFA20966
	for <e@80x24.org>; Sun,  2 Apr 2017 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdDBQqt (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 12:46:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750986AbdDBQqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 12:46:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E0A5753CA;
        Sun,  2 Apr 2017 12:46:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DpU9mwYIx0wL
        XEHcuH1KkuJ1buI=; b=SudcpTnX/l1dw3n3E2/UaYZQ4IYTLlbp1eICTDgGvL+B
        sg4NaDoUzzKRgPz5WzHWK7sW8OmDX8S/XhDr3QSEZ0Xx3aSVf2lYZ9/K0JI96HmH
        5USTQg/me5+4krR4seg1oPisuM3xk7vDLTcw3wzRaF0WErLmt5WknJulHKjq2kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Q3UhcD
        0XRBRyP6whiFyHGabb6sVHLusb6xL2xKy3Rz6oF9p/yd17CyWOWwgL9yQLzFkRo5
        ZQO6gAQhW/JmXAdSd57ypDQZXJjt3+xMVNwWZYolise56eMXTlm6UsrW2gSnPlZf
        Jfr9Fm25ksyvhTmPRvL1Ks5X5SIN4X1lVCRGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36FC8753C9;
        Sun,  2 Apr 2017 12:46:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C2C9753C8;
        Sun,  2 Apr 2017 12:46:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] contrib/git-resurrect.sh: do not write \t for HT in sed scripts
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
        <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
        <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
        <xmqqd1cwwyr5.fsf_-_@gitster.mtv.corp.google.com>
        <7028b4eb-aa2b-aaf6-764d-cffab24a9968@gmail.com>
Date:   Sun, 02 Apr 2017 09:46:34 -0700
In-Reply-To: <7028b4eb-aa2b-aaf6-764d-cffab24a9968@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sun, 2 Apr 2017 11:58:45 +0200")
Message-ID: <xmqqzifysqol.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF98B846-17C3-11E7-A09E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 01.04.2017 o 06:14, Junio C Hamano pisze:
>
>> Just like we did in 0d1d6e50 ("t/t7003: replace \t with literal tab
>> in sed expression", 2010-08-12), avoid writing "\t" for HT in sed
>> scripts, which is not portable.
>
> I guess it is not possible to use HT variable (similar to LF that we
> have in t/test-lib.sh, and which is defined by some scripts) set to
> literal tab
>
>   HT=3D"	"
>
> wouldn't work there, is it?
>
> Using this variable would make literal tab character more visible.

Patches welcome.
