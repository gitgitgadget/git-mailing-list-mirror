Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A10CC2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BD42072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvR3fkuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgDGPJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:09:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59323 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:09:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFAC9ABF64;
        Tue,  7 Apr 2020 11:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=o1h0KvPJ7jd+
        mqIgVh3ig/9w5BU=; b=cvR3fkuw2+zpcTpRbYvaMEitr5RmwrNLj7Ze6FgJ2Hzj
        71JU69C7E7Fi0KHVqelklgjYZPgpVL8mYmWAljmPw9syHgBUuw3eqbGeE5ltfLUZ
        lfqRbbdOSkS11FC/l8eQwIi7X+nQfUpq5H7lziMAlzKe4OdkjS68FYUfEHaugS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PleQtS
        xYiKEB1tySYh18lJjTktY5MpkuYCi4Gex2i1eQYT4P/yTjiTrZDjv7wUm8pU3NhD
        7/haakBaXR/lmSwqu42JN51qnl04GGzGoVOJLo4pbduKwPpJVd/IvgCDmxalg8H0
        MUPT/5m9AP0bBhfxvfRnO65K/NLmreveH3RLc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7A75ABF63;
        Tue,  7 Apr 2020 11:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9AC2ABF62;
        Tue,  7 Apr 2020 11:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v12 5/5] bugreport: add compiler info
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-6-emilyshaffer@google.com>
        <20200406234738.GA2568@danh.dev>
Date:   Tue, 07 Apr 2020 08:09:02 -0700
In-Reply-To: <20200406234738.GA2568@danh.dev> (Danh Doan's message of "Tue, 7
        Apr 2020 06:47:38 +0700")
Message-ID: <xmqqpncjtjsh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B80D4D92-78E1-11EA-B1B4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-06 15:45:26-0700, Emily Shaffer <emilyshaffer@google.com> wr=
ote:
>> Helped-by: Danh Doan <congdanhqx@gmail.com>
>
> If you ever send another version of this series, my Git identity is:
>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com>
>
> Thanks,

Thanks.

