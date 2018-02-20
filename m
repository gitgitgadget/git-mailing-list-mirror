Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D291F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBTUQg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:16:36 -0500
Received: from mail-yb0-f169.google.com ([209.85.213.169]:34330 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBTUQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:16:35 -0500
Received: by mail-yb0-f169.google.com with SMTP id e3-v6so2140909ybk.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kp2ZNH0rY/tyTqUIIzh3xR0a3Fd5srHcejXlSLXNh4E=;
        b=GfAas/Z6pDxDHLd/PwvfEDtxQ5UyahInq1zyYD9Zx+4EbzmL60Nk4vSeNDpbXpoW0I
         /rv81q9OdZSsyugEiZIaCSiAT2uLU1xrvMAt0L7ad5Np6mOCJ2AFFcGaw31SBdpsijCs
         d4qG2KayOWhxbu/vR33jgUMY1luv2GmDp9WHuj1am7xyAPdSKEUb2SOztTq7GUxCGOVA
         7GACG5rnoncHZujveYKfz1m/Tdf+lfXM3+U/oivoDmSXnlmKun2yztottQyNh2qeAa7J
         V/VjMCQdcZJiLYN3GWkmyVdlBZM7pJAaIvydnm/4WfhwxZpOsZrQdU+H0YVHf9u6kETA
         Ni3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kp2ZNH0rY/tyTqUIIzh3xR0a3Fd5srHcejXlSLXNh4E=;
        b=okUOK2Ojn7/fHCL8xBvFG6xwhRdaCNhCXkRB6REV8XRe6sfa4GSIqlRrB9lSXtIUcf
         o8TRd4vy005oZuKL6Q2nEJ5zo2TwJzb+6oeLbAnRvx/dfqmZMuXV0hgOqTMHzfNXWa4Q
         +jThf3y/+0/+3CSzL13C+LTTeODq4gWEqk7EI2X4bmE4MMv9YI2qta51/gYXAXjJinaF
         IilWUvkOwofMS/jr0i+7+xQWFmhU76yaI8BVnTnx2KlW0vlfxmgLApmzYJuQA8qy3czV
         gFr/TkWxDrjXNj7nRTmEGg++2pZygpV7MABHJwPXb48xUFf6r7i7VpiBW6NyfEbpA0rA
         wEDQ==
X-Gm-Message-State: APf1xPBQqpsbV8zcuUjJ/P2og4xFM8Wqe+zGex8rU7xhFp7RZwjUxvMV
        6ISF5TD1U0mxt/fzDiB8m+NjgUtvxNUIW/GtmLRmQg==
X-Google-Smtp-Source: AH8x224XKjZaBqLelOq5QzvD60C3jsn5XKzmTkkRHjNwQXGQz03L1cBCXJs1K/Oy0jjeKJFtOvLv+iwWeq91GUk7FKk=
X-Received: by 2002:a25:b382:: with SMTP id m2-v6mr715947ybj.334.1519157794368;
 Tue, 20 Feb 2018 12:16:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 12:16:33
 -0800 (PST)
In-Reply-To: <xmqqk1v7307r.fsf@gitster-ct.c.googlers.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com> <20180216174626.24677-1-sbeller@google.com>
 <20180216223404.GD216564@aiede.svl.corp.google.com> <xmqq371v4h6u.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kaUYYqtaJ-S6WaQ9NmXDnf6_wY_fRCSxLR8=Do1qSLMug@mail.gmail.com> <xmqqk1v7307r.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 12:16:33 -0800
Message-ID: <CAGZ79kbyB49J8eT0oQoA0UCzRnn=gBdiSZy3mB03gJaihVGTvQ@mail.gmail.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The step to take an object store would just add expressiveness
>> to the code, which may help in understanding what part of the code is
>> related to what other part of the code, so it may be a readability gain
>> on its own?
>
> It certainly would allow you to have a standalone object store that
> is not associated with *any* repository, but if we are not using
> such a layout, I doubt it would be a readability gain to add excess
> and unexercised expressiveness to the code.

So you favor v1?
Duy seems to be ok with v1 too if there is consensus that it is best
(or rather "if it makes Stefan's life hell, it's not worth doing.")[1].

I will try to resend that v1 shortly[2], as the only actual concern about the
code was where one struct was defined[3]. All other discussion was
meta-level, which direction to go.

Thanks for the clarification!
Stefan

[1] https://public-inbox.org/git/CACsJy8CPKESE8atc_eWdNVknQYp9T6ebwKwCdzLHyaFKH2BnZA@mail.gmail.com/
[2] https://public-inbox.org/git/20180213012241.187007-1-sbeller@google.com/
[3] https://public-inbox.org/git/20180213185120.GA108526@google.com/
