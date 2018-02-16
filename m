Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98531F404
	for <e@80x24.org>; Fri, 16 Feb 2018 19:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeBPTE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:04:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34035 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeBPTE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:04:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id j21so6742754wmh.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J70+kGMMV5zn/XPmzYKPmM6fwS3nd2IUQKboBXNgbbk=;
        b=LmrHEI6t0Gh0eUZZ1ANgsPiVZ81s9knRo2EXjkl0rrOzq1bic+hOJDJu757o0nvQyD
         9l2gHSE7rSJG73r9dzjvO4aH+CNFdqdVGFwXZtspTBCZyrIaLbLUFC7Mq963mGPyeAfF
         0+MqVbQs9A9+3gxF7rwfkR69eq7/FDMB9luGwFDkQwz+DultWw93STM7mx5wBoFP04lT
         ohZmnh9i/fTgCgR1FrZNNEiXBVb9ESM2UJAr+6csQqYp3YIbk3G2FfDtTKVkK9wmQ5LE
         USpS3X7TeASnt+dbxV1Nuc5S77igB0c2yxwrkmfSny9TDTFxEe1Mnf64Mf1mTt99+yM7
         33Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J70+kGMMV5zn/XPmzYKPmM6fwS3nd2IUQKboBXNgbbk=;
        b=uUtzIM3ltWJdy+C+Sft9X2zflYqlhEhywpwe6kq5HlXA9g/AjxyVkZ7npEDS1B16x/
         CNCUjVhNhe/GE9MSqcbexPCd9yKDsk9A5ztZMepBKDmEg58yS3hUJvNj2QZhNfB+pl8h
         TzyNTMXVxyMwDcIukIbuq3ThLL2yE1ZosY3iNVqN1BLKldcJWIr4Ecf3MAqnpqFGMvn1
         UFaeEQcD0tlxCp+4i1MmdUF5+1wJVgR+YA+iI9WqmOkFZ4OJhpG4TXCHN3VK6xL0oeQX
         SAlbzz9mXD/aOwnXV/fj48zS+iN8cas6P7mzlkqUZlCfT1rBWxsEyBLdFLs6NXTxyFbd
         VTaQ==
X-Gm-Message-State: APf1xPBViPneWxhStnbj5FD4LjtqIS7Ps2gsL0H37HlPs/8T6mZc+VUg
        ZPvFV9/VcYWI/s+sWUbrCXs=
X-Google-Smtp-Source: AH8x226CQZhAaGvp1s/9G7Oo5tMBTLdg84tQHcSuC1Ttcn8wjiOyAWUEZdKTpwHQr6ExmzrVIhGZCw==
X-Received: by 10.28.71.70 with SMTP id u67mr5340680wma.46.1518807895505;
        Fri, 16 Feb 2018 11:04:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o82sm13806701wmo.30.2018.02.16.11.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 11:04:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
        <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
Date:   Fri, 16 Feb 2018 11:04:53 -0800
In-Reply-To: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com> (Lars
        Schneider's message of "Fri, 16 Feb 2018 15:42:35 +0100")
Message-ID: <xmqq1shk7o2y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> One thing I find more problematic is that the above places *too*
>> much stress on the UTF-8 centric worldview.  It is perfectly valid
>> to store your text contents encoded in ShiftJIS and check them out
>> as-is, with or without this patch.  It is grossly misleading to say
>> that older versions of Git will check them out in UTF-8.  "will
>> checkout these files as-is without encoding conversion" is a better
>> way to say it, probably.
>
> True. But that's not what I wanted to say in the "pitfalls" section.
> If my Git client supports w-t-e and I add the ShiftJIS encoded
> file "foo.bar" to my repository, then Git will store the file as
> UTF-8 _internally_. That means if you clone my repository and your 
> Git client does _not_ support w-t-e, then you will see "foo.bar" as 
> UTF-8 encoded.

What you wrote implies *more* than that, which is what I had trouble
with.

If you say "what you have is checked out as-is", then it is still
clear that those who use w-t-e to convert non UTF-8 into UTF-8 when
checking in will get UTF-8 out when they use an older version of
Git.  If you say "what you have will be checked out in UTF-8", it
makes it sound as if pre w-t-e Git will somehow reject non UTF-8
in-tree contents, or magically convert anything to UTF-8 while
checking out, which is *not* what you want to imply.

>> Also notice that even in the world with w-t-e, such a project won't
>> benefit from w-t-e at all.  After all, they have been happy using
>> ShiftJIS in repository and using the same encoding on the working
>> tree, and because w-t-e assumes that everybody should be using UTF-8
>> internally, such a project cannot take advantage of the new
>> mechanism.
>
> Agreed. However, people using ShiftJIS are not my target audience.

Be aware that you are writing *not* *solely* for your target
audience.  You write document for everybody, and make sure the
description of a feature makes it clear who the feature primarily
targets and how using (or not using) the feature affects users.

