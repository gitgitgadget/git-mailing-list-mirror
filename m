Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904861F803
	for <e@80x24.org>; Mon,  7 Jan 2019 15:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfAGPp6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 10:45:58 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34934 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfAGPp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 10:45:57 -0500
Received: by mail-wr1-f43.google.com with SMTP id 96so922633wrb.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PlCQO2u7NIAbAgm5PyNWK1Wx9pu3u7SpWcIkMOe/QEk=;
        b=XC6pkKt47kwu1sNu1B+mTyLorACls50v9c/SgciV7RrFckAROc+drIcZyyWg1sD8JG
         hgn/GZnCI0wtdbLPlmA3otMPCkfKMHoIBJAAOch6bRrlt1xP+8w1Xs9ERIle05v84fDT
         xOdEjhSOAwj0aGQkgTY10Wwn1Fnxbd9Wf6/UIzQ7vK2B8YFjvi++tGV7JKP02HNnSxum
         YsZjQ5spDK/Nou1147BRl3sHAJz+UVKnqvqhcLwCwTSss6RagxUrCRI6uI8au6gSmQk/
         f22y9WSnvLLlpEkXYHwzMeN/SoWmVXs/jW+B0qaFAROc91SC35F8rvG/BmoFbk+YDTng
         7j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PlCQO2u7NIAbAgm5PyNWK1Wx9pu3u7SpWcIkMOe/QEk=;
        b=Yl06ggR3Ghsad9iaT4O0CdRHwH9ZU2dQ4k2JaUOQWpPXrPR/u0VlzADwRmmC3jB3rC
         CZlKJ8PUIn7tUmfshmsoExRaQIgicgI4PjYKhb2auA8jdDIpItRTK7IjJw92Ch6pMHHl
         FxxVeVUPHHUta+fept7aDx9BPIpfxobfgFQGt4OAtwGjMx30Xbks4YGbwhWi2jOijQ+t
         I5xkBx6DCg6iIS1ZNsLHks+Y+zKeaDx0h0PIye7MKhdb9AnR4MlWxgBUCRJCYH0BXTID
         EpyQbU8Qn3ieSCtAVfbucMHlm6txV8CErpWVkQAgT9AkPrx6Q6tvJTzExfkS3MMLFMVB
         QzMA==
X-Gm-Message-State: AJcUukdmBKbltoIuslGzIDNSimpNWS0dxxwM98Aza5XqSraQY2+dhSqe
        Qt8x+moyH+v/+qbx5HHHrAw=
X-Google-Smtp-Source: ALg8bN54qfX7UBUeZCVg4ILK7qnJ5yIXztZfZnHXC8QNPZ2ZReq2mQ3fTX+FjtFQi3sLOCjdzySuzA==
X-Received: by 2002:adf:8264:: with SMTP id 91mr50058305wrb.312.1546875955703;
        Mon, 07 Jan 2019 07:45:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v19sm73717128wrd.46.2019.01.07.07.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 07:45:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gers?= =?utf-8?Q?hausen?= 
        <tboegi@web.de>, Git Mailing List <git@vger.kernel.org>,
        szeder.dev@gmail.com, Jan Palus <jpalus@fastmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/1] Revert "t/lib-git-daemon: record daemon log"
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
        <20181125220138.GK4883@hank.intra.tgummerer.com>
        <20181126164252.GA27711@sigill.intra.peff.net>
        <20181220164150.GB25639@hank.intra.tgummerer.com>
        <20190106175310.GC25639@hank.intra.tgummerer.com>
        <20190107082041.GA21362@sigill.intra.peff.net>
Date:   Mon, 07 Jan 2019 07:45:53 -0800
In-Reply-To: <20190107082041.GA21362@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 7 Jan 2019 03:20:42 -0500")
Message-ID: <xmqq7efgbhe6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yep, this looks good to me. Thanks for being extra careful with the
> read/printf bits!
>
> Looks like Junio already queued a99653a9b6 (Revert "t/lib-git-daemon:
> record daemon log", 2018-12-28) on the tip of tg/t5570-drop-racy-test,
> but that's a pure revert. I think we can replace it with this.

Thanks, both.  Will do.
