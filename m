Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF9C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF51920838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nURJxBmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLTXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:23:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60993 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:23:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7F12D2E2D;
        Wed, 12 Aug 2020 15:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sPOa94SXwadejkkYVk+8Io+0Hkg=; b=nURJxB
        mr1bQLhMrZxYfJa/UqUrg+jSHkdeErqj70G7tkxUBxWhPMC8PHugeEJgWlcXmu9/
        9fTa5Th/tFolpy0rR3Le3ktJVRorLMc4GD4w/Sn3UwRJZt5AFZRRthX7BRvaDOl6
        dN3HGPqI1pyaJVnb0AHfogBZluyLb+XCVbbCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fAxIAspeVFe0+D2yizQDsxn+7QQk2/oK
        y6Kuw54buOFdazCc5oNyCNSuASQo8hZnKtztw3YdLK5GshZ0hYFwcdLeJuVYTpzG
        GnivtZdIlyW97fJBQIrrlu8YGA2uAAsbzwVtfO6o3mwm9aSiZFl9Zq7L77+1Ik8J
        sm+4MPNzsQo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0D4DD2E2B;
        Wed, 12 Aug 2020 15:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06065D2E2A;
        Wed, 12 Aug 2020 15:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] git-apply.txt: correct description of --cached
References: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
        <20200810110338.52203-1-ray@ameretat.dev>
        <xmqqeeoecw4e.fsf@gitster.c.googlers.com>
        <02911541-7349-38f5-bdca-9ba6b9100676@gmail.com>
Date:   Wed, 12 Aug 2020 12:23:01 -0700
In-Reply-To: <02911541-7349-38f5-bdca-9ba6b9100676@gmail.com> (Phillip Wood's
        message of "Wed, 12 Aug 2020 14:32:10 +0100")
Message-ID: <xmqqzh6z654a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DBE80CA-DCD1-11EA-84E3-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>  --index::
>> -	When `--check` is in effect, or when applying the patch
>> -	(which is the default when none of the options that
>> -	disables it is in effect), make sure the patch is
>> -	applicable to what the current index file records.  If
>> -	the file to be patched in the working tree is not
>> -	up to date, it is flagged as an error.  This flag also
>> -	causes the index file to be updated.
>> +	Apply the patch to both the contents in the index and in the
>> +	working tree.  It is an error if the patched file in the
>> +	working tree is not up to date.
>
> I wonder if it would be clearer to say "This option requires the index
> entry for the patched file to match the working tree".

Perhaps.  But "the index entry to match the working tree" leaves the
definition of what is to "match" open to interpretation, so it may
need to be further tightened.

In the olden days, everybody knew "up to date", used to describe the
state of a file in the working tree, is a technical term with a
specific meaning (i.e. the contents has not changed since it was
added to the index, and also cached stat information in the index is
fresh), and that is why the original description used that wording.
But I agree that we should be able to express this without resorting
to a term of art.

    An error is raised if the file in the working tree being patched
    has contents different from what is registered in the index.

captures most of it, but still misses the "cached stat information
also must match" part.
