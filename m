Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F09C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187D061362
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUXuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:50:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61958 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:50:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60194EDECF;
        Thu, 21 Oct 2021 19:47:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/k4zZBcJ89dx
        fjLinbaaPteFvnG8W8G2H78j+VuerwU=; b=goBwGmtJm8A9hUDOiwaBosdloecd
        ZREaxPY1FJRh8aoldWfOj1lc/3qIoeUMlHVDuHnNw2L52UaTmoqTUZIbM23/Fo61
        6YGCVaCarcLVKMiRAyUajl9od4Vblz8uy8vE7ZrxAvMXSSSiSNP2LDj/QGso4URK
        bM3+g4NIMinztek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57A88EDECE;
        Thu, 21 Oct 2021 19:47:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF5BDEDECD;
        Thu, 21 Oct 2021 19:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] status: print stash info with --porcelain=v2
 --show-stash
References: <20211021222532.463375-1-oystwa@gmail.com>
        <20211021222532.463375-3-oystwa@gmail.com>
Date:   Thu, 21 Oct 2021 16:47:53 -0700
In-Reply-To: <20211021222532.463375-3-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Fri, 22 Oct 2021 00:25:32 +0200")
Message-ID: <xmqq1r4egct2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4FA9AE14-32C9-11EC-808C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> The v2 porcelain format is very convenient for obtaining a lot of
> information about the current state of the repo, but does not contain
> any info about the stash. git status already accepts --show-stash but
> it's silently ignored when --porcelain=3Dv2 is given.
>
> Let's add a simple line to print the number of stash entries but in a
> format similar in style to the rest of the format.

Who is the primary target audience of this feature?  IDEs that read
from "git status --porcelain"?

Whoever it is, if they bothered enough to pass an extra option
(i.e. "--show-stash") to their "git status" invocation, I wonder if
they want to know at least what "git stash list" would give you at
the same time.  After all, the --porcelain output is all about
machine readability and reducing the number of forks would be what
those people would be interested in, wouldn't it?  I dunno.

Thanks.

