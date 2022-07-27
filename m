Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE71C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 14:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiG0OK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiG0OKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 10:10:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFB1A04B
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 07:10:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1A2914E659;
        Wed, 27 Jul 2022 10:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8KwCl0qN3fGgRu2GoZ6UtKMLk+Hyjv/1VOf6tz384oI=; b=M/FK
        Z6lOl4JFefAsC3l/QWEDQCip/PlkAaQhqVLNgk6AUwDkK0QfMyO+esONIzBqXRid
        JAT9Anvrie2fGKTa84wPGBw//4UHYoMSrlg4rq2pFnbcFdd0Unmtt2k0ML6oqW6o
        JKbIqG7NyMHu3qbb/wqisU/1+m9jMJHrtJvVsHE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99F9214E658;
        Wed, 27 Jul 2022 10:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 103E414E657;
        Wed, 27 Jul 2022 10:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
References: <cover.1658532524.git.me@ttaylorr.com>
        <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
        <220723.86leskqtej.gmgdl@evledraar.gmail.com>
        <xmqqmtczafku.fsf@gitster.g> <Yt8q8xvtXmztLIln@nand.local>
Date:   Wed, 27 Jul 2022 07:10:51 -0700
Message-ID: <xmqqtu72tzmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECC32BB8-0DB5-11ED-A1B2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Do you have a preference? I am fine with either approach, FWIW.

I do not have a strong preference, but in "text" mode, I suspect
that the users may find it more convenient if we discarded CR at the
end of the line even on LF platforms.

Thanks.
