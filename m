Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0D01F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJYNTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 09:19:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41924 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeJYNTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 09:19:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so7759863wrr.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Rgjmtxup8dR19WK13sglx/ynjuW79cDzRmxzZIhRQc=;
        b=pzlRas8PaCQ5UCPQCpjzBpXs8k1PX9datgvagao1L0yvvejriDy6TXzsbJoPnIWU2s
         YjPavc5PWgThzbmD+q9ZCntkTWQxewt7ZtB8eexD0jTL5/ObC+VSC9xPragxfX7s3ZzV
         6Mciw8zIx6ELBAY8gtP2IATUma4/Yg5JOKXwNFmLMpb9sr2emVxGmEMDBEyC1RdyYpzU
         tMXsGzfXVJq1CxGFIRg8P7E3TeKxKfGyFgxNHSNqXJAlPbQuEo1MdYXQCR3VjR5ERzeV
         9QpLpTslEYBzCa+ZaPfKquz5P0ydjF6+04ncyKzyYSDvh9WRrr5MlXKsU2pOGng/sMcE
         sOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Rgjmtxup8dR19WK13sglx/ynjuW79cDzRmxzZIhRQc=;
        b=XafGOT4cPngQtDlrbSGqwk31xMKmAqf6pFWhyLjV5b0QtI+2OS7ZW13NWpV2mWxxmT
         grnCIHGmhVbAZKooa94b6TjGWDE6GfNF06pL3jBQgPZd5Up+FgOCgWid77JWkdYSHhEy
         W0YnJlKiQ+KV2pwbG/6DcUKOl6Eg/Q9p7+KitjmzZqRuCBBj3oRy8MpezLcg7C+sG/Lb
         Q7X19JU4jtR8vJp9V+fuRj0VZybvWXEVpP0tM9t2qqWjsj2D6oWT7j82pmrZcfzf8MVU
         tQrY3jYG64HwfW2L/CJ9RLZMosyE1HWOj/Jx3xbkiUt0y5eGaeMgg27P08ARxe8jjuJi
         gNZA==
X-Gm-Message-State: AGRZ1gLb3N7uNN6pAMIVlEt5fADrCevVj2bGUyuFhqwuS25/BC8ArKA6
        RqC2SiFXPoegCynmPDCq9NA=
X-Google-Smtp-Source: AJdET5fyjcQI6tMlniB3gRGOnPPRT3KLbxFSkaGAMPDa/YzAhaG5bP51830sPHMVzo09XZK4ZjyXkQ==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr46390wrp.81.1540442915003;
        Wed, 24 Oct 2018 21:48:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j46-v6sm11365498wre.91.2018.10.24.21.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:48:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     slavicadj.ip2018@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>, Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH v2 1/3] [Outreachy] t3903-stash: test without configured user name
References: <cover.1540410925.git.slawica92@hotmail.com>
        <a055296c2034a44f02c253ce3194018b21eb4e1f.1540410925.git.slawica92@hotmail.com>
        <CAPig+cRGn0Z7F7TpSwF=8cQJpN1LJkQb2VxHMDi6j6wsaqkORg@mail.gmail.com>
Date:   Thu, 25 Oct 2018 13:48:33 +0900
In-Reply-To: <CAPig+cRGn0Z7F7TpSwF=8cQJpN1LJkQb2VxHMDi6j6wsaqkORg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 24 Oct 2018 16:25:55 -0400")
Message-ID: <xmqqtvlak4wu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +    test_commit 1 &&
>> +    test_config user.useconfigonly true &&
>> +    test_config stash.usebuiltin true &&
>> +    sane_unset GIT_AUTHOR_NAME &&
>> +    sane_unset GIT_AUTHOR_EMAIL &&
>> +    sane_unset GIT_COMMITTER_NAME &&
>> +    sane_unset GIT_COMMITTER_EMAIL &&
>> +    test_must_fail git config user.email &&
>
> Instead of simply asserting that 'user.email' is not set here, you
> could instead proactively ensure that it is not set. That is, instead
> of the test_must_fail(), do this:
>
>     test_unconfig user.email &&
>     test_unconfig user.name &&

Yes, it would be more in line with what is done to the environment
variables and to other configuration variables in the same block.

Not that I think that this inconsistency is end of the world ;-)

Thanks.

>> +    echo changed >1.t &&
>> +    git stash
>> +'
>> +
>>  test_done
>> --
>> 2.19.1.windows.1
>>
