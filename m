Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FC91F453
	for <e@80x24.org>; Thu, 20 Sep 2018 14:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeITT4b (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 15:56:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38243 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeITT4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 15:56:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so11201851wmi.3
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HDW4fF6/B2AbP2iYXIMqTK3iTu42KZ3gw2gWLKZmidw=;
        b=inx4Hk9mn5nEIOVOcm+Vr1AVe390glQ02FSLd7CWSmOjxC95+uNbo6w4kb2QOD030A
         9lRDQMvuhgcPsvUc/68EzCJmlbDnEcyuxKU87Yy4B35WCTI9KKMHjze11Ei6c/CWklIA
         8yhQQbgagHImR3qUfTcVNJK15+bvhkHhsOFShwXCq+gZ0raoPCToGEGK5Yr3mT14Ozw5
         KzCrkTlyOiDv/L8nqavv9M3PmOOjdZpe7OoYX1Figerr8fbrICjSMhvHDbDSeUFIBzkr
         8X/XNgFqSAAa5SY3N0uR+fwojm5d0jqXU9uZdwqewWOyMjCH46R+6LbN7yKlZ8kUgk+D
         KiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HDW4fF6/B2AbP2iYXIMqTK3iTu42KZ3gw2gWLKZmidw=;
        b=MbeUGLKODI2g8VD3uBc68Wpz1RcnLYt4S3xu8ACVcDBxjryGeZWeKxpJ287n52b8gC
         xrBIKV43pMPu/BeQfI/KDzAq9uSuiMv2M8jpVfULta1tHdzmcZZEOsjqZTfYmgl9zmMe
         tn0y1xxgV1s0Dc8o5973ceezJqLesbPw8AwEh+AMPaOLuOqAsHhcHeSX1hbupjE0McNQ
         FyNeaLw3k24Eup7eoF2Qj11TVfp5jQ+3x8EQVkLKoYZTwZ26WKtlTaz/Pk5fOrJ8DW4f
         ooV7w3bwn2UZSIclZk2YTIROHPH8lkdo98x2kc4PeSLQJ0YGLwp2oaLZjcuG9JrFnZLx
         8vEw==
X-Gm-Message-State: APzg51DtlQtHZ0QqEuZ9WG/V7QJhrEcAca2VF8m4nfgpcVKZuhwadsDI
        +ThanngtPNBEY+LVHDMA0cc=
X-Google-Smtp-Source: ANB0VdYfsASKJ7IcTxP+e8zCLcLWfOFkBLuFsWN+yNhUnqbsh3BIy8j5lh8XD22DGh+pH0f2AoQ8xQ==
X-Received: by 2002:a1c:1bca:: with SMTP id b193-v6mr3049637wmb.6.1537452768456;
        Thu, 20 Sep 2018 07:12:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k63-v6sm4285672wmd.46.2018.09.20.07.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 07:12:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Subject: Re: [PATCH 0/1] git-rebase--interactive.sh: fix trailing spaces on empty $todo
References: <20180918134412.32766-1-m.shulhan@gmail.com>
Date:   Thu, 20 Sep 2018 07:12:47 -0700
In-Reply-To: <20180918134412.32766-1-m.shulhan@gmail.com> (Shulhan's message
        of "Tue, 18 Sep 2018 20:44:10 +0700")
Message-ID: <xmqqfty42r6o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shulhan <m.shulhan@gmail.com> writes:

> For someone who use editor that display trailing white spaces, issuing
> interactive rebase will print two empty lines at the end of rebase with the
> last line contains tab,
>
>   #	However, if you remove everything, the rebase will be aborted.
>   #
>   #\t
>   # Note that empty commits are commented out
>
> The character "\t" in above example is white space tab.
>
> The "make test" was run succesfully but I can't reproduce/test manually with
> non-empty $todo (I have no idea how to do it).

While the issue may still be there, I think that the mid-term plan
for the release after this cycle is to use the GSoC version of
"rebase -i" that rewrites all the logic that produces the above in
C, which has been cooking in 'pu', and hopefully we can see it or
its reroll in 'next' soonish.

So please see if the issue is there, or if you find other new issues
(as this is essentially an attempted faithful re-implementation), in
the version on 'pu', and report/fix them in there if necessary.

Thanks.

> Shulhan (1):
>   git-rebase--interactive.sh: fix trailing spaces on empty $todo
>
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
