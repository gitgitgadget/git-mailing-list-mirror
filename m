Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D690EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 01:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGRBFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGRBFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 21:05:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509795
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 18:05:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92FF31AAF74;
        Mon, 17 Jul 2023 21:05:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UtjxWs/fxHY2UyEmRBPwOAZGfCswFSZPQYbDJz
        hWMr4=; b=rfWkXNDCvO7pZ+HFj3n0D26ZJmsaqKl7ktqm1P1oouQJI7dEpMCeSq
        bQuzv0GmCUvbl6iIjBG8ZD2SnvpDY5PuZGlxXIZMrtjrBv2Ya8cQzXlnXzlwbPKf
        DF1OkJShG2FvQt7e9BJf9yOkc3BlaSHTNt3mn1+yUAZ4XfToeDZOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 896FA1AAF71;
        Mon, 17 Jul 2023 21:05:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECFC71AAF70;
        Mon, 17 Jul 2023 21:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <xmqqmszudtih.fsf@gitster.g>
Date:   Mon, 17 Jul 2023 18:05:48 -0700
In-Reply-To: <xmqqmszudtih.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        17 Jul 2023 16:10:14 -0700")
Message-ID: <xmqq7cqydo5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C30363C-2507-11EE-AFD8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'll stop here. After skimming the changes to the test, I think this
> single patch should be split into separate steps.  Perhaps the split
> should go like this:
> ...
> Thanks.

Oh, sorry that I forgot to add one thing.

Overall, the patch seems to be done very well when viewed as a
whole.  Thanks for working on it.

It is just I cannot be as confident as I would like to be in my
review when the single patch does several different things at once.
If it were split in steps, each step focusing on doing a single
thing well and describing well what it does and why, reviewers can
be more confident that they did not miss something important in the
patch(es).
