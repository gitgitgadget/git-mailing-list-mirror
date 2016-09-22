Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A3A1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965855AbcIVTVI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 15:21:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65372 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966027AbcIVTUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 15:20:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F713DB2C;
        Thu, 22 Sep 2016 15:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MNuuA80LXiKS6rLB2elWUa8M8xw=; b=vWU0HB
        tzksgn6A3waMm/LXGAJ/KGPP4SyFjDhY/5ze/Pi772huu3ErVrwp1Xq3EX91vpZi
        hrtsDOiGRmIEswhsoNZXAlaVSd3yhGOuCy3yBFViDJo25OUsVb9YzsRB25cYJC4l
        Hp10cF9whlO+uu8EGKeSftwyKsplDtYZIpuu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cz333h4epqkdspFzeSwKa+YIbjPRrx6G
        JrhfP+34oarkJuU/rwiJc4x2hPVoEpIlirwrAeDVviZYVoHivwC6yhVONcA8dBsi
        E4jr8dV0Giak/dqsAdb+PyjT3mYDN91siJnrSPoK8NEajirbpE70JhREqkkXuA3A
        EzAqhDCj++M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11BCB3DB2B;
        Thu, 22 Sep 2016 15:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79B9B3DB27;
        Thu, 22 Sep 2016 15:20:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] do not reset in_vain on non-novel acks
References: <cover.1474568670.git.jonathantanmy@google.com>
Date:   Thu, 22 Sep 2016 12:20:04 -0700
In-Reply-To: <cover.1474568670.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 22 Sep 2016 11:36:54 -0700")
Message-ID: <xmqqmviz4u8r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91F1AB14-80F9-11E6-8E96-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is regarding the packfile negotiation in fetch-pack. If there is a
> concern that MAX_IN_VAIN would be hit too early (as a consequence of the
> patch below), I'm currently investigating the possibility of improving
> the negotiation ability of the client side further (for example, by
> prioritizing refs or heads instead of merely prioritizing by date in the
> priority queue of objects), but I thought I'd send the patch out first
> anyway to see what others think.
>
> Jonathan Tan (1):
>   fetch-pack: do not reset in_vain on non-novel acks
>
>  fetch-pack.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Just a hint, because you are relatively new to the project.  It
usually is not very productive to have a cover letter to a single
patch.  Your cover letter either ends up being useless, or ends up
costing you time by having to repeat what you write for the patch
anyway (and making others to read it twice).

Below the "---" line of the single patch is often a better place to
tell a backstory of the patch if you need to.
