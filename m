Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD4C202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 16:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdGEQWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 12:22:20 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34977 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdGEQWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 12:22:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so132101107pfk.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O6TedDjL+uofvo2U5O0eDJnX+shI1ywzGk+RlPG+9y8=;
        b=Nj2OwQMx3YbHoPwGpn2IpZcLU5OPv/0XU/cVIMXHE83bHD256RJxEbMUuXVy4L8XCL
         BbUeDXpDIxnAKE1BGuBe5qPTLhKPUBBj3mq9osQV18VKSTKajhDjmyVm6KKFPBTQ67nR
         deaeLbueFk1IaGmhQZ5MrGklBmC9wvcVIJgaSj8iy7Sh7GVmYOoGa6GxEXGnAUveoPRi
         4YSns7NZemP72L+3IlGuYtd9a9nO/O2nUUzrbT2bP+eQbIY5ZMymbngqF3/9Ygch4Mgr
         rYadcdfY7/vyww9t1X1t+NwjslGfuCTTWi1ngZNoQvanxM4ZiX7AWN0WDPzvUrK9S1rp
         T60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O6TedDjL+uofvo2U5O0eDJnX+shI1ywzGk+RlPG+9y8=;
        b=K3lEIifpwROBfUujr08GseY9G/jjj7+yq/UWPV4zcUG+Jl6jAFWH3o8rNS2j6W80rF
         ZdHJePsqM6MKSw3srIuwLvelvpOfGxilWGuoD8H81ZZ3GlZJ/KbbTHSzWAv1ONNOMvgt
         jiah39QVpMoJyuF+tHKJUQfepqiYBTNjA7bE32XECg+x9u1OdG9Od8VTEM2WCj8/zfYe
         ZjgADv35FUeT34JfxPTZ0fc9Uc1COvGl3jEbH02ugos0QMx5WUv1wGOiBTiKvHmdNoK2
         tTR0X0MrpKTZHxXZKDK7Z+CabhLb0HAKKzfCN4FouEvnVlhhCRinxckmGjN6BMHBlMOB
         ft7g==
X-Gm-Message-State: AIVw113HdP7CTVRv43WcSwmuaRZ/mC0Kxks4jeV5OwtwHXnxWwmEz8cm
        FJyJp+AVaVY6iMb6/VE=
X-Received: by 10.98.80.198 with SMTP id g67mr21769593pfj.146.1499271736028;
        Wed, 05 Jul 2017 09:22:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id r69sm52864669pfg.28.2017.07.05.09.22.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 09:22:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, xiaoqiang zhao <zxq_yx_007@163.com>,
        Emily Xie <emilyxxie@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
        <87podkehcx.fsf@gmail.com>
Date:   Wed, 05 Jul 2017 09:22:13 -0700
In-Reply-To: <87podkehcx.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 01 Jul 2017 09:39:10 +0200")
Message-ID: <xmqq60f6kg5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 30 2017, Junio C. Hamano jotted:
>
>> * xz/send-email-batch-size (2017-05-23) 1 commit
>>  - send-email: --batch-size to work around some SMTP server limit
>>
>>  "git send-email" learned to overcome some SMTP server limitation
>>  that does not allow many pieces of e-mails to be sent over a single
>>  session.
>>
>>  Waiting for a response.
>>  cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
>>  cf. <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>
>>
>>  """I thought your wish (which I found reasonable) was to record
>>  whatever information that would help us in the future in the log
>>  message?  I was waiting for that to happen."""
>
> I think it's fine in lieu of xiaoqiang zhao not being responsive to just
> merge this as-is. The info that can help us in the future is in the ML
> archive, which should be good enough.

OK.  I'll amend to add a few lines of note to the commit log and
then merge it down.

> So my WIP is, and I'd like feedback on the viability of the general approach:
>
>     create_test_file() {
>     	file=$1
>
>     	# `touch .` will succeed but obviously not do what we intend
>     	# here.

If you want to create, do not use "touch" that gives readers a false
and confusing impression that you care about the timestamp of the
thing being updated.  If you say ">./$file", you can get an error from
the shell just fine, I think.

>     	test "$file" = "." && return 1
>     	# We cannot create a file with an empty filename.
>     	test "$file" = "" && return 1

Likewise, as that would become ">./".

>     	# The tests that are testing that e.g. foo//bar is matched by
>     	# foo/*/bar can't be tested on filesystems since there's no
>     	# way we're getting a double slash.
>     	echo "$file" | grep -F '//' && return 1
>     	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')

GNUism already pointed out, I think.
>
>     	# We touch "./$file" instead of "$file" because even an
>     	# escaped "touch -- -" means something different.
>     	if test "$file" != "$dirs"
>     	then
>     		mkdir -p -- "$dirs" 2>/dev/null &&
>     		touch -- "./$file" 2>/dev/null &&
>     		return 0
>     	else
>     		touch -- "./$file" 2>/dev/null &&
>     		return 0
>     	fi
>     	return 1
>     }
>
> And then later on for the tests I do:
>
> 	# The existing test
> 	test_expect_success "wildmatch:     match '$text' '$pattern'" "
> 		test-wildmatch wildmatch '$text' '$pattern'
> 	"
>
> 	# My new test
> 	if create_test_file "$text"
> 	then
> 		test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
> 			test_when_finished \"
> 				rm -rf -- * &&
> 				git reset
> 			\" &&
> 			git add -A &&
> 			>expect.err &&
> 			printf '%s' '$text' >expect &&
> 			git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
> 			test_cmp expect.err actual.err &&
> 			test_cmp expect actual
> 		"
> 	else
> 		test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
> 	fi
>
> This still needs to be cleaned up a bit to be parameterized (i.e. the
> --glob-pathspecs argument, whether it should error etc.).
>
> It works for me on Linux, but I'm wondering if others see any issues
> with the approach, does simply trying to create bizarro filenames on
> some OSs cause issues? I don't think so, but let's make sure.

Issues meaning that the test wants to see how a pathname with ^I in
it works but create_test_file step would fail?  Your above construct
covers that with the if/then/else test_expect_failure/fi just fine,
I think.
