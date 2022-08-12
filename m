Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC27C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiHLUn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiHLUn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:43:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD28F96D
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:43:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 034061B2057;
        Fri, 12 Aug 2022 16:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=abuw6x3j33Rjd3OnbsDOhon9dm0t9ewIEoxBU0
        hfEmo=; b=O2zawyeiYBClVW8bvI7A3/MjNSKi4HkeH2LOVRgkIP1BrT+OzQiB4e
        VAES/tSootdQL20nEMU2dS8Tt8PPg+YkvQIfU+sYJhnklVg1MnEIdwQfYNbBd8Sa
        1wLV0IAFiq5nq0hj+n+qApMuxZ2xxEoIR0y4ZkDn+oJCgr8VFIfNc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F041F1B2055;
        Fri, 12 Aug 2022 16:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97D3C1B2054;
        Fri, 12 Aug 2022 16:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
        <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com>
Date:   Fri, 12 Aug 2022 13:43:21 -0700
In-Reply-To: <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com> (Phillip Wood's
        message of "Fri, 12 Aug 2022 20:21:04 +0100")
Message-ID: <xmqqy1vt9ora.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68002EA4-1A7F-11ED-8C26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Removing the N_() stops these strings from being extracted for
> translation, but there are several callers left that are still using
> _() to get the (now non-existent) translated string. I only had a
> quick look but I think we should remove the _() from all the callers
> of action_name().

Thanks, that's all correct.
