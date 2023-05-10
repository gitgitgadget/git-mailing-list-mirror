Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D2C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 06:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjEJGpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 02:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjEJGoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 02:44:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67527448D
        for <git@vger.kernel.org>; Tue,  9 May 2023 23:44:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so6484160a12.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683701087; x=1686293087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb/IAmudeOIAlSyErmezAHvXdo8R1OI85uRhDfuDXHM=;
        b=tVwMm2co/ZW3PDOsaptQDka0Wg532cJv4qHAhtSJNkayxOAQkdJONEmcqAHzTF6E7I
         BIXJloSY5kh9I9ChCa4x3qYWuZ5CVQEALwfndqmOj3Zb/vOwDU4CkIeRKbqF0Xty8AHT
         cH4WKfzQnGuEHb0bX5apmdL7IQtGsZjYLd8PyBff/2aJatnR8u2PAT0uDB+ypeBs7/Wk
         dCdhwUFIOgaOEHh6wLgVdkhCKa/W/drpoNchTBobrmJWM0t79arK2GoDqUewOP3nhqGR
         Fjzo4eS3rBEvm5mXsttoD/Hj5RKu1crB+dO2V2g79kgMd5iRSgvJgaVbiWTHoT0ORyZX
         VoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701087; x=1686293087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb/IAmudeOIAlSyErmezAHvXdo8R1OI85uRhDfuDXHM=;
        b=OR+PqNIfFlYi6RMisxMLf97VRabquNKkA/o/RpLoNgcZjfeUG4/B6rXyqmUFImYrX6
         0mfhDKYEUd3xoKCJ+126kBAcABNPW29Of3GTSMlohsISDYJGBDVOlE2V3IOHzU59s5s+
         uC1fYxbHar8vszg/X+d8AAyzK9tjVqohZr1krQ1yJDvfSJ59/vw0i2JO/pt+0gBzXM2E
         RAyeD6oVLuozm34wULUg7Q9QjvDC6dEkIsKx8AoZqOGXgZnhc9c1myakfsnlSZIlC0h1
         FBCR1Yi0h04BGhzWTwWo0FKB/+dPzQF2mM4bjKqqkZ9maLaDMuS2LY/Wvw31tDhPsRYT
         PO9Q==
X-Gm-Message-State: AC+VfDzZbA6mctumlt3ZEQBhzAnS/ya50zus6TO4sSwsam4za/L49jZv
        zWMo9mvL4PZDrJyOQlHjiAZxMeATrLI=
X-Google-Smtp-Source: ACHHUZ7RBAM1h1QV5LGZvUwIG9xYakKziWdY56zOkeFQB8Eawq6Ovsf7HVvCtwOOcpXk7gqY0jmQoNBXvRo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:6b02:0:b0:52c:5e46:c804 with SMTP id
 g2-20020a636b02000000b0052c5e46c804mr4770887pgc.10.1683701086930; Tue, 09 May
 2023 23:44:46 -0700 (PDT)
Date:   Tue, 09 May 2023 23:44:45 -0700
In-Reply-To: <xmqqa5yeobrj.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <0c10e40794d208ba408a2b1c394fdbd6caa7a92a.1683566870.git.gitgitgadget@gmail.com>
 <xmqqa5yeobrj.fsf@gitster.g>
Message-ID: <owlymt2cn0rm.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 04/11] doc: trailer: explain "commit mesage part" on first usage
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> From: Linus Arver <linusa@google.com>

>> This phrase is used for the first time here, but it's not explained what
>> it means. So explain it just in case it's not obvious.

> 03+04 should be a single patch

Agreed.

> otherwise it would
> waste reviewer's time (just like I did thinking and writing about
> 03/11).

Thank you for the pointer. I will be more careful about patch order
moving forward.

> Or just drop "part".  "git cat-file commit HEAD | sed -e '1,/^$/d'"
> is a good material to use with "--no-divider" because it only has
> the "commit message".  The "part" implies you first had something
> that has both "commit message" and something else and you split
> that combination into two (or more) parts.  But that does not have
> to be the case.  I think that made 03/11 confusing, at least to me.

Looking back, I don't think I had a good grasp of what "commit message
part" meant. When I wrote this series I thought "commit message part"
meant everything in the output of git-format-patch until hitting the
"---" divider. But as you point out in your

     git cat-file commit HEAD | sed -e '1,/^$/d'

example, technically there is never any ambiguity of what the commit
message contains (it only contains a commit message, not a "commit
message part" and a separate "patch part"). And the output of
git-format-patch is a patch (which contains the commit message and also
other things), not a commit message with different subparts. I was
operating under this flawed understanding, oops.

That being said, there are several instances in the DESCRIPTION section
when we use the "commit message part" phrasing (as opposed to just
"commit message"). I am leaning toward just dropping "part" as you
suggested. Also, I think we should add an explanation of how
git-interpret-trailers sees the incoming text, how it gives special
treatment to a "---" divider line, how it uses this line to mark off a
commit message part (and then uses this part as the default location of
adding trailers, unless specifying a "--no-divider" flag), etc. This
could be in a revamped 03+04 patch, or perhaps left out until another
day. I'll see what I can do in v2.

>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Documentation/git-interpret-trailers.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)

>> diff --git a/Documentation/git-interpret-trailers.txt  
>> b/Documentation/git-interpret-trailers.txt
>> index 3e60a6eaabc..7d6e250f37e 100644
>> --- a/Documentation/git-interpret-trailers.txt
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -22,9 +22,9 @@ This command reads some patches or commit messages  
>> from either the
>>   <file> arguments or the standard input if no <file> is specified. If
>>   `--parse` is specified, the output consists of the parsed trailers.

>> -Otherwise, this command applies the arguments passed using the
>> -`--trailer` option, if any, to the commit message part of each input
>> -file. The result is emitted on the standard output.
>> +Otherwise, this command applies the arguments passed using the  
>> `--trailer`
>> +option, if any, to the commit message part of each input file (as  
>> opposed to the
>> +patch part following a '---' divider). The result is emitted to  
>> standard output.

>>   Some configuration variables control the way the `--trailer` arguments
>>   are applied to each commit message and the way any existing trailer in
