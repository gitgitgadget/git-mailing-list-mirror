Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA221F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbeGKURC (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:17:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56009 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733004AbeGKURC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:17:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so3494680wme.5
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W4zGl86prrCx++Mq7trSN42MbHb8Y7SBYw5f9hmYVu4=;
        b=MuaezYc3wso7HpQslVmWSJk45LabxgEG4yi8zIn9jf6ewqvwgGBaiZGza0C+iJf/sl
         UxbgIypXjRTQLq2cCK/KsEJR9J8ncwU9bOKAzhNWdyOLU5qKOKdrxlsixu/JoAvgXMtz
         0PJyfC5xESdLyk1dHZK1E+HEfSPoPb0HknduNIV/oOsQVFEcNljpd+zjYcOnpK9mjiKZ
         x/iBNdqFpUDwcfKkPkNPjQb05nLkAWHOzpv5Ui/3reXdKWBA8Eb/XCJC3DGMLemd5C2Z
         CqR/aPwEhPZOWduezqiiQAXOyvJnN9J1zlfS6ZkggidcPiD9p2WLPqGLhGsGKHic3ZBE
         2zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W4zGl86prrCx++Mq7trSN42MbHb8Y7SBYw5f9hmYVu4=;
        b=sc1TYXArIxC7yePC0AiL46tblvHB+umuDIIbNaIsIOIhZ7amw6BltZk70rUeBn8q6x
         a5MHIx/G89ou7AG7SlQoFo2ydbEXyIBdANRyqtEKJ3LFu2JYkQLgS+z+QgjwgKt5y0uC
         +lX5d56JCRIptArOj5dSy6qEkQwzd5XWAqTegcxzygqYSRZZ4SWDkbEu0scFwblDeF4H
         9ctwafunfvt2CQJ02HuqNFwe9ZLaYr7Z5VWQQUT8dbohHmsATCsuusveXSeNaE8jt/CJ
         BAfFUGWCI/p/oDl+Msg9kpqulrSKMdVh9H1P53G6Zl6+yeE9TD6iHXn6Wgbz0EQF4wjB
         DrWg==
X-Gm-Message-State: AOUpUlHKps/1rsI2Kwr38eMcKeuSilJ1z1wvbbLiazEZ+SuxhW6U0+sX
        NPnDW4jbpp6l8N2BtFpug2PUc9Gq
X-Google-Smtp-Source: AAOMgpfr6GVRwzwNDdmcQAsUQKQuAEG0fVo4BVAe1lis0jQXBVt7ZEhsJlcrhV+sVzKc7zorZLmafQ==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr2383wmf.89.1531339863456;
        Wed, 11 Jul 2018 13:11:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t10-v6sm16540743wrs.59.2018.07.11.13.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:11:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v1] handle lower case drive letters on Windows
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <CAGZ79ka=HfzKprETBJ=+sdQsUZPXgHsgoqNWkbHprUGgLMggUA@mail.gmail.com>
        <BL0PR2101MB1012D2CC0BEA20AB35CBE967F45A0@BL0PR2101MB1012.namprd21.prod.outlook.com>
Date:   Wed, 11 Jul 2018 13:11:02 -0700
In-Reply-To: <BL0PR2101MB1012D2CC0BEA20AB35CBE967F45A0@BL0PR2101MB1012.namprd21.prod.outlook.com>
        (Ben Peart's message of "Wed, 11 Jul 2018 19:07:09 +0000")
Message-ID: <xmqq36wp3549.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>> -----Original Message-----
>> From: Stefan Beller <sbeller@google.com>
>> Sent: Wednesday, July 11, 2018 1:59 PM
>> To: Ben Peart <Ben.Peart@microsoft.com>
>> Cc: git <git@vger.kernel.org>; Junio C Hamano <gitster@pobox.com>
>> Subject: Re: [PATCH v1] handle lower case drive letters on Windows
>> 
>> On Wed, Jul 11, 2018 at 10:54 AM Ben Peart <Ben.Peart@microsoft.com>
>> wrote:
>> >
>> > Teach test-drop-caches to handle lower case drive letters on Windows.
>> 
>> As someone not quite familiar with Windows (and using Git there),
>> is this addressing a user visible issue, or a developer visible issue?
>> (It looks to me as the latter as it touches test code). In which way
>> does it improve the life of a developer?
>> 
>
> It is a developer visible issue.  On Windows, file names (including drive
> letters) are case insensitive.  This patch improves the life of a Windows
> developer by making drive letters case insensitive for the test-drop-caches
> test application as well.  Without this patch "test-drop-caches e" will fail
> with an error "Invalid drive letter 'e'" instead of succeeding as expected.

I think one point of the original question was if it is common for a
developer to say "test-drop-caches e" from the command line, or the
helper is run solely by being written in some numbered test script
directly under t/.  In the latter case, it would be reasonable to
expect and insist the scripts to use the more canonical form, even
if the platform is case insensitive (assuming E: is more canonical
than e:, that is) no?

In any case, a larger point is that it would help other people who
read the patch and "git log" output, if the answer you gave Stefan
in the message I am responding to, and another one that you may give
me in a response to this message, were in the proposed log message
in the patch.

Thanks.
