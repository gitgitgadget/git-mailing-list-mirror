Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D437C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDDB22209
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJYE6cUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgDQRkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:40:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63085 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgDQRkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 13:40:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00D95BCD6F;
        Fri, 17 Apr 2020 13:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fHVPR5SciXO3piNXLgHKGgUdUPY=; b=oJYE6c
        UzGAYXcbDxxmPogyrGW8pyCWPRRpKUbE6W4BHlaBOWGTRs4D8xQ1S6K1P/ViBPcL
        r828KJXzGb/fOtndIqFZI7pkiEfPNeMJuyT4zHPMvfis0LR7mmXu/+HGJjrsIFag
        KgG1Eq5zG2eK4M/HM+AUu8w892Marus5JOzww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZJRLygukCm8mBzJZtImRBONmpZjOWr+l
        S/Pdyee74z9xwbLEU0k3gFXEXci3zW3asqcWiwDU4WbD51p+nyhiO9mp3vgUVDSQ
        Jm7xFwjqOclP9+/UgebQDn2MVwurzrDSM2eNx+i18chuqSsNKVM3QeCJA4hfIhrK
        w+1kS11qVIA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED4E0BCD6E;
        Fri, 17 Apr 2020 13:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D278BCD6D;
        Fri, 17 Apr 2020 13:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200417022416.GE2285@danh.dev>
        <xmqqr1wmwu2f.fsf@gitster.c.googlers.com>
        <20200417133647.GA26701@danh.dev>
Date:   Fri, 17 Apr 2020 10:40:05 -0700
In-Reply-To: <20200417133647.GA26701@danh.dev> (Danh Doan's message of "Fri,
        17 Apr 2020 20:36:47 +0700")
Message-ID: <xmqqwo6eui2y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A5D92CE-80D2-11EA-BDB5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-16 22:38:16-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Danh Doan <congdanhqx@gmail.com> writes:
>> 
>> > On 2020-04-15 16:01:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> >> * dd/iso-8601-updates (2020-04-15) 2 commits
>> >>  - date.c: allow compact version of ISO-8601 datetime
>> >>  - date.c: skip fractional second part of ISO-8601
>> >> 
>> >>  The approxidate parser learns to parse seconds with fraction.
>> >> 
>> >>  Will merge to 'next'.
>> >
>> > I thought we haven't gained enough concious for "12:34:56.7.days.ago"
>> > Current code will treat it as "7 days ago at 12:34:56"
>> > New code will treat it as 12:34:56 (today?)
>> 
>> Yup, it clearly is a regression, and I do not think there is an
>> agreement that the regression matters in real life.
>> 
>
> Well, I _think_ we should keep it in pu to see other's feedback for now.

Thanks.  Will mark it as "On Hold".
