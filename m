Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F7F20248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDAKpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:45:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39728 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDAKpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:45:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so10781217wmk.4
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=YRviBuwZx5K4yd4vgZ56iXiW0e4+EH+Kmx/KI/6Fy5o=;
        b=mhizNHr5Pzf7PVyPOgkTjhD68CrDkomPBjg5vkw/7EbZkrgFU0ujq6AtFVPEIQdKu6
         AmpgSrJwEiID3S0Un0dgYallH+9qwbSsXxz5u+Gza1kzgzoGwBad8Q3wpbWW0EvcTbSl
         HGERQlrK2O+nNZSmCvapDMCFqtPnniaxtA+sKjpIMXBrdUCRe4IE0ez/EQUV2JZt2yrW
         raOMvRaTkkJoRgnsymmIWaLOiLYpHkDbNIxLhYbPVMcOpkrEF44BzMcSQJk4OLfXS/6t
         OFw4W3T6iVdyrZigcaDguDgJKtH+cKtxnRePTzr4PDJcKONNWuPRqVbh5tzvz4RuJt/c
         ts+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=YRviBuwZx5K4yd4vgZ56iXiW0e4+EH+Kmx/KI/6Fy5o=;
        b=Jj4uvveZ+4Jozdo9FtAr8XbiMz0B+NUoGDsJiREO0w+KxVJBWkzxz6cmyo1d+kjb0i
         Twk1yq8NspLfHbgkCA2WjyAnBXXxFmLffb5LsV87iutufcvWeXJ6JB6ZxqaeA99GCYAW
         aAqNR5FpTlM7+NnPjiM2agNEYbMGN+B7Q2spa9aydfM7tBkFd6mSTnnFsKb/Lp9XZeo0
         6bG+sW1EwiiiuwM2gpyaNzX79P/DeEQFxz20ofTvnoHeu6KTrTIIIFbayfi/4B2zGVnp
         DNEasQjKWpUZyM4caXXvSwE94XwPwgOiu3rYb9W2Gp/Uq9FIut2fPzAFTdiTyGnF1sKx
         +Qow==
X-Gm-Message-State: APjAAAVvBS7xOj76bFSL44wVxuLOnwjtj4qEipSBKezV/9kLUPtoeM2/
        OUf4n1kniSVmCYNwx+foSCg=
X-Google-Smtp-Source: APXvYqyNwRuoCyOgi9wcYbHRjPzQkk4G+l313JH4KXle5q6V8zci1e+o17ccCix/cGCOfokRFl5kNQ==
X-Received: by 2002:a1c:16:: with SMTP id 22mr11261894wma.91.1554115503148;
        Mon, 01 Apr 2019 03:45:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d7sm10143483wmf.31.2019.04.01.03.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:45:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
References: <20190323041332.9743-1-alexhenrie24@gmail.com>
        <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
        <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
        <20190325011717.GA5357@rigel>
Date:   Mon, 01 Apr 2019 19:45:01 +0900
Message-ID: <xmqqpnq6vwb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascensão <rafa.almas@gmail.com> writes:

> I agree that `pretty=medium` is sometimes hard to read and, as of now,
> `pretty=oneline` can be very misleading:
>
>     $ git log --graph --oneline todo~2..todo master~2..master
>
> This will look like you have a sequence of commits when in fact they are
> completely unrelated.

This is pretty much unrelated to which level of details should be
the default, isn't it?

I do agree that --graph should be more intelligent around the root
commits when showing two or more unrelated lines of histories.

Something like [*1*] from discussion in 2013 (not the patch that
started the thread, for reasons stated in the thread, but ideas
offered as alternative design in the discussion) would be the right
way to solve it and it would work with all the log formatting
options, whether --oneline, --pretty=medium, etc.

[Reference]


*1* http://public-inbox.org/git/1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com/
