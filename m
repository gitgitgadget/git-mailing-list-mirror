Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EC21F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeGWXmx (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 19:42:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53931 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbeGWXmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 19:42:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so614121wmh.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zNbxA1n8KScZZVn6cGorEuJEnJIWl4cKftnglpp3LwY=;
        b=RqsbKKHCcE9Q5roWCD61+nIhYWZMy7OVt319KG3bMvG94kVrB20KE54gxN4TsRiVTE
         QuT2abZu4LrZN4dbyKWAoanH2PbH0E9eVexYnlLmVNKmFmQE2zijW0quoHMJXv2PdDHn
         8VOisg08J7It2OfeWYOVowF9M03MB3NoB8HhJ+p9HVk+gaGyxmw36vchV+YW5EWHx3XA
         l0IpYzEMqC6dToVvcXf43MYzOV7eJPrGYY+Aqn8ANpfLnDHOTpakzptaHAd7ZX/Rqf4h
         jIkkUZh1v36y2lWYf7YznKgGfHMEeHqDXx1WTwd8ZADwrlMvps7KBtOSFqBYJMfIReen
         X6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zNbxA1n8KScZZVn6cGorEuJEnJIWl4cKftnglpp3LwY=;
        b=D/NjX92PXDDYAAt8YxU48kAkzKrTzGS7cxW2IL8lRLu0LDhYs/T9O1+dd46LZC39/W
         5l5iAZBe8EF3B8dnr/4hNMPYKsjQaxEIZ37sTxS91xad6djEHfyuCMBOgBZfw+OUOET6
         D9O2O28OOLp1NlEzTIcMYA1fT8Yd4qUUnWoReysqF7bMJC1G8n3KlciiYnzsDZ+kJRWb
         otHbl4njATWIWs47fkDAN2tm+QbWaeJUdlktaF5Qb1aio1ds08Ia9t3InoKSjb0UAU49
         o2WTKJJyusN0x1wrns7RB4+NW94zxv99jdiuQNzCRkpBIOXRg7oRspxklQZjEY7eHJ+A
         TyfQ==
X-Gm-Message-State: AOUpUlFf5qGuDFYSdobItgj9h9ifq2Sc2mtRTmHKF1KquIcif84Nmr+q
        SR5sscGwT9caJnrGDbehfJI=
X-Google-Smtp-Source: AAOMgpcrLP6ySr96/U63IALXupKCBnBytHufOHqlXnL/j+3/oMvTSKicPAEO9xXFBiayCS6aLOUXQQ==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr425646wmc.48.1532385567777;
        Mon, 23 Jul 2018 15:39:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h14-v6sm7395171wro.15.2018.07.23.15.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:39:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 16/21] range-diff --dual-color: fix bogus white-space warning
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jul 2018 15:39:26 -0700
In-Reply-To: <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 21 Jul 2018
        15:05:07 -0700 (PDT)")
Message-ID: <xmqqtvop37c1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -177,8 +178,16 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
>  	if (trailing_whitespace == -1)
>  		trailing_whitespace = len;
>  
> +	if ((ws_rule & WS_IGNORE_FIRST_SPACE) && len && line[0] == ' ') {
> +		if (stream)
> +			fwrite(line, 1, 1, stream);
> +		written++;
> +		if (!trailing_whitespace)
> +			trailing_whitespace++;
> +	}
> +
>  	/* Check indentation */
> -	for (i = 0; i < trailing_whitespace; i++) {
> +	for (i = written; i < trailing_whitespace; i++) {

It is pleasing to see that with a surprisingly clean and small
change like this we can exempt the initial space byte from
SP-before-HT check and from Indent-with-non-tab at the same time.

Very nice.

One reason why a surprisingly small special case is required is
perhaps because we are blessed with the original code being clean
[*1*], and the fact that a line[0] that is not ' ' will not trigger
any indentation related whitespace errors without this special case,
I guess.

>  		if (line[i] == ' ')
>  			continue;
>  		if (line[i] != '\t')


[Footnote]

*1* ws.c used to be almost all my code long time ago, but most of
    the shape of the current whitespace_error checking code comes from
    c1795bb08aa which is not mine, and I can say good things about it
    without feeling embarrassingly boasty ;-)
