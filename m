Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A7C20133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbdCCVi3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:38:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59240 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752056AbdCCVi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:38:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2090D665C2;
        Fri,  3 Mar 2017 16:35:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4LMpt10E0NUhdAdWsnO/cjbjxOw=; b=BjDVvZ
        0M4fpE+1CXwvwTl44oGBHap4uJzNhkPacUEOpO/8fG2dqWBb+VYSKFtCofwuudFT
        OXXlK3zhIsVm9ns8cH6KGlJxyrbb1Y6VGNdRJOc7MFsPEAdFkRBZ+ouzGu9EnwPr
        YA/wIQSocjw+mKOFn70W/PC8GPrCvtvkrdV3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ki78jJXOcu9blHuraBhB9Otn9kiuTTvZ
        dP3VNJzNylTAkS5r69gNR2FXsHRfX5825X4g0F2+Ws6YQqvGv1zCd6A1HRaviis0
        727mRa1We5CGMryEDfRNyV7soX72y2wcj0ZlDFJosT6LNQwEeaThLEJxuOYfWAjD
        F7To9KdziCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F05665C1;
        Fri,  3 Mar 2017 16:35:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 620C8665C0;
        Fri,  3 Mar 2017 16:35:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
        <cover.1488562287.git.johannes.schindelin@gmx.de>
Date:   Fri, 03 Mar 2017 13:35:41 -0800
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 3 Mar 2017 18:31:55 +0100 (CET)")
Message-ID: <xmqqpohy6o2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A3D3A00-0059-11E7-81FA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Notable notes:
>
> - In contrast to earlier versions, I no longer special-case init and
>   clone. Peff pointed out that this adds technical debt, and that we can
>   actually argue (for consistency's sake) that early config reads the
>   current repository config (if any) even for init and clone.
>
> - The read_early_config() function does not cache Git directory
>   discovery nor read values. If needed, this can be implemented later,
>   in a separate patch series.
>
> - The alias handling in git.c could possibly benefit from this work, but
>   again, this is a separate topic from the current patch series.

As Peff said in his review, I too find the result of this series a
more pleasant read than than original.

2/9 and corresponding 4/9 triggers "ERROR: trailing statements
should be on next line" from ../linux/scripts/checkpatch.pl because
of a line inherited from the original; I'll queue them with an
obvious style fix to work it around.

Thanks.
