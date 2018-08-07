Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32C9208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbeHGQve (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:51:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeHGQve (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:51:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so16038683wro.3
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QKcYBAv7Mme0jzruzvb9SQrcxJPrbUHSEDXZLTGNaFw=;
        b=UBvB3aq+P3cbMr3iZ7cwD7qQ5pNu5r7gq9c2j6/81hmBF63mRhy+LgPeZCyUiTpo0N
         VTsZWINBhSIcLlMZHKSTsnRaqZX8YdINbnukkQefiFrhhwo7J2KE8OaC70UXzDUlkHKh
         yyAZlqJGksQKgx97e8hKuCQJ9YNQECzcSq13nHgydvv5DSSNoRIqwY6257ocwl8tRX2j
         xNa2GTZAa0Pj9w49V2ou7dPWmTrvR8jXdJaQyBIm57HanjHddReGObHtFnrvt3KHCXTv
         yh+LcqGbUDloWWV4gvIdXbgrZQj72Afms5vD/kEv30Ol+aEObS8duJgzrpPZRU9+rnjG
         1egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QKcYBAv7Mme0jzruzvb9SQrcxJPrbUHSEDXZLTGNaFw=;
        b=InjUAibXH/0mLkRigXjIqnIoRup5aUUBsrbpSnD2c9avD7AhBi2p4lP1DDye2Q4QbC
         RcNF8YF76/89zlyyEJD2xSxvwX150DvBM6HreGdbVJpkO+sVGvjlVrnS0J9MQ1ggGCcn
         nKZ8DNts4MqVk7Q+YFrgJHG8NvwEvoCnlXQ+euTxDofnGQRMlPbH1RW+ZV5P5DAtyjOB
         TywH55AplVPIubWK4cI+tN0lN1TTNl9u6kphBGNnMIhtTKMsxg/IkCl/Ga9Qp/+z5m2T
         iMrn9PkzLdgMHjXffvlvai/6uIKfvwFNQZi7e2pGAjuX+uutzKLp+03TQ+W9igVPnzlD
         bhNw==
X-Gm-Message-State: AOUpUlH78v6pb4chEWfy11jt7oGWZ2vR/g+r4zFVQM9spSNj7ltdlXbx
        fqse0W95x3oS46S+odI2w/M=
X-Google-Smtp-Source: AAOMgpco+YmHGtyZYKlNSdtl6Ohwsgx6mZdBe+ine2dC+CPfQRslXpxjHjbH1FyL2anbdQGSVf8DwQ==
X-Received: by 2002:adf:ee4e:: with SMTP id w14-v6mr13393828wro.63.1533652615565;
        Tue, 07 Aug 2018 07:36:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f132-v6sm3458465wme.24.2018.08.07.07.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:36:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
        <87tvo6snll.fsf@evledraar.gmail.com>
Date:   Tue, 07 Aug 2018 07:36:54 -0700
In-Reply-To: <87tvo6snll.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 Aug 2018 08:21:58 +0200")
Message-ID: <xmqqftzqmeex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Aug 06 2018, Junio C Hamano wrote:
>
>> * ab/newhash-is-sha256 (2018-08-06) 2 commits
>>  - doc hash-function-transition: pick SHA-256 as NewHash
>>  - doc hash-function-transition: note the lack of a changelog
>>
>>  Documentation update.
>>
>>  Will Merge to 'next'.
>
> The tip of gitster/ab/newhash-is-sha256 has a unicode-corrupted
> signed-off-by line from me. See
> https://github.com/git/git/commit/f855a19d45 not sure how that got
> there...

Thanks for noticing and reporting.  Will correct.
