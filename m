Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDC01F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeINV3d (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 17:29:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40451 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 17:29:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207-v6so2512139wme.5
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+QEgQEAbe3QH8OOyPycKJgplUejaxLWc3KNiOmadaH8=;
        b=QbwLcPw7q6ZM/l8OMb2gCzgPgxDSVEqlhQSq/cq0J4TWfHZgYhHFg8iLxROQ2XMeYj
         BP6VWKhaaQEZCLUvTwSfAcAFId7YjMhxo3MeQA7YW+OEmLO2AUHADiK28YCrwtP+JyfQ
         7Dxh1K7XVc3AQ4+pgD7v3fmWtWNaurId9Fe6rKoLBQAulppCnPX2zzhhhQwxMpn7L4DO
         8dsTLrQ5kaFCyIosKnf2XBJpeveQFldCsnvL0CJHvgY3wO7aF+qyvTgqagIfoJ/rwfSS
         jZqhkxGwRpsS8n0eZLoctzUrkqYNsMDw9IR1fhHRlekgm1cNiznW0+4gAzXhMsNtrGqX
         O3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+QEgQEAbe3QH8OOyPycKJgplUejaxLWc3KNiOmadaH8=;
        b=JZuyE+VRvYY7NXNLNiGgqymKiybmeKaKatEROSlCL8bkVAfPw/0IEuqHtKwOznFo+T
         SInsDbYlA7ckX6L5TzgEym1x83ruXgwWUhdVILUT3SRBA19ezyYqlQMYvuf41WJyNzlY
         DZc+Z2RoB7gMYek8wka2QGcQtmuUUtFjFVhCnMBizCIIHzuVm8wMp04mzxzIuluresQ5
         8SXC5rvF1LJpKXArnAlYfqAu1tq7UgnaCC5Se0JHuS11nfqOzSgdDYqsf0W6rAMK5NzA
         WekfqsWhU0plJNMbfEtCEypa0tKoFGyc8+LfDt3lE5Yamwq2t2bpLGGgdW82dlt13icc
         /wkw==
X-Gm-Message-State: APzg51C9Jn/0ZISvFW4u7rB4O/TZmzmF6hUGAexTEB1JnQQpxRHSLsyT
        EGxSrBjVEbKq2h5UAbyApmI=
X-Google-Smtp-Source: ANB0VdagkBswP8HPXU0mDbbCBHBSiI74AgUvrnbXw5w3TaNdKV04mXKnn/BZ7iYxGEDK9zFh8nd59A==
X-Received: by 2002:a1c:c345:: with SMTP id t66-v6mr3067502wmf.100.1536941661072;
        Fri, 14 Sep 2018 09:14:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm4560781wrn.41.2018.09.14.09.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 09:14:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-3-steadmon@google.com>
        <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
        <87k1npkzh5.fsf@evledraar.gmail.com>
        <20180914060552.GD219147@aiede.svl.corp.google.com>
Date:   Fri, 14 Sep 2018 09:14:19 -0700
In-Reply-To: <20180914060552.GD219147@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 13 Sep 2018 23:05:52 -0700")
Message-ID: <xmqq4lesdpk4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I think though that instead of doing setlocale() it would be better to
>> pass some flag saying we're operating in a machine-readable mode, and
>> then we'd (as part of the protocol defintion) say we're going to emit
>> GIT_ERR_UPLOAD_ARCHIVE_EXPECTED_DELIM_PACKET or whatever.
>
> I think you're suggesting client-side message generation, and that is
> one way to handle internationalization of server output.
>
> The main downside is when the server really does want to provide a
> custom error message.  For that, we'd need
>
>  1. To propagate LANG to the server, so it knows what human language
>     to generate messages in.
>
>  2. On the server side, to produce messages in that language if
>     available, with an appropriate fallback if not.

That is one way to do so, but it does not have to be the only way, I
would think.  You can send a machine parsable message in pieces, and
assemble the parts of speech into a message at the receiving end.
Like sending a msgid to identify an entry in the .pot file, and
values to be filled in.

