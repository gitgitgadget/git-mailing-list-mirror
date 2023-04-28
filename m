Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B4C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbjD1TJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjD1TJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 15:09:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC021E9
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:09:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66b9bd893so2792355ad.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708981; x=1685300981;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPDe6wf5wlppQjuodjaflESrwqCiYxtKdb+XgMxXSec=;
        b=UxhDQwMl1LqAYh73c88GphlbUK/kKEx3jx+WHW3fuUMwpcqqxf6x9ChpyOwJAR5tru
         gN33ku5GCARNWfAzZCgkCphTEmG5g0eEbNHFhyfMNHhhBj0Bv4Z47FGAwbQHj13xgM4h
         5V3fgaGiR+2LhriFAcXNFHW88OpG3w1bFcUSKYL84l1wi7Wg5g9D1ZKB4pkW5OCPHPJZ
         tXj8dwc0nOxM/uVnjjm3/QjS4IiWuVa2NZo3affpG86+JhU2lOKZ7xYTQFftZwIi/K30
         kKEJZArrBhEYdiJxRlO12meL2y4f8K9wuFZOk5bCPc+VRBp6XnP9XMVT76/Obv4uJaA9
         Z4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708981; x=1685300981;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CPDe6wf5wlppQjuodjaflESrwqCiYxtKdb+XgMxXSec=;
        b=EKTaGzGI0Enk9uOm59wTLfumf/ZIRpNz3fI3E0L96+4//waz79jZno2f0tWg43FuUH
         Qj6q0A33Nth9s1Xen2Y4z6XO1f/lfyOMfQveqt2xv33ac8x5tMS2Hgo+lm62cCdwA7dG
         lXjTU3wZTXGs4TJscwRTah1LEOwkpq4J6vjbX83GoASTssSPJpHvIDFPEhW3GGher9Gl
         tqlY6IoaU6eqiOXsbDP1iunWwih7pQQ1bHhQN9rR7I+4NG6xpZhw8jp+rslygXxV36W0
         DeP5U9gKVhEgeny2zk4kP5ysqUPApvVDStkhkrpWLC0tMvJxm7CIH8sxXntvTf8djeaa
         9mXg==
X-Gm-Message-State: AC+VfDymv6fASU2QMlmA8G0rAlhj2wNWXJ6PhbXZoAmN2DyQ9uFavIHv
        Zx26CGJwVQZbFzb5Qck6MSK1ZJlDbwA=
X-Google-Smtp-Source: ACHHUZ6aJ2xDmeuSiSO6DrSQaOtVseENDhOlSnm00nB5On6X62HVQxCGC7FIWXJyCZb+yMbD5p2t9g==
X-Received: by 2002:a17:902:f54d:b0:1a1:e01e:7279 with SMTP id h13-20020a170902f54d00b001a1e01e7279mr6993707plf.4.1682708981062;
        Fri, 28 Apr 2023 12:09:41 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902988100b001a1fe40a8dasm13519916plp.262.2023.04.28.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:09:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 3/3] Capitalization and punctuation fixes to some
 user visible messages
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-3-oswald.buddenhagen@gmx.de>
        <xmqqttwzded6.fsf@gitster.g>
Date:   Fri, 28 Apr 2023 12:09:40 -0700
In-Reply-To: <xmqqttwzded6.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        28 Apr 2023 11:57:09 -0700")
Message-ID: <xmqq7ctvddsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> These are conscious violations of the usual rules for error messages,
>> based on this reasoning:
>> - If an error message is directly followed by another sentence, it needs
>>   to be properly terminated with a period, lest the grammar looks broken
>>   and becomes hard to read.
>> - That second sentence isn't actually an error message any more, so it
>>   should abide to conventional language rules for good looks and
>>   legibility. Arguably, these should be converted to advice messages
>>   (which the user can squelch, too), but that's a much bigger effort to
>>   get right.
>
> I think both of the above are good guidelines to follow, with a hint
> for a longer-term plan.  Good description.

I think the above two deserves to be added (in some rephrased form
to fit better) to the Documentation/CodingGuidelines, somewhere in
the following section:

--- >8 ---
Error Messages

 - Do not end error messages with a full stop.

 - Do not capitalize the first word, only because it is the first word
   in the message ("unable to open %s", not "Unable to open %s").  But
   "SHA-3 not supported" is fine, because the reason the first word is
   capitalized is not because it is at the beginning of the sentence,
   but because the word would be spelled in capital letters even when
   it appeared in the middle of the sentence.

 - Say what the error is first ("cannot open %s", not "%s: cannot open")

--- 8< ---

Volunteers?

Thanks.
