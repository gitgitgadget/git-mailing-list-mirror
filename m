Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E25C4321A
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255F864F18
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhCSByH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 21:54:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50593 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhCSBxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4343B580A;
        Thu, 18 Mar 2021 21:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=shgUTIlnQTnr+pMMW4jpxJP8iGw=; b=h+RTYz
        UBFNskn0oQQc9zv7QXkEQynwYQT4nA7Rk7UB+5L9XS8t1O1LZwvuqG4qPLGurM/r
        VGRXQHkF/16nmTs4ukbwQzrNwnKzz7NGpZtcVsJqS4XFwwdrOzKiVxT1i27o7iLU
        kFXdfpmq6o6uSQjrfEOE0bjvxUR6my7vl/UNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QHZok7a60BoVDFIBGbrfRhi5B3oMKdaY
        Db2PlaeuRu/gl7fnsaADdKH/AC/weEnqqEU9iLQG0VSm7nFJPluwkycJtwLqZH98
        ItKv/hhZkGzSfyiUAQtfnssojjxoCK7rbjl6tj6u4kIACKLBjip+ou31RQ5+AkL7
        6e1d3f3jdek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F8CB5809;
        Thu, 18 Mar 2021 21:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F790B5808;
        Thu, 18 Mar 2021 21:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
References: <xmqqblbhtoa6.fsf@gitster.g>
Date:   Thu, 18 Mar 2021 18:53:51 -0700
In-Reply-To: <xmqqblbhtoa6.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        17 Mar 2021 15:21:05 -0700")
Message-ID: <xmqqblbfq574.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4ABF904-8855-11EB-A66B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Git 2.31 has been tagged.  We will hopefully either (1) not see
> brown-paper-bag breakages at all, or (2) will see some but can
> immediately deal with them, in coming couple of days.  After that,
> the 2.32 cycle will gain steam, starting next week.  Let's see.

A few topics that are relevant for 2.31.x maintenance track have
been merged to 'next', and I am planning to merge the following
topics (including those that are new in 'next' due to their being
maint material) down to 'master' before doing anything else, before
the beginning of the next week at the latest.

After that, let's rewind the tip of 'next' and start merging other
topics down to 'next', but that will still be done as-time-permits
basis and the progress may be slow yet.

 + ab/remote-write-config-in-camel-case                         02-24/03-01    #2
 + mt/cleanly-die-upon-missing-required-filter                  02-26/03-01    #1
 + jk/perf-in-worktrees                                         02-26/03-02    #2
 + dl/cat-file-doc-cleanup                                      03-03/03-13    #2
 + jr/doc-ignore-typofix                                        03-03/03-13    #1
 + sv/t9801-test-path-is-file-cleanup                           03-03/03-13    #1
 + ah/make-fuzz-all-doc-update                                  03-08/03-13    #1
 + rr/mailmap-entry-self                                        03-08/03-13    #1
 + ps/update-ref-trans-hook-doc                                 03-01/03-14    #2
 + tb/git-mv-icase-fix                                          03-03/03-14    #1
 + rs/xcalloc-takes-nelem-first                                 03-08/03-14    #1
 + bc/clone-bare-with-conflicting-config                        03-10/03-14    #1
 + jk/slimmed-down                                              03-14/03-18    #1
 + jc/calloc-fix                                                03-15/03-18    #1
 + rs/calloc-array                                              03-15/03-18    #3
 + jh/fsmonitor-prework                                         03-17/03-18    #1
 + jk/bisect-peel-tag-fix                                       03-17/03-18    #1
 + js/fsmonitor-unpack-fix                                      03-17/03-18    #2
 + jt/clone-unborn-head                                         03-17/03-18    #1
 + km/config-doc-typofix                                        03-17/03-18    #1
 + rs/avoid-null-statement-after-macro-call                     03-17/03-18    #2

