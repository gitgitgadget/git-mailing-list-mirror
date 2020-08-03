Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E076EC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB41520A8B
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gdsgUY3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHCROs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:14:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64882 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHCROs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:14:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1AB177A6C;
        Mon,  3 Aug 2020 13:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qBI+Oe/RUMIVQROHsVUBINcD8cg=; b=gdsgUY
        3+ITEylGQPavW/+DKi90lEzNB4aKb15F4inBziBvdAlt3J2dTPDPZpHecajqu4/9
        BnI/Dt43ATVOs37tBIWFEtCHHMRJhGiIvt8cYIMr18jELkjNClUQ/VQgzrrB9yFe
        kzr2xs4GDuF/b+7+eoqflBBHHz49kYA6T5huY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vyTCz/0YqsKwpwaI+2imTnD5rQo6mQSE
        /+YEsEc4z4zbgJpoUzSyKnU4+jx4g8TGRYzaVz4z6oNBdmQckJYDe6L6TE2ncKja
        bjKE6Pajn/2Y9+rhHpq3K5miwWc5vX8Q3Olk7htI4axDAHmDZtdb9LLnhoaYztji
        fA/k9ddvHpA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C706D77A6B;
        Mon,  3 Aug 2020 13:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 384D877A69;
        Mon,  3 Aug 2020 13:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git-worktree documentation cleanups
References: <20200803053612.50095-1-sunshine@sunshineco.com>
        <20200803161102.GB50799@syl.lan>
Date:   Mon, 03 Aug 2020 10:14:44 -0700
In-Reply-To: <20200803161102.GB50799@syl.lan> (Taylor Blau's message of "Mon,
        3 Aug 2020 12:11:02 -0400")
Message-ID: <xmqq3653wt17.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3C92254-D5AC-11EA-97C9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Eric,
>
> On Mon, Aug 03, 2020 at 01:36:08AM -0400, Eric Sunshine wrote:
>> This series fixes some problems I ran across in the git-worktree
>> documentation while working on another worktree-related topic. Since
>> these fixes are distinct from that topic, I'm submitting them
>> separately.
>>
>> Eric Sunshine (4):
>>   git-worktree.txt: employ fixed-width typeface consistently
>>   git-worktree.txt: consistently use term "working tree"
>>   git-worktree.txt: fix minor grammatical issues
>>   git-worktree.txt: make start of new sentence more obvious
>>
>>  Documentation/git-worktree.txt | 96 +++++++++++++++++-----------------
>>  1 file changed, 48 insertions(+), 48 deletions(-)
>
> All looks good to me. Thanks.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Yeah, they looked good to me, too.  Thanks, both.
