Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F28C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiGYR4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiGYR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 13:56:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDE1BCBB
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:56:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED6B61403A0;
        Mon, 25 Jul 2022 13:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YgEZjN/SxvFd
        XXJ8/XlNrVnd9IZG1AIPtejtsl/QdAs=; b=dG2DUrTwRxT/2MWuYhRzH29/C3Jm
        iMls6eipvfFJjdIqzk9fFjfcJmbGoctgHt66SNC4ynDRwWMnWrJIc2NJ6j0czLA3
        BgjX5i3sx8tVqSJw2IS9qzvYAsl8WfcSJQi5rnwPHuuEFXgE9e4jeFgoxML1ctMu
        Tt8ZQp9SlhJBJq8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E438814039F;
        Mon, 25 Jul 2022 13:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AED314039E;
        Mon, 25 Jul 2022 13:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
Date:   Mon, 25 Jul 2022 10:56:45 -0700
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 25 Jul 2022 14:38:37 +0200")
Message-ID: <xmqq5yjl5b4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26562C50-0C43-11ED-A36B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>   - builtin/bisect.c: after the conversion/rename from 'bisect--helper'=
,
>     cmd_bisect() doesn't use parse-options anymore.  Take what's on 'se=
en'
>     to resolve the conflict.
>     Note that the conflicting topic should have marked cmd_bisect() wit=
h
>     the NO_PARSEOPT flag in 'git.c's command list.

I was wondering about this one.  Does the new "subcommand" support
help implementing the dispatching to subcommands better?  If so it
may not be a bad idea to redo the cmd_bisect() on top of this series
once it proves to be solid.

So far, I like everything I saw in this series.  Nicely done.

Thanks.
