Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344FB2021E
	for <e@80x24.org>; Sun, 13 Nov 2016 01:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbcKMBN3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 20:13:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932127AbcKMBN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 20:13:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14A2F4E3DB;
        Sat, 12 Nov 2016 20:13:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A7EtJ/zzpmE6CNCXC8EpjVz8mN4=; b=HoH/vg
        1cR4GB4cnb+4v7m7HT9+Jw1utC+8k9s5aiC4bL7lGUY9u/wmLfTuE91Dbaapfr4H
        sImzEDQG2pYe2+YKQuhMXsdJSsgLvdhkVxx8LoCk2NeTs1ZN4TLNDVMYbY+kbS65
        08qbJSjhel717tvcDmfhSU+WxEQk5FzROirN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X3X4jj7+Zlt7ftpJUAe+0udI6OUgcXJV
        2kDYaY3Fv2tNho737cV4k0txVTKxqzRSGthD23eIVSFJ04osSZ7IyA/hbmZeVaGU
        ged78jk5NWz7TVa3GI7EzqWItOu6fZD+hsYiwGRFPYrgxv3StYhmMuV3qMTlvZBa
        bSZ3WJNveEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED38D4E3DA;
        Sat, 12 Nov 2016 20:13:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C52E4E3D8;
        Sat, 12 Nov 2016 20:13:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variables
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
        <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
        <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
        <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
        <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611121237230.3746@virtualbox>
Date:   Sat, 12 Nov 2016 17:13:25 -0800
In-Reply-To: <alpine.DEB.2.20.1611121237230.3746@virtualbox> (Johannes
        Schindelin's message of "Sat, 12 Nov 2016 12:40:14 +0100 (CET)")
Message-ID: <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6115D5CA-A93E-11E6-B9D8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Thanks.  Dscho, does this fix both of these issues to you?
>
> Apparently it does because the CI jobs for `master` and for `next` pass.

OK, thanks for a quick confirmation.

> The one for `pu` still times out, of course.

Earlier you said 'pu' did even not build, but do we know where this
"still times out" comes from?  As long as I don't merge anything
prematurely, which I need to be careful about, it shouldn't impact
the upcoming release, but we'd need to figure it out before moving
things forward post release.

Thanks.
