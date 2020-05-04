Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD8C47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2DC206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S1NTmL+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgEDQcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:32:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbgEDQcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:32:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D2E3BA66E;
        Mon,  4 May 2020 12:32:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2f8FAF5oJqE14Ls40t33EqBYiB8=; b=S1NTmL
        +GjeufZztaO9+kTttU4C34u1xz9bsvSasUHMevP+Usy7URClC8OQwnYZna831w6A
        KqLT/cRCZCam55GVkrPmG02hZD0lECm7AKVsqGYRXiDbtclBu3KVix9PC7dNRI2h
        6iSEazlx1o3QhV9vDbpQtEpOvI6gdX6npf8gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jTYpuXShksdemTVIVtO/McwKpFUVKUPz
        WLmYVTS0dSKdfJONOOhzpB50VmiHTKaGW2g5UZ+zDD5R5Aw5FCcXNAHdowbzBAje
        XEef2swm9rWdPxv1siENiv1qKDg6JKAKywwf77Hv6s5ib3zKiVgGTSCmYKLMQJlP
        QrBCgR9woB0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23E50BA66C;
        Mon,  4 May 2020 12:32:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 673B0BA66B;
        Mon,  4 May 2020 12:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vadim Zeitlin <vz-git@zeitlins.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch: allow running as different users in shared repositories
References: <E1jHGdD-00079b-06@smtp.tt-solutions.com>
        <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
        <E1jUeoi-000205-RT@smtp.tt-solutions.com>
Date:   Mon, 04 May 2020 09:32:44 -0700
In-Reply-To: <E1jUeoi-000205-RT@smtp.tt-solutions.com> (Vadim Zeitlin's
        message of "Sat, 2 May 2020 01:11:36 +0200")
Message-ID: <xmqqr1vzhd8z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2DDDAB6-8E24-11EA-83A4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vadim Zeitlin <vz-git@zeitlins.org> writes:

>  So I'd just like to ask directly, hoping that it's not inappropriate:
> Junio, do I need to do anything to get this patch accepted or am I just
> being too impatient?

I do not even recall seeing the discussion, so you are right to
suspect that it fell thru the cracks, and it is quite appropriate to
ping the thread directly like you did.  Mind resending the patch to
the list, just to make sure nobody else sees any problems with it?

Thanks.
