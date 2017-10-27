Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF4B202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbdJ0BPy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:15:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbdJ0BPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:15:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35476AD148;
        Thu, 26 Oct 2017 21:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6poT8hcR005ZkIJlV0y0PZXyjtI=; b=FigXaf
        XRFjM4KfrjLqM6+uevShrEOqM9njZZxCDF4S81Il2ETn+ddu8C0jdTHODKrQd+1e
        RIcFI/FqWtSoV8ZdPf5kYNbTz0E/HwKIqg/8anf0kSwxcrzMfyePDC/V/l0RwoO4
        O+wYgg6AzHnkhGCoAZz7s+sIm7dz3nRXXWN4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tv2+IOlxjUcHI2sGRZLJ15Sgl4bA335j
        AEzN5IIo2rLHlYFx3spBx0oGbSMgZeod4P+viEtaOnoOHL6bFVOzJ1KsIXoTJ0Qi
        1vBVcJHwKxr8l6ZPYnhjwZT5zDfmRRoFPE+jvPO6OWseNNsyZEwnQt/xhQwZH9rJ
        qv07NtnUHKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DA4FAD147;
        Thu, 26 Oct 2017 21:15:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C2CCAD146;
        Thu, 26 Oct 2017 21:15:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t0000: check whether the shell supports the "local" keyword
References: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
        <CAPig+cTv4YW0m0PLH+UucEHjgQkbCsOunPrkKVDrPQXNkd=GAg@mail.gmail.com>
        <CA+P7+xoCKTaG9kV2T9YUHvagHVzD6v7A=neLzF3Qj1q8Fi0u-w@mail.gmail.com>
Date:   Fri, 27 Oct 2017 10:15:51 +0900
In-Reply-To: <CA+P7+xoCKTaG9kV2T9YUHvagHVzD6v7A=neLzF3Qj1q8Fi0u-w@mail.gmail.com>
        (Jacob Keller's message of "Thu, 26 Oct 2017 01:40:46 -0700")
Message-ID: <xmqqd159e6go.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 600EE486-BAB4-11E7-9EFC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I don't think you're missing anything. I think the idea here is: "do
> any users who actively run the test suite care if we start using
> local". I don't think the goal is to allow use of local in non-test
> suite code. At least, that's not how I interpreted it.
>
> Thus it's fine to be only as part of a test and see if anyone
> complains, since the only people affected would be those which
> actually run the test suite...
>
> Changing our requirement for regular shell scripts we ship seems a lot
> trickier to gauge.

Yup, that matches my expectations for what we would gain out of this
change.

