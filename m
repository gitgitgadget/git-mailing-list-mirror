Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406D71F424
	for <e@80x24.org>; Thu, 26 Apr 2018 01:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDZB4I (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 21:56:08 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35857 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDZB4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 21:56:07 -0400
Received: by mail-wm0-f52.google.com with SMTP id n10so10009285wmc.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IsuV72Q8xNSaZAXhtBdWPgSGBjKk5JHpGw+5m5TxnOA=;
        b=hyqhpMT0PfHj0yTElMAha09MTuuwNk2ytKhWK8Yyg4RuiGJX9dZQpEJ+j83VyhRUXE
         vU0VTY/XnSpIZxccocAuyKb9AwdSFS/yJjBPUUd/GoRm0w/Y4Qefd+tQ25lxlozpnyjj
         4J+prKiUysZuLNwYk01I1YFJH1a/NLQXkOnUpxrN0KB/4WuJazAdx3e0lLuW52zvjamX
         yC0UvrCTXLjzm1tiq2e+RBpvc+fELZPZs6KMhsW4A+ID859g7pKjhUHrI1GZhBkspAZ0
         qhD0F+kXptj3umChWqZ3ctmpwISC4nqi/J7ii6gKGtWmyHoIie8vemv2m619HdCKhDVn
         SkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IsuV72Q8xNSaZAXhtBdWPgSGBjKk5JHpGw+5m5TxnOA=;
        b=THVaIqVEnmMKSU28npY7JhvjPoDfiSdVmg8wqTb0H5o61Cc6YkWwCfw0XgzLc5buyI
         zQulxMJGskq06KUXdl+cywCEAj/FCPhEnU4sxqjDseBYp8oHMehd02OdmFsg+SvXDqQL
         1i4cMd01uwyf96doA0m+cRw44V8yTnsoUUv3H85C96225FvXP7GPcQYFqWgX5U2bBwbY
         PdcQr6d4HE+JfzgVdsf6pc/S915njCaLiBTdFzMDAXIis6pb6DtXDNBXCpqckIXpnbBH
         wPUOPYUiM3ooNlQZDk+v7lu34HuCD755+m7o5Byf67yqIWlSN93nm6IXyNYqKkFZCJKh
         SJqQ==
X-Gm-Message-State: ALQs6tBCf1LfjdZ190ax9cQtb5/V105kfKj8NS3tVyUBjEgB27NYcuUM
        fr5K9VrtC0OgC+QWBFuZNHz4bWsoXAc=
X-Google-Smtp-Source: AB8JxZqZ1L1VYwTbFWRjj+cpedVVr4O4QKOn766sTunM7zGfgzbzcQo1UFnE0fzGNFPSsXZOMRS2QA==
X-Received: by 10.28.218.19 with SMTP id r19mr3335366wmg.2.1524707765860;
        Wed, 25 Apr 2018 18:56:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a13-v6sm18796550wrc.19.2018.04.25.18.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 18:56:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] Make running git under other debugger-like programs easy
References: <nycvar.QRO.7.76.6.1804101023100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <20180424234645.8735-1-newren@gmail.com>
        <nycvar.QRO.7.76.6.1804250923280.4978@tvgsbejvaqbjf.bet>
Date:   Thu, 26 Apr 2018 10:56:04 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1804250923280.4978@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 25 Apr 2018 09:25:58 +0200
        (DST)")
Message-ID: <xmqq604e4tor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ...
>> 
>> There is also a handy shortcut of GIT_DEBUGGER=1 meaning the same as
>> GIT_DEBUGGER="gdb --args"
>> 
>> Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Looks good to me!
> Dscho

Thanks, both.
