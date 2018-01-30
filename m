Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC931F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeA3WgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:36:09 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35174 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeA3WgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:36:09 -0500
Received: by mail-wr0-f176.google.com with SMTP id w50so12940978wrc.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PQToaIzmfkaL/NVRQnZgmOFt9t1YGEN0FkUAeyn1bws=;
        b=tvHMUWUjVPHHnZZvyUsZde140Ranfn37773G8tordIZs1ncjxi+H1FdYzcqzR3TX+4
         E49HBo/FvUmQpGoCTV4LOAhMALDsrfA+r+EWC93ueYD63oxKxs3xlUSw3/eV7uPOkdDt
         KRwulqt0IYqvlW3c+mI7EwFJSX4wR0LZy2GOD+V75tqVGwQUcEuetHUZSpSnHsp/syOT
         quBFWawU8NER92tsUEo/WTvK90oDfjmIHHlzgLfY5f9Mp3GlXPGh8WUXpNaLWf8nCICs
         9SOVDXYnAdD72YMwqOgw4BRGVYokFA8YW9MScoJKGxSdIV3M6w4ui87gEw8sOZIgSHCW
         CNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PQToaIzmfkaL/NVRQnZgmOFt9t1YGEN0FkUAeyn1bws=;
        b=HbZsynveLQtiwCjZo0ipAc6uz4fBu9vLGFsKd4M5yV4HMAC6Y4lC78TxoB5w8/MXhO
         XE+DvTGbGt5QN8CFVdbefbEIJ7aNXunzC2oGXfRHmzAp5sSemC7gh45DUiv2Lxb37bME
         47zYVjJMIlkkWHZ7ycCMXmMJkru5wK8rPSCHALKdrlzpeXPy5wMWVl2+xi0pZfuTEz68
         S+/yHin5IAhoHWq+zD5D+/jB+clJe8Rnk46rZkJ0RJ/HlIabzA2UPSLajOWQp6px7kdZ
         xgxhjmuY9eBz2q5m+CpJdITd+AFU6Wx7QWocMGL5Ooq8kXOTbG3NiF6LN2ZI7wdFhtCb
         mAMA==
X-Gm-Message-State: AKwxytcsa6rTmBfjr/inXOpbRBwq+WECEc3gwnXsVsCjg0wMXzIgH3lx
        GPT+eJuCKY79Fi86w0QD/Nk=
X-Google-Smtp-Source: AH8x224DCG0nMIgSMfbcFcIws0qdGoWRDSLk8m96wcqh3rg5KLs70Ll4QqXSrWqrWs68RDA07wCrWQ==
X-Received: by 10.223.197.13 with SMTP id q13mr23077423wrf.235.1517351767452;
        Tue, 30 Jan 2018 14:36:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e67sm29779543wmf.7.2018.01.30.14.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 14:36:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
References: <20180129223728.30569-1-bmwill@google.com>
        <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
Date:   Tue, 30 Jan 2018 14:36:04 -0800
In-Reply-To: <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 30 Jan 2018 07:13:16 +0700")
Message-ID: <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Is it simpler (though hacky) to just  do
>
> #ifdef __cplusplus
> #define new not_new
> #define try really_try
> ...
>
> somewhere in git-compat-util.h?

Very tempting, especially given that your approach automatically
would cover topics in flight without any merge conflict ;-)

I agree that it is hacky and somewhat ugly, but the hackiness
somehow does not bother me too much in this case; perhaps because
attempting to use a C++ compiler may already be hacky in the first
place?

It probably depends on the reason why we are doing this topic.  If a
report about our source code coming from the C++ oriented tool cite
the symbol names seen by machines, then the "hacky" approach will
give us "not_new" where Brandon's patch may give us "new_oid", or
whatever symbol that is more appropriate for the context it appears
than such an automated cute name.

> Do we use any C features that are incompatible with C++? (or do we not
> need to care?)

Good question.
