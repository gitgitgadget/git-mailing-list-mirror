Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF38211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 00:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfA1AC4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 19:02:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55515 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA1AC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 19:02:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so12036409wmc.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 16:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a4Mf7xCfXJ2xa8PgeRwanR2fA775s2ZofcA3p8JOb+4=;
        b=CZoEaIMZXM7vNJxEzR9mDwQIxPveNSuIzyMcg1eIy+6wFzYtnEbfBB/2f/8FaPr9Xu
         IjGMMNgtD3wrx2hGsSni6kCJ0tUKV2C3y2FnvKAwIDzGmhOqgEgCYpp+jUooC1ZFd0Ud
         PAWbXfdzyaAjBVmWZS33gwtcDbS6Ywm4E6yhd9Gv/CXe4tsYgdXc9JlzXL0HZDFw2k7l
         O/vjsuM+ePLBiflACd/gPD5H4Wc7qRyw2moyjqvlLOiED4hJhuR2NuFZVGca1LxiJR0u
         wQ/AI4QBgDYR6ynm/cWayYS1BOCpXq19LK1iy9YAJ3iLbebPaXPc7IxjphLIdSnqzDOh
         WSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a4Mf7xCfXJ2xa8PgeRwanR2fA775s2ZofcA3p8JOb+4=;
        b=TfLecwdJxhFP8kIn8ZZC2cJFwEE73wT6pYaEzHefiA3lnhWI0HGLSgDetIGQgUggK4
         YxOhf7po95icjEv1U67LSDJ3ImCm85MuXaXOQ+jVjKxHIrXBEsVKNiepWe8Q3ladVNOf
         hlW1ADHgXc5YKko7TxoUgu3Q0bMMwak8lXbBbV94xzHypBLAPpzaX/q12eFPW7cTIBTU
         y7G5er1zNsVw4PT52bAeyg8Jo1eIpzrDAso3ZthIUz8B6iY0RnKZWv9mrg0ugztgwQkI
         /gdYbrrZIvG4ZMxAgyrHA8pAJbl12Kw9hRklpMlvdQp/UijQbYhiPash1k8rJUQWUgwc
         o9gw==
X-Gm-Message-State: AJcUukdmy2iiRbnIL0Ryaj/qiJLvSx58KPC/tJP+F25FAJodLMmZEbBI
        BHIBZG3dc27yi3kL2ISOzmY=
X-Google-Smtp-Source: ALg8bN4K0pm60iI07UN3m/eHSIMP7kl7NDCqH7IYduMkJTC93MMgx0+rljiV6fkwF/YKkAcGztoA0w==
X-Received: by 2002:a1c:3282:: with SMTP id y124mr15376535wmy.134.1548633774339;
        Sun, 27 Jan 2019 16:02:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p10sm9687155wmd.14.2019.01.27.16.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 16:02:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Arti Zirk <arti.zirk@gmail.com>, git@vger.kernel.org, e@80x24.org,
        peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        wil@nohakostudios.net
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
References: <20190124161331.25945-1-arti.zirk@gmail.com>
        <20190125020451.GU423984@genre.crustytoothpaste.net>
        <xmqqva2cg61l.fsf@gitster-ct.c.googlers.com>
        <5bc3256d49834c96db2a51c12190f2cb7cf7ac42.camel@gmail.com>
        <20190125235811.GW423984@genre.crustytoothpaste.net>
Date:   Sun, 27 Jan 2019 16:02:52 -0800
In-Reply-To: <20190125235811.GW423984@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 25 Jan 2019 23:58:11 +0000")
Message-ID: <xmqqh8dtejir.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Jan 25, 2019 at 05:22:45PM +0200, Arti Zirk wrote:
>> This is the built in http server that Python comes with (like Ruby
>> users have builtin webrick server). While it is possible to install
>> something else, I don't think many casual git-instaweb users would do
>> it. 
>> 
>> I haven't looked in depth into it but I'm pretty sure that by simply
>> changing the imports I could make this code also work in python2.
>> 
>> Upstream python2 support ends in ~11 months and would Red Hat/CentOS 7
>> users using new git releases really care about "git instaweb -d python"
>> not working on installations without Python 3?
>
> I'm sensitive to the fact that upstream is dropping support for Python
> 2, and I have no objections to limiting this to Python 3. However,
> whether we like it or not, Red Hat/CentOS 7 is going to be around for
> four years after that.
>
>> In the end I would like to keep the name just "python" to signal that
>> it only needs standard Python installation and nothing else.
>
> Could you update the documentation to put "Python 3" in parentheses or
> otherwise make it clear in the documentation? My goal is to avoid
> confusing users who are on systems that still have Python 2.

Calling the option python3 (not python) would give readers the same
message loud and clear in a simpler way, I would think.  Is there
any reasonable reason why we'd want to avoid saying python3?  It's
not like we are afraid of sending an message that we won't stay
working with python4 that is in the near horizon ;-), and as Arti
says, those who already live in Python3 world would know, when they
see either "python" or "python3", that is what they have anyway no?


