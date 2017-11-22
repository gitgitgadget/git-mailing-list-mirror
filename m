Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75692036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdKVDsZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:48:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751415AbdKVDsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:48:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2D32B10EB;
        Tue, 21 Nov 2017 22:48:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y5p5S047FzN3JHJMfti/qihx0o8=; b=ybGAuM
        aMuOBlGskgUpjiHdn+pQv6L6GjlERcQc0zyb8IWR5gpJauxBHkieUHx+t6Y6NxEx
        Z+ryOWPBOx+SaTobTglfjEDKwcT4K0sgye+Pr20w2pa/Y44ungWhQfVL2vAVepwr
        RBe/B6YQ6dGOXDjdlBwq7EOIMDK/8P2YoqZ98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hC+NR3ZlQ0lgQaYoVBTIXGztk9fP5NHz
        nlgcHkxWoaJoCrsETsxFn4jv00eWzMP3M2lRld4B5NM+j25e80B7+4oyO4YU633F
        bR0YecVDvBDaTMQfrddWkARzXEhbtVaOwZYa42eT3FJK6FVPg+rOnEJj7woEa3sG
        40gh08xf1/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA75BB10EA;
        Tue, 21 Nov 2017 22:48:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FB9BB10E9;
        Tue, 21 Nov 2017 22:48:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
Date:   Wed, 22 Nov 2017 12:48:22 +0900
In-Reply-To: <20171121160939.22962-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 21 Nov 2017 17:09:38 +0100")
Message-ID: <xmqqzi7fug6x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCFE25C6-CF37-11E7-B986-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The function calls itself "required", but it does not die when it
> sees an unexpected EOF.
> Let's rename it to "packet_key_val_read()".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> These 2 patches are a late follow up from:
>
> https://public-inbox.org/git/CAP8UFD2vk4jV7jEBx3Axd-dhfcsGSJVFFt+pumdT1j8GD_oM_w@mail.gmail.com/

Thanks for tying the loose end.

