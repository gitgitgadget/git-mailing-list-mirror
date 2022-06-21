Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B072C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 21:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353918AbiFUVgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiFUVgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 17:36:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C1CE12
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:36:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 106561381B8;
        Tue, 21 Jun 2022 17:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YSPV7PhQSo/ENwjraiGzJERFH4KUNmbpr/jNV7
        y9YKc=; b=nXJdJ2ZVrF1UZ90uwdYQ7iMZpTSZmjT/Loc9k9FtPyKtFkY9BeeBFU
        BHMBpvz5HAsBYGW7SZtCANspfOOR2PH/VIKEMdxhBIAAdBij9QyGfOWQggfxbfsG
        ugXFq1WKBvH9TZtDE2nERyfxtT7R+4+UkF5zM9HlFmDPlx6HR0cTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 080871381B7;
        Tue, 21 Jun 2022 17:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 673AF1381B6;
        Tue, 21 Jun 2022 17:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        Jeff King <peff@peff.net>, avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
        <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
        <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
        <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
        <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
        <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
        <xmqq1qviht4h.fsf@gitster.g> <xmqqy1xpg3th.fsf@gitster.g>
        <dbfbbbd6-70bd-3830-8c87-9f50c346e8ea@github.com>
Date:   Tue, 21 Jun 2022 14:36:36 -0700
In-Reply-To: <dbfbbbd6-70bd-3830-8c87-9f50c346e8ea@github.com> (Derrick
        Stolee's message of "Tue, 21 Jun 2022 17:13:35 -0400")
Message-ID: <xmqqa6a5g0m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC55FA2-F1AA-11EC-8DCE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/21/2022 4:27 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Yup, a solution along that line was what I expected to see from
>>> those who write Perl when I saw the discussion yesterday.
>> 
>> Here is what I queued tentatively.  This is not exactly new;
>> e1790f92 (fetch tests: fetch <url> <spec> as well as fetch
>> [<remote>], 2018-02-09) first appeared in v2.17.0 and we can
>> live with the same glitch for few more weeks ;-)
>
> There are also other tests that need similar updates before
> we consider this topic done.

If we can check with single-quotes and dollar-signs in addition to
at-mark, that would be interesting.

> I recommend updating the authorship to yourself or Peff, since I
> was mostly useless in constructing the actual solution.

Sure.  That's what "tentatively" means.  I didn't do anything (other
than cheering from the sidelines), so...


