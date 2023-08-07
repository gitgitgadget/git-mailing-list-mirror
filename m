Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD6AC0015E
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 01:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjHGBHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 21:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGBHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 21:07:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC8170A
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 18:07:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC2419EF8B;
        Sun,  6 Aug 2023 21:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L1n3HNMfo5XlEhP9DLGBAcjvCv1YTeMh4V/tC9
        jjHpE=; b=fJYTkUhXDzmqw0fwFaFF9yciW2yNyTEhQ8NNgu9ug+Dd+oJ9usndeK
        K4bBAK8ehJtG4Nccr4M2CmAbuC09KL7muFDv1U6w1m2lxFlO4VXYJw+1HWyWz8Qf
        Udzuv0LgLDsbmX3wuf+qTf4QWqj7Rl9//R8m1+Sog5C9wAVh9HoHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25C4D19EF8A;
        Sun,  6 Aug 2023 21:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A58319EF89;
        Sun,  6 Aug 2023 21:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brooke Kuhlmann <brooke@alchemists.io>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Git Commit Notes (fetching/pushing)
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
        <ZM/9+YyOAbWWXQtC@nand.local>
        <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io>
Date:   Sun, 06 Aug 2023 18:07:30 -0700
In-Reply-To: <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io> (Brooke
        Kuhlmann's message of "Sun, 6 Aug 2023 15:49:22 -0600")
Message-ID: <xmqqwmy7irsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C901AFCA-34BE-11EE-9707-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brooke Kuhlmann <brooke@alchemists.io> writes:

> ... o why default branch push behavior is being
> ignored/overwritten.

The root of your confusion lies around here, I think.  The "default"
branch push behaviour is given only when you do not customize.  Once
you add customization, you would specify _exactly_ what you want.

In other words, the customization is NOT something you tell Git to
do _in addition to_ what it does anyway (otherwise you would not be
able to configure _away_ what is usually done by default when you do
not want to see it done).

