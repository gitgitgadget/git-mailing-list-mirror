Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B005C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJLQFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLQFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:05:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16F3FD54
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:05:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0AFD1B5297;
        Wed, 12 Oct 2022 12:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MwnmUs6/VH4s
        CerjcNY2vFlkmyoE5R0deUE5AVL5Npk=; b=XSf9IicUWQIPWSNUPE/3z6iDwZQH
        IWc3xVPkcBUw6ia1K+Dg2mpdTe4dEtfBOxjUUSPhUYFbVDL6gtX1bq1XvAc526SL
        xJKF54bE51Vc9zxh1j2RRWcwTG5uiHQP2RMC0PS0cS/nUCGnPxDvM74gWFLGbzRd
        36EFzVZ6iGSHzS4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B41BE1B5296;
        Wed, 12 Oct 2022 12:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 210A51B5295;
        Wed, 12 Oct 2022 12:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 08/22] run-command.c: use C99 "for (TYPE VAR = ..."
 syntax where useful
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
        <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
        <patch-v2-08.22-279b0430c5d-20221012T084850Z-avarab@gmail.com>
        <ae08523f-13ac-d9aa-b787-f136a88b5804@gmail.com>
Date:   Wed, 12 Oct 2022 09:05:36 -0700
In-Reply-To: <ae08523f-13ac-d9aa-b787-f136a88b5804@gmail.com> (Phillip Wood's
        message of "Wed, 12 Oct 2022 14:04:35 +0100")
Message-ID: <xmqq35btm3hr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5CBF1A2-4A47-11ED-8574-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   	while (1) {
>> -		for (i =3D 0;
>> +		for (int i =3D 0;
>
> Here we are moving the declaration to the loop.
>
> Am I missing something, I don't understand how these changes match
> this description in the commit message

It matches the commit title, and makes it clear that this does not
have to be part of this series.

=C3=86var, try to do a focused series that achieves the objective of the
topic well, without succumbing to the temptation of creature feep.
It is especially important when you are taking other peoples' series
hostage by requesting them to rebase on you.

Thanks.
