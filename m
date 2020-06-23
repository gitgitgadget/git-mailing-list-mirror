Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE40C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1938A208C9
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4xBjsxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgFWTbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:31:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbgFWTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:31:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C168C64F8C;
        Tue, 23 Jun 2020 15:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+fLRr+uQ9IDQ
        dbQYThs4tYwhhKo=; b=D4xBjsxRgbJcsutKrZiUI20/O7sDdK3fjGB3xHvezIJ2
        8eCYdmeET5HPBuC9Us2Zu8KNo0ys3LXJnKu0Ue3HpqcDoe70W84Y2HKl6Vm3d5On
        mZ+0zwxfv3yVCCoxZRMt9FgvnaUi9/E+GpK5ksCzwDpncdL8aHDUPeWjEdsf1pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B+SSnj
        fsliV2oXtc90bRNMcmUx+UFedFgoccHi5qEmucvufngNUWQO4TESqHUCozVyjSLO
        xy7UvgwKMZCXRiebvoE24NSs8Ly244K8HDalfSY6cP+AzApudx4EiDTHTMMonB5I
        C1t9f26MS7I6PFjpO/Z4qZOzWLSpehqFmIkvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B920264F8B;
        Tue, 23 Jun 2020 15:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4962664F8A;
        Tue, 23 Jun 2020 15:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] docs: adjust for the recent rename of `pu` to `seen`
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com>
        <20200623153106.GB20455@danh.dev>
Date:   Tue, 23 Jun 2020 12:31:45 -0700
In-Reply-To: <20200623153106.GB20455@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Tue, 23 Jun 2020 22:31:06 +0700")
Message-ID: <xmqq5zbhd1em.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CFCAC50-B588-11EA-B99F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Hi Dscho,
>
> On 2020-06-23 15:04:13+0000, Johannes Schindelin via GitGitGadget <gitg=
itgadget@gmail.com> wrote:
>> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-re=
mote.txt
>> index 0a5c8b7d493..492e573856f 100644
>> --- a/Documentation/git-ls-remote.txt
>> +++ b/Documentation/git-ls-remote.txt
>> @@ -101,9 +101,9 @@ f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags=
/v0.99.1
>>  7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
>>  c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
>>  0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
>> -$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu r=
c
>> +$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen=
 rc
>
> rc is not with us anymore.
>
> Should we replace it with next, too?

I do not think so.  I think we never had 'rc'.

I think what the above example is demonstrating is this.

    SYNOPSIS calls the last command line arguments <refs>; they are
    actually mere patterns (which is how these command line
    arguments are described in the documentation).  It is *not* an
    error if no refs match a particular pattern.

And because we have no refs that match the pattern "rc", we only see
"master" and "pu" (now "seen") from the command.

I see a couple of possible improvements here:

 - The "<refs>...::" documentation should explain what kind of
   pattern match is performed here.  I recall these originally were
   just tail matches, but the rule might have been made more
   flexible over time.

 - The example should first explain the setting.  The first sample
   depends on the current (./.) repository having these tags or it
   would not work (showing the sample upfront and explaining the
   outcome shown in the sample would work well in this case,
   e.g. "we can see that in the current repository, there are tags
   X, Y and Z").  The second one at least needs to say two things:
   the sample repository does not have a branch called 'rc' and that
   is why it is not shown, and it is not an error for patterns to
   produce no match.

Thanks.

>
>>  5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
>> -c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
>> +c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
>>  $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
>>  $ git ls-remote --tags korg v\*
>>  d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
