Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5877C20248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDMFpk (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:45:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMFpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:45:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so13776820wmi.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 22:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QIhRCGakhIe3qVYahGYH7XDzntc4EB/sq3jzfe13udI=;
        b=bM9oMolYbyMJWvDGR6oFMRDlTceO2hX6wEFGcGVTuvow8LDFIwkulwt4tlmgqYH5N6
         fTMy8sz2GyEkj3S4i8whEXxMWNnuC6Uyj8PUOe1pEjV99prn1644Ws5nGoTJnnHSBJZy
         zRhf/9CWyO3MUm3hEE5PrCJ/G75FsdIaFuPGlHGU4eGTCtBmv271UvcJOKGxpD0oS1lB
         vHmcG81X25YmecpG0eqvMtyPpdNXIyNjSO3vWPgMuajagZBTLgs7auO6H5EpjwpQpI/F
         G8oy5Jkky4zWXfa/5Kg3b3dXSmYZP3PZ1BQvSBG3D29aLq2X2WTD05HWXe/kKe8kDDaZ
         KRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QIhRCGakhIe3qVYahGYH7XDzntc4EB/sq3jzfe13udI=;
        b=WWoD0XuvutZCIOOpULqUZ3vbNBHey+f8bVYEbU3tq+mUzgLaRE4MyNWBrwcYwA0e8p
         vj7gMwGDpVZrvjs9Yb/R8viUQyYRyRbzhpIdwDyUNPiuBkSHuRdp42bJDZ0u7hJ+V3a3
         2l29cQUU8FLl3GWfOPnWuX32RtlfTITBxsPQF/BBdk8kOMb2/LgL8pXPPTK7DyG5ADmH
         qI5q+UR0JH4csfrcuopuFV+XaB+XzfatINcRQBP/8O4vH8E/8vcRV4l+0x+JqKBNwjhD
         YoGZiNKtvRZ8VImKtj6pxRkhOqez1a22xCgI/cLEvfHp9NvpeV93jwjviaIRWxEZYEx1
         J1PQ==
X-Gm-Message-State: APjAAAXnDPmwXOmhzqieUKrXxn4fNy0lcJyMmrqWjT6I+Ez0Tm1K6fsI
        Q5QozheUfTLFNu7/8TAAIbc=
X-Google-Smtp-Source: APXvYqzkOabAXKn7EkovSs9ji7plC3hMLxBLEAW7MPW5BUP6/wmlijv5/ffP1p2XtAVjEoXm9eJQUA==
X-Received: by 2002:a1c:1a46:: with SMTP id a67mr14126480wma.21.1555134338713;
        Fri, 12 Apr 2019 22:45:38 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f128sm11419717wme.28.2019.04.12.22.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 22:45:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH] *.h: remove extern from function declarations
References: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
        <20190413012424.GA2040@sigill.intra.peff.net>
Date:   Sat, 13 Apr 2019 14:45:37 +0900
In-Reply-To: <20190413012424.GA2040@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Apr 2019 21:24:24 -0400")
Message-ID: <xmqq4l72xxtq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So it sounds like you did that and the result is not _too_ bad. But I'm
> not sure about doing it automatically with sed. For example...
>
>> diff --git a/packfile.h b/packfile.h
>> index d70c6d9afb..dab50405e0 100644
>> --- a/packfile.h
>> +++ b/packfile.h
>> [...]
>> @@ -43,10 +43,10 @@ void for_each_file_in_pack_dir(const char *objdir,
>>  #define PACKDIR_FILE_PACK 1
>>  #define PACKDIR_FILE_IDX 2
>>  #define PACKDIR_FILE_GARBAGE 4
>> -extern void (*report_garbage)(unsigned seen_bits, const char *path);
>> +void (*report_garbage)(unsigned seen_bits, const char *path);
>
> This one is a function pointer, and so the extern is actually changing
> the visibility of the declared variable. It needs to stay.
>
> (I didn't read the whole patch carefully, but I knew to look for this
> one in particular since I had to deal with it in my patch, too).

Yeah, after reviewing your recent packfile patch, the above hunk was
what I went to hunt for directly in Denton's message ;-)

As I care much more about correctness than "conflicts with in-flight
topics too much", I'd prefer people to understand why we avoid the
wholesale update is because of an unnecessary bug like this one, not
the one-time conflict resolution load that can be subcontracted out
to "rerere" once dealt with ;-)

A wholesale rewrite using a tool more suited for the job (e.g.
spatch) is a different story, and raises the confidence level of the
end result a lot more than a "sed and then eyeball" rewrite, but any
tool that allows transformation that is sophisticated enough allows
bugs in the instructions we give to the tool, so...
