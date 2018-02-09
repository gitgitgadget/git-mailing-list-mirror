Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFF11F404
	for <e@80x24.org>; Fri,  9 Feb 2018 02:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBICcd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 21:32:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53720 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBICcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 21:32:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so12888367wme.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 18:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RmcYhXMhtuph+2XQGWAXD2KXhq7vWdNpyjPw0rUxsJc=;
        b=O3HfOwvGu1JW+T74gOfN3BrG+49YHfF2mV7NLdJEbKitl4iTGe+L9MJ0sZgpO6Py88
         1lpmz+QjS8f/sUdmGcebuGsLnTlHlZi3sAXWabYRPW2ETeWBwjcSDWkS98jDosLa01+y
         pUpHf4gQuPEEFA9EiuBf8mb6ygmQa+TdwK7ocsifKh5pBF3FcF3sDChAGkbcbuwuRP4Q
         G2OfjlRCAw+Bez2oJVNjEAiWggBTLslOF44+nZw/XUWFuiB3xKORp2QowC+wUFxJI8Sq
         /DddwwCy2FbuihDtvot80dVPBfKc08LFZYOhT2hdpi4vFQHgcwRY8D6ODb2deGmKK13v
         ghCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RmcYhXMhtuph+2XQGWAXD2KXhq7vWdNpyjPw0rUxsJc=;
        b=cKd1xLUfDqGMapp0/+Ianb8CKV5SZfdIr3FU/aw35BJ8LiUTh3sy8VdKDC6/azGmxn
         HwlEGVEvE10SacnqZiaL+dzyZuIkjCOR2AqnC2Mf9uEpGOKNddHnl5blb5lNswFj5OOC
         tC8byssJksG3Crv9H+cvzg7T1SIvC3y+jKi3bmyLIBA/yD7/6nA3bDwwWAiXeKguHlT9
         j2jBVrSJN2wdDRxbIIujDrHzMt7KlsBWUJui5dK4oyTtz5XUXWRN4ai8uyhu3LBRECXR
         JQBKweNtZ4l643egUC2iE8Rp45lsAHsYfQaoNsGrSiuB7YDQx6NKHeVFS/mNylKJ4s6a
         XWvQ==
X-Gm-Message-State: APf1xPC8XdFAYp+cHDyxLrjXudCbMW3rf713kdMwbpa+9cNdq8P2Fa6c
        6IPjhBeS6SbH/MpPrLB+qoI=
X-Google-Smtp-Source: AH8x2269x2tguSrs0ILyHG0Obt7Z91VTk/3CVkmIPZ0HZvF1bF5VDg7tF2o3PIa898hDCAfZg9Shaw==
X-Received: by 10.28.239.3 with SMTP id n3mr769007wmh.88.1518143551055;
        Thu, 08 Feb 2018 18:32:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l9sm2660680wrl.1.2018.02.08.18.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 18:32:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Viktorin <viktorin@rehivetech.com>
Cc:     git@vger.kernel.org, Gregory Herrero <gregory.herrero@oracle.com>
Subject: Re: bad behaviour while using git rebase -i -p
References: <20180209013902.6702a0dd@jvn>
Date:   Thu, 08 Feb 2018 18:32:28 -0800
In-Reply-To: <20180209013902.6702a0dd@jvn> (Jan Viktorin's message of "Fri, 9
        Feb 2018 01:39:02 +0100")
Message-ID: <xmqqtvuq6gg3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Viktorin <viktorin@rehivetech.com> writes:

> since Git 2.16.1, I've noticed a bad behaviour of git rebase -i -p. It
> screws up merge commits created with --log (or config merge.log = true)
> in my history.  A good merge commit with message like:
>
>     Merge branch 'test'
>     
>     * test:
>       c
>       b
>
> is changed after rebase (without touching that commit in any way) into:
>
>     Merge branch 'test' a git-rebase-p-test.sh test: c b

I think we saw this problem independently discovered and a fix for
it posted today to the list.

    https://public-inbox.org/git/20180208204241.19324-1-gregory.herrero@oracle.com/

Thanks.

