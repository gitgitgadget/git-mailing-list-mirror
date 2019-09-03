Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596E51F461
	for <e@80x24.org>; Tue,  3 Sep 2019 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICHv6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 03:51:58 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40618 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICHv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 03:51:58 -0400
Received: by mail-ed1-f51.google.com with SMTP id v38so11723065edm.7
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Whnrzg3MnS82FLpw6MRrrrB8qSuwHA9lIJ2scO1UnZU=;
        b=riSkIH3heNdEcRcJM1bB+dH6FnytqGe8VN+BkPd6UVp8no65aSH6hzHqlJG4TK5mJo
         gKh7Mj6AaQgLOCMV6JXXkvMluS9yOjnMYdeU8IYO2Dt+ILBJJ0K0vv8dhe3ArQBfJFLN
         j8eqaM1gCj34mghBPDq9afdEHuK7wJf3WjoBQWZK3zurOyuf78Ia6lKuYsMu8PWr4XEQ
         3kn7TgTi0wzkrtzEC2bmV6+YTTxh+7zsWie4LvSPesW/UrWCIlYU5oqqMNY3JwJTYY1M
         Yr8ZLXng2K9J2/YQkLM5qKRNbvpVBWG569HF8gNY5eL8508yKUohi9XT8M7xcVMfPM78
         CVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Whnrzg3MnS82FLpw6MRrrrB8qSuwHA9lIJ2scO1UnZU=;
        b=iBKMAwPBYTJY7pA70rnqSURORzIE6omohqFtqqgh1C3Ucb8WWeK57XxlgFTYaOrBBd
         qs/qrZaMf5AO2X6iQyiDboNX4ksIZ+/6XV+3at6VKIJYHPgIvwvmFwQzMnm28JTBJW+p
         RpABC6ndV/YBAEjXBWa8ShoJxKrwrYqLbCAQWiWanKnaaBeffn8AzolKVW9G+ILkuL8w
         ZIBFl0VDok5KjdkcWyIKyRSHE+rPSC+6T/MKZBbNQoMLHhs/+AqtSOjB86RNiCNV4gNZ
         LmHQWXG/7zhyTCZVS+G+RQs65AAYUm+puaVyTg9qBRarqZ9Rwn8Jdcd07kayJ+g9mpWZ
         EdOw==
X-Gm-Message-State: APjAAAVc1r3XRS8/8R3jj8yVdxo72+03reu2DQvudvyD9BDVkPUsF/Uc
        w0KHzp4LJHn80FZBdazDO90AgAmqPpljqQ==
X-Google-Smtp-Source: APXvYqxLQIeyMZLfM+ZM0GSogKjoDN7zh+7MuVze388sSeUOFzN4VO/A3nNiq9Uozo0dRhpJbt7etQ==
X-Received: by 2002:a17:906:4b49:: with SMTP id j9mr20861346ejv.81.1567497116614;
        Tue, 03 Sep 2019 00:51:56 -0700 (PDT)
Received: from instance-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id ns21sm1573374ejb.49.2019.09.03.00.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 00:51:55 -0700 (PDT)
Date:   Tue, 3 Sep 2019 07:51:54 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190903075154.GA18496@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1rwyv6tq.fsf@gitster-ct.c.googlers.com>
 <20190902215048.31a69442@naga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 02, 2019 at 12:25:37PM -0700, Junio C Hamano wrote:
> I'd rather leave the sleeping dog lie, if we need to encourage
> people to live in 21st century and step outside US-ASCII to do so,
> then do that instead.

+1 to let the sleeping dog lie. When you say we should encourage people
to step outside US-ASCII what do you mean by that?

On Mon, Sep 02, 2019 at 09:50:48PM +0200, Michal Suchánek wrote:
> As much as I would love to agree Windows is dragging us down here. I
> don't think there is any other major (or even just not completely
> obscure) platform that does not support UTF-8 in the terminal.

Well, I don't know how much Windows is related to that. On my Linux
machine my user.name ends with a single quote: I have a US keyboard but
my name ends with an "o grave" and I can't type it.


