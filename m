Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9451F406
	for <e@80x24.org>; Sat,  6 Jan 2018 17:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750966AbeAFRca (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 12:32:30 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:38773 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeAFRca (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 12:32:30 -0500
Received: by mail-io0-f178.google.com with SMTP id 87so8919005ior.5
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hiENCW1LWigdsn5ffW+3pzxR1MHNYVDRmS6A55Gu0Xg=;
        b=HbiDcu56F0wN5imZwlb/KsubvC61LnOZqfN355V/eRMNMsQB4NvEf0NHMkUcWZ4fvT
         T8pNwIsZPdxdV6jh/eTj6VQR7na6na7smNzk0YBZpZ5AJFLUkMxIAaqXdJpNrD28WBj2
         NcyQ3p74kNQVnjadZ1OPG/ZqpZplOqOtybd+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hiENCW1LWigdsn5ffW+3pzxR1MHNYVDRmS6A55Gu0Xg=;
        b=BT7jH+0x1ZoxTBAAAsLM/MUh7Q6nV7bFJQgRIEkJFTuGZr3ajc95leoopb65VNgVcJ
         +EopwgEQl3TSH2lg/d7M37qh7/Zf8XWni40UJtMcmYbLo2J0Q/uGUnLOM1ogwzCBqQk0
         0XxFuqVtHpKVfZkDnhMybUmNxyy5UgA41Ec44jLbSBUifiLkToqt4AF8RN4+wXT3MGj9
         AvfMKsy3xZHgkVg9HSYw+8WpmiO9xuB/UgiasfVwt8bPi8yVt+8dGYmUqhGkEFmZnYV0
         dY1SgyK+nfUzwFAIxy9sdxeYdpyvsrE8/CxbB8jRklfNtMTBnAHLEjpjdTIc1nWqWTfl
         JDog==
X-Gm-Message-State: AKwxytcsoQbREWHd8bN5nvc2D+HduBO+W6AI7eM410aTkDjko7URdLSr
        hZX3MtL2or5b+VJLnus5byZ6Cg==
X-Google-Smtp-Source: ACJfBosfqYShDGFABIPzQ4FCeAryO0EyuGAZXjRcbwjDdqum+bLdXB/tGZgv5Sl0WfXSOcvXobEm5Q==
X-Received: by 10.107.35.75 with SMTP id j72mr6403949ioj.26.1515259949203;
        Sat, 06 Jan 2018 09:32:29 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:ecbd:512d:cd90:54dd])
        by smtp.gmail.com with ESMTPSA id y64sm4255810ioy.25.2018.01.06.09.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 09:32:28 -0800 (PST)
Date:   Sat, 6 Jan 2018 10:32:26 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Fick <mfick@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180106173225.GB17272@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <3447055.jsE6nH3DQt@mfick-lnx>
 <xmqq4lo0cbbv.fsf@gitster.mtv.corp.google.com>
 <20180106172919.GA17272@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180106172919.GA17272@Carl-MBP.ecbaldwin.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 06, 2018 at 10:29:19AM -0700, Carl Baldwin wrote:
> To me, this is roughly equivalent to saying that parent pointers
> embedded in a commit object is a good idea because we want a richer
> relationship than mere "parent". Look how much we've done with this
> simple relationship. Similarly, the new relationship that I'm
> proposing handles much more than the simple m==n==1 case. Read below
> for more detail.

Of course, I meant to say "is not a good idea" in the above paragraph.
Please pardon my error.
