Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1EC433E6
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7418F20786
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wvv7BS9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJXId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:08:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55082 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgGJXIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 19:08:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263107EE4F;
        Fri, 10 Jul 2020 19:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3x5HkavcQe0h
        7Vl1qwgZOIJWdkY=; b=Wvv7BS9kZRDJ8DZgmrLqAGaRnVDIbot7GkbCER/bTHev
        XlMbXOR9aOAhq0xuQRme7+K3Nz35TrSmitbKbNsO8VQesrXKgE6jS4FRq5oezFqd
        XZXhhSygnJm0cV+u8aaGFPqGoGxZePH+GsUvovQoWaXb+SV7k5CGdlNVuFzk1Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NQgHOe
        roXvjKomr3QtC49X+G0lNjO7f+IGKA6PyUu1yTWgQmLX6w4x8MwjCvAAfoe0JgYY
        xVe45ZDKf+zE0kj059eUhI+/PlVb7JWdlnrt9owxVJknXtrlVo3CZE4tgsoPy+jE
        reL5dMxVNBQE1ZXZdTU9iVbzMoasaRjB41iWY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E29B7EE4E;
        Fri, 10 Jul 2020 19:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F5527EE4D;
        Fri, 10 Jul 2020 19:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] bash-completion: add git-prune into bash completion
References: <pull.667.git.1592784835441.gitgitgadget@gmail.com>
        <xmqq366ndkey.fsf@gitster.c.googlers.com>
        <CAKO26MsKK5Eu=aNtOkMr3v_VBm_TR8_vZOFz=fNMzax8RxntYQ@mail.gmail.com>
Date:   Fri, 10 Jul 2020 16:08:30 -0700
In-Reply-To: <CAKO26MsKK5Eu=aNtOkMr3v_VBm_TR8_vZOFz=fNMzax8RxntYQ@mail.gmail.com>
        (=?utf-8?B?Iuael+iHquWdhyIncw==?= message of "Fri, 10 Jul 2020 09:18:35
 +0800")
Message-ID: <xmqqy2nrq87l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45CDF126-C302-11EA-8E85-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:

> Hi Junio,
>
> I saw this integrated into master. Thanks.

Thank you for writing the patch.
