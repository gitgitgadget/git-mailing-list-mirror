Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3522EC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiCBHnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiCBHno (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 02:43:44 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6175DE5F
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 23:43:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BE6017AECC;
        Wed,  2 Mar 2022 02:43:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6kvPByXXnJvbHvsKJiggKsQxn+GxwaDYB4pzJh
        jcohc=; b=N6Z8tIly/VF2bcG9ESUAGTb0rxv2fTwhW6+GsrfGLu+wVWn47ruG/g
        oVJgaTGP9q+CbaKEsMgFfMXAnV4wTzW7O5UlTlOj66w1+hP3v1yodETo9uogsbC3
        o12CLsbzYEDW6jxXKec+EqmlIDc4kOeZCpGSBKcqmkNyfr0cNVTns=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54CBE17AECB;
        Wed,  2 Mar 2022 02:43:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C676417AEC7;
        Wed,  2 Mar 2022 02:42:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v2 11/17] builtin/pack-objects.c: --cruft with expiration
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1646182671.git.me@ttaylorr.com>
        <d68ce281324097e10e4c1921d84c577bed6943e7.1646182671.git.me@ttaylorr.com>
Date:   Tue, 01 Mar 2022 23:42:57 -0800
In-Reply-To: <d68ce281324097e10e4c1921d84c577bed6943e7.1646182671.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 1 Mar 2022 19:58:24 -0500")
Message-ID: <xmqqwnhcn6ke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61808032-99FC-11EC-A223-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  builtin/pack-objects.c        |  84 +++++++++++++++++++-
>  t/t5328-pack-objects-cruft.sh | 143 ++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+), 1 deletion(-)

I'd renumber this to 5329, as the latest iteration of generation
number v2 series took 5328, while queuing.


