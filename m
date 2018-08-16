Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBD11F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeHPXnE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:43:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54818 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeHPXnE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:43:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so5649219wmb.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jpVwp6N21LLiGPHf9Z+z0lct8wpn4LIE9ilCtRGY3Kw=;
        b=u0sQhetMqACFcof57plC9g5As98jdd2jxl4iN97RMpPRXRpaFF1Sjy/EOzv527LqHc
         6DINUZzWfdBMdWlPR9fwBuV1aOMrqwq2VdTQoxs8ixrVAfV+Zl+Fp8/XTOLFldxU2pNE
         H9tDP2PTJ0NxXGWXaOz8R5wc3ZrAqIVow2f8FL+1eBVSRk77XrxeaqsYwWv3S4AXBRuD
         0r+6eezIarSJ+Dyok+QpQp1SDX8hmdR61G+W3ZT2BmRiB23hSU6/MUT7OLaC/QcWF1v3
         fGz6dIqy+BHuaWBHXrDdKnXlymEq4k43uP2RBaRUa2E5q6BuPQW4w4g4YPCQW/QGz2/S
         YGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jpVwp6N21LLiGPHf9Z+z0lct8wpn4LIE9ilCtRGY3Kw=;
        b=Nj8X5EeE6NlMPm3W4qfl/0LHwySAastK7MJbai4enqHiE5gtTFglJpdSHIR+85r7Ba
         ecjS+mcMNgXJn4VJhV2UoxI/aT44YZT05qFUleVGG4iMfF3X9B1I/V4S4THgpyNd1uG2
         ZIn+tQBwCMR4b+IQrO806xAqcci6OBhei9tYDwES656Fs8xmfHnyLR1HG8bwqHSEC3MY
         Vx0M5IrjlZ+rAmZi9t7LklfY/PrEdCfmdm84k772Vn8vulJRMc1O0/wNnAll65JES7OB
         Obj7iy9itOTc3GtG0bheJ5gLp/vNcyZqAyRiHhD9HSJriOOmZu7iVj1sjvr4p0hTAwxh
         z0PQ==
X-Gm-Message-State: AOUpUlEH4oj80cpMmaBLLPtiTvZrYg9p8QPf+D5YjnIq9zn/SGXbACAY
        +tyKXhKw6D+D6MOsoZVc1GM=
X-Google-Smtp-Source: AA+uWPx/UlM7ZvG3d0sg2rh7JrgeFmafmlQ+ipBsavE5yZluxDrpap/RZWoGxyX0xhWQbyDpIFTGJg==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr17325782wmf.161.1534452146009;
        Thu, 16 Aug 2018 13:42:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b13-v6sm189069wrn.17.2018.08.16.13.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 13:42:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, karen@codesynthesis.com
Subject: Re: [PATCH v2] worktree: add --quiet option
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
        <xmqqftzedp3p.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 16 Aug 2018 13:42:25 -0700
In-Reply-To: <xmqqftzedp3p.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 16 Aug 2018 13:38:02 -0700")
Message-ID: <xmqqbma2dowe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
>> index be6e09314..658647d83 100755
>> --- a/t/t2025-worktree-add.sh
>> +++ b/t/t2025-worktree-add.sh
>> @@ -252,6 +252,11 @@ test_expect_success 'add -B' '
>>  	test_cmp_rev master^ poodle
>>  '
>>  
>> +test_expect_success 'add --quiet' '
>> +	git worktree add --quiet ../foo master >expected 2>&1 &&
>> +	test_must_be_empty expected
>> +'
>
> That's misnomer.  Unless existing tests in this file are already
> bogus, I'd like to see it called 'actual', which is the name we use
> to store the actual output (to be compared with another file we
> create to hold the expected output, typically called 'expect', like
> "test_cmp expect actual").
>
> I noticed the breakage after merging this to 'pu'; it seems to die
> with "fatal: ../foo already exists" which comes from die().
>
> Oh, more seriously, since when is it OK to muck with stuff _outside_
> the $TRASH_DIRECTORY, e.g. "../foo", which would contaminate t/
> directory by creating a direct subdirectly under it?
>
> Ahh, and I suspect that it is exactly why I am seeing a failure you
> did not see---from a previously failed test cycle, "t/foo" is left
> behind because "make distclean" would not clean it (of course).
>
> Do not ever touch anywhere outside $TRASH_DIRECTORY.  Is this
> something we could enforce in our test harness, I wonder...
>
>>  test_expect_success 'local clone from linked checkout' '
>>  	git clone --local here here-clone &&
>>  	( cd here-clone && git fsck )

A quickfix (I wish I had a lot more time to spend to be extra
careful, bit I don't) I'll apply for now to get going...

 t/t2025-worktree-add.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 658647d834..c674697913 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -253,8 +253,8 @@ test_expect_success 'add -B' '
 '
 
 test_expect_success 'add --quiet' '
-	git worktree add --quiet ../foo master >expected 2>&1 &&
-	test_must_be_empty expected
+	git worktree add --quiet another-worktree master 2>actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'local clone from linked checkout' '
