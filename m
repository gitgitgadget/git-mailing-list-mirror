Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80931FF30
	for <e@80x24.org>; Mon, 22 May 2017 01:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbdEVBTz (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 21:19:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33200 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755502AbdEVBTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 21:19:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so16258443pfe.0
        for <git@vger.kernel.org>; Sun, 21 May 2017 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6gE4Tc3euCgALFoOKKyd1/H9Y7Pn5+MRlQ7Klax3LUE=;
        b=hZYLEKxgozYz1ppCzUW1q24+G7oMt9kgp9LiuFiaBVHR3CJdQTVT15Aphy1FFszoLz
         09zX/My13kqlCA+9egjHXbTvXh+D6kDwIJ8IXGfOcSeTexhsBPpd0/CHETO86puBLIXn
         +Ujm/ZTijAqrVZIVHPjwBW4ld+Nzl/DTZ49bSutllFCHBURf7kkN8khRYWx+AHJmUL3L
         R3bFWOsZP2vL8zSVwOLyHK6oYKMjRej2uor1O6qzNdG64mkqkLLAEr7hmZSSZNQEzdlk
         yyYraks5N/4KUcylhSB+GlQjZBKPnvJDNdHx0jqpAtT6iXtIPfnTqtI5eHiiMzCmOHlN
         /RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6gE4Tc3euCgALFoOKKyd1/H9Y7Pn5+MRlQ7Klax3LUE=;
        b=a6bHVFibu/TIYsDj60gGhV+BeuNCciPXNvK5Yf572BDXK8OQ0ZKJgKHauOz7zzDFSU
         xaZkC1To4cmXOj7XKcmfLjo16drh62ilOPuWW2W897SStIN5IdhqOBymA7aZXAT4nEQK
         smVPJ5ac9tOcyAGvLJxjB785Zde1OuITyi3nnQHHpXTXYVEdFAwE2KuN7zcZ2fNMul8p
         ZWKQSawDK4HWUmEZpuowH+58pNfIKlGVbWzILW7hRhEl+JaXucNmoRFLqjeqHQng7mgX
         HGh0+IV6APwVu/kgeoS5hB4aMMwzR26Nx+UwGl04JtGIBEC3UrsoqAzQjYow0GdEbNt/
         lomA==
X-Gm-Message-State: AODbwcDUiScnjrBnmwE2MyelkLKR3PfKxku5WTMqUEI5/Q5tBt4yw4vB
        AsMbvw1rHxDlW6AZgmE=
X-Received: by 10.98.89.5 with SMTP id n5mr22381447pfb.2.1495415993550;
        Sun, 21 May 2017 18:19:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id y5sm23558589pgb.4.2017.05.21.18.19.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 18:19:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     DOAN Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, animi.vulpis@gmail.com, j6t@kdbg.org,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
        <20170521134209.25659-1-congdanhqx@gmail.com>
Date:   Mon, 22 May 2017 10:19:52 +0900
In-Reply-To: <20170521134209.25659-1-congdanhqx@gmail.com> (DOAN Tran Cong
        Danh's message of "Sun, 21 May 2017 21:42:09 +0800")
Message-ID: <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DOAN Tran Cong Danh <congdanhqx@gmail.com> writes:

> Starting from commit 949af06 (branch: use ref-filter printing APIs, 2017-01-10),
> `git branch -v` doesn't treat CRLF as line separator anymore.

A seemingly good problem identification (but not quite; see below) ...

>
> Quote from git mailing-list:
>
>> Here is a recipe to reproduce the error:
>>
>>    git init
>>    git commit --allow-empty -m initial
>>    git branch crlf $(printf '%s\r\n' subject '' line3_long line4 |
>>        git commit-tree HEAD:)
>> The reason for the "bug" is obviously that a line having CR in addition
>> to LF is not "an empty line". Consequently, the second line is not
>> treated as a separator between subject and body, whereupon Git
>> concatenates all line into one large subject line. This strips the LFs
>> but leaves the CRS in tact, which, when printed on a terminal move the
>> cursor to the beginning of the line, so that text after the CRs
>> overwrites what is already in the terminal.

... and good analysis.

However.

If you look at how `git branch -v` before that problematic change
removed the extra CR, you would notice that pretty_print_commit()
was used for that, which eventually called format_subject() with
"one\r\n\r\nline3...", got one line "one\r\n" by calling
get_one_line(), adjusted the line length from 5 to 3 by calling
is_blank_line() which as a side effect trims all whitespaces (not
just LF and CR), and emitted "one".  The reason why the next \r\n
was not mistaken as a non-empty line is the same---is_blank_line()
call onthe next line said that "\r\n" is an all-white space line.

So, while I think the realization that we have a problem, and the
analysis above i.e. "emptiness of the line matters", are both good,
but I do not think this is suffucient to get back the old behaviour.

The thing is, we never treated CRLF as line separator in this code.
What we did was to treat LF as line separator, but trimmed trailing
bytes that are isspace().  That is what the analysis you quoted from
J6t says.

Here is your test addition:

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 5778c0afe..29b392066 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -13,7 +13,8 @@ test_expect_success 'make commits' '
>  
>  test_expect_success 'make branches' '
>  	git branch branch-one &&
> -	git branch branch-two HEAD^
> +	git branch branch-two $(printf "%s\r\n" one "" line3_long line4 |
> +	     git commit-tree HEAD:)
>  '

If you change this test to

> +	git branch branch-two $(printf "%s\n" one " " line3_long line4 |
> +	     git commit-tree HEAD:)

then the old code before the problematic change will only show the
first line i.e. "one" in "branch -v" output.  I think with or
without your code change, the new code would still show line3_long
and line4 in the output.
