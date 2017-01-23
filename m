Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1752D20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbdAWS1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:27:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWS1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:27:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78CED61ECA;
        Mon, 23 Jan 2017 13:27:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E2K036SzjxrfTdC4Fchc8Lo7/oo=; b=GgzbMO
        jeQEkwGZ/8nsEEqPoXgxebL6nAziiSqRqrMs6NpGJ5tj04kJYHmbTNTQyxrbjl3Q
        Pi0G06UInjF+mkAJeWxIwZMpu55bGnJFWtuG8Tr+7WhtnY5FQ4Yb8KQnft+h5u0j
        o5V66AeEg2fLDJtdcZaIbqrBUb51rIj/qnr64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlJzZjb79iHuNllasgXtPD3A3PKOlBKo
        AcecFdHlnk6HvoPFO8Mj05htVujRL3P3hv3ODN3zTFXy8GW5EJsi9ucA2IizU0pk
        k2N9k4PZkv6PVbaLsvw9cIAfGrV5TY2sH0Y5qFcF2hSVJhItWa8GWT+2kpWvMIBH
        4S/IOgTugfQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FBF061EC9;
        Mon, 23 Jan 2017 13:27:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B213261EC8;
        Mon, 23 Jan 2017 13:27:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] stash: introduce push verb
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170121200804.19009-3-t.gummerer@gmail.com>
Date:   Mon, 23 Jan 2017 10:27:45 -0800
In-Reply-To: <20170121200804.19009-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 21 Jan 2017 20:08:03 +0000")
Message-ID: <xmqqziihskbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A358A604-E199-11E6-9B37-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +	stash_msg="$*"
> +
> +	if test -z stash_msg

A dollar-sign is missing here, I think.

> +	then
> +		push_stash $push_options
> +	else
> +		push_stash $push_options -m "$stash_msg"
> +	fi
> +}
