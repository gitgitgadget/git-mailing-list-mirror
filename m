Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA1F1F462
	for <e@80x24.org>; Thu, 23 May 2019 00:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfEWAEZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:04:25 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46332 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbfEWAEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:04:24 -0400
Received: by mail-wr1-f48.google.com with SMTP id r7so4164356wrr.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qHS8w7GrEF0+gDeehuDr3x0Ouym+WgiR0jALCj3amNU=;
        b=IZliv6m5jnAAky+13YCcL1E/63OFSo3UvkFqojRZDXQWAcfNWHRu+IcP+rl1RdA/NV
         8XBiTltmigY8TfeGH+ZTTCEHm+d+ivGgBmSwb4iEY6CTas7HlJ388AuGWI5h0IFjb/L9
         VO+oWYn4vyU9797gab5p3fR54Pn67YUf7pOB02ExP1cbWJKbG5Ad9vSsSll+0hhyNZWx
         UKgs+feM4ZvykyxSGSRdeGda32hQsXVciSnhi3/5xCQ10tXq083LE3g4/35ocFe1NU4C
         59H57Vx3hp0wIZb1cwnh9oJWC0I1z+Ac7IYk5sepPZtmc9PkjCSzpO2kjkZUS0hpAFQw
         oTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qHS8w7GrEF0+gDeehuDr3x0Ouym+WgiR0jALCj3amNU=;
        b=lZy5gtfRRD29PMQ6Xw1vFXnqzuNNW/8WOM2JfyHPA9wD9L+9uzwKbPXBJ5Pj5MikKQ
         czziFdQwEL9cq5PL/moQ5NrBmJQbFCJNmw2N4eAdLqCVUefHg0FNf9OtiylKV247cyqJ
         ZF9XK3C1HieS/s16YX9/WJYMs6HcpKTVAGQ+gZSdnUi0XYIhzdAsXqk104CkmAsJf/4d
         k8ZB7hg031i8eNCPuuwN5yu3ue/ZoBrJuoBKtFYBuG+gX+qmXWoU+iwEQSM33Rl5Fg23
         7qotsDkuOxP6bX4LHN/TPV7X8t6z+YlfPAz5S1BLlXv83yn47IKjPYtWNB9pjkEaW1ci
         EUCQ==
X-Gm-Message-State: APjAAAVkNi4NtKVXeBOIFaiwzhJw++V6tjeyWav/vMQGb+Bhb9Uwbaax
        wQfjR60xxOD19PUueFxCLRw=
X-Google-Smtp-Source: APXvYqxHE59H+uch+SN8PeQcu8X97G0O1nQqalSu6cYJsbuphwizk9rzBfq88afv3tG3D6ljjxVzKA==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr29358250wrp.322.1558569862387;
        Wed, 22 May 2019 17:04:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a14sm9524337wrv.3.2019.05.22.17.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 17:04:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: git describe/contains for submodule commits
References: <CA+P7+xrXz7-TgV4ufVkXqjgi8X1UD=pQJC3s2JA5fH-sEEnENA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CA+P7+xrXz7-TgV4ufVkXqjgi8X1UD=pQJC3s2JA5fH-sEEnENA@mail.gmail.com>
Date:   Thu, 23 May 2019 02:04:20 +0200
Message-ID: <8736l6ujcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Jacob Keller wrote:

> Hi,
>
> I've had a few times where I was curious of when a submodule got set
> to a specific commit.
>
> I noticed that git describe has "blob" support, which outputs something like
>
> <commit>:/path/to/file
>
> using the revision walking machinery.
>
> I'm curious if anyone knows if that sort of revision walk could be
> expected to find the first treeish that had a submodule commit instead
> of a blob.
>
> I'm not that familiar with the revision walking, so I was hoping to
> get some pointers of whre to look before I began implementing.
>
> Ultimately, I'd like to have some sort of command like:
>
>   git submodule contains <submodule> <commit id>
>
> and have it try to figure out the most recent commit htat has a
> submodule change for which the submodule is a child of the specified
> submodule commit.
>
> I can sort of reverse engineer this through git log, but it's slow and
> tedious, so I was hoping to be able to implement it into a revision
> walk that did this.
>
> Once I know the commit that introduces the submodule change, I could
> feed that to git describe --contains to find the tag/version which
> included the change easily enough.
>
> Thanks,
> Jake

You can do this with --find-object, e.g. on git.git:

    git log --find-object=855827c583bc30645ba427885caa40c5b81764d2

Plugging that into describe.c should be fairly straightforward.
