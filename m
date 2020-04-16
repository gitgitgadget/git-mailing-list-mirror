Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D2C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7044221D7E
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K4aeSCOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbgDPQhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:37:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53569 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgDPQhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 12:37:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E21B42A92;
        Thu, 16 Apr 2020 12:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a0JttvSlZZE0wd5ymn9plEftXbw=; b=K4aeSC
        ObfcfejfLeGuwfOCbyMTEW0POOZdsUvk1aLiFQ7+SLLYJ8ywAp40jQVmUiAim1Xa
        xITCbP8kUFzc08gkQaR7/41VX2xKuOKg1Enfur9TYVCh/+h/aNPK7hkIWuMIv2tH
        ejcLzg5WJB6F0w5v1mC4D2lOMgsX1SPs2LlCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ez0xbtUHwK8cy0AwJieLwDe/eHalkJKZ
        zfsx3uX4E+XSdayXyYN/DBxeyOXgO7KbRtrbOZurtxH9TDAW2BEQ2VZM+xV7KxVu
        D9SeEML23uO1WN+1AIgIa4OIK+gIbViOySWJssbQQRYlY63D5MlLDcff2ZlQjL/u
        6OIvQ4T0q74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14FAC42A91;
        Thu, 16 Apr 2020 12:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FB2842A90;
        Thu, 16 Apr 2020 12:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <CABPp-BE6xrKLA26Xn4apW-MReCeeyPKu=UMkgr4DsPW0vH4kDw@mail.gmail.com>
Date:   Thu, 16 Apr 2020 09:37:43 -0700
In-Reply-To: <CABPp-BE6xrKLA26Xn4apW-MReCeeyPKu=UMkgr4DsPW0vH4kDw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 16 Apr 2020 08:28:02 -0700")
Message-ID: <xmqqwo6fz8rs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9908E282-8000-11EA-9314-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think it's as ready as it's going to get.  I'm not aware of any
> current issues, am not planning further work barring a report or
> further review, and I'm feeling much better about it than when I first
> submitted it with a bunch of big warnings (though the big warnings it
> contains in that one commit message are still justified).  I'm glad it
> spent a good long while in pu.

Thanks, let's mark it for 'next' then.

By the way, I merged quite a large number of topics to 'next'
yesterday.  Those who want to polish their own topics further may
want to check the status, so that they can switch to update
incrementally from now on for topics that are already in 'next'.

Thanks.
