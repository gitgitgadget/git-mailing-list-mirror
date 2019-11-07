Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCED1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 03:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfKGDfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 22:35:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52575 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbfKGDfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 22:35:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 651798BD58;
        Wed,  6 Nov 2019 22:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fmXlG9sk6RV2H+iyJXXFusz5yXY=; b=dF7yvr
        V5ELtciajTBwiIGovKWrn1LQZtw9mQF9r0w3z96q8VISo8BgyETOI0P7gMMUe9p1
        e555YNfJTs+c6tqG9iKjTMBA716duZHfuDqiwBoOk5FoL9jfTfGkjR846LLUZTB5
        QaMuVExuK0hKd2ouYok4jJiD58eYQbinz7oNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pKZfJp1DUZK2GxlhsrmdwYWlh57WDpuR
        nnshyohbd9nWwdckrcRtwM3HSKvzptiH1YpFUoTK9mV8qBgb7MOVvexSWgidadjp
        dmrc3zSNgbRQ6Zw50FHhaeoRxXmq+YWcrWO2OZucRqOoOdoJmuCLU+RbWi2msAcB
        u82hSO8ieo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C6108BD57;
        Wed,  6 Nov 2019 22:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 877138BD56;
        Wed,  6 Nov 2019 22:35:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     workingjubilee@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
References: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
        <20191106213609.57464-1-jonathantanmy@google.com>
Date:   Thu, 07 Nov 2019 12:35:09 +0900
In-Reply-To: <20191106213609.57464-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 6 Nov 2019 13:36:09 -0800")
Message-ID: <xmqqy2wss6j6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A751020-010F-11EA-8986-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > Also, clarify in the commit message somewhere that this commit does not
>> > change the behavior of "git bisect".
>> 
>> s/\.$/ when used without the "--first-parent" option&/; you mean?
>
> As far as I know, "git bisect" doesn't support --first-parent, whether
> before or after this patch.
>
> At first I thought that this patch also teaches "git bisect" to support
> "--first-parent", but that is not the case.

Ah, I was not paying enough attention.  So this is only the first
part of the whole solution that does not have much end-user visible
benefit yet.

With "yet" at the end of what you wrote, I do agree with you that
such a clarification would be necessary.

Thanks.
