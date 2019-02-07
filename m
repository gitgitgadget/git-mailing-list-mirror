Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA521F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBGTE5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:04:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52352 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBGTE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:04:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so1029048wml.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LZZafoxJ7hgep28P5WtfwbeBtILGgCB6tnAaXJqKn3E=;
        b=hrwPN1JK4fzhUnVybxFm35BFlNoo2evS5N9JO+zW3nWb1EIhJhDWCx87Wn3kW189ns
         Koo+U4aC3TfLT32iXs37sZohnPhdfJ1J2jIAUJpJUa5i+rO3mzrYLuSPlsiie9UMwWal
         CeTKY7dINTA6o6GiDiwFWycouN9outufbAJvTkkmgb4gd9HXpYN0hGulirx1+AURjT2W
         kFnClFU700SeGwjU5KGL3kySsVFnb1eEoqjtTPsAgzutKjxyY3GaEqIxEbKzBctNgR/g
         8FhLaf0zNdfyWDslLKHK986dTJpF7zL6ief9KR+c39rPPmfXo2OorljAU637Jjw8OXzf
         DVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LZZafoxJ7hgep28P5WtfwbeBtILGgCB6tnAaXJqKn3E=;
        b=AXtLqt6UiNh95fohjS1odxb/dN5H+OZ3OFn779QvJE0jJBpVU1YLjKNfTWZ98GE+n7
         B9OtaqSXOhn/4I6ATzTUgRVaRCQ4OWomsnx0pNFn0mSR4BR09ECacTRWRjbPLtVabE64
         LV73Bm5RNiybPaM1WxE/OXOTh6xj7n8Ci0Kxc3i/oaXEoCKoebFvVXbcnhTuFMVT+Cx3
         Omr5PF4VRwHIQQb4iKoT3oun+YOzcBkhPqHmhViX7pss/ayEbCem74nv+qVqHlA6vJvi
         mw09kN9d44GfbM6LpmEuzO/br4vyV9aZDPlOy8nnoy6EQOmqieEhOsm7z8WPYvZTJ/ku
         DCCQ==
X-Gm-Message-State: AHQUAubJo1qGUous+vhyZpwap+gRr1V2GXH2dGqAqtYHIxpAAwbuKc2y
        735fHd7IPMvGGKgcHltv/T9jsRj0
X-Google-Smtp-Source: AHgI3IYknhzskJY9RvxFUUbkRE+0UaRfzg1w4rflgmcOTy4KWM0pij9MhQqytC4THoGio+tsIRdjeg==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr8434784wmf.105.1549566294570;
        Thu, 07 Feb 2019 11:04:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o64sm63866wmo.47.2019.02.07.11.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:04:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
References: <20190207183736.9299-1-szeder.dev@gmail.com>
        <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 07 Feb 2019 11:04:53 -0800
In-Reply-To: <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 07 Feb 2019 11:00:14 -0800")
Message-ID: <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> Append to MAKEFLAGS when setting the compiler to use, to ensure that
>> the number of parallel jobs to use is preserved.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>  ci/lib.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> index 16f4ecbc67..cee51a4cc4 100755
>> --- a/ci/lib.sh
>> +++ b/ci/lib.sh
>> @@ -185,4 +185,4 @@ GIT_TEST_GETTEXT_POISON)
>>  	;;
>>  esac
>>  
>> -export MAKEFLAGS="CC=${CC:-cc}"
>> +export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
>
> Makes sense.  Thanks.

Wouldn't all other hits of "MAKEFLAGS=" in ci/lib.sh also want the
same treatment, though?  We know that "if travis to this, otherwise
if Asure, do that" is the first block to muck with MAKEFLAGS in the
script, but a new assignment before that block can be added in the
future and cause a similar issue unless we do so.

Of course, at some point we do want to say "we do not want to
inherit it from the outside environment", but then such an
assignment of empty value should be done at the very beginning with
a comment, not with "this happens to be the first one to set, so
let's not append but assign to clear any previous value", I would
think.

