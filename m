Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E58C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A0D207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSM604H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgE1Oow (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53986 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgE1Oov (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:44:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80AAF569D8;
        Thu, 28 May 2020 10:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o29izf9+9Be2vAINHSeDtIN43J0=; b=OSM604
        H6IJCMGxSK9Tiuq2MrDGQ4ffG8x+M9eJY0DQGB6x+Omhx3lU/omMLt9RfSPHEOQT
        sF8YSf5oV1HIBlaEkuiADP9mFaINEpEtIBsWqoPw36RhQSZpA4y0syAFjz2oEau2
        oSgNfUZ20BeAJva49z+9XSpQSgeY0O7kL8D28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fjjIUD5IOCHIdW2uhfQEwhYKEQm7Py/0
        AbDBn2VPwrkM/daUDoouYbwCpRXziDvo2MOMMTZc+542NGTWymrGPozRu5z+u1wO
        hRIMQ+oKmR3uB02MWyMhe9MJYqBMYgweDOfO650JdvoaCDYltNr5694zbMvI6Cen
        l2uW2ubadz4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78288569D6;
        Thu, 28 May 2020 10:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E79D6569D5;
        Thu, 28 May 2020 10:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: jn/experimental-opts-into-proto-v2, was Re: What's cooking in git.git (May 2020, #09; Tue, 26)
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet>
        <xmqq1rn5kpzi.fsf@gitster.c.googlers.com>
        <20200527235808.GD56118@google.com>
        <xmqqeer46g9l.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005272159570.56@tvgsbejvaqbjf.bet>
Date:   Thu, 28 May 2020 07:44:47 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005272159570.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 May 2020 22:05:28 +0200 (CEST)")
Message-ID: <xmqq5zcg5db4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7E81066-A0F1-11EA-8290-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> No.  I fully accept your reasoning in the proposed log message why a
>> handcrafted query to the config system is done in the location the
>> patch adds a call.
>
> Now, I apologize. I had not reviewed the patch, and only just read it.
>
> I agree that it is a bit unfortunate that it uses such a non-standard way
> that hard-codes "feature.experimental" in a different place than
> repo-settings.c.

You make it sound like it was a choice made by the implementation,
but (1) a "non-standard" way may not have to stay non-standard
forever (there may be many more experimental features that are not
tied to a specific repository in the future), and (2) the patch
needs to do it in a way that is not tied to a single repository
because it is not at per-repository level decision.  As long as we
are aware of this limitation caused by the current "experimental"
arrangement that is tied to a repository and can work towards
extending it to support this new use case in the future, I do not
think it is unfortunate at all.

> Had it been a patch to repo-settings.c, I would now have tried to lobby
> for including it into v2.27.0, but as it is, I fully agree with your
> reasoning to just leave it out.

No need to apologize for raising it as an issue---hearing from those
with different risk tolerance from time to time is a good way to
calibrate my own.

Thanks.
