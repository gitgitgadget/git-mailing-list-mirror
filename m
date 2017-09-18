Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6BD2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 15:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdIRPZX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 11:25:23 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45738 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdIRPZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 11:25:22 -0400
Received: by mail-qk0-f181.google.com with SMTP id r141so873715qke.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uqkjwaUPnSOgmHIq8ccQwTD082TSo4NxiWCbuOVqHa4=;
        b=MQgs16aTSmVuC0ObzmKNwBKtyoxqV2+0lph3eagjej88wS+xK1V6ToBaA5cFwboGrv
         1Hp08LUO3MVBuPrxOgKUOi0tAxHvLXU1MgbM3m+VUjNX7jtK2UPzwHsHZ83CR4+l//ol
         Om5dP4M5DkzyIcRtlHi7dEs7wAHrzbIhARW/7WmzZy7y/EheW0WEbHtV1jNFBkjWfrcr
         EdMKi/EJOVhY7zJZdnlNcwqlBvtqZ6JXMFzhezGHvZ6n7klZVj16W/YjA2Xu0/mjpcj6
         7B++OL5ui8n9/hNweMFHfJzG1brpBAtqY9YWBKlU/2GVouf/PA0AhemnLBanNWRZSw4q
         a85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uqkjwaUPnSOgmHIq8ccQwTD082TSo4NxiWCbuOVqHa4=;
        b=iWvzthgzP3dAWE8vI2kfAplbqmXoKzI4ACXcFHwdRZZVs1r2coWk2eMmGdOjkdJSUh
         3f+7fr6WmBZ5UiLSsv9tXM0ypcILnnc3Meut+Tg4v52BCoATuL3ZC/5DnSZ8i53I8hTw
         PLP0mDaGLTa3XCqNdq5jY3mmV/umaTjB86zMETljM6+brcRfqOj/NlCa10IgiBrWCoQW
         AqHpsVrDvFCyBeT6Hz60vAUN11Csb7OuGMDVKZgEaa1o0ygHpq6v7Bdt0TpfkiQ2BpCu
         /3Cdo7TN2N8s4oGaGzqyzL+hRwzY87VLdvl8qxReAKKKshUfh5UbxM3SQOd5wJDohfp/
         HD+w==
X-Gm-Message-State: AHPjjUiRVgMm35GmLdBQEDfUFYvSDTMvcMUPURAzNotT0ARbT+xcFC3I
        e2HkQ0f3rfr0hw==
X-Google-Smtp-Source: AOwi7QBDaFixd6YMEnwI7tJa0B+AwF1eCJLMWmPWeydLnTzjTmzZDTM1ZY3lIEOj8yilEfeTwvHZOg==
X-Received: by 10.55.75.11 with SMTP id y11mr20253218qka.96.1505748321257;
        Mon, 18 Sep 2017 08:25:21 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id b77sm5206040qkg.26.2017.09.18.08.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 08:25:19 -0700 (PDT)
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
 <xmqqy3peszho.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2f3cdc85-f051-c0ae-b9db-fd13cac78aed@gmail.com>
Date:   Mon, 18 Sep 2017 11:25:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3peszho.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/17/2017 12:47 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> +write_integration_script() {
>> +	write_script .git/hooks/fsmonitor-test<<-\EOF
>> +	if [ "$#" -ne 2 ]; then
>> +		echo "$0: exactly 2 arguments expected"
>> +		exit 2
>> +	fi
>> +	if [ "$1" != 1 ]; then
>> +		echo -e "Unsupported core.fsmonitor hook version.\n" >&2
>> +		exit 1
>> +	fi
> 
> In addition to "echo -e" thing pointed out earlier, these look
> somewhat unusual in our shell scripts, relative to what
> Documentation/CodingGuidelines tells us to do:

I'm happy to make these changes.  I understand the difficulty of 
creating a consistent coding style especially after the fact.

<soapbox>

Copy/paste is usually a developers best friend as it allows you to avoid 
a lot of errors by reusing existing tested code.  One of the times it 
backfires is when that code doesn't match the current desired coding style.

I only point these out to help lend some additional impetus to the 
effort to formalize the coding style and to provide tooling to handle 
what should mostly be a mechanical process. IMO, the goal should be to 
save the maintainer and contributors the cost of having to write up and 
respond to formatting feedback. :)

Some stats on these same coding style errors in the current bash scripts:

298 instances of "[a-z]\(\).*\{" ie "function_name() {" (no space)
140 instances of "if \[ .* \]" (not using the preferred "test")
293 instances of "if .*; then"

Wouldn't it be great not to have to write up style feedback for when 
these all get copy/pasted into new scripts? :)

</soapbox>

> 
>   - We prefer a space between the function name and the parentheses,
>     and no space inside the parentheses. The opening "{" should also
>     be on the same line.
> 
> 	(incorrect)
> 	my_function(){
> 		...
> 
> 	(correct)
> 	my_function () {
> 		...
> 
>   - We prefer "test" over "[ ... ]".
> 
>   - Do not write control structures on a single line with semicolon.
>     "then" should be on the next line for if statements, and "do"
>     should be on the next line for "while" and "for".
> 
> 	(incorrect)
> 	if test -f hello; then
> 		do this
> 	fi
> 
> 	(correct)
> 	if test -f hello
> 	then
> 		do this
> 	fi
> 
>> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
>> new file mode 100755
>> index 0000000000..aaee5d1fe3
>> --- /dev/null
>> +++ b/t/t7519/fsmonitor-watchman
>> @@ -0,0 +1,128 @@
>> +#!/usr/bin/perl
>> +
>> +use strict;
>> +use warnings;
>> +use IPC::Open2;
>> + ...
>> +	open (my $fh, ">", ".git/watchman-query.json");
>> +	print $fh "[\"query\", \"$git_work_tree\", { \
>> +	\"since\": $time, \
>> +	\"fields\": [\"name\"], \
>> +	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
>> +	}]";
>> +	close $fh;
>> +
>> +	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
>> +	\"since\": $time, \
>> +	\"fields\": [\"name\"], \
>> +	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
>> +	}]";
> 
> This look painful to read, write and maintain.  IIRC, Perl supports
> the <<HERE document syntax quite similar to shell; would it make
> these "print" we see above easier?
> 

I agree!  I'm definitely *not* a perl developer so was unaware of this 
construct.  A few minutes with stack overflow and now I can clean this up.

>> +}
>> \ No newline at end of file
> 
> Oops.
> 
> Thanks.
> 
