Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D2C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DF520C09
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QOAl8sDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgFRSIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:08:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFRSII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 14:08:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FF50D8E06;
        Thu, 18 Jun 2020 14:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhTlvsTbfn1s0oHfTTK7e9t4kv4=; b=QOAl8s
        DsUZrQox4GZx29nNmu0BJmxxEdwWdD0SqcC+rc6Q2+fq0Bd658vUlRnyILwVcU4B
        z8miRClO/cnLWgV14peI0c2HOBamUpRZViDsNVeWV3clF03cXdLyDhi8UgZGhfag
        nTFA/yhORs8mish178ZwIfgZvgGQj9kFJkEw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QXo2D9SDfE1sb1ziumvsgjQ59MNjJCAz
        EQp+9R8sDrPrRfCxcJJrNiL+8hxnMvpGhTSYJ94UvcMVQYiU/rv8NOo1o5AZ4heH
        82mUPHU+XFyE+JrSfJ2Rn2Qkw/Qc7tSclI7ez6Mlk5NabiD37Hxb7hXLxtGlHBZu
        WLlDH+Qy510=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07898D8E05;
        Thu, 18 Jun 2020 14:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51228D8E04;
        Thu, 18 Jun 2020 14:08:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: do not use "slave branch" nomenclature
References: <20200618163843.22181-1-bonzini@gnu.org>
        <20200618164554.GA616157@coredump.intra.peff.net>
Date:   Thu, 18 Jun 2020 11:08:01 -0700
In-Reply-To: <20200618164554.GA616157@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 18 Jun 2020 12:45:54 -0400")
Message-ID: <xmqqwo44nt6m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6FFA078-B18E-11EA-BFFB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 18, 2020 at 06:38:43PM +0200, Paolo Bonzini wrote:
>
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> 
>> Git does not have slave branches and has never had.  Independent
>> of any future change to the naming of branches, remove the sole
>> appearance of the term.
>
> I think this is a sensible change, though note that something simpler
> was proposed recently:
>
>   https://lore.kernel.org/git/20200610165441.iktvzuwz44sbytfg@chatter.i7.local/
>
> and the review suggested using a name that is even more meaningful to
> the test case (so we not just remove the unwanted names, but make the
> test easier to follow).

Thanks for spotting that both versions share the same issue.  We'd
just need a single one that is fixed up ;-).
