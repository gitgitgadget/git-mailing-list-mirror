Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C1620374
	for <e@80x24.org>; Sun, 21 Apr 2019 23:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfDUXoW (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 19:44:22 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55381 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDUXoW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 19:44:22 -0400
Received: by mail-wm1-f51.google.com with SMTP id o25so12603045wmf.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C4JdThpuXyKTqrGTrv9y5R4n2x6d6eP+RYEjyG6kU3M=;
        b=NZLpX+MMLWVu1pqE4Je8ftNigo8HXaXU1M2ZhT5kWNREhaWWIuWzGYrs1l1zCsKch7
         +CjOe0LJNXGSP+9kNbuRxY+Uf8i+kOj0SV0HKjTbV6VhACV3M6Gmorh0gDHXm1u7OgD2
         phTARdcXv7CB3YHyFEHlQjxfVJZmaNRlZE/fYmQ1MuW2VURdJewAMaUPK/viJzH105h2
         ZjbE01JdJY+MrAPJT2qoHxI0JsR+epRmD86nA52+J7QwF84UdgP+c/dZIJyk8FjQEtQu
         opkgnji5M0FhL4dQAP3gRe8hnzIi4A9NOeOqtV6iWD3O8HEBpHLUaFiXKYwT/EOTcOQC
         InIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C4JdThpuXyKTqrGTrv9y5R4n2x6d6eP+RYEjyG6kU3M=;
        b=crkVF5nnTiz3BtWbHuuZYO/32NsgFuhYv1k7euEiUIOAQQvCYNZMzY+2Z0p9jzMmal
         EYQZ0C5oKpkJBq3tTEUwIcrSViC+bNsv1ewzxDTXNim0Ti17xxeQYTdDXDM09UCFfbVK
         rtxRaH71Vp2eJQDWBLikTI+hKT2X1aIaIT6Am4p+DmaGsx6cNUB69PNVKaOTrky+S+sh
         9coZuC9jdTCAfa5MLexb4AnykAVkjiqNglgYwEMQwThuwVmg0C1+H8NA9hfoPcTXQ4pG
         OpcnwWQ+TG2iOiLWLtg3RJbt+oo7Gjz+LEthRGWdG/TXWxYvhvfQpA/S0iqrNl6pELcp
         DOmw==
X-Gm-Message-State: APjAAAVOkF9Ox2jjGBVU3kwt2zYen2ciLbDa0pkaxlatex4M8WcxupFg
        gH05p5djcn0PdURyi2xIRlE=
X-Google-Smtp-Source: APXvYqwrTHGvNg/YPB8y0c38L/7jG2TKOC520KpM5BJJtgEIWUSt+7Ini6V3JkgseWaTyFb3YooyWQ==
X-Received: by 2002:a1c:3507:: with SMTP id c7mr9652209wma.20.1555890260252;
        Sun, 21 Apr 2019 16:44:20 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j190sm13363100wmb.19.2019.04.21.16.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 16:44:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@talktalk.net>
Cc:     Andrew Janke <floss@apjanke.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: gettext, multiple Preferred languages, and English
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
        <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net>
Date:   Mon, 22 Apr 2019 08:44:19 +0900
In-Reply-To: <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net> (Philip
        Oakley's message of "Sun, 21 Apr 2019 13:59:48 +0100")
Message-ID: <xmqqbm0yappo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@talktalk.net> writes:

> On 21/04/2019 12:08, Andrew Janke wrote:
> https://public-inbox.org/git/d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net/
>> I don't think it would even have
>> to be actively maintained, because for new message strings that aren't
>> included in the .po file, it would fall back to the non-translated input
>> strings, which are in English anyway, which is the desired behavior.
> Given the above comment, could the en.po file
> (https://github.com/apjanke/git/blob/english-dummy-translation/po/en.po)
> be some very very short version with only one 'translated' string?

Or use LC_ALL=C and be done with it?

> This may be a way-off comment, but if it could be such a simple
> maintenance free file then that sounds sensible.
>
> also adding in Jiang Xin <worldhello.net@gmail.com>, the coordinator
> for extra comment.
>
> Philip
