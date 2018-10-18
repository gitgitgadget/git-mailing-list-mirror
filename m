Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42BD1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJRKDo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 06:03:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJRKDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 06:03:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so3770606wmf.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pPmCthxwi/6pqViq677eBeyPqf/a2ZIrl1WC+5wOwJM=;
        b=uVTEl3F9ruz4dWpGR18CyGu0bx/A9UCJgqTJMc+G1BtSs3HB8isKLnkLig75IpS1oj
         NkBfOK1HQvUlmWHeo7yFxTWnfkdPjLQz2r+kJRzAotAmaq9VHwRG2PDUzf0n3bkX2+vW
         vNGQc4JYWPdspIAHnk3AjlUUFTMmcK0ymrs0dO8M1nis0xT2MtDXE5gVNj6PTYGmMtxj
         YyhCHtAAOwm3Cjk72KxZfW6BW/rlmeL9E6foEYnPNjHRkbG3xVpq6vTgCZkgvpMiKUXd
         fuoQLeEPPoyA6v27lFgI6ryXqCxXKYK+pWlwmP8nPTEqPyRUAobE3hNVj2+mCTsESsSK
         +1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pPmCthxwi/6pqViq677eBeyPqf/a2ZIrl1WC+5wOwJM=;
        b=Vhlkwhgs6O0XS4EbjPNDKdZ8va3YqhQaM7PuQIsDJSOcDv7HtPKiiZdxOsOtpLfOZL
         OKsBF3ZjDKvevNwaheDhv4dSAm6k3V8je0SK2fnQ/NiVDLU7JRFXEWTp4eZUZT1CeK7l
         MmojXVd+ASJceYtdWONAEI3/gndrCuSuNX/IR0ieb5CXa60HuNv4ULCr6dtqX4Pp+f7y
         a0c+m3akdZdnF7uFL+YjGzfibkakwIQMS2S4D4+xvhpxfLniNGYHb/1bQO2uQBTc9ISN
         9C7N9B5Co1YAR98iP6f+6ZmZqTw5ayuAerRX9dYfNYRHKj76fVdAn+1puwitKJHKMQiB
         ouKQ==
X-Gm-Message-State: ABuFfogFYvQXkuZ6eIp3FBTdqwu0eN1sA4PmZsGRDi2dlJf/o1jIS6Uu
        dEIavb1Uev3mexgcAwn7/YE=
X-Google-Smtp-Source: ACcGV61giFicPbkrWWriG9UCuM0xx7L6XIk5WBQJQneZGbTnzh/iC/qSIZNBm5kWzPOtWBV+sjnbGA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr5397075wmd.100.1539828309090;
        Wed, 17 Oct 2018 19:05:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p7-v6sm2679089wrt.10.2018.10.17.19.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:05:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Hesse <list@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: make install targets depend on build targets
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
        <20181016075624.30176-1-list@eworm.de>
        <20181017024503.GA117170@aiede.svl.corp.google.com>
Date:   Thu, 18 Oct 2018 11:05:07 +0900
In-Reply-To: <20181017024503.GA117170@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 16 Oct 2018 19:45:03 -0700")
Message-ID: <xmqqk1mgvwks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> -install-html: $(GIT_SUBTREE_HTML)
>> +install-html: html
>
> This broke the build for me:
>
>  make[2]: Entering directory '/build/git-2.19.1+next.20181016/contrib/subtree'
>  install -m 644 html /build/git-2.19.1+next.20181016/debian/tmp/usr/share/doc/git/html
>  install: cannot stat 'html': No such file or directory
>  make[2]: *** [Makefile:78: install-html] Error 1
>
> The rule says
>
>  install-html: html
> 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
> 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
>
> and $^ substitutes to "html" after this change.  How was this patch
> tested?

Gah, that was silly of me.
