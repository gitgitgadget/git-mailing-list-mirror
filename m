Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB141F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIMXCQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:02:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeIMXCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:02:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so7231676wrr.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7z5CsCLFbTAEg7fiCsJp9HZ3rgHw/nCvCjZSiN4hz4Y=;
        b=WSNFdQXXBrAayv4CB+5OdI2Fa5za0dYM8jxoCre8+rXMJIZrP8OYhQg5uyj/qEL3X6
         0vNYRn9cKuyKITGynIIzllATvCnlP2XPXfYhgqhaBMUc0mzYqCFnrnBLZyx2yLQtGvRq
         P9xXLUz+JoN09/xbg7dugpnBt4mUuR22Ny+2FPxEoFoLHcNxkxRYkykOSh0aZ5k7tSXs
         VwQQ0kS5JPkBVEoCLb7UBxGdkHPeikIYRSfZzS1ZQIyz5ky46MeJkHa591xJt//umsPl
         tHd6pU6gZotJKv9Bp8Qb2mSj/hk/ux3byAg2m9FWBJx/DthFP85RJeP3uBdY0rQETbvM
         d4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7z5CsCLFbTAEg7fiCsJp9HZ3rgHw/nCvCjZSiN4hz4Y=;
        b=ZiXei+K25rRAvVMVqRYunKRbw8m+gleehSAS7JTgLvGlMeXi1ceuxMQ6/eyw1DfQLz
         SUPMwO/QBWgqRiZ9axKd2V4Y16TmDyxvg1fKmw29XMz2yqXZ7wk9/1vFZrtQyrWy0HtW
         jbUvRAYCwU5huV4zbS079qxbUSWjH6t2LztG6DTVPhIhRaEkgSErlll+cXgn+EnQ5BpI
         S+bZfFQa3yB6jTR/T7m6iOLV/dS9YZufSteTIykwbGPH/0fZIFFlfGyPp05aG3EYkPpd
         wYeak9vEvSSO72gl6+Uk/IlRaJNHa05uK8qHXM2Aqemv114ntPoBK4CQcqS6E1BeO5z1
         lP6Q==
X-Gm-Message-State: APzg51ASWauNEuMeZnhOvMM+K+EsODW3wMgHtLmGMlUgAKSaK9hMwRKD
        DerKOvkg8EJgwto9WmltHRgnlSia
X-Google-Smtp-Source: ANB0VdZHxdMcKwImyaGCvGpdCz9nTk+cgFuue4wf4aSZZxfF0FahqDLvtOlz7woeaqEIlKB1pgvXHA==
X-Received: by 2002:adf:8167:: with SMTP id 94-v6mr6934494wrm.127.1536861101759;
        Thu, 13 Sep 2018 10:51:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y205-v6sm57090wmc.3.2018.09.13.10.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 10:51:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
Subject: Re: [Question] Signature calculation ignoring parts of binary files
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
        <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
        <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
        <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com>
        <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>
        <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com>
        <xmqqefdxign2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Sep 2018 10:51:40 -0700
In-Reply-To: <xmqqefdxign2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Sep 2018 08:03:29 -0700")
Message-ID: <xmqqva79ffpv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>> The scenario is slightly different.
>> 1. Person A gives me a new binary file-1 with fingerprint A1. This goes into
>> git unchanged.
>> 2. Person B gives me binary file-2 with fingerprint B2. This does not go
>> into git yet.
>> 3. We attempt a git diff between the committed file-1 and uncommitted file-2
>> using a textconv implementation that strips what we don't need to compare.
>> 4. If file-1 and file-2 have no difference when textconv is used, file-2 is
>> not added and not committed. It is discarded with impunity, never to be seen
>> again, although we might whine a lot at the user for attempting to put
>> file-2 in - but that's not git's issue.
>
> You are forgetting that Git is a distributed version control system,
> aren't you?  Person A and B can introduce their "moral equivalent
> but bytewise different" copies to their repository under the same
> object name, and you can pull from them--what happens?
>
> It is fundamental that one object name given to Git identifies one
> specific byte sequence contained in an object uniquely.  Once you
> broke that, you no longer have Git.

Having said all that, if you want to keep the original with frills
but somehow give these bytewise different things that reduce to the
same essence (e.g. when passed thru a filter like textconv), I
suspect a better approach might be to store both the "original" and
the result of passing the "original" through the filter in the
object database.  In the above example, you'll get two "original"
objects from person A and person B, plus one "canonical" object that
are bytewise different from either of these two originals, but what
they reduce to when you use the filter on them.  Then you record the
fact that to derive the "essence" object, you can reduce either
person A's or person B's "original" through the filter, perhaps by
using "git notes" attached to the "essence" object, recording the
object names of these originals (the reason why using notes in this
direction is because you can mechanically determine which "essence"
object any given "original" object reduces to---it is just the
matter of passing it through the filter.  But there can be more than
one "original" that reduces to the same "essence").

