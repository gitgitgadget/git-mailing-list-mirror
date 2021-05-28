Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E5C47089
	for <git@archiver.kernel.org>; Fri, 28 May 2021 00:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBF9613B4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 00:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhE1AUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 20:20:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51106 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbhE1AUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 20:20:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7970412F558;
        Thu, 27 May 2021 20:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JmCEv0phMDfdtRUfKUyvk4sNjeh8fie9mbFrQb
        gomGw=; b=BDiNkz2bwNPCebvm+DPzJc9XnHzkwX8YF4xoBAd1sNdefAkZzUj+UO
        d1FyZMrfKED7N/RM81htFp5Z3Rw3Y+Wx1dcHHwDyzLspD5DmprhNnfEd4J9i6w+H
        Ry/a77knX5+eWPOEP05AsRm4nIKphwQp+yu8F28b2OXu5UooW61hs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72D3012F557;
        Thu, 27 May 2021 20:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B191112F556;
        Thu, 27 May 2021 20:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net, j6t@kdbg.org
Subject: Re: [PATCH v3 00/17] fsck: better "invalid object" error reporting
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
        <20210527170832.2669483-1-jonathantanmy@google.com>
Date:   Fri, 28 May 2021 09:18:42 +0900
In-Reply-To: <20210527170832.2669483-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 27 May 2021 10:08:32 -0700")
Message-ID: <xmqqim3390d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43977B4E-BF4A-11EB-88FA-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> My main comment as a reviewer is I think that there are a lot of
> unrelated changes in this patch set ...

Thanks for reviewing.  I share the same feeling, not specifically
about this series, but I find that "doing too many while-at-it
changes" is shared among the topics by the same author, and I often
wish each topic were more focused.

