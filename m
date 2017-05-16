Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEBD201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdEPAXe (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:23:34 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35608 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEPAXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 20:23:33 -0400
Received: by mail-pf0-f180.google.com with SMTP id n23so66012062pfb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1ykj3Fq9RJ32pUusAW894SrRtyXWZabqsEOZT1xFVr4=;
        b=tXgWSYfXMs3yYv1o9ODvtgCMXjwCrWEhyeaNyua8F6Ia78vkU6SCwPsFDHTKfJ70el
         zuzNkmkHdBQ7elJXaASOFKjETDWd2MWWuU0PtI6mtnFwFgn1Silee4UpermKxt5KDVgm
         xaaBuFHIo+6JPdMZrd6hFiDWy99DmJZHHwpaP3FnYl69SKlM3G0+YQUkUDo2T3NvagPL
         01DUFYCHXVwKqBqhzSQSVVqUE+AuDloPMnnpR+EQ3uq3VX7TU6PJIxl53PZl5pXDExB7
         TkQ1hlm0UIcSHqNV7K5jKto7rbNX2BMeLRecuteQZHpZ5ocw9QIL5/DOZY6tfvAeYO2k
         jQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1ykj3Fq9RJ32pUusAW894SrRtyXWZabqsEOZT1xFVr4=;
        b=VhOAWcuAGP+E1rsDhbDDQjBTKGLtN9JgTtsbUzh+dsNny6i8Td5llOFrRyGwWaGvyZ
         vhpsaTyNSzwRKJWK3xfU5kRzydYKGjpaTI4a7lFwZTcRfkwdK9T5XnUvURzZEf1NeZBG
         c5SffskID0T4D+/aE5ZCSZxAm7fXgZ3MzVBQPagchOJQx9cdhIB4HD7d2gO2BkA8vFaA
         qY8/s5i4NerwfUbUAa0yuLRSySNzWRk9F6KVEHgoFtYYkYpwd8K6gZvxhmlXUzJpMQOd
         J6KUfPOSvjgci4PDTusUB1sQuV0DdQahS+/I9wgCpVNGwPLaGglxFGnQz7EjWIRjvxvx
         glIw==
X-Gm-Message-State: AODbwcDiEjObgnXrDebSfpYFW0m7Q6CBtau7V7AYYuB9DJV7CCmV6t5g
        7zgbKqLMwDOKNA==
X-Received: by 10.99.97.68 with SMTP id v65mr9011098pgb.76.1494894212502;
        Mon, 15 May 2017 17:23:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id 194sm18012663pgf.62.2017.05.15.17.23.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 17:23:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Smith <whydoubt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 00/22] Add blame to libgit
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170514031513.9042-1-whydoubt@gmail.com>
        <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com>
        <CAPX7N=4jidx5pr3BfFoTL27gbHDT6sdm1q2Z2YxfjsBuN01XaQ@mail.gmail.com>
Date:   Tue, 16 May 2017 09:23:31 +0900
In-Reply-To: <CAPX7N=4jidx5pr3BfFoTL27gbHDT6sdm1q2Z2YxfjsBuN01XaQ@mail.gmail.com>
        (Jeffrey Smith's message of "Mon, 15 May 2017 08:52:10 -0500")
Message-ID: <xmqqefvp6458.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Smith <whydoubt@gmail.com> writes:

> On Mon, May 15, 2017 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff Smith <whydoubt@gmail.com> writes:
>>
>>> Rather than duplicate large portions of builtin/blame.c in cgit, it
>>> would be better to shift its core functionality into libgit.a.  The
>>> functionality left in builtin/blame.c mostly relates to terminal
>>> presentation.
>>
>> As I said in my review of 04/22, it is a bit hard/tedious to sift
>> the changes to refactoring that actually changes code and pure
>> renaming and movement of lines across files with the current
>> sequence of the series, so it is very possible that I may have
>> missed something, but from a cursory read through the series, from
>> the comparison between master and the result of applying all
>> patches, and inspection of the resulting builtin/blame.c file, I
>> think what this series does is very sensible in general.  blame.h
>> does not seem to expose anything that is not needed, which is a good
>> sign.
>>
> I did try to keep any unnecessary changes out of the big movement
> patches (17-19).  Would you prefer I break down 19 further?  I had
> been holding back because of the added churn that would introduce from
> lots of changing function visibility in blame.h and blame.c.

To be honest, the "rename symbols while moving" done starting around
04/22 made the series too noisy to read and I had hard time
reviewing the later ones like 17-19.  I think they share exactly the
same issue as 04/22, e.g. 17/22 renames origin_decref to
blame_origin_decref while moving the function and some of its
callers across files.

>
> (And if gmail would quit trying to make my messages 'rich text' --
> a.k.a. HTML -- that would be great...)
>
>
