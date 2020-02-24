Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BCC38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7617C21556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="muaWIFye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBXVRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:17:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51234 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:17:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3701D5219D;
        Mon, 24 Feb 2020 16:17:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5E9Hs0EnHSz8qjtMUlt1BEw5Cj8=; b=muaWIF
        yeGGDewW3mkMfGhH2zRatPo+j0JaeZur2Pv7dSGgB0XADgUzJnH+rmMTDF6ac14J
        ciL+ZR3+2olBnAP5GWAWyRLs6o5e+tXXdxUdPy068sB+98l7sm7HNDVPWqkEBw+9
        eso9UlYg+PblNf1BbN9OsSD8lCQqqrKoofl70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hdZAsDBUkeEjZPuYmarJkYG/6NfkamUD
        j3ISeUQwv4yfZgqOELIRl2cyCxvdr9V2ZBKGxh77Cbzykw1tzrVz4ruVwwCnmeZ+
        +SoALMHboo9xq42zPyhXuhuJddTALFSKD4eoIeENEsLDdcF5NHDsnStz3bdS9B6f
        QpAFODaemcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E86E5219C;
        Mon, 24 Feb 2020 16:17:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9428B5219B;
        Mon, 24 Feb 2020 16:17:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [GSoC Patch v3 1/2] lib-log-graph: consolidate test_cmp_graph logic
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200224133814.100150-1-abhishekkumar8222@gmail.com>
Date:   Mon, 24 Feb 2020 13:17:12 -0800
In-Reply-To: <20200224133814.100150-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Mon, 24 Feb 2020 19:08:13 +0530")
Message-ID: <xmqqr1yjofc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06C96E92-574B-11EA-A505-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Changes in v3:
> - Elaborate on first commit message.
> - Fix SP violations in lib-log-graph.
>
> Changes in v2:
> - Arrange patches by functions changed instead of files changed.
> - Rename library functions by prepending 'lib_'.
> - Drop outdated sanitization calls to sed.
> - Create specialized helpers to reduce code noise.
> - Fix style violations.

This round looks quite polished.  I'll queue after massaging the log
message of the first step.

Thanks.
