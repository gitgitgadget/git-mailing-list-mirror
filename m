Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105BC1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbeFACXx (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:23:53 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42195 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFACXw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:23:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id w10-v6so34796612wrk.9
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pVROc1vmJ7Nxr//zyncUqpSas//WLB5/89E1c3ty734=;
        b=H+DJ7kBwU6/3aLZx2GULv2riAHCs1kAZwybj1UsrLL5GWqGGjkGdRrScBs4vtDME8q
         nvBdz9ZVrwEAMZIDn6XFGHkqxehqXhTlkxG7fyuLR5gp6BTVbdN3QZQcpla66NYPFTX0
         VZozgNtfTvs+MF2k0cjRHgFIk5LudNskcmunbtoLff2p/B0miaeFgkhP6+fUdUJH8prk
         LyqpIWhSsj1ErO/LCnTD+mr86K9wmvB8uTtigx0+DOiRyl2bDUYKH71llNhSzdkyxGAP
         nbwx8Ki6NyEaAqXxxtpuB0qqD6YFdUeDGAHN9brXYMqAvaQpUnQ57yST1aSa8vlo3aPi
         bBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pVROc1vmJ7Nxr//zyncUqpSas//WLB5/89E1c3ty734=;
        b=P13ti+5IYD6E0bh0BUtPwY4tOhB/EKRbPWZDpOjpJETI7p6At/MYpRJJv/WxqFuoHc
         Hk52Z2ATFYOl4VRf5RvzM/1ZPihzcFXb38cn+A8xOPIP9VeXvHjUVrEzqFRC+zOo6Qoc
         S+0uYp3H5YaacZri5W5/fB6wGmUlVYeUGiLY5NAbKA795c0RBuYO2JnsOpy4OiKL9+6I
         P9Z5/SE14NVYSWYCj+3XV4f/mbMaDyUi56HG6jIkw+6LR6OuSTdtDWBTw7yi3uy5A9+U
         /iRFfLRzWxBF1Po+n0n9fkQ7VGNuQiImOiYz+u6dvvKg0ai3bNZU+045g1qWirU5YB3K
         lvLA==
X-Gm-Message-State: ALKqPwd57k2HT4cfKodZlt+PCqApXsfuD/dNCKE+dL3v1X4xkMQQ3eP/
        LdRfNFhWlyzgxjbAEEcfCaM=
X-Google-Smtp-Source: ADUXVKI8fp8KkoI60q+fVCfA7JLTWWixF7402r2KuudV3CEetHw+rlJCFQQSkWOF9FfsiIRRMQE1kw==
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr6876966wri.199.1527819830742;
        Thu, 31 May 2018 19:23:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k4-v6sm1871258wrr.68.2018.05.31.19.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:23:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
        <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
        <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
        <f27d8344-4acb-3e87-3bd9-b23b21c4b82a@kdbg.org>
        <alpine.LFD.2.21.1805311907280.19720@localhost.localdomain>
        <CAGZ79kZ9x2OWU+qfZRckZFAdy1KFqttAZqkJwbzsvQfqUokg3A@mail.gmail.com>
Date:   Fri, 01 Jun 2018 11:23:49 +0900
In-Reply-To: <CAGZ79kZ9x2OWU+qfZRckZFAdy1KFqttAZqkJwbzsvQfqUokg3A@mail.gmail.com>
        (Stefan Beller's message of "Thu, 31 May 2018 16:25:04 -0700")
Message-ID: <xmqqh8mn9rd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> plumbing command, so the likelihood of git-log calls in scripts out
> there is high.
>
> So maybe the community should strive to be more aggressive about
> changing the porcelain interface for the better.

To me, these two paragraphs are being incoherent.

If plumbing these days lag behind "log" Porcelain and tempt script
writers more towards "log", we should aggressively reject attempts
to change the "log" Porcelain behaviour to keep it stable, until a
suitable plumbing that scripters can rely on catches up.

Or course, aggressively improving plumbing would be a good solution
to that problem as well ;-)
