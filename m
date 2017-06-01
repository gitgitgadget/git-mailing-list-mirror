Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2B220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdFAXOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:14:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35666 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFAXOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:14:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so9505506pfd.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QuKkuhABo8j+fjD+ZAIJv6Tirfz2p59I78K9v6lkHjU=;
        b=dL/Osncr7XjotWVQZoXNwc+p2mz+A9Kfa9Mh6q60d4AyXwdm3iO+n5F4tJAYL9Ndk4
         0Qb6iyNAEKwvrAzTuQHgYLYD4v90AiBwPyl44glaEuMd9PSJSh5bsf5jBy0nrxJrO0y4
         LmYmy6S4ppl66hnzl57/VDg89depjT4jheuKu8aeJf6KD6DQuwqIhEaMCf03WpVOoK00
         TNa/HufEsgVLksSt4m+xUcQ1JDffbaM/FG8v0If6Yo4e4DCMvqrFDHrqfgZFnuRdFb//
         lOmLtCdFT76xATMemKzhorsiyFy/1uEk5/SeshfhAulevj6Ew6oRvELES0WEpcWKKWhK
         Rsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QuKkuhABo8j+fjD+ZAIJv6Tirfz2p59I78K9v6lkHjU=;
        b=qcO7wCSzUYpnODAM+xLPp7hO5YY17DS+hkfzg3rJYgD/ZpjTCx1rc5xtp0IZIjv7fZ
         XpATT2wOU2RFeGtdtzdBX+Z/MynW6TcSnWsW/4s/GHt23KbXTqBl6BhNhti4NherMV9x
         mxSXdoQfqFRkZhinC7vTBbpcD39Ab8YhJEiYomCJUJN0CQ4cKXRwb6iyypDwUKvr0X1M
         Iw3HjHxFYXRVZ+jFvKZ4FDGYOqKyenbEZRdcXsQ3l9jtUCqH0A5tsoCO97atSYrj3BQ5
         9gh3gREumWyF6NyfhqNVGUzJa/qRvII6QD/Xtr7YSYD69cqsj6r4NENhyoqdQ5HAMZBl
         6WpQ==
X-Gm-Message-State: AODbwcBSDh5gKTeOhhknU9CJ1E8UPUqcC5PlfTmAQrXOabteOuJGSqtw
        XBuSkm/rxgLCiQ==
X-Received: by 10.98.82.77 with SMTP id g74mr3452103pfb.115.1496358886302;
        Thu, 01 Jun 2017 16:14:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id 204sm31635626pfu.19.2017.06.01.16.14.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:14:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2017, #01; Thu, 1)
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
        <ebe29db6-45ed-81d7-2a3e-24437406eb08@kdbg.org>
Date:   Fri, 02 Jun 2017 08:14:45 +0900
In-Reply-To: <ebe29db6-45ed-81d7-2a3e-24437406eb08@kdbg.org> (Johannes Sixt's
        message of "Thu, 1 Jun 2017 23:06:27 +0200")
Message-ID: <xmqqk24v47x6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>   Waiting for an Ack to the SQUASH fix or a reroll of the tip commits.
>
> ACK!
>
> See also
> https://public-inbox.org/git/2899d715-a416-1852-4399-28af0a3e9b6e@kdbg.org/
>
> -- Hannes

Thanks.
