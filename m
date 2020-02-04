Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F294C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 23:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127BE21744
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 23:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7M438pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBDXoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:44:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58872 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgBDXoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 18:44:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833B853AE4;
        Tue,  4 Feb 2020 18:44:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVJFhn512vKoNVsXWOyIjE6rxnc=; b=O7M438
        pI2ssaaWdahuVqnqpnZYFoMJGdA0UONDIj8ufMNPbaLnFcNd20MO5QetycEULpHn
        aiSU6zCEPZJzNfgsV8pos8+TsFGM4rbDWEWTGzrerIaPXrtXSZ6HeiTI67Mp3guS
        Ts+kKQzdmdwvq0nUbVOJfYJUm4VzeVBkMnjzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EcpGXf7fLyVreJv+oc9TPWAtYQhQAux/
        U68/TVrE6stIDgRXRG6A1q07tdDM3iRc1oVZRp/QqmNFzN7Ap5Rw/2cIXuYdGOrp
        CQmhfjcD1QxmfJ/D3Fi2fCkjHQU+LZsnP9bM75LSncLp/FJo3yFPu7ouiJrzA1S4
        WQ12kNd3/6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F0F653AE3;
        Tue,  4 Feb 2020 18:44:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8594253AE2;
        Tue,  4 Feb 2020 18:44:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
References: <cover.1580430057.git.me@ttaylorr.com>
Date:   Tue, 04 Feb 2020 15:44:04 -0800
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com> (Taylor Blau's message of
        "Thu, 30 Jan 2020 16:28:14 -0800")
Message-ID: <xmqq5zgl7waj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AD9DDD2-47A8-11EA-8A9F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the topoic this depends on has been updated, I tried to rebase
this on top, but I am seeing segfaults in tests.  We'd probably need
a fresh round of this one to replace it.

Thanks.

