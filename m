Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789D51F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfAaXlp (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:41:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34341 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfAaXlo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:41:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so5262019wrp.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/b0St8AaWGQLH1C0sYsvrfQZkGGFHFyBFDqfbUx33xM=;
        b=fkn0h8V0VOVBTA3m3bhKsxF6GczIafZz8XtEbhdjdvVA3rWcev92tmAbQfZb+qequZ
         FW6wWgSMnzl97gMwoJ+Hf8FXnTckz70o6AVIif9wg1H/AH3EEdoBw3yejL2HpVxGNOEP
         PVwuhSKy//n2gTTAhMHuKdiUL+g9I9Lv2HrFR9AEEqn/S6a09glg+VFtR7BfGMFvxzoE
         4QLwKxJ/G2fNXoBlqOYHcJ3m6tGnyhN6arc7102O66yw5RSuMT+rbpLrl4cy5xWOG7Lw
         IRyYxjiMrS+P8LwdP77C/ROoYXo81eqnaucVR5W8F0qZMzdgL/0DL+lg4P0WRnLgqo1H
         ZewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/b0St8AaWGQLH1C0sYsvrfQZkGGFHFyBFDqfbUx33xM=;
        b=EIdi86ovnt32i4HuQ70xZ+fyCwGvqkJiOVZdJFXwFwhWasXaj97lzPtKMTH9tLOGQM
         sCXWD44S+8enmodCPchUGqyu4cOcTY4ws1be1n0OyLUXmMmk4mUzNsvXFzFzEN/w8L8m
         9ksIrJEKFgTKeJUlWe49Fa/LUqSUlK/9jb0TM5S7xOTk34adebgl5dONBgchw8PrmwaL
         3u1SqDOjsuzXtb5Od0Lmrjc7vv7Sjfw8fERm+y0dHMuz6S8QUP1DRS3DIqybEkuRkhvi
         rMbvGVrx2vbNk+l38953YWn6cC7NJpLRemBud34XyI2RVrC1lpuDFJrhI6ddBdj2BDCl
         WAAw==
X-Gm-Message-State: AJcUukfy2Aj5xYm4WrTMYJUmVIDldpWF8V6X0Cp/xJFjAK9zPF8fXoNZ
        f40qtBrD9WCWYBbBv4IR7p4=
X-Google-Smtp-Source: ALg8bN5PP7ibF65zwbT7Dk7C/PJRDRCWFMujR+X964a79/SCvG0rkTtGfO6UxurHO+hKGnmgGGL7Pg==
X-Received: by 2002:adf:d112:: with SMTP id a18mr37928815wri.17.1548978101820;
        Thu, 31 Jan 2019 15:41:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f3sm1046388wmd.22.2019.01.31.15.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 15:41:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v4 14/14] trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
        <8d47cd71ede3fd4e932e26756ef8f3f82b41d659.1548881779.git.gitgitgadget@gmail.com>
        <20190131232851.GD10587@szeder.dev>
Date:   Thu, 31 Jan 2019 15:41:40 -0800
In-Reply-To: <20190131232851.GD10587@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 1 Feb 2019 00:28:51 +0100")
Message-ID: <xmqqtvhoz96z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Jan 30, 2019 at 12:56:34PM -0800, Jeff Hostetler via GitGitGadget wrote:
>> Create unit tests for Trace2.
>
>> diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
>> new file mode 100755
>> index 0000000000..517d5514df
>> --- /dev/null
>> +++ b/t/t0212-trace2-event.sh
>> @@ -0,0 +1,234 @@
>
>> +test_expect_success 'event stream, return code 0' '
>> +	test_when_finished "rm trace.event actual expect" &&
>> +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
>> +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
>> +	sed -e "s/^|//" >expect <<-EOF &&
>> +	|VAR1 = {
>> +	|  "_SID0_":{
>> +	|    "argv":[
>> +	|      "_EXE_",
>> +	|      "trace2",
>> +	|      "004child",
>> +	|      "test-tool",
>> +	|      "trace2",
>> +	|      "004child",
>> +	|      "test-tool",
>> +	|      "trace2",
>> +	|      "001return",
>> +	|      "0"
>> +	|    ],
>> +	|    "child":{
>> +	|      "0":{
>> +	|        "child_argv":[
>> +	|          "_EXE_",
>> +	|          "trace2",
>> +	|          "004child",
>> +	|          "test-tool",
>> +	|          "trace2",
>> +	|          "001return",
>> +	|          "0"
>> +	|        ],
>
> Just curious about the vertically aligned '|'s: are they there to
> circumvent 'git diff's big red whitespace warnings on these deeply
> indented lines?

I suspect that the reason is some of the lines have 8-spaces or more
after '|', that can be tabified, but when tabified, <<-EOF will strip
that second and subsequent tabs.
