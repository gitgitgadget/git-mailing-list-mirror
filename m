Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661AF202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 00:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdJXA7l (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 20:59:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdJXA7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 20:59:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D24295310;
        Mon, 23 Oct 2017 20:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dNU+odeVua6yQDf+FosqX/ftoUw=; b=Wy7GN0
        NQqyvglc32Kax4C2uSkh8CELnezBDmkDrMBsd9ZtwJk5dDtqidHpandlzDVLWFYo
        0YRPT64XSX0RPepSTdCsLftt/FVeAI1DBWrP2Jw+uHcVZnvfaPAdp6W8MNiQDtVO
        7D19fmtQNV1BlEqPV7sKEHcwkI4nv/eLKdRBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cv0NZjUG7jJVMzIQkqHS/SCv8EyD/3lF
        BPuythlIaY3LkF1+iPNd9aWSQcB/5pLDdT5VKpltWGNGrJWFaEhMcsew3wz3G/W0
        oujqmt5kWhgEHT2ToAy5PUbtjwuzd6JsPz8apljsAjHlBSMF1EvGdh/VPq7JTkvT
        yhxiW0EV9DA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3582A9530E;
        Mon, 23 Oct 2017 20:59:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 966439530D;
        Mon, 23 Oct 2017 20:59:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     <christian.couder@gmail.com>, <git@vger.kernel.org>,
        <peff@peff.net>, <sbeller@google.com>, <thais.dinizbraz@gmail.com>
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqfuadgtcu.fsf@gitster.mtv.corp.google.com>
        <20171023114449.11902-1-marius.paliga@gmail.com>
Date:   Tue, 24 Oct 2017 09:59:38 +0900
In-Reply-To: <20171023114449.11902-1-marius.paliga@gmail.com> (Marius Paliga's
        message of "Mon, 23 Oct 2017 13:44:49 +0200")
Message-ID: <xmqq3769bbt1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CE380C0-B856-11E7-8CDD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> Push options need to be given explicitly, via the command line as "git
> push --push-option <option>".  Add the config option push.pushOption,
> which is a multi-valued option, containing push options that are sent
> by default.
>
> When push options are set in the lower-priority configulation file
> (e.g. /etc/gitconfig, or $HOME/.gitconfig), they can be unset later in
> the more specific repository config by the empty string.
>
> Add tests and update documentation as well.
>
> Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
> ---

Looks good.

> +This is a multi-valued variable, and an empty value can be used in a
> +higher priority cofiguration file (e.g. `.git/config` in a

s/cofig/config/; I think you inherited from me, sorry.

I'll tweak it while queuing; there is not need to resend only to fix
this.

Thanks.
