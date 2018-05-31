Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FBEA1F42D
	for <e@80x24.org>; Thu, 31 May 2018 23:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbeEaXPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 19:15:50 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41277 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeEaXPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 19:15:49 -0400
Received: by mail-wr0-f172.google.com with SMTP id u12-v6so34503821wrn.8
        for <git@vger.kernel.org>; Thu, 31 May 2018 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8WTnf7nqoecjV2zP000mWkwT4Q1wIGMmWtrywe/1xH0=;
        b=M82TFUvMZxKt7yGj+rbxwA9fu+Cqph7LFMPR5lQY6ENA+SiaJoGVG1XD97uONQEj/z
         ovHgJ5Ug3weEzxmPmpjmwT3J5hLs0RkHmJUVs8OvoDxnZmIzn3KJPNAj01KwkvAg8SSX
         HeVy8FbxUibvYaOL9P7BTFLdMQL1YyG7tzGzZrMrGvAK6ZLDsvvl4C3MgHu0Q5UFWwn3
         EUAvlBR7OyxKAKFJcmnoMeVxA8c43BxlZA7lGcxNyq+aTuh4g6E7z/t11vlX204XgURy
         t8zPLhoGTRw5Gt2tKVZqQ+vnUf28VlLv/x+Ey0PxNmjR0D8xeLo9BGNoZnpOFTGgJ7Kn
         QRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8WTnf7nqoecjV2zP000mWkwT4Q1wIGMmWtrywe/1xH0=;
        b=QPwNJfr8H4OQDCy/MLEG+3oLUjzGJB0wobPJOCS5iIWHsIUwu0ddv/Wmo9spoVy6QE
         z6beQE0EwojL0XKQhztPksvplGq35fa3+SGhtGpXaP6aTgukLHKhVLKQYtm9ao4L493n
         oAHEeSZC3E75p86RTyL5+onHpObRe5/xZCHjTq6DqDna8ciri+1Kda5o018nDlc17jkG
         SM9AEZS5KwS7HjZXHt8ZizvjoQeiiAvw6tcpaDgP+nhIwIxzJJXvk5H+cha+lKX2LoL5
         U6WxX7j9O/Ir8lWbuGmNvAIdQBWAi7SraiB8GAG7MBrr3BL8JOHDAGrj1pwISZdMG3D7
         iGuA==
X-Gm-Message-State: ALKqPwdZhmVq9dPanRE4Q2MGVXdT8vq2WpJ3MWp6Vl99e/MKt348ngto
        rlfV3Iq76DUeCAHjIh5rbVc=
X-Google-Smtp-Source: ADUXVKIKWEwx0Lf9VHANOwZlmuBsqx41JN0NdH+kQwIBYm0OYUtAtpIU2w9kxxj7ZEYr9gOI97Ax1w==
X-Received: by 2002:adf:a873:: with SMTP id l106-v6mr7207001wrc.53.1527808548023;
        Thu, 31 May 2018 16:15:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c11-v6sm14137533wri.49.2018.05.31.16.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 16:15:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
        <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
Date:   Fri, 01 Jun 2018 08:15:46 +0900
In-Reply-To: <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
        (Taylor Blau's message of "Wed, 30 May 2018 09:09:08 -0700")
Message-ID: <xmqqefhrct7h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I have these patches mostly updated on my copy (available at
> https://github.com/ttaylorr/git/compare/tb/grep-column) but am out of
> the office for the next week, so I will polish and send these on June
> 8th.
>
>> * tb/grep-only-matching (2018-05-14) 2 commits
>>  - builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
>>  - grep.c: extract show_line_header()
>>  (this branch uses tb/grep-column.)
>
> This topic is done, but will be frustrating to merge after the changes
> in tb/grep-column. I'll update this topic once tb/grep-column graduates
> to master, that way they will both apply cleanly.

Thanks for an update.
