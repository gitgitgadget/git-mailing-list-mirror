Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD6C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352847AbiDZQQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352852AbiDZQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:16:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B79D074
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:13:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84FBA127498;
        Tue, 26 Apr 2022 12:13:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EU+IFlxvxgzIXp8ehwFkvb4pNM4h5kdEG4sLD5
        zKOZM=; b=KUekBmflZi3QMIvlLuB4ZcWUiKg70VbMebbkZ/6dprWVJC242WykeA
        avl++6ip8aIGryCHc56OlMvRKYbWp9ND1CtIa7Sb3Na1ha2HVYfOLeYb6fmIk3ut
        hAGaemVgq8F3znTgloDK2NM9aFM+hVKKu7B3MIZpZfbJw7wSkOA8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 779BB127497;
        Tue, 26 Apr 2022 12:13:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F29C127496;
        Tue, 26 Apr 2022 12:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Guillaume Cogoni <cogoni.guillaume@gmail.com>,
        Jonathan <git.jonathan.bressat@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge
 conflicts
References: <xmqqfsmg97ac.fsf@gitster.g>
        <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
        <xmqqczh4vp6e.fsf@gitster.g>
        <fdd9f13d14e942f3a1572866761b9580@SAMBXP02.univ-lyon1.fr>
        <243b40ef-a720-46aa-6657-87ac8d3c3bdc@univ-lyon1.fr>
Date:   Tue, 26 Apr 2022 09:13:06 -0700
In-Reply-To: <243b40ef-a720-46aa-6657-87ac8d3c3bdc@univ-lyon1.fr> (Matthieu
        Moy's message of "Tue, 26 Apr 2022 08:38:43 +0200")
Message-ID: <xmqq35hzsu0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3B563D0-C57B-11EC-B6B3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> Git very rarely goes interactive like this (only a few special command
> like git send-email, git clean -i, git add -i/-p prompt the user).
>
> Prompting the user in the middle of an operation has several drawbacks:
> ...
> In this particular case, actually, I can't imagine a sane behavior
> when the user wants a mix of "yes" / "no". If a single untracked file 
> conflicts with what's being merged, the merge aborts, even if you're
> OK to replace other files. So I can only imagine a single yes/no
> answer. And then the question can be replaced with a suggestion to
> re-run with a command-line flag when all the conflicting files are
> unmodified.

Nicely explained.  Thanks.
