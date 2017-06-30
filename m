Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1785201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdF3TVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:21:53 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34869 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdF3TVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:21:52 -0400
Received: by mail-pg0-f52.google.com with SMTP id j186so67815922pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mSTJ9JCVGtWSkCLhkCEyijCWx3jdEnWfXCdiF8cZhjM=;
        b=a35NpWz4Ai9XskX+xMh8Lut7Safa+/SLo5vTz9KR6DHgWi1KwbHCgKpIjJZJEMikSN
         XY83tz6pdh5m6OGJtNqXJUX2psmrlO0QD8jHwUWalHWAieA2o3oHp03JBfrC6QoXmRdB
         uOZabEi4l4vhJQRxg8V35AaGvumZdRuf09DAT/B0U4eW1Oa4iY5S+QmrZ+JaadkugpUy
         QRxEa18efOEFqV9u6sGHIh8qQtQo0TsF1dTgEstcvh+/6ahOgwwEYNPvDNJLTPeu2eJF
         VpTVNFkyRmvKhBmWj5BGiEbqv5mojS9Gd7+KwSEWb3SuTH9YuTikQe+Zpcr55zOL5Hvh
         rYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mSTJ9JCVGtWSkCLhkCEyijCWx3jdEnWfXCdiF8cZhjM=;
        b=Zs0UuLi8R1ssDr2bkt8OO4G+rgj1rZGtvJ2HrVbfugNrjVa+iyzYo8uNaLJ1b+X7lk
         hdOrDnw6Nc5uKKh4slknNPVZUb9KqY7r6w5uKoZN+VykECtxlSqwHKofHU3pIxwrl4f6
         m7Dnd/ImqVsKcTSbrdaMAaKZ9f6+lqooZQabxpVH8NDfTO8/UEZH7Wtlt5fvgKEHwjZX
         zbJkop4ClfXJ32I9gmvQSHZMvOoq/o+arQV/90HzqDU8rEGZWZ+8TghuHy7BZnQmnpj0
         r2Bu5QQtFBbCt8PmfWaqxMHYcmovz7q427vE8C//EEVIpIMYOpzNxhzi+ZYO9BlFQGYl
         B4aQ==
X-Gm-Message-State: AKS2vOz/es/CelzHLKnoOpK9x8bgk8rQDbY6xHXbx3r7iN8dRSuGJq6g
        Pspdya7oHJkeAQ==
X-Received: by 10.84.214.22 with SMTP id h22mr15977735pli.277.1498850506772;
        Fri, 30 Jun 2017 12:21:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id 188sm14831503pgc.49.2017.06.30.12.21.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:21:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laurent Humblet <laurent.humblet@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Warning suggestion for git stash drop
References: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
        <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYd+3OoUBcsTS9=S9qEUwKj9ypyHyjXLBW=KjWOVoae4A@mail.gmail.com>
        <CAFirYm_UzUe=zSefAVpt45OuEwKyn7bAZbumLXYWbPFVRahPew@mail.gmail.com>
Date:   Fri, 30 Jun 2017 12:21:45 -0700
In-Reply-To: <CAFirYm_UzUe=zSefAVpt45OuEwKyn7bAZbumLXYWbPFVRahPew@mail.gmail.com>
        (Laurent Humblet's message of "Fri, 30 Jun 2017 20:33:49 +0200")
Message-ID: <xmqqinjdqo1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laurent Humblet <laurent.humblet@gmail.com> writes:

> Thank you for your feedback.
>
> I suppose that turning a hypothetical confirmation option 'on' would
> impact a stash pop for instance as it automatically drops the stash if
> it was applied without conflicts.
>
> What about a --confirm flag?  You could then simply alias 'git stash
> drop --confirm' locally and it wouldn't impact anything else?

I think that is probably trivial to add, but how would you make sure
you give it?  One way may be to train your fingers to type "git sd"
with something like this in your ~/.gitconfig:

	[alias] sd = "stash drop --confirm"

but at that point, you could instead have something like the
following in you ~/bin/git-sd and get the same effect:

	#!/bin/sh
	if tty -s
	then
		echo >&2 "are you sure you want to drop all stash entries?"
		case "$(read)" in
		[Yy]*) ;;
		*) echo >&2 "ok, let's not drop 'em"; exit 0 ;;
                esac
	fi
	exec git stash drop

without adding the "--confirm" option at all.

So I am not sure that would get us closer to a satisfactory solution
to your original problem.  

Retroactively adding an end-user safety is hard.

> Have a great week-end!

You too.
