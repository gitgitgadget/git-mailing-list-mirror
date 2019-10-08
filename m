Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4FF1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 02:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfJHCgK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:36:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56735 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHCgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:36:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77FA52C6D2;
        Mon,  7 Oct 2019 22:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OX50ZZa0WUVhfumRtObVNZI7EI4=; b=D3nuOg
        IAJcczdqD+qZkYZBM5toDPbmfNNULfbyUZ9ACByN2+sPOR/Mn6q0YTtV+JlPm/JG
        W1ymUxrbDZ0B29PXRzYrkMGeGZGeWMA+8WZ4cHbE/i+1+4uJUAbm7ZLR9JZoLiwg
        luZcPvBIPrHJWehbgpOTCSE/kyRtCTDm0vipg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tq/QymnLghXFNPHLlPcFvdKYCjlNb/eY
        TkGuksMAV8GgPvuemp6oLhHJLR78TrpVhhxRzLsTNfd7oO0N/ae6+jojSEByoqAC
        aljhLdViypXuGj3seKJXx1Z3SOb2E15VNpoMBF/4z3Yc3NsQQjPQ/eaWgVyEv+Wv
        03Uly87Y8KA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A7D52C6D1;
        Mon,  7 Oct 2019 22:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A4272C6D0;
        Mon,  7 Oct 2019 22:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: fix the fix to the diff3 common ancestor label
References: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com>
        <20191007155211.23067-1-newren@gmail.com>
Date:   Tue, 08 Oct 2019 11:36:05 +0900
In-Reply-To: <20191007155211.23067-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 7 Oct 2019 08:52:11 -0700")
Message-ID: <xmqqr23oneui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 619C6CEC-E974-11E9-963E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In commit 208e69a4ebce ("merge-recursive: fix the diff3 common ancestor

I think the above was an earlier incarntion of what is now known as
8e4ec337 ("merge-recursive: fix the diff3 common ancestor label for
virtual commits", 2019-10-01).

> label for virtual commits", 2019-09-30) which was a fix to commit
> 743474cbfa8b ("merge-recursive: provide a better label for diff3 common
> ...
> The handling for "constructed merge base" worked by allowing
> opt->ancestor to be set in merge_recursive_generic(), so we payed

s/payed/paid/

> attention to the setting of that variable in merge_recursive_internal().

Thanks, again.
