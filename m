Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46771F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJLKr5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:47:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45896 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJLKr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:47:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so11784034wrw.12
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oAkaCMsLK7r29mAxdh09J0KwB/ro9NvT848qYmsg8/o=;
        b=bjOObslluHwg1xXLMiCBBoKs9LmGYtU2zxX4xPKl+JLuuf0u5vHjP8xz/oJQVW73cJ
         iyMwl9KST2O90jdbGVYsHpspuA/2mJovJLhTPKYRG9KrxK8bDiuj4SQUhkBFnY/h4tLC
         aXzALk7aOYJXE+ZCpp4Scppcy2fyQsj7pMZZ+BeHXnQRFxyNA09vE8yQ4vx1mnq/c4NM
         n8HMscAFYIx94GULoH0N1oe88Cnj25ugv4tiTrq2IXcUQia1kFbsk/gdWBczhrJLl6w/
         PkePPm28A5IZBsoA828L1uhBIGwvE1rDw1HZ/ClUQNlrYNSejTx4ni6cntSErYdGqjep
         Zzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oAkaCMsLK7r29mAxdh09J0KwB/ro9NvT848qYmsg8/o=;
        b=XEBBMv4wvs3mO/95CXBqyrRJczQFNCdRG7Q7+JwJYWgKqraKfG1vErjRKqd1+vHc3l
         GfBeyB8DI6abzxFzsfPq0TLZXWftMhVZxwZa5KyneA8iOZ/BEAmWFmzrY91bWk3VZXNq
         +l+XFG6hivw8qEQSGBpohbyu9mt+mJTIXXfl8UP1dn79D5AbB9M7DpK858AepqW3z/D5
         w3VjkLHOw8b6iNLnHvaHI/2FocnA8lRXkw3MaPhwy+OvBhy/5PGiy3ZAunGDR8mjs8sx
         VIalcN4LqQqV7OMP8cBPDNCNlIZTfeqkj8iORHnrLF8Wgo4AQutsWV3OlsIUNgRvh5GJ
         z9JA==
X-Gm-Message-State: ABuFfohNOU3+EABSwRBBDPIiSOIwVNVsm/VRPtPnKWQgHjnhthb5EvXy
        vEzHwaKGnESNqnHbSi63JGCTO6xrpmE=
X-Google-Smtp-Source: ACcGV63Jtly3JRdwfeEsDcf88hvN7P289hBx18jUi6YV/maWxNTxVz4pfcUk9L1Hh9YQOoiESVCGkw==
X-Received: by 2002:adf:92a6:: with SMTP id 35-v6mr3807523wrn.137.1539314259289;
        Thu, 11 Oct 2018 20:17:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s1-v6sm19544332wrw.35.2018.10.11.20.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:17:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] alias help tweaks
References: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
        <20181009115909.16648-1-rv@rasmusvillemoes.dk>
Date:   Fri, 12 Oct 2018 12:17:37 +0900
In-Reply-To: <20181009115909.16648-1-rv@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Tue, 9 Oct 2018 13:59:06 +0200")
Message-ID: <xmqq1s8vetv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> v2: Added patches 2 and 3, made "git cmd --help" unconditionally (no
> config option, no delay) redirect to the aliased command's help,
> preserve pre-existing behaviour of the spelling "git help cmd".
>
> v3: Add some additional comments in patch 1 and avoid triggering leak
> checker reports. Use better wording in patch 3.
>
> v4: Reword commit log in patch 1.

Sorry for failing to point it out and let the style carried over to
v4, but the above is insufficient for a cover latter.  Those who
missed an earlier round has no clue what these patches are about,
and there is not even a pointer to find an earlier discussion in the
list archive.

I think the patches are good with the rounds of reviews it went
through, so let's merge it to 'next'.  Here is what I plan to start
the merge message of the series:

     "git cmd --help" when "cmd" is aliased used to only say "cmd is
     aliased to ...".  Now it shows that to the standard error stream
     and runs "git $cmd --help" where $cmd is the first word of the
     alias expansion.

Please do the cover-letter better next time.

Thanks.

>
> Rasmus Villemoes (3):
>   help: redirect to aliased commands for "git cmd --help"
>   git.c: handle_alias: prepend alias info when first argument is -h
>   git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
>
>  Documentation/git-help.txt |  4 ++++
>  builtin/help.c             | 34 +++++++++++++++++++++++++++++++---
>  git.c                      |  3 +++
>  3 files changed, 38 insertions(+), 3 deletions(-)
