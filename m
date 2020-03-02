Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2B4C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DCF21D56
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CjKU75By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCBQrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:47:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58811 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgCBQrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 11:47:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A8E8BD459;
        Mon,  2 Mar 2020 11:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K6bi9f2tQxH8gnOC14GuX7cqgTs=; b=CjKU75
        ByFM+197cD0NaLNJ0eWeIQ0R61PWqzBPWond++rVCoPE766QTXsXQQ1aIaIeHijp
        3TlgBNLUC1bYveI30cXgEIFpfIlB/GqpBuqrDUTlXXO+wkqAVbQAg0uBU2FXYkqk
        iK5UsJVuNljAzy+uB/37XRt8+mCZuimvymqUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k/ahwKrZ0E5NrAanlrhUrh5BcZfUJDR+
        bJMvpJISje6kBr33NqyhBOWp9w0FlI2mIQ7nu3srGTi6mnVCgxKoy1VLfylCv68Q
        agkxYJiu6lznpemXtdngV7KwzNzAKyoDefCQVIUJjSKuJgPfUQbQC9IRNKTpw6v1
        LM53pIIyPGA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23494BD458;
        Mon,  2 Mar 2020 11:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41962BD456;
        Mon,  2 Mar 2020 11:47:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #06; Fri, 28)
References: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
        <CAPig+cSZvVWbzKp6uEmPxZVgUQdzwgjjfz81PJRYdG+OQ__kdw@mail.gmail.com>
Date:   Mon, 02 Mar 2020 08:47:02 -0800
In-Reply-To: <CAPig+cSZvVWbzKp6uEmPxZVgUQdzwgjjfz81PJRYdG+OQ__kdw@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 29 Feb 2020 20:16:00 -0500")
Message-ID: <xmqqo8tebt6h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 722854FA-5CA5-11EA-B466-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Feb 28, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
> ...
> This description still has the problem with inserted text splitting
> the "y" off "directory". Did we want to go with the revised
> description suggested by [1]?
>
>     In rare cases "git worktree add <path>" could think that <path>
>     was already a registered worktree even when it wasn't and refuse
>     to add the new worktree. This has been corrected.

Nice.  Thanks.

These three-line summaries by topic authors are very much
appreciated.
