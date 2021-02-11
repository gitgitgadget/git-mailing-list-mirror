Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18119C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB06264DCE
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBKS4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:56:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57745 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKS4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 13:56:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E6A211DD82;
        Thu, 11 Feb 2021 13:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d9Yibr0T46xEY0TZlZB7+WusRzg=; b=NEYf1u
        YjJKuNqiXNFBhkYuTSQMRWcuCzqpGaOVmgYEUrGeXd3Fjf+KiwO9Hvu73QDIDaHj
        I/4xk47HPl4LvCRId0OIxC7srjZzrv7QqOz9FwB/kVfo5z02B0inGRpYXBK2jddU
        4DQadoa+/Jui9vhE3kJn/9Mvl5XsRL7p3UHdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eycdPhRaljL7U2ZUvVzFFlvVklpILGDr
        d7O5R2jg64RugpLe6XzJdzS4voXur3YIx0qqqc3VUMvJkHdmfIl3nnUCaFqQRghW
        jR69xGEf1Wlh6/CeDuoSZ56Le3YjVrQmnIqMJdhlDOH1HB6uQCFtJhdwkcXwOs6h
        3q1pOM9rHv8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7792711DD81;
        Thu, 11 Feb 2021 13:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C319711DD80;
        Thu, 11 Feb 2021 13:55:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 0/9] midx: implement a multi-pack reverse index
References: <cover.1612998106.git.me@ttaylorr.com>
        <xmqqlfbvxbrc.fsf@gitster.c.googlers.com>
        <10c76063-f6b9-d88e-cb2e-731dec204bba@gmail.com>
Date:   Thu, 11 Feb 2021 10:55:30 -0800
In-Reply-To: <10c76063-f6b9-d88e-cb2e-731dec204bba@gmail.com> (Derrick
        Stolee's message of "Thu, 11 Feb 2021 13:37:06 -0500")
Message-ID: <xmqqwnvewi1p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B721BB18-6C9A-11EB-9166-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Could you two please look over to see if I made any silly mistakes,
>> when I pushe it out later?
>
> I reproduced your merge and got very similar results. The differences
> that happened between my result and yours are not meaningful in any
> way.
>
> Definitely a very subtle merge, so thank you for doing that!

Resolving this kind of conflict is like a quick quiz in the
classroom to check my understanding of what is happening in all the
topics involved.  It is like solving a puzzle, and I do not dislike
doing it (otherwise I won't be working as a maintainer), but having
a second set of eyes, helping with independent verification, is
always appreciated.

Thanks.
