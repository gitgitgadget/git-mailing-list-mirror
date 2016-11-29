Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F501FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755029AbcK2T0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:26:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752356AbcK2T0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:26:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 314874E3F2;
        Tue, 29 Nov 2016 14:26:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nn85ozhPbeRjhP0HeefuiGCSlgk=; b=DSuhNi
        MgBXhPnugnr5XPcxiRN0Sj1qc/z+SY9KVagC+eK1fAhWSOt+fnlBCUsN3BeFJx7b
        5zyRnQu2txcQkXmbKcl+qOTCjsXQD2iZfh9WHZ1pQ1bnyAMopkQYW9dpQ6eXOHb8
        31nx32ZbeJX46CiVtGc1BhWOfrNiZHrulsjh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wyIYM/9KekzSchky5kK3lOHlBlO7fLcu
        m7G2qB3SMhner4Zg8r5HZN21Hd079JdHlbL3oNzPUhtqfhbYWGAZphBMqSnlq5Oc
        Qx5nZC0BqMFOwFs1Uh6USfo1A1ae11lJ4fq8adSm6l3l8vwACD5gHrSsuoVOb3SY
        oCreuZg73Z0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E4B4E3F1;
        Tue, 29 Nov 2016 14:26:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A01924E3EF;
        Tue, 29 Nov 2016 14:26:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
Date:   Tue, 29 Nov 2016 11:26:04 -0800
In-Reply-To: <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 29 Nov 2016 11:21:39 -0800")
Message-ID: <xmqqk2bmf5pv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC1BA36E-B669-11E6-B4EA-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Nov 28, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
>>  - push: change submodule default to check when submodules exist
>>  - submodule add: extend force flag to add existing repos
>>
>>  Turn the default of "push.recurseSubmodules" to "check" when
>>  submodules seem to be in use.
>>
>>  Need to rebase on hv/submodule-not-yet-pushed-fix and then consider
>>  merging to 'next'.
>
> The rebase is without merge conflicts, so I assume there is no
> work needed by me here.

Correct.

>> * sb/submodule-intern-gitdir (2016-11-22) 5 commits
>>  - SQUASH
>>  - submodule: add embed-git-dir function
>>  - test-lib-functions.sh: teach test_commit -C <dir>
>>  - submodule helper: support super prefix
>>  - submodule: use absolute path for computing relative path connecting
>>
>>  A new submodule helper "git submodule embedgitdirs" to make it
>>  easier to move embedded .git/ directory for submodules in a
>>  superproject to .git/modules/ (and point the latter with the former
>>  that is turned into a "gitdir:" file) has been added.
>>
>>  Need to read it over again, deal with SQUASH, and may ask for a
>>  reroll.
>
> Ok, I looked over it again and I may see some issues:

OK then I'll procrastinate on this.

> That slipped by me. Will review.
>
>> * sb/attr (2016-11-11) 35 commits
>>  - completion: clone can initialize specific submodules
>>  - clone: add --init-submodule=<pathspec> switch
>>  - submodule update: add `--init-default-path` switch
>
> I may end up rerolling these top three patches as its own series
> again without the underlying pathspec support.
>
> I will investigate if we need the mutex at all for the attribute
> code or if we can initialize all attrs (in the pathspecs) before the
> threaded preload_index takes place. That sounds cleaner to me,
> but I do not prioritize it as high.

OK.

Thanks.
