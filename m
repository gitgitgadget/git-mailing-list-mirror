Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABCDEE7FF4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjIKGZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIKGZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:25:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179D100
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:25:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A55932DC1;
        Mon, 11 Sep 2023 02:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Xjvo8xsnvEGFu+3E/fX/h47GVoeVczjqpToOhO
        6Gef0=; b=DiCm6zq90gCVT7y3hOETtYv7IffD022cl4C+bEYkrBeNSPFqQG1R+n
        kz2qldY1VRsDOsuSJzl0ubbnEy+9dO73LJUljVsXI4ECSyd5qLNfI4JaDkE/ntWm
        c6TgleDce1AOpVJTjupqZNndvz53/ptWtZTEMbrkb24XjS+hqoMSo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5061032DC0;
        Mon, 11 Sep 2023 02:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9F7B32DBF;
        Mon, 11 Sep 2023 02:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 14/32] commit: write commits for both hashes
In-Reply-To: <20230908231049.2035003-14-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Fri, 8 Sep 2023 18:10:31 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-14-ebiederm@xmission.com>
Date:   Sun, 10 Sep 2023 23:25:15 -0700
Message-ID: <xmqqo7i9i5v8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F93EE9F0-506B-11EE-BBB6-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> +	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
> +	struct object_id *parent_buf = NULL;
> +	struct object_id compat_oid = {};

Ditto.

	struct object_id compat_oid = { 0 };

would be our zero-initialization convention.

Thanks.
