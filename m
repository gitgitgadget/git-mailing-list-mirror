Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3CFC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjEHTda (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHTd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:33:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8022459CA
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:33:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-528ab7097afso4114446a12.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683574406; x=1686166406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpBqvDFYicaO77jOLoDwPRqerz2G+8iPWDbzdSJotlQ=;
        b=4m9VaAEL6qUFjqP+s00pJeiSjvNuVWa9/HXPQt6reKpBrLN2hPWqqtgtJJDi6k98vO
         L+88a+/36x19Dqh8+qyh3WrgD4E0SyUn96NUFAOMLwmqv78k0AlEraRECuR4KaroIePZ
         MzT/c2vC4LW4Q9ThSm5nOwNqrWxQj3TggFfz5fIJVff+mGaCaz/uzGq0j83glLN5X5JY
         b8r3fyqEYBHVEFYZ0kgBtMi7dyidgaPf1plsj8NiSShG+yWG2DKzllm2KWXE9yVXqaPJ
         kKUSvkMfu2nXxeSlg1SHDA9A8NZSc1JGIdNG+nc9PEoNRWaAdzlddjHcNkChM6Xx+kmL
         Nnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574406; x=1686166406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpBqvDFYicaO77jOLoDwPRqerz2G+8iPWDbzdSJotlQ=;
        b=DOzmjDbUTNSHrM83Xxm/8bMkEvYu5Qmb0kQweW9AGiugbI1MViiQmqcy3RpZBfaNCm
         Ry0Qo9MAaRujFTI10OzrRiZd+wAPsq/IXOWDI3V+Cod0Q+C5M9dydltdeLFn82GhfXHF
         D7X3wPPjZ3fv71TQWHo+HJQMKYMBsN5oXU6tjRoXw8nohopEiqhruzjZfia3F8J0eNXk
         +rrevtK92CzuOSiYIoaR329tAL5wwdnK4Lhv1yyotIl3zemW5549PJAMrRo0RACtyu07
         vjeDRhVN++tom7lJQLSoXz56CTeZjDv+/3YZGJY6CCt3XYJ8GZgs2HkknnwnwzXKZ8a0
         qDMA==
X-Gm-Message-State: AC+VfDx80st5TL3EGARGqR/zrogU2d3irtuTgv8P2gaQq4EtUL9z5s9n
        7UA9UZnXnL6rnFa3BPcPxUo+WkyewaI=
X-Google-Smtp-Source: ACHHUZ5i4WmSk6BxonqLWwUMP0kILi68KKIB8iQaSESDRXlivc+ZPvdlyU7moDFcEd/W9OIRGE0udUIF+g8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:8449:0:b0:52e:d311:ba5b with SMTP id
 k70-20020a638449000000b0052ed311ba5bmr2280085pgd.6.1683574406042; Mon, 08 May
 2023 12:33:26 -0700 (PDT)
Date:   Mon, 08 May 2023 12:33:24 -0700
In-Reply-To: <xmqqpm7aoclp.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <12d4850a9ab8659c40fcb6470caf8f98d7f6e486.1683566870.git.gitgitgadget@gmail.com>
 <xmqqpm7aoclp.fsf@gitster.g>
Message-ID: <owlypm7amxdn.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 01/11] doc: trailer: fix grammar
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

>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Documentation/git-interpret-trailers.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)

>> diff --git a/Documentation/git-interpret-trailers.txt  
>> b/Documentation/git-interpret-trailers.txt
>> index 22ff3a603e0..e695977fbfa 100644
>> --- a/Documentation/git-interpret-trailers.txt
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -14,7 +14,7 @@ SYNOPSIS

>>   DESCRIPTION
>>   -----------
>> -Help parsing or adding 'trailers' lines, that look similar to RFC 822  
>> e-mail
>> +Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
>>   headers, at the end of the otherwise free-form part of a commit
>>   message.

> Is that a grammatically incorrect sentence?

I think so. If we remove the dependent clauses starting with "that look
similar ...", we just get

     Help parsing or adding 'trailers' lines

which cannot stand on its own as an independent clause. The correct
version would be

     Help parse or add 'trailers' lines

which is what I first considered. However the auxiliary verb "help" here
doesn't really mean much, because the interpret-trailers builtin already
is _the_ authority for parsing or adding trailer lines, so I opted to
remove it in my patch.

> The command does help doing these two things, but we can say the
> command does these two things without closing clarity, so I do not
> have an objection to the updated text

Exactly (I think you meant s/closing/losing here).

> (the only "ungrammatical" part
> may be that ", that look" should probably be "that look"), but I am
> not sure if "fix grammar" is a good explanation for this commit.

I think punctuation (especially with commas) can be pretty wide-ranging
in terms of what is acceptable or not in terms of grammar. But looking
at it again I like your version with the comma removed. I'll make the
change locally for a v2 series.
