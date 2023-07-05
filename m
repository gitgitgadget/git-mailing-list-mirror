Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7816CEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGERSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGERSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:18:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B8BA
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:18:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD3AE188C65;
        Wed,  5 Jul 2023 13:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sYsFT/oJxIsRDa649/6n4v2LI43oF3DGzQ4axP
        bJGoM=; b=KnnlxU+0D/Zylu00G2q7VuSQC3AzkxOO6Gs41Mz2WJUgFvwfgOMqxQ
        q1iIrTPlX1EkJKeoak7IkIvDEoGP4T0FcVMCmDLyZT29DvQYbPFazTSc329okzL/
        btMpxihEvnUIpF2XQUpa06wJmKA8uqvKE93akHMBiClGj9pWysCpk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5880188C63;
        Wed,  5 Jul 2023 13:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 417BC188C61;
        Wed,  5 Jul 2023 13:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] imap-send: some -Wunused-parameter cleanups
References: <20230703063247.GA3524302@coredump.intra.peff.net>
Date:   Wed, 05 Jul 2023 10:18:18 -0700
In-Reply-To: <20230703063247.GA3524302@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Jul 2023 02:32:47 -0400")
Message-ID: <xmqqa5wa2s6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB59666-1B57-11EE-9AAA-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are a few patches where I opted to clean up code rather than
> marking parameters with UNUSED. Plus a bonus cleanup in patch 3 (though
> I am also OK to drop that one;

> I don't care much about the imap-send
> code, and I'd be just as happy if we deprecated and eventually dropped
> the tool).

Thanks---I too was wondering when we can drop 'imap-send' ;-)

>   [1/3]: imap-send: use server conf argument in setup_curl()
>   [2/3]: imap-send: drop unused parameter from imap_cmd_cb callback
>   [3/3]: imap-send: drop unused fields from imap_cmd_cb
>
>  imap-send.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> -Peff
