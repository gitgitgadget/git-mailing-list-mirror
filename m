Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917CBC2BA12
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjIPRpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjIPRpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 13:45:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4FE6
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 10:45:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58F5534B71;
        Sat, 16 Sep 2023 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=H5ykzysW3ZujgWT0tU/W7pX3G9gSez9092HEkf
        T5pn4=; b=kI+SY+uJSfsyl5HdOvxB6kFxD37MxHNwZHspPPwNyo2e0K5X6qvnUE
        TbZnWnFcDAzA2dh1tIIDPs8WlniDiVdMWvcyXutlJi7571qtGelcBYcnMgfzHMKZ
        DawYNQzxM15LNjXM0yUSXCdJ2H/sqDIh8KnXXzaFwZaYbnoY27hEc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D8AD34B70;
        Sat, 16 Sep 2023 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC36634B6C;
        Sat, 16 Sep 2023 13:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Evan Gates <evan.gates@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-config: fix misworded --type=path explanation
In-Reply-To: <20230915202610.21206-1-evan.gates@gmail.com> (Evan Gates's
        message of "Fri, 15 Sep 2023 14:24:59 -0600")
References: <20230915202610.21206-1-evan.gates@gmail.com>
Date:   Sat, 16 Sep 2023 10:45:04 -0700
Message-ID: <xmqqh6nuau73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C588D7BE-54B8-11EE-97C9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Evan Gates <evan.gates@gmail.com> writes:

> When `--type=<type>` was added as a prefered alias for `--<type>`
> the explanation for the path type was reworded.  Whereas the previous
> explanation said "expand a leading `~`" this was changed to "adding a
> leading `~`".  Change "adding" to "expanding" to correctly explain the
> canonicalization.

Nice spotting (and good archaeology, too).

Thanks.
