Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E9BEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFZPxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFZPxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:53:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696010C6
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:52:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3261193294;
        Mon, 26 Jun 2023 11:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xz8IEefbrCCyguS2pb+mGUhUs0UKkaKH38aUAo
        noux8=; b=bBkovdsQA1IbLhvcJWUnJCG0HhD/v1gfF19khxol0OlLmnGJJ2+EBx
        ZmzbWGPUGkm4N8zSkcnZ0lMsbk1E9V7bQhTbU3VX0qRsC0v8U9e4Bo75GcX7tlie
        fI9BRrizy7k2RVkP0+56K+ikSA29XypftG5NuskSjjJB9oEv15xyc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9C64193293;
        Mon, 26 Jun 2023 11:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58E0E193291;
        Mon, 26 Jun 2023 11:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <xmqq8rc8781p.fsf@gitster.g>
        <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
        <xmqqwmzr5yul.fsf@gitster.g>
        <b7181a2d-ba97-eae8-6bf4-4fc4b0db64c2@gmail.com>
Importance: high
Date:   Mon, 26 Jun 2023 08:52:45 -0700
In-Reply-To: <b7181a2d-ba97-eae8-6bf4-4fc4b0db64c2@gmail.com> (Mark Levedahl's
        message of "Sun, 25 Jun 2023 13:01:13 -0400")
Message-ID: <xmqqsfae5igi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E8B1F1C-1439-11EE-9E0D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> I had originally organized as you suggest, no problem doing so
> again. What gave me pause was this paragraph I originally wrote for
> the cover letter:
>
> Patches 1/2 cause git-gui to function as it has for the last decade on
> Cygwin, but with Cygwin being detected. However, the browsing and
> shortcut creation menu items, removed in 2012 then re-added when is_Cygwin
> was fixed, do not work, and shortcut creation will crash git-gui if used.
> These are fixed in patches 3 / 4.

As you are removing (ancient) Cygwin specific code that did not work
with modern Cygwin at all in step [2/4], it is not so unexpected
that some stuff does still not work after that step.  I am not sure
what your reservation exactly is, but if you are wondering if code
to disable browsing and shortcut creation on Cygwin temporarily
needs to be there in the same step (instead of crashing or not
working), it may make sense if and only if it is done with minimal
changes.

Thanks.

