Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C701FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 03:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbcKVDmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 22:42:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755134AbcKVDmb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 22:42:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B6BC518BA;
        Mon, 21 Nov 2016 22:42:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qimqWZivsTVIz98YzuieKA6KB0k=; b=Rw2UGc
        a0MlAoewgtyDQ3ieqctQApwQ3keyczsj6ENNmhqFEaiZPnHz0GAaFF30DR6f08Lp
        2o9F1NyS3Hf3sokvjcgQkwqPChSEpzUVIqXQ0LPQ1tGOH+oDno81PA5liiQm/s3N
        QWyS88V4UzNyKPMMJBqIAPQp13JmhyH/RQquI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OSWMD36F/Tujer/IYLwy3CwzjiXMLK83
        fSxfxsI9mqdy67J1ffgyj8JcTFr66tEsZL/P9Flvn9QXYa0mFt13CtS5pBxwDWkY
        cVfBjQ9rN3XxLt1MgJcFvD4ZNevG3uW1g6EWpXLKDfiHWnZW2o/IV7k2lN6uPcEs
        1nJIHedWcno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13995518B9;
        Mon, 21 Nov 2016 22:42:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A99B518B8;
        Mon, 21 Nov 2016 22:42:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCHv3 3/3] submodule-config: clarify parsing of null_sha1 element
References: <20161122013550.1800-1-sbeller@google.com>
        <20161122013550.1800-4-sbeller@google.com>
Date:   Mon, 21 Nov 2016 19:42:28 -0800
In-Reply-To: <20161122013550.1800-4-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 17:35:50 -0800")
Message-ID: <xmqqziksfae3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B166D564-B065-11E6-B127-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +Whenever a submodule configuration is parsed in `parse_submodule_config_option`
> +via e.g. `gitmodules_config()`, it will be overwrite the null_sha1 entry.

It will overwrite?  It will be overwritten?  I guess it is the latter?

> +So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
> +with the repository configuration, the null_sha1 entry contains the local
> +configuration of a submodule (e.g. consolidated values from local git
>  configuration and the .gitmodules file in the worktree).
>  
>  For an example usage see test-submodule-config.c.
