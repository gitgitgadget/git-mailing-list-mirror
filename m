Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA4C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D6720CC7
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bfa2sFq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEFT1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 15:27:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56046 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgEFT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 15:27:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89EC447B37;
        Wed,  6 May 2020 15:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JyG+HVTwIamnjggLqrvABSdMrSM=; b=Bfa2sF
        q6kh6UrobDSTDD0T9fALNc79Ly8/NgnK3FgP4ReYWLNrRZP/qnpjK/0cGslz721j
        bloOzEIWBOS++cxyN2uhYOkJwm684n4gRvGMV3TsspXODBwEq/xcR7lOXkSJ++Gg
        d6Wc4CkCzVR0iFE8/BEldJwl3f2rATNgUTb6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jwVA7ERpFp0p9eaoSJKat5DcNLuOBf0P
        Z1iynafvPDQyy/rC0XPzkMBUf711vPL+KFcBlphkqziCGfSFa9yXH9G681Wa2zzL
        dkPSm4HKLrN58pjZ/gsBLjDfUrnfrSEbxnG58H4o1IafPtw111Nq7BZjsFhXZYGt
        dc5G2sOD1R0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8196D47B35;
        Wed,  6 May 2020 15:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1454047B34;
        Wed,  6 May 2020 15:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] auto-gc: pass --quiet down from am, commit, merge and rebase
References: <20200506094327.GC31637@rillettes>
        <xmqqd07h6kcs.fsf@gitster.c.googlers.com>
        <xmqqpnbg6gfv.fsf_-_@gitster.c.googlers.com>
        <xmqqlfm46g3x.fsf_-_@gitster.c.googlers.com>
Date:   Wed, 06 May 2020 12:27:26 -0700
In-Reply-To: <xmqqlfm46g3x.fsf_-_@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 May 2020 12:03:14 -0700")
Message-ID: <xmqqh7ws6ezl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EA73BA6-8FCF-11EA-AF6E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Teach these commands to do so using the run_gc_auto() helper we
> added earlier.

Heh, what was added was run_auto_gc(), so this patch would not work
well with the previous one.

I'll send out a fixed one sometime later today.
