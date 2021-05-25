Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A3C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32E261417
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEYHAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:00:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58375 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEYHAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:00:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1962ECD2C2;
        Tue, 25 May 2021 02:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jkUGgXteuNcn4FeV9jbByJv8kEYZgCButDS93DOtD4A=; b=xbOb
        lOqYrRXs4XH2CpBF3FN0nfKWfCan2kd7IWL1APihXQUiAACIgLDMr38/ik9qqULL
        6jJFyESaaUluRv0AoFCBYet7AdM0xF72co/9Stwonta0Pr1+GV793/O+/CvdIT9R
        AFAX+2tt7IeYs2HC2FD3U37LSf62hFNcmYmriIc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 115D5CD2C1;
        Tue, 25 May 2021 02:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97FE3CD2BE;
        Tue, 25 May 2021 02:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
        <xmqq1r9wj9im.fsf@gitster.g> <60abfd46a8ca3_1b20920823@natae.notmuch>
X-Gnus-Delayed: Wed, 26 May 2021 05:38:49 +0900
Date:   Tue, 25 May 2021 15:59:17 +0900
Message-ID: <xmqqlf83fge2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B913535A-BD26-11EB-92C8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Apparently my scripts call `git format-patch` with -D, which doesn't
> generate appliable patches when files are deleted.

Don't call format-patch with -D, then ;-).

> Do you want me to send it again without -D?

Sure, if a collection of patches want to be reviewed and applied, I
would think it helps for them to be appliable to a common tree (like
my 'master') with tools reviewers and the maintainer are know to use
(like "git am").  As more roadblocks are added before the changes
can become reviewable in the reviewers' trees, less chances they
have to get reviewed.
