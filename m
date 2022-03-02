Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC1C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiCBJKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCBJKP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:10:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B091AF5
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:09:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso1221630pjo.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=Z8ta2bRnxW9+NRMtXbW77cRtRBGQSAxMaqBGBZC3GsQ=;
        b=Dn7RrtniEFo07reZP9ANbV6vEdkHL80RzNx5QnK84ObKvbEL0WJtEviH8KvwStQcNW
         rqPL0RKyFxTP/x/S15HZgClmrtZY0gB6cgcAFMAaHCbONdU8Yf5ORkARKiY8Qzuh7rMd
         Gt0bKPWTZD8+9i24IHbgydO0VlxQEHI+CcZax1M0SWdVEvLAjdyhp6iWCoDd/BaQKKWF
         3IBQZjTIBPeOH6iAwA1vIh4juADiO3TruStb9s9zGmS0qhTmnhVpzQYUhFi/tcQH5nTT
         OrIk/yKlCJ6mImU6JDu51caGbnOFzS98hZ2YxaC7vyshlZvWOWjy/xuYP69Qs3RNEdkF
         QYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=Z8ta2bRnxW9+NRMtXbW77cRtRBGQSAxMaqBGBZC3GsQ=;
        b=YSN412GgFAabxdV5TgR/PeXqakbmTDcrBafyl82EUmiSX1gyOYJB2+dx8YAk9S+N7I
         Q1/9XESCod6X1IIaEWm1qnY3IfgiFGxyO+uP+O0xogMYiRPqJMj/uEO/BjL8ZM6h8CMR
         HiwrItwKx9c/gvuy+vXlnOKFMijZMp6a2o+5Me3vGrR75j9491bczWvNq+QEbOTMqcPi
         J9Xa6TTy8YQhk7TklbzrMkpViMCu0XJCj3ihYEieOdgIO5d8Dt68OuWmydNowvyx7FBe
         xDZ7QcjpxRHgkjB0I3+82q89QJMecrLrFcE0ijgz67srwuFlvV7GjxlJV3u9D+3ZIuhB
         qHCg==
X-Gm-Message-State: AOAM5322rFpbIdUDiWhEm+4iOXHRukjnvLo3ItES7cz3gKtZWNVUlfYV
        sOjOr8YBGSkArSipx5cyOqc=
X-Google-Smtp-Source: ABdhPJxMhE1xfdNduJknueitRR947eSL4zMH5wO01Os5R3iprjWrHgjcKpV16reOJfU7iVvIp84mqg==
X-Received: by 2002:a17:90a:7f84:b0:1bc:aba8:f281 with SMTP id m4-20020a17090a7f8400b001bcaba8f281mr26012478pjl.101.1646212171707;
        Wed, 02 Mar 2022 01:09:31 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00199100b004dfa7f02369sm20320091pfl.205.2022.03.02.01.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:09:31 -0800 (PST)
Message-ID: <f16cf3aa-dbae-8645-1d59-a8d5639d22fc@gmail.com>
Date:   Wed, 2 Mar 2022 14:39:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-2-jaydeepjd.8914@gmail.com>
 <34a2ad39-604c-4edd-ea1c-de1212fc506b@kdbg.org>
In-Reply-To: <34a2ad39-604c-4edd-ea1c-de1212fc506b@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This test does not demonstrates that numbers do not end at an '_',
> because if it did end there, the change would be from the single token
> 100000 to two tokens 100 and _000, and the mark-up would look exactly
> the same as we see here, and would remain undiagnosed.

Yes but numbers ending in `_` would be illegal syntax in Kotlin so the regex
assumes that user is writing correct code.

> Instead, write the pre-image as 100_000 and the post image as 200_000.
> Then the correct mark-up would be
> 
> <RED>100_000<RESET><GREEN>200_000<RESET>
> 
> and a bogus markup (that the test wants to diagnose) would look like
> 
> <RED>100<RESET><GREEN>200<RESET>_000

Right. I will add that test too.


> What is this "0x0F"? Did you mean just "0x"? 

`0x0F` indicates that its a hexadecimal literal in Kotlin.

> And what about prefixes 0X
> and 0B? Are they not used as prefixes for hex and binary numbers?
> Moreover, I do not see how a hex number 0xff would be matched as a
> single token.
> 
> > +	 /*match unary and binary operators*/
> > +	 "|[-+*/<>%&^|=!]*"),

Yes. I would make the changes.

> Do not do this. There is an implicit single-character match that need
> not be written down in the regex. List all multi-character operators
> (but not the single-character operators) like you did in earlier rounds.
> As written, the "++!=" in an expression such as "a++!=b++" (which is not
> unlikely to be seen in real code) would be regarded as a single token.
> 
> The verb "match" in the comment does not match the style of the other
> comments (drop the word), and please insert blanks between the comment
> delimiters and the text.
> 
> >   PATTERNS("markdown",
> >   	 "^ {0,3}#{1,6}[ \t].*",
> >   	 /* -- */

Noted.


Thanks,
Jaydeep.
