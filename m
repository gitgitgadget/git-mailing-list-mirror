Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24006C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiI0VlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiI0VlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 17:41:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE36E2DC
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 14:41:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9836E1CEFAB;
        Tue, 27 Sep 2022 17:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=okMz9Lw4C6KZAuh3zWg/C4Nd50oXJ8uXUPqtKqd65qU=; b=UiYK
        WyIYPBXw0EBgaNvJE2JDw6u3kXzGM0abMXBAc3Q5gzc0HXevGUQSvJbCig11Z8v0
        rD7WczVGl/T9HPwO5aD+VVykwGhYnuOH1IQwav/jP0smOWbhFTrYGS6T6lzmuznb
        X65uEaKeonrKFlVP+NJrGmQbSNalyK97KyKmdnM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91CEE1CEFAA;
        Tue, 27 Sep 2022 17:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 371411CEFA8;
        Tue, 27 Sep 2022 17:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-2-calvinwan@google.com>
        <xmqqy1u9uddc.fsf@gitster.g>
        <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
        <xmqqpmfh8lxw.fsf@gitster.g>
        <CAFySSZC1DMdnCpi9enDG0=NDb+OU8jufHsq4WkjoN3mp1SZT8w@mail.gmail.com>
Date:   Tue, 27 Sep 2022 14:40:58 -0700
Message-ID: <xmqqo7v01onp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 134C42F6-3EAD-11ED-B002-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> ... I would rather
> implement a separate "git status --porcelain" output for just this
> submodule case so 1. we would not have to worry about unbounded
> output and 2. both the output parsing and the command could be
> optimized.

Sounds good.
