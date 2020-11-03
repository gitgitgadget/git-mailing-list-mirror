Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBFEC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29C32224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhqC9z/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgKCBCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:02:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60489 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:02:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 174BEE40AC;
        Mon,  2 Nov 2020 20:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iU/yGiyrFMEv2qvU1EOGRIuWZdE=; b=jhqC9z
        /xLijpMOXZxQx5Kychjglar57F1LWjOyxjaSg6dZGrmI+k/pAHxCh4G1z5X1n6Pk
        8CcrfgZcPhrQ3uM5E+X12oyJBG6XoMgDKVC37Hi0QRQ+pbx75MGA0YIWVTXTXUfR
        cDnZqBDxIhLHqjhmL/Gpq9wU0ObkjSny7A4Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p+xxDHPWgiD2AjjUK20f6mIdY+Ia0Mi7
        u4yNDdCLlwpXzOXK1m+KXqEdIs/GNAklqKc3sfo08ybi2TiA+iuM25hbRDnD0N0x
        /KVp8MrhW/FCpGU8xXyUyhLDgK6/MwqfkoZyGEB5cGiSuKMX7HzXFUxF87mrsccu
        wGRt/Mhhxz8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1186DE40AB;
        Mon,  2 Nov 2020 20:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45FA3E40AA;
        Mon,  2 Nov 2020 20:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Advertise trace2 SID in protocol capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
Date:   Mon, 02 Nov 2020 17:02:40 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com> (Josh Steadmon's
        message of "Mon, 2 Nov 2020 14:30:58 -0800")
Message-ID: <xmqqy2jjp80f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 469A6C1A-1D70-11EB-AFE7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In order to more easily debug remote operations, it is useful to be able
> to inspect both client-side and server-side traces. This series allows
> clients to record the server's trace2 session ID, and vice versa, by
> advertising the SID in a new "trace2-sid" protocol capability.
>
> Changes since V1:
> * Added a public trace2_session_id() function to trace2.{h,c}. Used this
>   in place of tr2_sid_get().
> * Fixed a style issue regarding using NULL rather than 0.

Thanks; will replace.
