Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A8C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiD0Vv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiD0Vv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:51:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E343972AB
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:48:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6D24135320;
        Wed, 27 Apr 2022 17:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ssQFYctXI4g7jetKsozf+mNvdbGu30teUZVe51
        4QHo0=; b=EmUtelXFFmUKOJCDBbbai9Xe5M3s1ZMZo8VTokc6UulyU6yjgaCPWM
        z36ADCuqLO+pohsd64aZAias0abySi9o7PLJaYqf48zRI0sA9ObTS3pSc3zvI2rm
        5MgRRYmC3w7g6jPYT2e0V8f3w62i9/Q2EaJyJNJQ75LKm4flHqYGk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE6D213531F;
        Wed, 27 Apr 2022 17:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C20C13531E;
        Wed, 27 Apr 2022 17:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/3] MyFirstContribution: move cover letter description
 to a separate file
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 14:48:42 -0700
In-Reply-To: <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 27 Apr 2022
        19:04:46 +0000")
Message-ID: <xmqqr15ijiyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEA32450-C673-11EC-8837-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In a subsequent commit we want to reuse the explanation of the purpose of
> The cover letter form the "Sending Patches with git send-email" section
> in the "Sending Patches via GitGitGadget" section.
>
> To avoid text duplication, move this explanation to a separate file and
> include it in MyFirstContribution.txt.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  .../MyFirstContribution-coverletter.txt       | 18 ++++++++++++++++
>  Documentation/MyFirstContribution.txt         | 21 ++-----------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/MyFirstContribution-coverletter.txt

If the end-product is a single document, "MyFirstContribution", I am
skeptical if it is a good change to duplicate the same text in two
sections.

Should we instead reorganize the document so these concepts like
cover letters, log message for each commit, etc., which are
applicable regardless of how you send them out, are explained,
before we start talking about "now, we understand the components out
of which a patch series is made of, here is how you give it a final
polish and send it out, with send-email and/or with GGG"?

Short of that, perhaps whichever appears later in the document that
uses "cover letter" can just say "see above"?

