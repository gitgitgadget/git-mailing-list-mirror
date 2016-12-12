Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF2A203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbcLLWUr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:20:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753209AbcLLWUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:20:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DEEA5800E;
        Mon, 12 Dec 2016 17:20:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/VZFtL7lE8xr0boOlSXo7tVf/A=; b=lB4c7I
        65TYo0p6WRVagBpZ+vOpcErOd8+ErO7UxCoU+v+Y6Mfwgyfl1Gg6hpdJvIDPgjcW
        dUWycHtvz+Op1930kgzH5ZFIJSwKOgI1Di7uo9PVKNgqmOhngBJcoe4C9aWESi6p
        uhR8ZQOfm0Iv9U00GOvZIJO0j+otljx2WYnNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ERHrbUVmSsKkln9ixk77OTv0+RzrLcuj
        rL9MdEXTq++YeLxUzy2M/jn2e6eu5xgD/8K7AAKV1yKZilLwM2RtdOVDUJ6ABR/k
        Xah1n+XKUueqooaN/aBzhVCCW7VVfasHJjrH5erVfyUfjPqaDuz2lzOstt97+r1P
        mgv3AbkMzWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93B5D5800D;
        Mon, 12 Dec 2016 17:20:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0787F5800C;
        Mon, 12 Dec 2016 17:20:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 2/4] real_path: convert real_path_internal to strbuf_realpath
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-3-git-send-email-bmwill@google.com>
Date:   Mon, 12 Dec 2016 14:20:43 -0800
In-Reply-To: <1481566615-75299-3-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 12 Dec 2016 10:16:53 -0800")
Message-ID: <xmqq8trk94ck.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 391D1744-C0B9-11E6-B4FD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Change the name of real_path_internal to strbuf_realpath.  In addition
> push the static strbuf up to its callers and instead take as a
> parameter a pointer to a strbuf to use for the final result.
>
> This change makes strbuf_realpath reentrant.

Yup, this step makes sense.
