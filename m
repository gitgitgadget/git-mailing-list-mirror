Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D6520248
	for <e@80x24.org>; Mon,  8 Apr 2019 04:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHE2t (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 00:28:49 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42494 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHE2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 00:28:49 -0400
Received: by mail-wr1-f41.google.com with SMTP id g3so14555277wrx.9
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=txsKT7aVDOeNqIrnBXDJ6Nt+s18wVspK/QnCnhF+D7Y=;
        b=Tfbr5wImrpXsDDoY7B9ACtrmvLVCQ8vQ5rHXmfMIFHQhsGl07JzRbBEJhiQpo/69Cx
         Nn58scXrAPqact3fSClgReKysCysNenYlibAfUoC/2nUaavy903nIwjomIY6TuIpkGB2
         4gtdFtB6Q226rb59HGrEwNo4gRRDvNoBwEY2GMbHUZ7Gq8XYDJAnKcCzt2pkMaGYXFw9
         CrGPnI8gtom9RK5Fecd5msaPLq5TIB6ZR7SGxWV3bCOs8j/fMDW6eMNE9c6+7NUU9BQn
         0J9a0YAww9Z9PfyNwcHrEaGwJhbYws18xaz2X2zzylCJ9x17FpNmVztO5bkFXhWrCbSI
         hrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=txsKT7aVDOeNqIrnBXDJ6Nt+s18wVspK/QnCnhF+D7Y=;
        b=WIL/vFZDtoU7B5X/v0pz3mT0sKy6OqOEilyfxQBP03B50u0smB5jC7SqjaIDzSw2tD
         skZ/5+auuOy0Io0gIaUljKPtYJA+dnpbMNUheZtvYB8aDQeN2ZPfiEKLlp0V073EE+aQ
         AoyMMbOP//n5gykNcqtSpthtftsHULIZeRyYq8CcyqJZK5ZWlB83j9cONxx7TlwK3uHH
         nfqKMOzitwF1sULMWSoWPBZXzXmXAZDY8PI0LdBjzSxfVOmp8EeqyHmOC5Ug04TCJhAi
         +mxINcOIWWDdXmODhdvM2NV29ahBk0Z0s4QWt7lLtk5KKo5AHcBbY7hanF8j/6ezlgox
         HrVg==
X-Gm-Message-State: APjAAAWi63NSplcebaosRLDtyjWoaAsrlmFeluQKKWzBeJ82VwUkBuh/
        XhxTUnbpD/4JEWyp+dA0cLQ=
X-Google-Smtp-Source: APXvYqz8mPNY64Ru0Ihi137ILXzOJiBVzk8tN1AjgLVkbkrJQ//eNFPpnY1AVPo0KR/uCH0MIiEI6g==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr16516773wrp.6.1554697727411;
        Sun, 07 Apr 2019 21:28:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r18sm9087004wme.18.2019.04.07.21.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:28:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
        <87ef6eaoub.fsf@evledraar.gmail.com>
Date:   Mon, 08 Apr 2019 13:28:46 +0900
In-Reply-To: <87ef6eaoub.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 06 Apr 2019 21:57:48 +0200")
Message-ID: <xmqqa7h1aznl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> unique (AFAICT "actually unique" in practice) in the parallel in-flight
> jh/trace2-sid-fix
> (https://public-inbox.org/git/4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com/)
>
> I think it's fine to merge js/trace2-to-directory down as it is, but do
> you/Josh think that retry logic needs to stay with that sort of SID?

I do not speak for Josh, but I think the only two logical choices
are to open with (O_CREAT|O_EXCL) and

 (1) fallback with .%d suffix, making it clear that we are not
     willing to lose log files even when SID generation is botched; or

 (2) die/BUG when it fails, making it clear that we do rely on the
     guanateed uniqueness of SID.

A distant third may be to warn when open with O_CREAT|O_EXCL fails,
but I am not sure what its value would be to do so---especially if
we trust in the "actually unique in practice".  Between (1) and (2),
I have a slight preference to (1) over (2), as that is much easier
to explain.

Those who want to have a "fixed width" thing could just ignore the
ones with suffix---as long as the "actually unique in practice"
claim holds, doing so will not lose any non-negligible amount of
information anyway.

