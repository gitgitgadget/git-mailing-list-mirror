Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA9C20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCFXzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:55:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38890 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:55:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so15371376wrm.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cvlMNZE5g0Zb+qXhbJAA1vd2glqoy5cwySgUm3suV+A=;
        b=q0v6rfZ26ktfshmt2hg8wrf95e7IfgxgW9P6Pe/xmYSjGw+LKxVlKx35JU3ozElxD3
         BbrraSFVPU7vwxq2Hn+DpOBPLCLaIh9ulqfXi9ZVIv0f0gYKoQYPFDkq7+bLwvYcqYzi
         iTVc5W+cnI4eenV7GNVnjVtMT+ym+OSLk+JGw48fRaq2aTZgP+ENERhiK1t1QLi2tOv5
         AusZ94F8+hPAl91ZJrjiZVi7K9uJRdOQCaNUx28e4I9T6XEyIwHGJhhPX0JP38Ao0A96
         G+ibFetb7pDRe1ZnAWfAlCnvXYczp8U9OA26E8VKxvQtPXPUW2DTFjLzXVhboSUmsg0+
         YM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cvlMNZE5g0Zb+qXhbJAA1vd2glqoy5cwySgUm3suV+A=;
        b=dGSMUSuKmAfs+3n1+ubTnWa28dXKnZjIA0Tzjt/sIht7JqX698/KzSZi7us6dCcLDj
         2veJYMK3QTPO1T97GFN7/7dyxqg91BHwTn6kY6hiK5PzVA/PcYi8LlxrUjEuvlZ6dfx4
         LH1ihoTEpHzkAxeqX+1ulLr2jaDY6PMAqcScVv552oW8WiK1v2bKc9X0uww1Dkdxa7qu
         98JCYNrkipFo9V3ZP6F0OZDcs9Y8f/oSAhskyzhs5c900neG2XggwQL4zbb3ylDYZ53X
         P0zHZQwp8qQOve/HZg6VMVXUV6wztZMWkofyKnhj9RCQFbCoB5mYduATYnMWZa3HoSiD
         WxYQ==
X-Gm-Message-State: APjAAAU7r5vUpL1DiPbIXqYP8/7lreanEvudqBFkL43HVjT9ecabDGUX
        tG683gNkL22QDrbWQgAgsH8=
X-Google-Smtp-Source: APXvYqyxC5lE5Iwm+4/ALuTD9ZavX1kZT2zDan99UPYZJ13amiCJF0fXEv+qKNQZ+d/Qi1pVQlCsDQ==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr4953086wrv.274.1551916506552;
        Wed, 06 Mar 2019 15:55:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o18sm6650032wrg.40.2019.03.06.15.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:55:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903061339260.41@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Mar 2019 08:55:05 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903061339260.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Mar 2019 13:47:36 +0100 (STD)")
Message-ID: <xmqq8sxrpnhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 6 Mar 2019, Junio C Hamano wrote:
>
>> * nb/branch-show-other-worktrees-head (2019-02-01) 3 commits
>>  - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
>>  - branch: mark and color a branch differently if it is checked out in a linked worktree
>>  - ref-filter: add worktreepath atom
>> 
>>  "git branch --list" learned to show branches that are checked out
>>  in other worktrees connected to the same repository prefixed with
>>  '+', similar to the way the currently checked out branch is shown
>>  with '*' in front.
>> 
>>  The top one probably deserves retitling.
>>  The second one is of dubious value.
>
> As somebody who likes color [*1*], and who has *dozens* of worktrees, I
> would really like this to hit an offical version, including the second
> patch.

It's "meh" to me, in the sense that I do not have strong feeling
against (or for) the extra coloring.  In either case, these are
not ready as-is anyway, so...
