Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8D6C47423
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F0E207C4
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m8Vd7vTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgIYUdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57205 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgIYUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:21:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DB5D9B517;
        Fri, 25 Sep 2020 16:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsCxrrfGAgsqxPCZC+tN1X5DTnw=; b=m8Vd7v
        TpkbZwTLEzn9B87XX4iLPHH1NbY0OFXbLVsX9Mfd1BvOxUCvwyL2p8ZcwfjfKzjX
        YNgvvqTzYtxIKq99dCdR0cEwFQ0HuY8E5rSU/cmVCI4rGpsyBJZPaHode1/8/nwN
        1vlqQS4UomhZsfYjrbCTj9kSP+hSY9RMRQZyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oUB8dq8ixqz7icq2+mpAIFFxaaEXhliU
        +h96v6IYxOj3Ezw/ohwh8wNqI9YwEHOD8UFW8lop7cbaWZ9MRpASDW5p/QRASodM
        YxL2qI4xKffoGzm6KzJJ/sylUPqnL2BHOX9MgfS5swC2pkS6uFSS+vCRi34BcEfJ
        R5dg5MVYjZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 618209B516;
        Fri, 25 Sep 2020 16:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE0AD9B514;
        Fri, 25 Sep 2020 16:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     shubham verma <shubhunic@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 07/11] t7001: use ': >' rather than 'touch'
References: <20200925170256.11490-1-shubhunic@gmail.com>
        <20200925170256.11490-8-shubhunic@gmail.com>
        <CAPig+cTwQCSA1sjAWyDC5ZydT6NKzOY9ziLUJcOVMRV4cP_sAQ@mail.gmail.com>
Date:   Fri, 25 Sep 2020 13:21:39 -0700
In-Reply-To: <CAPig+cTwQCSA1sjAWyDC5ZydT6NKzOY9ziLUJcOVMRV4cP_sAQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 25 Sep 2020 14:57:40 -0400")
Message-ID: <xmqqv9g1k3os.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8127A4E-FF6C-11EA-ABBF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> In patch [5/11] you dropped whitespace following the redirection
> operator, however, this patch introduces several new cases of unwanted
> whitespace.
>
> Checking "master", I see that there are 209 instances of `: >` in
> tests, but 1023 instances of `>`, which suggests that we should stick
> with plain `>` rather than `: >` in this patch.

Agreed on both points.  Thanks for a careful review.

