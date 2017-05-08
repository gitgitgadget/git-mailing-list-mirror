Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC71220188
	for <e@80x24.org>; Mon,  8 May 2017 06:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdEHGHF (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:07:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36309 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdEHGHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:07:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so8517969pfd.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yEFQyDpF+8PxTkzcvbfE37Ujd7CTueozwco/Zqm4IZs=;
        b=G8AiYKGRIiWPp7HK4kuYJs24DmoZpJdMFftaU65sTdcBwAy/GJ2FFCVF6MnxzFnIl5
         rzae+7QobDzkRbQOhWo3cLJGOdW6nHMsb7jiKuo6m8KWHJ0oqSZ5f44pWimTrNR+k/K9
         LlWPVqylw7vNq6SF/9U/JZV0iWYx/lX/BZqW5QipLSy5AjuUvNAoIUhZef+qwIYx8O3M
         VaFO88cCP644gApQhz1r3tlL0nrdX09GC/2t+4D2N/PZDsCysb5ruxiufDAyq2AG8mQO
         E/xtuk00F0/3aeO76IOdjFpGFZhMb41uQi26vPtAzxYxxyEiJlwG1+LJO4jAQrGHJVGF
         FNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yEFQyDpF+8PxTkzcvbfE37Ujd7CTueozwco/Zqm4IZs=;
        b=Xe4/4wiNyKjWiCiZ2dVuiF4K7qLPPq+QTPRkeRB264ckCMEbAqgZBVCnEoM/bQsN3T
         ZkV4UARiW8xeaQCEu1IEyQy1egwUK6qjc8H3BYhFT6RNv1rgbQxki2ES5b7LXCkz3ZFC
         F8SYHhPsTVE/mjS3Zf9U+y3ulozcIbWVwTO8g8snhPibDek8LMOTV01VrI5RNgTD2vZu
         Pbe5SnONTCPRGoOk85BgRrCPU+YTU5KSLcRLKJJfSB8fo4Oo81hnS386XoZ6gv15Gd/E
         YHtTCE0qKmTfRkBTx8/8431GIFBBHwM0HB1vPmBAMGevGU5c2qRyP2+OppLOUlo660ZP
         OIWA==
X-Gm-Message-State: AN3rC/5z7/4Vwq0dnPZpXSXOiAY2bxCHA0733Qzoxznvkmk12Abn2st1
        GKo5CIFhN9mwVQ==
X-Received: by 10.99.152.67 with SMTP id l3mr16855221pgo.97.1494223624246;
        Sun, 07 May 2017 23:07:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id r14sm755831pfe.9.2017.05.07.23.07.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 23:07:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
References: <20170507233512.GA9332@HP>
        <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
        <20170508111836.GB3014@HP>
        <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
        <xmqqlgq89dzl.fsf@gitster.mtv.corp.google.com>
        <20170508122705.GB3540@HP>
Date:   Mon, 08 May 2017 15:07:02 +0900
In-Reply-To: <20170508122705.GB3540@HP> (Yubin Ruan's message of "Mon, 8 May
        2017 20:27:08 +0800")
Message-ID: <xmqq60hb9915.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> That would be helpful. But, frankly, if a user would be aware of that `advice.*'
> variable, he would have enough knowledge of Git to be aware of that situation.
> So, I think that 'M lala.txt' in transitions from branch to branch would be
> sufficient.

Ah, you got the advice.* thing wrong.  The "advice" messages are by
default noisy, and experts can turn them down by setting advice.* to
"false", saying "I know Git well enough that I do not need handholding
in this area."

So a newbie does not have to know about "advice.*".  When s/he gets
experienced enough to get annoyed by noisy messages, s/he can tune
it out.
