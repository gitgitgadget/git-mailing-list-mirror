Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E2C202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbdJ0BCN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:02:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932488AbdJ0BCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:02:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9CEDACE3A;
        Thu, 26 Oct 2017 21:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhZ19BVzRjr/MlTAlaAddkzbFGA=; b=LbFUZ6
        lruHpE5LGcLyLskXUJpNMAt9ZTdj1Py2NKGxR0YF771S8KPpuV8FgFxjopllt0fF
        cc9KdACBrHmpdmgWtFjAY4oPi9BdaBblE8Uc4/fsGZ3Z1nDJ9nw6VAgIbRbr/iNz
        t2Egi6XP+WqoJSDV4Fpd7bqSRvPfofNTtS1uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MGADfppvrEsdBe2t8eFseDLk4vBaLW9u
        HVhGF4ukH4UgP1X3wSkoRz2xV6/NInhfgJtEoAQ5WSvfrj/MROM9jIYxcGtDajst
        Nnkn/fbwO6YJcyuJC5qnhM6CeVEhcQnZNmpPZtdGG+kma7XFFaSBL2bdYoEN1Vwv
        5NVPvlI6gOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B06CDACE34;
        Thu, 26 Oct 2017 21:02:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20A05ACE33;
        Thu, 26 Oct 2017 21:02:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2017, #05; Tue, 24)
References: <xmqqk1zlktbc.fsf@gitster.mtv.corp.google.com>
        <7b40d574-c6e3-d824-5e2f-b7cf18dadeb5@ramsayjones.plus.com>
Date:   Fri, 27 Oct 2017 10:02:08 +0900
In-Reply-To: <7b40d574-c6e3-d824-5e2f-b7cf18dadeb5@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 26 Oct 2017 17:44:54 +0100")
Message-ID: <xmqqlgjxe73j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75CE56BE-BAB2-11E7-AE31-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 24/10/17 06:28, Junio C Hamano wrote:
> [snip]> 
>> * tg/deprecate-stash-save (2017-10-23) 3 commits
>>  - stash: remove now superfluos help for "stash push"
>>  - mark git stash push deprecated in the man page
>>  - replace git stash save with git stash push in the documentation
>> 
>>  "git stash save" has been deprecated in favour of "git stash push".
>> 
>>  Will merge to 'next'.
>
> If you don't intend to include this in v2.15.0, when re-building
> the next branch after release (the above is now in 'next'), could
> we please remember to update one of the commit message subject line.
>
> In particular, commit 742d6ce35b ("mark git stash push deprecated
> in the man page", 22-10-2017), is marking 'git stash *save*' as
> deprecated, not *push*.
>
> [Sorry for not spotting this earlier; I only noticed when doing an
> 'git log --oneline' display which, naturally, puts focus on the
> subject lines. ;-) ]

Thanks for spotting.  I can always revert the merge into 'next' and
then merge a rewritten copy of the series back into 'next' again to
preserve the fast-forwardness of the integration branch, so that I
do not have to remember ;-)

