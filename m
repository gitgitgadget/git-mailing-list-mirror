Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF19C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F110B611BE
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhEYVXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 17:23:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63644 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhEYVXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 17:23:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0145D12FD3B;
        Tue, 25 May 2021 17:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=CLSNT8XK8sUzRTrWz0le8Bm+wVIz3eCPDUI6YdtqIng=; b=MEE6Vj+D55P2
        sb3WRbHjIe/CkNU453fbeiH8m/oKopSslepqDTF73vqmCnhCa6KdCdQhnzv1+NGl
        Hxd42jABH3/sw+iSjL7Gyf5EXYIqTum8O0NccKxoc+IKVcIahU/qrdonl/LlXDgD
        cRYkn79OXLOsm65rHO+AaG7b7gU8RbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE7EE12FD3A;
        Tue, 25 May 2021 17:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22DD312FD39;
        Tue, 25 May 2021 17:22:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: CI fail: "invalid object type" only on dockerized linux32 runs?
cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Date:   Wed, 26 May 2021 06:22:03 +0900
Message-ID: <xmqqsg2acxvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40EBEE22-BD9F-11EB-8AA9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/git/git/runs/2669078911?check_suite_focus=true#step:6:3195

shows a test that expects "git cat-file: could not get object_info"
gets "invalid object type".  What is curious is that most of the
other workflow runs do not get this error.  Only on the 32-bit run.

Rings any bell?

Thanks.


