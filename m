Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3798E20248
	for <e@80x24.org>; Wed, 13 Mar 2019 04:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfCME6J (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:58:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCME6I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:58:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so425122wrg.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+du1CGs6DtcrVBK0WD1BXPFAkVF0fiRHU5q2B29YjSc=;
        b=YAKZ+t3Zdq4Ahs24DhC+vV1Uf4jpR0X51HYdF4P5kOmHUKa5UkfWlF+gYuLeke/s7x
         O8iiDtt25g6HR6Jby/mgZVk4etebVK1PUmSjHJxxvyn7KGErh8fh4kypQh7wmgy3cJM1
         iCpxYQQcvoN3UrxCQZhB3m2fD2i5bbdJj2uZKyYCqf7T5Y9Uc236Dpc+B7XH1hcuj4F5
         fuWiY8T+g/ISdkgfmiubfsyNFPsG5O4m7KPPAohizNXk6wZflLYMXtWlNdlbEMH1PXB6
         gj1CbGBJU47CyvO2iBq4bB9+mCQGb5i5S4sAKMNmTxmsILajhSV7tm/tPrNzyksSooHb
         Wt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+du1CGs6DtcrVBK0WD1BXPFAkVF0fiRHU5q2B29YjSc=;
        b=Gwc4xkbkfS8GCcdJJn+QBTK/2RRwAfS1Wb5k7+L7Ukv19CAu1XiTTJKMwCAWx3Q3WB
         O2MEqQUQJGg7LsSJUI6qkWo+AarYciXRLHcfgqdai6Q8oY5OUup9gdbn6bNaBxbkqnkC
         bnIEPZyy60fE/l68HpG0O/l/Fezzfg0Gq82Yh74/1w9MQ6UuqpDKY++YP+AT2xyT+UZh
         GGJ+h3a/JHvWOKF7PLLVTBrFDIKBu4aCOY2w206uFlS5MrKdkC/SPKH08DjS8chCO4yq
         JDndUWwb/8eEp9nxu7HL1qXPKNhgOaarUTfW/2vF3g8aZZl/VdE+KgznYo9a4ZR8TxGP
         Bk8g==
X-Gm-Message-State: APjAAAW6QBNSot6PhFB1wwzGW1GXA4OV6yPDH3IfF0/gfieYUkXwxCd5
        5I4+Wq+eEHL8KzUN0/vJ8Kk=
X-Google-Smtp-Source: APXvYqz3b40DSxE369hCjWtu4FoyndXohxNMYkEB7hnHLkBEsKLIQHrrODrRCgikYjE9L184DRcw7w==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr24306329wrm.4.1552453086661;
        Tue, 12 Mar 2019 21:58:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a82sm896737wmf.11.2019.03.12.21.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:58:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190308101655.9767-12-pclouds@gmail.com>
        <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com>
        <000b01d4d814$64907000$2db15000$@nexbridge.com>
        <CACsJy8CJ5VimEJsJMN4G2sFxn7X72qM-8QLBo7NNSjWx39npug@mail.gmail.com>
Date:   Wed, 13 Mar 2019 13:58:04 +0900
In-Reply-To: <CACsJy8CJ5VimEJsJMN4G2sFxn7X72qM-8QLBo7NNSjWx39npug@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 11 Mar 2019 21:36:58 +0700")
Message-ID: <xmqq7ed3e5gj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Just curious: At what point did git checkout become not commonly
>> used? Git switch and git restore are not yet in git as of 2.21.0,
>> which is rather current. Maybe I missed a thread.
>
> I declare "git checkout" not commonly used the moment git-switch and
> git-restore are released!
>
> More seriously, this is an attempt to promote new commands. The
> "commonly used" here refers to the set of commands that show when you
> run "git help" (they are called "common" in command-list.txt
> classification). Since the people who type "git help" are mostly new
> people, I think promoting the friendlier alternative is a good idea.

So it is mainly how the word "common" is defined?  It's not how
common the command is in the minds of the population of Git users,
but how common we want it to be?
