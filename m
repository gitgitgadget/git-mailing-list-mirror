Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C8EE7FF4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjIKGRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjIKGRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:17:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB40100
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:17:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B385932D02;
        Mon, 11 Sep 2023 02:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=hfo4Uv0J2OAp5ZL2YWjTiJT2NMl2I6wdqPV/Of
        LCPoM=; b=nMeRUvo2qAiXjpsg+BQbNSS6R3eiCE31f3KJ+IFbYyfIULD5CDU8cK
        f5VZdkxtQD2GGW7yaLr0OCsmHlAAjOjsIczrg1pTyCuRz2X0UfYYYFULuu7S/Sjp
        Fksn0N2StiiT4V+OhXush+A2lwVGsI7clJvJ66vK8LiGwuffogXSI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F1A532D01;
        Mon, 11 Sep 2023 02:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A31832CE7;
        Mon, 11 Sep 2023 02:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 12/32] bulk-checkin: hash object with compatibility
 algorithm
In-Reply-To: <20230908231049.2035003-12-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Fri, 8 Sep 2023 18:10:29 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-12-ebiederm@xmission.com>
Date:   Sun, 10 Sep 2023 23:17:29 -0700
Message-ID: <xmqqsf7li686.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3B1B51E-506A-11EE-A27C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

>  	struct hashfile_checkpoint checkpoint = {0};
>  	struct pack_idx_entry *idx = NULL;
> +	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
> +	struct object_id compat_oid = {};


bulk-checkin.c:267:39: error: ISO C forbids empty initializer braces [-Werror=pedantic]

