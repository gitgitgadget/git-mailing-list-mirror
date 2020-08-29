Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D098C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F24120774
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lxm4VAAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH2T3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:29:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgH2T3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 15:29:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7DA9D6A0A;
        Sat, 29 Aug 2020 15:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dx7XrUSx1QVffQjq3mIA9BGVlWI=; b=lxm4VA
        ApGFSS8e5MjWYr51xKQ62rS1L0c89/m2lCGZmjb/bTRgETxyeKcBUu5U2UXsm/Mq
        OgRqHWbZNJMu9CuZoAMpGdnWixga2HAc0tCLK2QL41Kw+WZ+SAUYb2KuwUEJnR6r
        nyybJrWltd+NFYfuxN6uboYhbkawalvn+j+xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q7KQ0DcaVXFuuK0bNxDRSOac9Dxd35Ez
        poFvre9opej5uVHUC97HVhUx4Tl35xIwnTe+AhTkdLTFmhnjNm5gf2C7+jcNDf6B
        X5yav+rr716kLflCLIp7JYpU6//ihG9QHUgj/8LMiEsatl+k8cfWnUU3uytTYeB0
        ltrzBbdsDbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E05FED6A07;
        Sat, 29 Aug 2020 15:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 387ECD6A04;
        Sat, 29 Aug 2020 15:29:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
References: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
        <20200829153920.17155-1-vvavrychuk@gmail.com>
        <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
Date:   Sat, 29 Aug 2020 12:29:47 -0700
In-Reply-To: <xmqqwo1hi9nv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 29 Aug 2020 11:33:56 -0700")
Message-ID: <xmqqft85i72s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00E23C36-EA2E-11EA-A3C6-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Vasyl Vavrychuk <vvavrychuk@gmail.com> writes:

Another thing I forgot to say.

Subject: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.

Especially with grammofix s/to enable/to be enabled/ applied, the
above is way too long as a title and would stand out like a sore
thumb in "git shortlog --no-merges v2.28.0..v2.29.0" output.
Something like

Subject: [PATCH] send-email doc: mention less secure app access with GMail

perhaps.

Thanks.
