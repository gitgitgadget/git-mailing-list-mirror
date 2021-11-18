Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F7E61AA5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhKRXyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:54:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhKRXya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:54:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CF85168B66;
        Thu, 18 Nov 2021 18:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yx91Sp7C6ZPT+JEyXNeFWmH1fVe5ao17uI9djcdJ3FA=; b=imG2
        aglcDVIHYgsSXPRhOVbrC0phKWJ794RZefCLvJMfUPgLuoFgdhrPVpc8Ma71yroa
        kswfP/sfy7ZTKokWTMZZbA7BCNx7NwD87GIvjcHKyg5Qo/BQqirbezOV19QKoh9e
        TVzg4nM5i7FijCgt+NdcSus2a7jpVb9xGX3mWJA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04257168B65;
        Thu, 18 Nov 2021 18:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4DFB2168B64;
        Thu, 18 Nov 2021 18:51:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Yvon <samuelyvon9@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v2] builtin-commit: re-read file index before run_status
References: <xmqqpmr5nekx.fsf@gitster.g>
        <20211117164842.36381-1-samuelyvon9@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 18 Nov 2021 15:51:26 -0800
Message-ID: <xmqqv90pt43l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71E90A44-48CA-11EC-A8B3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Yvon <samuelyvon9@gmail.com> writes:

>> And if this change also affects the "committable" assignment in a
>> consistent way, it should probably want to be mentioned in this
>> paragraph, too.
>
> What do you mean by "commitable assignment"? 

Assignment to the committable variable in the codepath you are
looking at, was what I meant.

