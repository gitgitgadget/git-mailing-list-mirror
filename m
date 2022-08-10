Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71DC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiHJShq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiHJShj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 14:37:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86F6BD6D
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:37:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF99D1B5071;
        Wed, 10 Aug 2022 14:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SQHtkYtzl0lYIetZn+QTR2N501Ny7ynXYJ4Bf+
        nNbhY=; b=ZRa8ZnOj1tNO2ijQ+pp1a0VZVXC9MfPTQtbo5T/PlFh9Lk82GmfvCY
        97I3YjVaQXe5XDjUIi96ZDp1JdbrdfAZ2hKegIB4TywH+TPYTgad5LkwI+dZ5S3O
        BPUBkn46ThhzoOTkHyqPvYjcQjlSQIN5pv02Aw4NBM5tr1udh8Q94=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B740C1B5070;
        Wed, 10 Aug 2022 14:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 661581B506D;
        Wed, 10 Aug 2022 14:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
References: <cover.1659291025.git.matheus.bernardino@usp.br>
        <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
        <xmqqr11zoe6i.fsf@gitster.g>
        <439p713r-32o4-5187-n8nn-r81n3007s4pp@tzk.qr>
Date:   Wed, 10 Aug 2022 11:37:33 -0700
In-Reply-To: <439p713r-32o4-5187-n8nn-r81n3007s4pp@tzk.qr> (Johannes
        Schindelin's message of "Tue, 9 Aug 2022 12:00:02 +0200 (CEST)")
Message-ID: <xmqqtu6kkkr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80185AB6-18DB-11ED-BFA3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would like to encourage you to think of ways how this project could
> avoid the cost (mental space, reviewer time, back and forth between
> contributor and reviewer) of such trivial code formatting issues.

I do not need your encouragement.  I am sure the submitter could
have run clang-format or checkpatch.pl or whatever and noticed the
issue.  Small style diversions in submitted patches are distracting
enough to prevent me from concentrating on and noticing problems in
the more important aspects like correctness and leakiness.  That is
why people get formatting issues pointed out and CodingGuidelines
talks about styles.

Checkpatch is OK, but IIRC, you cannot ask to check "only the code I
changed in this patch" to clang-format, which may be the show
stopper.  Otherwise, I would quite welcome an automated "pre-flight"
automation, like "make" target, that submitters can use and GGG can
help them use.

Thanks.

