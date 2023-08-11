Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB20C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjHKUic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHKUib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:38:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A697FD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:38:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31FE7266B2;
        Fri, 11 Aug 2023 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BRBgMZU+QVPd4fXF93u9dvyBufr0VQFIKhFo7/
        oSNpY=; b=TElx8C3uLuvT1EZuujgFvM8Ldx3If+xG9WWXEboIOtM8gCQ/JvyzWt
        5iw0oNdTJClHsE3lAfHHWiOwUOLM7xmeEumRuEWtnNVG5RIRCDh+uCwxrwtcD5ju
        pocqebxJqPwwxbGZwg5YmKn9AzdECxL7fp4zNhJGC9801nX3Y/YmY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B6DA266B1;
        Fri, 11 Aug 2023 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CCA3A266B0;
        Fri, 11 Aug 2023 16:38:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Glen Choo <chooglen@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
        <CAHWeT-Zo3nTTGBfJPwNhg50KfLn-GAdpU8WZ96d7fT9_axAQXg@mail.gmail.com>
Date:   Fri, 11 Aug 2023 13:38:24 -0700
In-Reply-To: <CAHWeT-Zo3nTTGBfJPwNhg50KfLn-GAdpU8WZ96d7fT9_axAQXg@mail.gmail.com>
        (Andy Koppe's message of "Fri, 11 Aug 2023 20:04:51 +0100")
Message-ID: <xmqqv8dlqpq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0577BC58-3887-11EE-88F5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> There are a number of uses of designated initializers already, so
> hopefully compound literals aren't too much of an extra challenge.

I do not see how one leads to the other here.  I'd prefer not to see
use of a new construct we do not currently use mixed in a new code,
even if it is mentioned in the proposed log message.

If we want to use compound literals in our codebase in the longer
term, we should first add a weatherballoon use to a very stable part
of the codebase that rarely changes, in a single patch that is
trivial to revert when a platform that matters is found to have
problem with the language construct, just like what we did when we
adopted the use of designated initializers.

Thanks.

