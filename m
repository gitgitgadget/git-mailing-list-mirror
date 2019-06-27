Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F4A1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0RxT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:53:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56487 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:53:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD5DB7B560;
        Thu, 27 Jun 2019 13:53:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LfQ2EFw5EKY7
        LVPzqqW/r5qO9lg=; b=a9yc1iZ0vhmZgTofzXQftRcIkDPuMulcxmNvJTxGoyLG
        tbA9OkEfRfSKSFTVQrydBHbLaAokua9dCGGrSpp59rFy8wEwuuzssRpCkFVqRCAu
        b1P+sDYXmApdPaBGblx3vTBjv0h0RFvwEF8YFGYSqePzRxGvFCKYaSng9atmu1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UdghaD
        HWY8Yz33LeKEY473KOJWuPbQl9iBA7WwugXxCNboCt0L5MooxuYt/h6NPHKKuciK
        D+NznJDTmYAuUW3DIyAZKftAusLBcb2pFzgrsZcTNvPzcfmSx2nN0c4g9S8SHi1a
        YO8DJu5fAZDtTENauJYWt8DJMDDM7p73t6ZIA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4EF97B55E;
        Thu, 27 Jun 2019 13:53:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2DE47B55C;
        Thu, 27 Jun 2019 13:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Some more on top of nd/switch-and-restore
References: <20190620095523.10003-1-pclouds@gmail.com>
        <xmqq8stoce5w.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Di1720RhDxgieVNTfpNONJhi5ZniKje=wj4pZDy-0EwQ@mail.gmail.com>
        <CACsJy8CeChO6wJkr_Pp8aH1a6rJwUCDYtK89SLwLw_9KOgQHeA@mail.gmail.com>
Date:   Thu, 27 Jun 2019 10:53:12 -0700
In-Reply-To: <CACsJy8CeChO6wJkr_Pp8aH1a6rJwUCDYtK89SLwLw_9KOgQHeA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 27 Jun 2019 15:53:43 +0700")
Message-ID: <xmqq8stmc3uf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6FEB874E-9904-11E9-8949-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jun 27, 2019 at 9:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Thu, Jun 27, 2019 at 2:58 AM Junio C Hamano <gitster@pobox.com> wro=
te:
>> >
>> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>> >
>> > > This is small refinements (except 4/4).
>> >
>> > What's the status of these?
>>
>> Small test fixup needed. I should be able to do it later today.
>
> Actually since the patch that needs updates is 4/4, which is not part
> of nd/switch-and-store-more, I think the status is "ready". You
> probably could safely make them part nd/switch-and-restore.

Yup, that matches my understanding after re-reading them.

Thanks.\
