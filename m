Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B46620248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfDSStL (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:49:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51246 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfDSStK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:49:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so7094264wmf.1
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PAIBllqE48j1lwgRCaKicq7pl5OsYXmmT5ZXKeIrYS0=;
        b=H8P+vBfZi5UWZl3bNl1HpHgYw9UWg+7WBZZ4V66UnBTiby3aIykqmNjvd8oIxbD7Mm
         mUWWQTubp+uwpXsbq/qYxYs9jQT+xGq3vCBdFi7mlQCsTCIQSXILqPipheWhuLUt/GSU
         iXir2TxrTumivI8TztfdOQO/bN1pPlfwN13BrZ6BCZLP/oxQaYv2hWsnL1n0faoHbzge
         YVv593oLB9vm9Dxduxj2SmubW+bksyLgS2Ywgepq3HZ+w+LDW/U/YA0FnJERENy8oLw/
         efkWpDhKvINg35RXCk0jPTyW++a8PdtUxXLJGs9kfWVOVZgU0tRLabuPpKQp9cPezN3K
         QpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PAIBllqE48j1lwgRCaKicq7pl5OsYXmmT5ZXKeIrYS0=;
        b=IF32TlHsSskuL9v8RP8h1vbvNYiVAI4wmWND3y2B2RAqFM1jX02N6sxQMBgpKyCeie
         DoTMsQXivmEwFNIQB6kCcNBb9yO7JcSc/A7VexmLL7HFh8WKGdqAKiHnZ1AHcqz2jr/A
         +CgrFeey7SEUZe1E/Eaw0Em/510EKxoRgiNp58ej7KxqkJEW61F1TGglft/AZOlT2lL7
         eZoamjlV8TSNXze/HMbi19kHQkOKt8SpZvT8oi6t7yuYqa74wJhgrnRDy5ninId+J9N7
         evaawfHj6YWBv5UhJudgnKD3zKgJRCZlHhqLC9Mic6Od0Mc5yHzYNVhPbn9iyq9syUVX
         045Q==
X-Gm-Message-State: APjAAAVzqeyFjIjhBLl0J+YuoMZrftuAHKVrVxQvqdlv4Nb/KpuvzCv1
        IJJqhWaUEcYZpO5pwtRroK/OdmwEhpA=
X-Google-Smtp-Source: APXvYqxlfB9gXHvdSREAFc4WvT1g8AkMH8kkxAhYN1HYHNcMaPBlZwhuC3nVBpxlWmstAh3BDmJOKw==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr1192469wmc.81.1555649809347;
        Thu, 18 Apr 2019 21:56:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x5sm2902683wru.12.2019.04.18.21.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 21:56:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vadym Kochan <vadim4j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] configure.ac: Properly check for libintl
References: <20190418050419.21114-1-vadim4j@gmail.com>
        <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
        <20190418082844.GA10068@lwo1-lhp-f71841>
Date:   Fri, 19 Apr 2019 13:56:48 +0900
In-Reply-To: <20190418082844.GA10068@lwo1-lhp-f71841> (Vadym Kochan's message
        of "Thu, 18 Apr 2019 11:28:44 +0300")
Message-ID: <xmqqmukmegof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vadym Kochan <vadim4j@gmail.com> writes:

>>     Some libc implementations have function called gettext() that
>>     can be linked via -lc without -lintl, but these are mere stubs
>>     and do not do useful i18n.  On these systems, if a program that
>>     calls gettext() is built _with_ "#include <libintl.h>", the
>>     linker calls for the real version (e.g. libintl_gettext()) and
>>     that can be satisfied only by linking with -lintl.
>> 
>>     The current check to see if -lc provides with gettext() is
>>     sufficient for libc implementations like GNU libc that actually
>>     has full fledged gettext(); to detect libc with stub gettext()
>>     and libintl with real gettext(), aliased via <libintl.h>, the
>>     check to see if -lintl is necessary must be done with a sample
>>     source that #include's the header file.
>> 
>> Is that what is going on and why this patch is needed?
>> 
> Yes you are correct. 'gettext' even might be defined as libintl_gettext.

With this exchange, I was aiming for extracting a more useful title
for this patch out of you ;-), and I think I accomplished my goal.

"Properly" is fairly a useless adverb in the context of a patch
title, as it does not tell us why we thought the way in which the
updated code works is more "proper".  In addition, because no code
is perfect, future developers are bound to find something inproperly
done in checking for libintl after this patch gets applied.  It is
better to say the most important thing the change does concisely and
concretely.

I think

	autoconf: #include <libintl.h> when checking for gettext()

is probably a better title.  

Together with your originally proposed log message, which we now
know explains why this inclusion makes a difference sufficiently to
be understandable by an average Git developer, the resulting commit
will communicate to our future developers the reason why we thought
this was a good change clearly.

Thanks.
