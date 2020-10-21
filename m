Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549DC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3141A2237B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOt5i1wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505494AbgJUUpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:45:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52215 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505489AbgJUUpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:45:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58AAE903FE;
        Wed, 21 Oct 2020 16:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iPIBhQuOGX5Fy5WHJmSILesQ82U=; b=kOt5i1
        wGr2iNJkhEvEjo1vHzdhZ3TsMo6smwV2bZJ5xUm299ROcoQTdZm5nZEAA8Yk41yt
        Yf8bg7ICbx1MMVJFhFYwEWdlL234I/MyF/M+LGL01l2JMlMb10F69LFOssZ6DLYZ
        nG12TlK0hz3kkB9SzV1W8BPz/ZMdZkAmM2h/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w4NYyzY+uivupzX7ah2NOASGpxsjRgix
        3AYZOfOxX/Q5RLvAzW9Th/MSELevkK9MTCSQEjDD1hY1eQr01Cq18IsyCyepmvkU
        eYZSFRdSOON/KPg6Sh+HEXm9xm5MECSqfFsn40huXahcDVi10A1udKtqwememQ/d
        wJI/kmCPm2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E9AF903FD;
        Wed, 21 Oct 2020 16:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFA96903FC;
        Wed, 21 Oct 2020 16:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: mr/bisect-in-c-3, was Re: What's cooking in git.git (Oct 2020,
 #03; Mon, 19)
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010211647050.56@tvgsbejvaqbjf.bet>
        <xmqq5z7371i2.fsf@gitster.c.googlers.com>
Date:   Wed, 21 Oct 2020 13:45:22 -0700
In-Reply-To: <xmqq5z7371i2.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Oct 2020 13:44:21 -0700")
Message-ID: <xmqq1rhr71gd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56FD30F6-13DE-11EB-9C24-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> It has been reviewed _quite_ a couple of times over the course of 9
>> iterations, and I think it is ready now.
>
> Oh, numbers I can count.  I wanted to hear "yes, all previously
> known issues have been addressed" from those who did read everything
> in it and gave their feedback.
>
> Do you want to give your "reviewed-by" now?

Ah, I should have looked again.  Yes, these look good (and the
sign-off chain ends with your reviewed-by already).

Thanks.
