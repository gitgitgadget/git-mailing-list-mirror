Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234DC27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbjHXP7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbjHXP7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 11:59:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB51BCF
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 08:59:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03B4F221ED;
        Thu, 24 Aug 2023 11:59:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=95rrKHCgwaK+QN6FxVNM9Yf93F+t9VpJlOd6MD
        aMSF8=; b=UGHxiWavKmf6AD04cknsX8hNizi9SJuXKrHeJ4GTCVmdN1RoKX8Jxr
        0yTMde8QJgmpEhUXOMrG5sKPlr4TvelTusLrOToCWbrb7qY1Z/xDegY+K0y0fsmv
        pPSMXW0sbJ+hr6F+1F1Yu6JxYLbI0NxFApTue8/1eFNSRBkfeUXu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F095A221EC;
        Thu, 24 Aug 2023 11:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4808221EB;
        Thu, 24 Aug 2023 11:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <ZNTI6xpXIRaoFlxx@ugly>
        <20230824150046.802008-1-oswald.buddenhagen@gmx.de>
Date:   Thu, 24 Aug 2023 08:59:10 -0700
In-Reply-To: <20230824150046.802008-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 24 Aug 2023 17:00:46 +0200")
Message-ID: <xmqqr0nsbfe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A9DC594-4297-11EE-9DB2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The canonical way to represent "no error hint" is making it NULL, which
> shortcuts the error() call altogether. This fixes the output by removing
> the line which said just "error:", which would appear when the worktree
> is dirtied while editing the initial rebase todo file.
> ...
> v4:
> - fixed reproduction instructions

Nice.  Will queue and mark it for 'next'.  Thanks.
