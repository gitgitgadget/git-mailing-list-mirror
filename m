Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A08208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeHFTsa (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:48:30 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45393 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbeHFTsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:48:30 -0400
Received: by mail-wr1-f53.google.com with SMTP id f12-v6so13116477wrv.12
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T3XeiKRmuyB4/OdTh6SuGmfpGPEjujYJoDJ451ZqpdU=;
        b=qlVlh2p7rkruamKQHaeXOqzjNkx6Gu0TyNo4XCpRKDTumlPjaieZzQNRHnjk8s7mIq
         P7YTPakj4XxpiM+oy73s2yBzS9bkaGD4dEDiMKHoqflEf0eyZ/wzPjAnwSdvNF7ZBq/A
         In4ZgDPiLje85k50EE0mnvvsYKbFa6ZhWWgH1PnQos6JBa7df1JgHa5BLPe5Ct+/j3Mn
         5trABcSDAALjbCFAVFPnPwL+Ud9NZUE0GgQEachRqXAFa3Vc6s+fFNTrStv/ciSt9Yud
         g1O0R0apaY+yaQ5WnIR5lLWgNU2yGsJjjTvV6OCBLjk1x0Eju1JfjXMxpV3MCmq7W6Rv
         fBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T3XeiKRmuyB4/OdTh6SuGmfpGPEjujYJoDJ451ZqpdU=;
        b=rIIssqnlbl1TEUfILkY1nrZFRE5v5BJXvdEJZ/mJ5wL7kKVSlPJWnykRiISWax9OgL
         p3fHpmOXpKvWMYIoPi+BIHCf5N2bsUvcAjjcxgD15Dsu6IE4ii6FnxYd1jFpj+aNnHqV
         jg7u2SJKOFyG+T8ZIHNXk068k6Jp34Co3O2AbW+Zy44XUW4xcdq7BHU6DTLHJwHyN1Aw
         4Su73KuMrCsPSllayaLV3TDbkD/YP+86tJXKTDOIZHwsOFEKRa+d7UIDgNKLTcgAqxtN
         4hZxQgf7a1tKtJrcNJtn7TRHuVqkzcCeJviz/uDp4BTC8qOIjuiVbNQaMQ8wZxDwtUj1
         +/7Q==
X-Gm-Message-State: AOUpUlEe/6TidAan9kPaLeJ0LkOJ1ktGxmEWTNl9/+dMC1v/uGvQfngq
        5Y1QRDp2aogPYmrXmdHkavCkYiSs
X-Google-Smtp-Source: AAOMgpdinCV3cO3YBsw/N11JAdqIQ5cKwfxvLXUvd1zCvsJTbJ2zosOe3epZB9q3DFo9SGSDX/2fJQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr10656283wrs.137.1533577101234;
        Mon, 06 Aug 2018 10:38:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q21-v6sm1836788wmq.3.2018.08.06.10.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option to the 'config' sub command
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
        <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
        <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
        <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com>
        <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it>
Date:   Mon, 06 Aug 2018 10:38:20 -0700
In-Reply-To: <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it> (Antonio
        Ospite's message of "Mon, 6 Aug 2018 12:58:28 +0200")
Message-ID: <xmqq7el3pf8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

>> I also do not see a reason why we want to stop referring to
>> .gitmodules explicitly by name.  We do not hide the fact that
>> in-tree .gitignore and .gitattributes files are used to hold the
>> metainformation about the project tree, saying that it is an
>> implementation detail.  Is there a good reason why .gitmodules
>> should be different from these other two?
>
> Not sure about that, but one difference I can see
> between .gitignore/.gitattributes and .gitmodules is that I got the
> impression that editing the latter by hand is strongly discouraged, if
> that is indeed the case a layer of indirection can make sense IMHO to
> make the actual file path less relevant.

I do not think we discourage hand editing of .gitmodules more than
others, say .gitignore; and I do not see a sane reason to do so.

"If you commit broken .gitmodules and let another person clone it,
submodules will not be checked out correctly" is *not* a sane
reason, as exactly the same thing can be said for incorrect checkout
of files with broken .gitattributes.

Quite honestly, I just want to get over with this minor detail that
won't help any scripts (after all submodule--helper is not meant to
be used by humans) and focus on other parts of the patch series.
