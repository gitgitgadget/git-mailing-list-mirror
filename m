Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C05C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 21:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiHTVfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 17:35:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE6248FD
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 14:35:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 455F01307A8;
        Sat, 20 Aug 2022 17:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u714HGBfCYbSQDXWmi3U/UudLshSppOfVziqVg
        zsq0U=; b=usP5hNiqT8JmmwksjmzTIspcerGJT7Io5NGMDrnYvsdaGBtEoKyEIw
        yXYZBKEbDF3MrKGmu4tedLHZpdWzvqozdHET4WP1sdFCj0SZOjG1jXzJwaPMVRgn
        qDY468ehLwdoDugU+4MxpGld4nlD2Ntjp79yA2t+lmhX69fQEg0zw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D1381307A7;
        Sat, 20 Aug 2022 17:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A60AC1307A6;
        Sat, 20 Aug 2022 17:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thorsten Otto <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "git am" gets confused when commit message contains text
 looking like a diff
References: <16297305.cDA1TJNmNo@earendil>
Date:   Sat, 20 Aug 2022 14:35:48 -0700
In-Reply-To: <16297305.cDA1TJNmNo@earendil> (Thorsten Otto's message of "Sat,
        20 Aug 2022 09:12:04 +0200")
Message-ID: <xmqqleriha2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F198F0E-20D0-11ED-837C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thorsten Otto <admin@tho-otto.de> writes:

> Apparently git tries to apply the diff from the git commit message, instead of 
> the real diff.

This is very much expected, and that is why people indent diffs they
quote to support their commit log messages.

