Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B881F42D
	for <e@80x24.org>; Mon, 28 May 2018 02:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032940AbeE1CpX (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 22:45:23 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:38734 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032426AbeE1CpW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 22:45:22 -0400
Received: by mail-wr0-f177.google.com with SMTP id 94-v6so17781261wrf.5
        for <git@vger.kernel.org>; Sun, 27 May 2018 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QYeLlL2Zgjd6rENz4LXFnctOxxjv8Wo6LgZE6F/0hUI=;
        b=TpXdX4l7+X0saKnrS+hvuL2hVh1cUSxVXPvSd4fLYZhXIQbLroUiMRwjK+BBjbfxBx
         1M37pVmq+m7rhlDm6mC/QzwDUVKPXx/8/VMvKd0vwBIMTzrMiRcxDgAEAkiIrfoOoscY
         HQAugbZEg6yoY2rgY+795/WkXPuU7v0DDyNxwo/B0G+mWkzftkttDVVg1Hy/EgBLyJIR
         p3QggtRd/jr/3RgAB76VXeUA25gtrDrC4vsYXkz8v6zGayPcWISueIBvXPS9ICDYnQgC
         TIYG6cwVm4iD89UqSZ0fFtVhe5BepSu3oiV+QEPjMOAiFEBMltzy8wPKaipwnq7ab2YZ
         lLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QYeLlL2Zgjd6rENz4LXFnctOxxjv8Wo6LgZE6F/0hUI=;
        b=tdUMNQ0wfm7G4KxGbDtDP3CEjGMz7RVTPeSTn3emPOybhf7nUKcjcxQH3cdqiD8G1F
         n5yImLO74I7elLFK9mGBO66Z9wKeRKZFiS6AkC0LVn1paO4P/371AVRE8wb6UUBuzJz6
         J51PmsKaus725YYLy3OncxCA4sPxrSjHy4NGpM+66sReERO6VBtGxA4yD5vtnTsWTKdK
         bC4XBL0PbzKjV+aCJy5TptYjszHYEiwECULvpPw0EPpE54OBEkfzHsZoU4M0LSs8VH3G
         VFoVixe717krN1gC4M2sWLpMkuRSiCCIcsbRXiURwgukwKRTueMxeiK+Tb3HblOG4Swj
         y6oQ==
X-Gm-Message-State: ALKqPwc+nekh5ZvKi6nISCKoj+/iF8m8kclReA3b3JQC4h65qLUKNRrB
        nrz2xPzlTF392EYbrQ8UdLI=
X-Google-Smtp-Source: AB8JxZqpSsg1lHgbcSafhsBzyUNBRPXS+biqmPJVEGCdZNI3I9ewAElLCE5NFKQEKjGfK4QakSd9Hw==
X-Received: by 2002:adf:c613:: with SMTP id n19-v6mr8173561wrg.177.1527475521101;
        Sun, 27 May 2018 19:45:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v31-v6sm32481937wrc.80.2018.05.27.19.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 19:45:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: git rebase -i --exec and changing directory
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
        <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com>
        <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley>
        <CAAUqJDvCgXPubhtSKzMLqTU5au320U15UQ8Lst7+JeZYBp8wTA@mail.gmail.com>
        <3465c994-3917-cd45-bb8e-d1121f60bfb4@talktalk.net>
Date:   Mon, 28 May 2018 11:45:19 +0900
In-Reply-To: <3465c994-3917-cd45-bb8e-d1121f60bfb4@talktalk.net> (Phillip
        Wood's message of "Sun, 27 May 2018 17:07:58 +0100")
Message-ID: <xmqqfu2clcqo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> I tried your recipe and got the same result as you. However I think it
> could be a problem with 'git status' rather than 'git rebase
> --exec'. If I run your recipe in /tmp/a and do
>
> cd dir
> GIT_DIR=/tmp/a/.git git status
>
> I get the same result as when running 'git status' from 'git rebase
> --exec' So I think the problem might have something to do with GIT_DIR
> being set in the environment when 'git status' is run

Yup.  

When GIT_DIR environment variable appears without GIT_WORKING_TREE,
"git" assumes that you are starting it at the root level of the
working tree.  In your example, if there is README at the top-level
but dir/README is not there, "status" would report that you removed
it.  You can unset GIT_DIR in your --exec script if you know that
Git would find the right repository when run from your script.

