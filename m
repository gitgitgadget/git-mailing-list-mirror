Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EA2202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 17:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdGDRmn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 13:42:43 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35409 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdGDRmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 13:42:43 -0400
Received: by mail-pg0-f41.google.com with SMTP id j186so112783009pge.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vvrWYLwZ8lZn+WJeU+D0FWINqD5K6NCkWosp/RZrDUU=;
        b=RXxphgWJxmuxW3E3RTxuxYr1EaApdI18B5LmFiPwX2robPqGbIX3FKee9lISAWF0fo
         uPY4RHeQZZLwTn4U8yekEcvRLfCzHHQUyFefzAM5QlDBFumQDchVUz+2tPOTZwF3tUGD
         BRJXnTJq84Bc/ELcPQ7BxzuX/ZIU8qpm5YfHM1uO7aS36Bwup5kbnwrjWfj4m0LL/Pz2
         TTa37fw+9qSoJRu9ZR6KVVLoBuA8AJc2m8heRKU+BaQWir15tYWyJqXe85HbXirGu7ay
         fIrKO0i2mJLMaV9xf1OeA1faiOL/BNeB2xd9K8U6IC0U791YOo52bgoznR0UsY677BiX
         +fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vvrWYLwZ8lZn+WJeU+D0FWINqD5K6NCkWosp/RZrDUU=;
        b=TIKAHtLR7zb1qj96fBAt2dmeFgGSe2tB7qUHp5IXS8LbJoG7TCRjy6+uSbjeuOeROO
         XgzAyxtkUiI8+Tr5oKWCI7Kb7MAlkHituWlKqC9is0aOYMjActxefTlzKveMQoA4XuIT
         bJ89ynOBPG+nOSA6JBUxfmVLt41ClWn6hhO4sVR3qlRSaxWAkG2MjYdVCtpJ7PH29Ebe
         AXpk0MD5zcMDv+wl71DVgIrzrj1P8WDV0qomcWLJ76yBFxE/0i3n8zYTTRV8eBArYER2
         XOi3iL/TjaArXZ8KSbf+xSDGisFsuAIOwhVHIVhaXeeSdPSdnDZ00ulRGjq+xcmOHiqC
         7j2A==
X-Gm-Message-State: AIVw110KhYpoJMQQrlCJOp3A+AnnpyEZ/dbVKpC34qOO39nC50TGk9+c
        xb7FY8+lSDN4oqdCE1k=
X-Received: by 10.99.117.94 with SMTP id f30mr17051149pgn.197.1499190162190;
        Tue, 04 Jul 2017 10:42:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id s123sm48304123pgs.2.2017.07.04.10.42.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 10:42:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] add --signoff flag to `git-merge` command.
References: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
        <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
        <87tw2sbnyl.fsf@gmail.com>
Date:   Tue, 04 Jul 2017 10:42:40 -0700
In-Reply-To: <87tw2sbnyl.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 04 Jul 2017 10:33:54 +0200")
Message-ID: <xmqqzickjdyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 04 2017, Łukasz Gryglicki jotted:
>
>> add --signoff flag to `git-merge` command.
>
> We'd usually say this as:
>
> merge: add a --signoff flag
>
> Or something like that.

I thought I gave a fairly complete example that can be imitated, but
apparently it didn't go through X-<.

>> Some projects require every commit to be signed off.
>> Our workflow is to create feature branches and require every commit to
>> be signed off. When feature is finally approved we need to merge it into
>> master. Merge itself is usually trivial and is done by
>> `git merge origin/master`. Unfortunatelly this command have no --signoff
>> flag, so we need to either add signoff line manually or use
>> `git commit --amend -s` after the merge. First solution is not ideal
>> because not all developers are familiar with exact sign-off syntax.
>> The second solution works, but is obviously tedious.
>> This patch adds --signoff support to git-merge command. It works just
>> like --signoff in `git-commit` command.
>
> It would be nice to split this into a at least a couple of paragraphs,
> and more closely follow the format suggested by
> Documentation/SubmittingPatches.

Good suggestion.

>> More details here:
>> https://public-inbox.org/git/CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com/T/#u
>
> These more details include my outstanding question in
> 87fueferd4.fsf@gmail.com which hasn't been answered yet.

I have an opinion on that topic, but I'd prefer to hear from others
first before I speak out.

>> diff --git a/t/t9904-git-merge-signoff.sh b/t/t9904-git-merge-signoff.sh
>> new file mode 100755
>> index 0000000000000..f542f136f5dda
>> --- /dev/null
>> +++ b/t/t9904-git-merge-signoff.sh
>
> The convention for adding new tests is not to add a new one after
> whatever name sorts the highest, see "Naming Tests" in t/README.

Correct.

> I.e. this should be somewhere in t[6-7]* with the other merge tests.

Yeah.  While most of t[67]??? series are about the contents of the
merge, i.e. resulting trees and what happens in the working tree,
there are some tests about the merge messages in there.  t7608 is
exactly about how the command prepares the messages before giving
them to human to edit, and I think "merge can be told to optionally
add sign-off" fits there just fine.  All existing tests there are
only interested about the title, but that does not mean there must
not be tests that care more than the title in the script.

Also, as you suggest, these will become a lot shorter when the
standard test helper shell functions are used.  I do not think we
necessarily want a brand new test script to test only three or so
combinations (i.e. last one wins when --option and --no-option is
given, --option has an effect, --no-option does not have an effect).
