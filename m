Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D823C11D20
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78B20679
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZPVdKbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBTVUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:20:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61828 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBTVUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 16:20:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00C84A9F5E;
        Thu, 20 Feb 2020 16:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mWsA7UI1aZmoWMnP8ItHoOvaWxk=; b=CZPVdK
        bJ4b1OD3BKpHMnIacQIe1UZ21rZKxTWYAzbdGsCoGujAFF/zMQodCAMxD99HW3wA
        ECmMqCyIqSXGkFL0f5JvYv+g8fEFq+wljajm3lXumQ9xXn77TfT4I0EQhdhHg/CI
        oyOWxR9ZE9ufLKBL0lDItKVLzSgR/55qssFIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EQizJCqbTQf0oXUnUngwbHawew5eSI9v
        5wzfcu+Wz52JB6LoPXXgzLLrFKaX0WhqNejmKjH+RYGD4qwJ0cLElYlNOMRPwjFm
        lJOpTd5jbbqblwuTP5543IIMHpyMS/Cn9dAcCba25ZzFoXPLSzplUKbAUmawGMPS
        FsYb6XVEmlU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED9E8A9F5D;
        Thu, 20 Feb 2020 16:20:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CA7BA9F58;
        Thu, 20 Feb 2020 16:20:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] credential: allow wildcard patterns when matching config
References: <20200220022413.258026-1-sandals@crustytoothpaste.net>
        <20200220022413.258026-6-sandals@crustytoothpaste.net>
Date:   Thu, 20 Feb 2020 13:20:01 -0800
In-Reply-To: <20200220022413.258026-6-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 20 Feb 2020 02:24:13 +0000")
Message-ID: <xmqq5zg19cse.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2D7D056-5426-11EA-857E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: brian m. carlson <bk2204@github.com>
>
> In some cases, a user will want to use a specific credential helper for
> a wildcard pattern, such as https://*.corp.example.com.  We have code
> that handles this already with the urlmatch code, so let's use that
> instead of our custom code.

Quite nice.  Will queue the whole series.

Thanks.
