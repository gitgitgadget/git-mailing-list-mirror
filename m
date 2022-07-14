Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44681C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 22:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiGNWsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNWsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 18:48:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02357BED
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:48:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CCFF197968;
        Thu, 14 Jul 2022 18:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DN44HTBwhEyRQ22keYqdgDgSU8JI6GxLcYaI5F
        sCfOM=; b=vjdb4dYuhEwdW/LbSCxBotLCGjgsx4EOxoIdUj1t2LfE6m4VO+k1nK
        CY2s9BEOeThNx1/2uzwLgESdVkbFVil1+qJlRDlfiLlHvCiu+RK2uSHW5m2g0G0H
        8Xa5/l8YF4p2dJ/bgp5nDFbncuQpZKSzabVQEOlU9qBabFwsPfkzg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 055DA197965;
        Thu, 14 Jul 2022 18:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A6208197964;
        Thu, 14 Jul 2022 18:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v4] commit-graph: pass repo_settings instead of repository
References: <Yjt6mLIfw0V3aVTO@nand.local>
        <fd70b6119153b165a62ee4f693dbe47031cfb2be.1657834657.git.steadmon@google.com>
Date:   Thu, 14 Jul 2022 15:48:30 -0700
In-Reply-To: <fd70b6119153b165a62ee4f693dbe47031cfb2be.1657834657.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 14 Jul 2022 14:43:06 -0700")
Message-ID: <xmqqtu7j2tvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15C4E5FE-03C7-11ED-8CAC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> From: Taylor Blau <me@ttaylorr.com>
>
> The parse_commit_graph() function takes a 'struct repository *' pointer,
> but it only ever accesses config settings (either directly or through
> the .settings field of the repo struct). Move all relevant config
> settings into the repo_settings struct, and update parse_commit_graph()
> and its existing callers so that it takes 'struct repo_settings *'
> instead.

Sounds good.  Will queue.

I think this is ready to be merged down to 'next' by now?

Thanks.
