Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C5DC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B15204EA
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GFRwPRPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHXUak (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:30:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55113 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:30:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AA9DD4909;
        Mon, 24 Aug 2020 16:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=44iwUhLmWE9FK8ZPyo/tVnZQDHI=; b=GFRwPR
        PCXVvy5uBKVGzPWFliTdgJ9I3AtIsGYziqDyfBribVy5RKbMq1F2Qzken10N8DPm
        cbU+7vQYDCbL28RvTajeZhBEZeLaGFU24Avo9xkjD//REbOUHrJP0zSV7gGRUHRE
        LfsrCineNS9Zqfz0+3MkM/IRQN4ikApqh+/7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a6+V4U8i63Ry0d4Y/cT8NC/m4Ppk/CYs
        XeIK2Jo521FaySKWOwVNzY0VfCd/QnhzY/L5lnPu0jNQXHxmc6FZQx89rvk3q3VK
        fGAv1uCYu1ki7ySNFXa2PAPKAmc47OIdk7t7XJXbrRvjzjY4UMZM1T/iqyzW6i13
        ASwTAzQ8EYo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32487D4908;
        Mon, 24 Aug 2020 16:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 772C5D4907;
        Mon, 24 Aug 2020 16:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ori Bernstein <ori@eigenstate.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <20200823005236.10386-1-ori@eigenstate.org>
Date:   Mon, 24 Aug 2020 13:30:33 -0700
In-Reply-To: <20200823005236.10386-1-ori@eigenstate.org> (Ori Bernstein's
        message of "Sat, 22 Aug 2020 17:52:36 -0700")
Message-ID: <xmqq7dtn4wie.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA28AE18-E648-11EA-B481-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ori Bernstein <ori@eigenstate.org> writes:

> Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles

Documentation/SubmittingPatches[[summary-section]]. Perhaps

    packfile: avoid infinite loop with malformed packfiles

> In packfile.c:1680, there's an infinite loop that tries to get

The line numbers can easily change.  "In packfile.c::unpack_entry(),
there is..." may be more change-resistant.

