Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B13211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfA1XAX (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:00:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46561 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1XAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:00:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so19929414wrt.13
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ea2faeqD4DwOUp7j5paoQas5efshmr7bGF215e7Lw1Y=;
        b=Ej8urVY+RMHG7AdEZz/5AAL1xDK8JxS3BUIGvrF02y7jZhyQCtIOxfsuRasfVGw3+1
         mtq7lFD+U1Lih7X7HcPs5J+SRS5jhb1rJOrlsvK6GdqINlHDfNw1+gx567+waRzGItPL
         oqPsN4eLN03tYGBmSzjjmhA60tr616aZOscIY/gsBuU5Jv3Xmj6SoZRqoQQ4xq+m1iKf
         EQ6ZJa4YPJd0ARtGrudzhfJuEJHm8G+8NKaxkhH/Eqppvgw1+GR6GTnBXlaFqUw5WxRi
         b89ulF6nA86oihPdX+yLMAq8C+ObQNda8FKVKeXu0CO2tnpS3gHgNGBhdSL1aqWUVTFz
         ousA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ea2faeqD4DwOUp7j5paoQas5efshmr7bGF215e7Lw1Y=;
        b=jTRGaekGiSsOlfXFVylXvskoZTnFDXhp766zPOdcmz4ZQGVFf1MyekQ6oV6BG66GgD
         pJsBLzl+ucNNdM6h36rTG/LVnjCoUWZz0geYju03YS0trSCeMbnlb6ATNibMcA5TvW8+
         wUCHOw+9cBrMnELqp8uMOGXnZV7ufT/nLMNLxwNyNkrvSC62tD7/l09z4/YlZQjyfiaM
         GRh1CqadR2s2z8OLE3wFPVtGnJbTrmbAgzlPfBj5WJybEpRpZJI/X8BqY4j4tFWMNeEm
         AszY3d9kha/cVN/IEeF9lDoFHQpPC0XqJeOiOmEq13LvJlU1/SkAw8LZnSxe7bqQcVyC
         u1zA==
X-Gm-Message-State: AJcUukdNyWpTvLLwviLb0c/9RBT8VDGpsuECQbyZSG+v/1tHH0gsfHVJ
        Ikd+VA7JgYbRlHsVH6zftxM=
X-Google-Smtp-Source: ALg8bN4Cbqnet2MkP63uPDg3RC/MJy0vLo5cf2Yn191pDAsNLXPSmdabbPsCTGjQ/IU+0HqnRTJj3w==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr24853319wrr.67.1548716421343;
        Mon, 28 Jan 2019 15:00:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f3sm1234514wmd.22.2019.01.28.15.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:00:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 18/21] t0061: fix with --with-dashes and RUNTIME_PREFIX
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <d613c79aff9c65ab9c3723a876c99e6f35a2f133.1548254412.git.gitgitgadget@gmail.com>
        <xmqq36pdcz3o.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901282337550.41@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Jan 2019 15:00:20 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901282337550.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 28 Jan 2019 23:44:52 +0100 (STD)")
Message-ID: <xmqqzhrk8k1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Two questions that would come to the readers' minds are
>> 
>>  - Why "it fails to detect the system prefix correctly"?  Is that a
>>    bug waiting to hurt end users?
>
> I recall explaining that already in a different thread (one that actually
> *was* about the RUNTIME_PREFIX feature, where you asked why we cannot test
> for it in the test suite): to verify that we are in a valid Git
> installation location,...
> ... But that was clarified already to your satisfaction in the RUNTIME_PREFIX
> patches. Or do you want to reopen that case now?

This is not about me.  It is about those who read _this_ commit ---
if the change is justified to them clearly enough, then we'd be
happy.  I did not think it is with the proposed log message, and
that is where my comment came from.
