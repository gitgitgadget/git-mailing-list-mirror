Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C70C202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdJ0BU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:20:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52573 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751305AbdJ0BU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:20:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FAF7AE06E;
        Thu, 26 Oct 2017 21:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c6z/XdY/ZR9+qInuhmYjq4GgkNU=; b=ShM2Xs
        OZCO5pes7ibN0+T3cVbvcudWkF8yt5/DwWNs8rrNBR83QJQoZdSLBs3ylrgWuLmG
        9jmaZlglcqy4k2BkwFW929k54QWeftnF1ns4Ay+XWyX85LDcpnqJQvEXaCYx6ck/
        nM/0ln1ov4JoI50Vi7gFokg238KKKhixn8w2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GcOGiuNlYXElJlxP5djuTpA0Um9CFU8c
        rTKUIZ3sH420UpZZGn/ozSkkJorRLIVjFIbfJIK6/9frk6H3qhrLN4jBHCzJ5xjF
        5EPgRMRHQGZDJkTpyhVwXm1YWbjdIWwArmkfk7uhQGKh22p9iHluWIQMB88uEL2V
        bmlt4qH2MN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0762DAE06D;
        Thu, 26 Oct 2017 21:20:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D2B1AE06A;
        Thu, 26 Oct 2017 21:20:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] dir: allow exclusions from blob in addition to file
References: <20171026180222.39421-1-git@jeffhostetler.com>
        <20171026180222.39421-2-git@jeffhostetler.com>
Date:   Fri, 27 Oct 2017 10:20:24 +0900
In-Reply-To: <20171026180222.39421-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 26 Oct 2017 18:02:22 +0000")
Message-ID: <xmqq8tfxe693.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02B3E092-BAB5-11E7-AA8B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Refactor add_excludes() to separate the reading of the
> exclude file into a buffer and the parsing of the buffer
> into exclude_list items.
>
> Add add_excludes_from_blob_to_list() to allow an exclude
> file be specified with an OID without assuming a local
> worktree or index exists.
>
> Refactor read_skip_worktree_file_from_index() and add
> do_read_blob() to eliminate duplication of preliminary
> processing of blob contents.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

Yeah, with a separate do_read_blob() helper, this one looks a lot
easier to follow, at least to me---as the author, you might find the
earlier one just as easy, I suspect, though ;-)

Thanks.  Will queue.
