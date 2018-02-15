Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3B71F404
	for <e@80x24.org>; Thu, 15 Feb 2018 19:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161224AbeBOTQm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 14:16:42 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44145 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161053AbeBOTQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 14:16:40 -0500
Received: by mail-wr0-f179.google.com with SMTP id v65so734104wrc.11
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 11:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tvWTE1oS5kPVB7XABHo9A2xGabCztlopKlZPRUZS928=;
        b=n1x/Js10STjsgLDDOVIzZTDofY/ntnumWo8QLIBXbZpbv6IbYJAh5JvxwppOvtcdL5
         T2NmuzS7oOUWjIxXU22a+6uWEQmS0EbsyoPjHaEbbGXGLGqa05b1wKgs1kMBdMqwseCd
         ipK7yA0+v06C5Z4ugvUe8oHwNT/DwJ6lmkAHJfMEi1JMXyExJIff9lS5DFoRNWudhQnn
         GPwOoylaWT7pR+4vmwprBdi4f0Pu0o8J0o5Yf28x5kXsfLbPHPGL+AnTV/LtEDh4J2fr
         UOPwVeXRcTnU5Nap9aHw/kNkTHQJch4Sz6CZLzLMwAWLgiyK+OghhB7zyn8RjhCBrfni
         3hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tvWTE1oS5kPVB7XABHo9A2xGabCztlopKlZPRUZS928=;
        b=J8aMtFQAaiQjsnv4UeO4FlOTtpKGD+lIW64CZkX+LC3r9ElY2XzMKQP/sjE59CABRp
         7agRiwqFSQ1+ss27Ma+pdRESBCdl82XGgWOh69ofvKJfTiwMhgz7CNkdMGeb1ag80qSy
         fzMCjqK9Py8rl6kfknWOX0DcLosva4yPdoZdrprEOST7x1KmqLvXODay83ckVoenE8Bw
         +Y4Zwzx0xLmNrwK0LPjBBkJenJNa+sd606WoD2HeC3UbiqHpoEv6uizGsKPn9m7L/eDJ
         d6yETx7Xx7gIVjUaH8MZH2XRHgBNKpq0AhN0Mo/HtGHIEIgPBh04rnH+STc7oTPmvg2/
         JG4Q==
X-Gm-Message-State: APf1xPDRnVxXZCjc96xDFdaJtgwYWrVGTQ+gyeybeHOlrVKYrBsFSuUW
        JOPyLWCUhe72vGT8eTxGh9E=
X-Google-Smtp-Source: AH8x224UDBuSRkdSg16pgW3+ORgiahAL9fu4r+7wSs3craTLLBTrx1FmEUN2ZlPVYD67bv5e7R3EMw==
X-Received: by 10.223.157.71 with SMTP id o7mr3814640wre.248.1518722199092;
        Thu, 15 Feb 2018 11:16:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 81sm14376714wmi.26.2018.02.15.11.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 11:16:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
        <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
        <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com>
Date:   Thu, 15 Feb 2018 11:16:37 -0800
In-Reply-To: <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com>
        (Robert Dailey's message of "Thu, 15 Feb 2018 09:24:40 -0600")
Message-ID: <xmqqvaey83my.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Torsten Bögershausen <tboegi@web.de> writes:
>>
>>>> $ git rm -r --cached . && git add .
>>>
>>> (Both should work)
>>>
>>> To be honest, from the documentation, I can't figure out the difference between
>>> $ git read-tree --empty
>>> and
>>> $ git rm -r --cached .
>>>
>>> Does anybody remember the discussion, why we ended up with read-tree ?
>> ...
>
> Sorry to bring this old thread back to life, but I did notice that
> this causes file modes to reset back to 644 (from 755) on Windows
> version of Git. Is there a way to `$ git read-tree --empty && git add
> .` without mucking with file permissions?

I think the message you are referring to is a tangent that discusses
how it was done in the old world, with issues that come from the
fact that with such an approach the paths are first removed from the
index and then added afresh to the index, which can lose cases and
executable bits when working on a filesystem that does not retain
enough information.

The way in the new world is to use "add --renormalize" which was
added at 9472935d ("add: introduce "--renormalize"", 2017-11-16), I
think.

