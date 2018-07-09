Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6661F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGIQqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:46:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeGIQqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:46:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so2774763wrp.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dwKsQNohHWHBgwkEE62aDdXBsZ0YqYOBME/ItaF3wAo=;
        b=C9teCREDXCHkeTlJ8qC8Mp8HOREqPYlOx77Nr3Y71W2Uj9wAARjQQNpcd4YmmMU9Nl
         qSc79GfA+0yiPrUUfpcl5JKK51XuseEgzVW293CSuMsKtnr6V6TRfBA/8D8ZJUTA92ta
         PHinnV36gvefJo1fuAHUE527p4uM5gBxK7/uox1Q4NoDYxWP4qSQf/whvJg48PJvXDKD
         fx8wptiqzKBl3HsUFApvSTWHo45hhcZ9P/VK8EyQZ1shuqIqMBpX91N8vmfXIeIZLUP4
         tp69qgW+8f2YleDsnuyhCArCrEhUq1R3SfZDRVySP5Box+SSSAJ3zxwEBIWl4jqXOpbs
         LHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dwKsQNohHWHBgwkEE62aDdXBsZ0YqYOBME/ItaF3wAo=;
        b=EbM63Jgr0J+9ae5QZvN7H1LA/3gvhDPMDcbIIzOO16zQwSZxplue3MSEQ/NLLY8e1g
         1rRR1HXksoU80ichJPf9htIjZ+4lz2xPGKH0EKP4s7Fj79fORgnwaO3Qg1PtXI3X1HPk
         ECOgLTkX1z38MD+lklLjhYacL4ZViNVVWJ4QhJLkYAaXnTtm1T1sUVvUf8esawFQahGo
         b0Tg0+2W4djiUZw3xuCWQ5n9c6ZcdSE2038s4iZLARAu65tPyd7a3id22C6mWD5HQSfe
         zHLWhH9L5yerHdgYhzavwBXIa5qvNADf9LBTq14EguE+ypsiFmpMnJyE6EiOe1zu1DGT
         r2hA==
X-Gm-Message-State: APt69E2x9ypayu4DpPI3gvOhLjNH0Je3ikTV6++C5hIgxCIbsEmD9/Hu
        0RMDeioiXFH0t59DDJayf2g=
X-Google-Smtp-Source: AAOMgpeC6nXyJkWDSLmCwH8GwNIX/pTJJ3pAMmkjCXF8JMGRBIxyPXr3ASMOsrJga0Yh8AFYqU0V6w==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr17165467wrb.155.1531154772532;
        Mon, 09 Jul 2018 09:46:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b33-v6sm14471176wrg.45.2018.07.09.09.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:46:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Harding <dharding@living180.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
References: <20180708184110.14792-1-dharding@living180.net>
        <20180708184110.14792-3-dharding@living180.net>
        <20180708210200.GA4573@genre.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Jul 2018 09:46:11 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 9 Jul 2018 09:52:13 +0200 (DST)")
Message-ID: <xmqq4lh8fjcc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Brian,
>
> On Sun, 8 Jul 2018, brian m. carlson wrote:
>
>> On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
>> > Signed-off-by: Daniel Harding <dharding@living180.net>
>> 
>> I think maybe, as you suggested, a separate test for this would be
>> beneficial.  It might be as simple as modifying 'script-from-scratch' by
>> doing "sed 's/#/>/'".
>
> It might be even simpler if you come up with a new "fake editor" to merely
> copy the todo list, then run a rebase without overridden
> commentChar, then one with overridden commentChar, then pipe the todo list
> of the first through that `sed` call:
>
>
>         write_script copy-todo-list.sh <<-\EOF &&
>         cp "$1" todo-list.copy
>         EOF
> 	test_config sequence.editor \""$PWD"/copy-todo-list.sh\" &&
> 	git rebase -r <base> &&
> 	sed "s/#/%/" <todo-list.copy >expect &&
> 	test_config core.commentChar % &&
> 	git rebase -r <base> &&
> 	test_cmp expect todo-list.copy
>
> Ciao,
> Johannes

Sounds sensible.  Nice to see multiple brains working together going
in the right direction ;-)
