Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A9C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC66561968
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhCSP5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:57:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62664 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhCSP5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:57:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8D7D12A4CF;
        Fri, 19 Mar 2021 11:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ir4SEwDTguIFZUPvwfi0srhqAnc=; b=wjE/iQ
        SD+mOjnrQLWdjDl7NrCdm3vTGF5VBsqH8hdtEjAyQeFh3E/iGCeF1lbtlXMrS+T9
        g2+tb04d3QRVQVJo6wxpdwIvMxxDIdrzpATD7fNOLTNtOs3wxw5H4mPEabtVBvOB
        WB+EMGcYF22nzvGsTstKt4mdh18ZC0pLZGzjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mzI9C3zIpvUaMyJCobuR1+a6lq0wOJIb
        PEPJ3yBESS12cqt7bKTZfHZAy69lfmnrFGwifvP4PHoF/Raw+Rfp0UGooNVdv36W
        p8UnmCYXA1MnsYaVXuOO75S1b4rZMV6XS4j+y9OzMnswHKJ2u71lFECiTrc/ryID
        W6Rgb5s6jLE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1B8512A4CE;
        Fri, 19 Mar 2021 11:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAF4D12A4CD;
        Fri, 19 Mar 2021 11:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 0/3] git-completion.bash: improvements to
 _git_stash()
References: <cover.1615855962.git.liu.denton@gmail.com>
        <cover.1616060793.git.liu.denton@gmail.com>
        <xmqqv99oqg39.fsf@gitster.g> <YFRcLpfRNQbqpHoo@generichostname>
Date:   Fri, 19 Mar 2021 08:57:02 -0700
In-Reply-To: <YFRcLpfRNQbqpHoo@generichostname> (Denton Liu's message of "Fri,
        19 Mar 2021 01:09:18 -0700")
Message-ID: <xmqqtup7nnld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF98AA52-88CB-11EB-BC7A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In any case, unless you have any other concerns, I would declare
> 'dl/stash-show-untracked' ready for 'master'.

I've read dl/stash-show-untracked a few times already and agree that
it would be OK after the "fixes" graduate for 'master' and also for
2.31.x maintenance track at the same time.

It would be nicer if we just rebuild on top, perhaps making the "use
__gitcomp_builtin" as the first of these "improvements" patches.

Thanks.
