Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB10C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82E20733
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HeRFs3Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgC2QX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:23:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57580 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC2QX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 12:23:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F388CB091;
        Sun, 29 Mar 2020 12:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Aq8+ituN2POg
        +U3SHeO1EBYz6Ps=; b=HeRFs3EhwxF42/ajbksGE+60wGUJqzLfpYCn9Yr+Vsti
        v7r2DziIc3KSpSSCEyumlPMu82ujjNi8UOFiqAA/zBLNMELYNyTv43PqwXrMg0Ps
        yOPNgjIXcyoxspvXa0e9RajwhEXBfRxbzwQk8RQAuJMGwOZEGZv7Rwq218Jzoe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Bf0aqr
        HPn3hxqyo2N+jM4xLndC9NShS7wXEsMTCsE68DAh/J/I3Uvdna+8e8DEiE4WmK9V
        sfDcvctd9guzxHJQDHB+EWFmGhMxmNi95a1X4LeHpFX0oA1hVR7+M8+BgyUPcs8Q
        3lmikFjUlp7RfGUwS3hQ/0HD7CyTyypwyU9Ng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1763CCB090;
        Sun, 29 Mar 2020 12:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61F51CB08F;
        Sun, 29 Mar 2020 12:23:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] Travis + Azure jobs for linux with musl libc
References: <cover.1585203294.git.congdanhqx@gmail.com>
        <cover.1585474409.git.congdanhqx@gmail.com>
Date:   Sun, 29 Mar 2020 09:23:49 -0700
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Sun, 29 Mar 2020 17:12:28 +0700")
Message-ID: <xmqqmu7zb04q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD19440E-71D9-11EA-ABBD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Change from v1:
> - fix spelling
> - run-docker.sh: use "jobname" environment variable instead of passing =
argument
> - add linux-musl job on Azure
> - Add 4th patch for jt/rebase-allow-duplicate (feel free to squash into
>  jt/rebase-allow-duplicate)
>
> The first 3 patches could be applied on top of master,
> but the last patch needs to be applied on top of jt/rebase-allow-duplic=
ate

This note was very helpful.  Very much appreciated.

Please keep this a three-patch series ([1/4], [2/4] and [3/4] become
[1/3], [2/3] and [3/3]), and make the fourth one a separate fix to
the other topic.  Even if we were not going to take this topic, the
last one is an independently useful improvement.

I'll update jt/rebase-allow-duplicate with the last one, so no real
harm done, but keeping the topics separate on the list would help
reduce confusion.

Thanks.
