Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DFD1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJKQmM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:42:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50232 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKQmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:42:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB2989D6E4;
        Fri, 11 Oct 2019 12:42:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yHoLdX0Is9EnU0rXWPQZZsOm8Ek=; b=Sbea/U
        LHTcQF23Q6sF0tvpAJBkbglPTRM4wiX3TGjMn535JkoSgAceugl081OZrCQps2vd
        YoNd04kE3R+xSBnOb0RIrY1BlqmuxULa+sWFuyzpVhZxz/yU3VvBab5nu/H1aSeV
        OFw2U5RrAYhdliO9zYqvTByMy9OYZiFcSwZF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eczn0mP3y4FmlCUM3a4cTtLNT2MijUBB
        VdoRNR1ut7jsMVymHDgfGtu8gfnIV2bEM7QmzEa6qF7354CAa7uMvzLHNLVU9Ysc
        F15KbCQpMxnw/lIN3i8QOLH5GldsPOpxgG0EdupQRN+BdmSaDwyn04+9OPCCHA+b
        bjnHLJm8eYE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B427D9D6E3;
        Fri, 11 Oct 2019 12:42:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCD859D6E1;
        Fri, 11 Oct 2019 12:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
Date:   Sat, 12 Oct 2019 01:42:04 +0900
In-Reply-To: <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 11 Oct 2019 08:44:50 -0700")
Message-ID: <xmqq4l0fgroj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FD7DCE6-EC46-11E9-9D08-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/fast-imexport-nested-tags (2019-10-04) 8 commits
>>   (merged to 'next' on 2019-10-07 at 3e75779e10)
>>  + fast-export: handle nested tags
>>  ...
>>  + fast-export: fix exporting a tag and nothing else
>>
>>  Updates to fast-import/export.
>>
>>  Will merge to 'master'.
>
> Any chance this will merge down before 2.24.0?  I'd really like to see
> and use it within filter-repo.

A few general guidelines I use are that a typical topic spends 1
week in 'next' (a trivial one-liner may be there for much shorter
time, an involved multi-patch topic that touches the core part of
the system may have to spend more), that an involved topic that is
not in 'master' by rc0 would not appear in the next release, and
that any topic that is not in 'master' by rc1 needs compelling
reason to be in the next release.  So it is cutting a bit too close
for this topic, it seems, but we'll see.

