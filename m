Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03EC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD064E3F
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhBBRKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:10:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50101 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbhBBRCL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:02:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE44C10F5DE;
        Tue,  2 Feb 2021 12:01:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z6jZS0+gHukCr2sg/DHINrMDF98=; b=gXuTKX
        HJFYyxMOzdu/EdQAOqwv2wBtcp9iXuUs72IwFMAkkbqxP6oqlgs/gUYOoSJQwvWS
        WqUoQKoV2SqcskogKFWY6U6doihU3qaGkOQ0qL0L/3nh0E8bQRTyTsJ1DV8gbfVy
        lRisNCS7gGUHSYJA2c8OIt6TBzefIRMeIROuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H9bPwGIPUxeXPRRIuqUP1hCGXSKGKW+H
        jRFhTGYIRbCtAcdmfWepECeIhskpSnAcHtFcLhjCvBVVYwXAvZUVgmFY3jkEHqQ4
        waLnGPJ+bxcG7Ak6gsBDCdBKzOseLFdCP4Zfm0EX6aqwO/yLtTVnvmWQhSLWzTk3
        /ThT6aDvWZs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6F3C10F5DB;
        Tue,  2 Feb 2021 12:01:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 253C810F5D9;
        Tue,  2 Feb 2021 12:01:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
        <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
        <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
        <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
Date:   Tue, 02 Feb 2021 09:01:17 -0800
In-Reply-To: <YBkUJP2u4NcldpOp@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 2 Feb 2021 03:58:12 -0500")
Message-ID: <xmqqzh0mh09u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44EB11EE-6578-11EB-824F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 02, 2021 at 04:31:59PM +0800, Hongyi Zhao wrote:
>
>> On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > You can,  on _your_ end, filter incoming messages that are sent via
>> > vger.kernel.org and do not have your address on To or Cc.
>> 
>> I'm not sure if this can be done by Gmail.
>
> If you only care about topics that you have participated in, the easiest
> thing is to simply unsubscribe from the list. The usual convention on
> this list is to keep recipients in the to/cc fields intact, so you'll
> continue to receive those emails directly from their senders.

Ahh, yes, that is indeed the right answer for this list, as we
accept and respond to messages from non-subscribers, and the
convention is to Cc everybody involved by default.

Thanks.
