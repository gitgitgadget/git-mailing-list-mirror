Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAD420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeLKGR4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:17:56 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34257 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLKGR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:17:56 -0500
Received: by mail-wm1-f42.google.com with SMTP id y185so8196805wmd.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 22:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4p7zCVNHLo520OdBdsoQIBppVUrWbsjHI9p7Qf1JBw4=;
        b=l593hNre/WJJSBajbJwB0IpHm9+00QvW3OXVbAENn6xX2yJu8YL5iTUuzx37YMkY3F
         oa36WE9R2A29Cs5P10R77c8VD1JZrQI4sri85qBPbRd9wKprFcg3vYczgtOZXHPLQsDd
         fL6xtbbuM+PXaLNkge4ZLAOmBqBiXPOBQOU5DDSNM7q1JoWgjG8BttAV1T5J/VVy3N71
         xEAq+B//oQmTWOMzyQmeYQBHaJ5Xbd5CTfA+7EkMH0DP0QxFtLW4UfM8FkAziKtUOHhR
         0fsjAdGgGt232qFUVtFwBf/YfOTQVpEJqrFzJf35d9fciWZSss656bOUZYmErj7b6Cb7
         bXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4p7zCVNHLo520OdBdsoQIBppVUrWbsjHI9p7Qf1JBw4=;
        b=mQKlIo7y5Rt+ZgdKYSjudMMUHLnaBAObxXnF3aUQ7rNB2hZEzCxqVYXEm1CB7xIstm
         Xd+GEScFWdp+GkaoXi2wNzw0X/4BNbw8WqVH1tjHKR2SbfslwvR9YjkU5My6Sl5woYYk
         rKc8acqOURBffn4dhsC4FQ03LExUNGRmr/t2TFjEQsHn2zGAd1aQQDeqdzwLueruDca1
         VCsQ7qaZ2pdiggVuQenXJ0zFqLrzZxw+ywKRcj09Z1a/7kp0+PRM7utYZ+cn0SmZyMSp
         Z7dTJTci0WeLzoh+CVtbcpe72yffUYUZiNkzlobTU5NEuitRtJfzCOLqB9OGLrxEoyRs
         Emqw==
X-Gm-Message-State: AA+aEWZM7864A/sbg1xhWZSlMIzyF9UnFhApxwbuSyXRBmxaAzWb7kgm
        JI3ico4dRtef+eOQutdSaF4=
X-Google-Smtp-Source: AFSGD/X2K8m6B1CBV62b290VBl1H49i27FH0RcmWPkhQQ2Aq+QIr2i3fzAQfWcib4IL57SiYFWRzXA==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr967460wmd.151.1544509074215;
        Mon, 10 Dec 2018 22:17:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t6sm15731568wru.11.2018.12.10.22.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:17:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZrYP05=eSx4=09Y9Nx9pNMyyKz=tGXjueuhVgJo=Z5bQ@mail.gmail.com>
Date:   Tue, 11 Dec 2018 15:17:53 +0900
In-Reply-To: <CAGZ79kZrYP05=eSx4=09Y9Nx9pNMyyKz=tGXjueuhVgJo=Z5bQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Dec 2018 18:00:30 -0800")
Message-ID: <xmqq8t0wlh7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I saw you picked up the latest iteration of the last patch at
> https://public-inbox.org/git/20181206212655.145586-1-sbeller@google.com/
> which has received no review comments, yet, and you seem to have
> just taken it for replacement without looking closely.

What's there in 'pu' does not even count as getting "picked up".
Near the tip of 'pu' outside 'next' is merely serving as a bookmark
so that I do not have to hunt around in the list archive after
people comment on the patches.

> I think it is ready, but I seem to be an optimist at times
> when it comes to my own code. :-)

Oh, who isn't?
