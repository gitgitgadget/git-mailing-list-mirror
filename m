Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D911F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH1T0Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 15:26:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1T0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 15:26:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1996758wrr.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f6AH+oASH15aDD+zIc5mmOIaB8kEOzDj4sjZgKBWV6c=;
        b=m1Y2/EgHLwKIz+QeLgtzn6X7kIlpgFFkFtsIXCzBVcNytW795fMVHEthBDO8C0kgLq
         58INoP1IEr5Q571uGhiThicE+vdfI/HrhqvDoZWDLiVtr/ohwUJlIhFmnpeXxmYutkZr
         ChrbQXzlUDwuHIh6mNa/P/0h1AFdlDriEVAv+TpI56OIb2mWrODWQuoOYH1KJHKbuxFh
         uJ7nuUAF3Tay8y3zGY5AaaotAWtE6tb9luX5TrR/6ScI47n0iYBTe3t7FGVT0j9T9EEM
         k3rUx15MWiCLZ2l1f0y34DDuafZF53HyWoxd94Kwp5YUizNwHGUp8jdXqiJtEgZxRIMN
         LkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f6AH+oASH15aDD+zIc5mmOIaB8kEOzDj4sjZgKBWV6c=;
        b=FWlIc9+rTTdz4bj44jGIZvs5dy86y0WtuAucTyTHxJ8jp67lSbMxkdPKpWS2KCEfLo
         QwCQBuHw4vq86LzLkJnKk8oa1WSU8ZdIoy5Bsk53g3AlCeSqkL6ozdQigKCMwSZBeGEz
         Uswjc+cx6ijbF2IvM6REYxQ/XMcJJUoVnAZZzaurm+Rj/p0zqqk4Nd/DgDY2fiOFvv6C
         M76j3pwjtMaRpKiaM2TiR1HhTKe0x9jLrLlWeQIbjJ4DWpYXdFxLdVDvThmcIY9Q1dyc
         DMV0BiFt2WvOkdOfblQwDTaUEmrULXL8Nq8AUW9iarpVBjfa8liruWO6cqUCF4gv7AOw
         XpkQ==
X-Gm-Message-State: APzg51BodiuCegzRuk4YK0vp0a0dKeyv0uWZi2OyXvNygcOlwm1y5EGb
        w+eshwjlwYCJL6m8T6vV0LSAgsGz
X-Google-Smtp-Source: ANB0VdbxVZ1sGvmwrtcnazwGo9CKqfNavZNyDgQgPnEnWYTEGnuVxoCscBdmFbBcRarYzmq/hqGRXw==
X-Received: by 2002:adf:d20a:: with SMTP id g10-v6mr1675289wri.66.1535470450979;
        Tue, 28 Aug 2018 08:34:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q5-v6sm870313wru.79.2018.08.28.08.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 08:34:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive rebase
References: <pull.23.git.gitgitgadget@gmail.com>
        <20180823024856.GH92374@aiede.svl.corp.google.com>
        <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet>
        <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
Date:   Tue, 28 Aug 2018 08:34:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 28 Aug 2018 14:53:13 +0200 (DST)")
Message-ID: <xmqq8t4qijym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do recall discouraging you from including irrelevant rant/whine in
>> the log message a few times in the recent past, and also I do recall
>> you never listening to me.  Don't make me an excuse.
>
> Junio, I would really appreciate less emotional, and more professional
> conduct from you.

Which part is unprofessional?  

Being caught and corrected with truth immediately after badmouthing
another by lying may hurt, but that is your problem, not mine.
