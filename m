Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1900F20248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDBAuS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:50:18 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44325 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDBAuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:50:18 -0400
Received: by mail-wr1-f53.google.com with SMTP id y7so14290311wrn.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3vUO3XViAPmJGOKyApynuv8BeYN7kGdfIMU73BlSnqY=;
        b=e2VPFtKaYNwzSevKqu8aNrQqFPU32t/lQUtDzwGKhKqikV6VCSd7H3WzUpSdEEP7YR
         Q41/FsAJI1TsC1BP/gH+vUvFErQpL2WstFRV5R2LUmE+T7VCusi6sgLT6JB6ycUu4KIL
         kbuNvcByG6+9N6B9kdX27/unZZQjBNZHuzOVq2yvATkmC13IQt4LxZep/WzSjqd4KOrA
         Awe6fGdnB0/r+V9dovXY9nS2IF4BTqwwp33Br+2d2W/wvh+JfcB7TGQ4/p/pDkPaKJxU
         Y6ItUxBuQsEXxHON5ii4lshpwmpSP6kilSAjUNfTEIj9HIH6mnxgl9fCcDnq7xB/AEnZ
         WH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3vUO3XViAPmJGOKyApynuv8BeYN7kGdfIMU73BlSnqY=;
        b=iTQqDaKMGNzbTf+E7kKFbcxDjHnXQ7JYEQWfVJZWZ+ba2+dW4bVN69Nkd51iaXERUE
         bQGIJC38xnGetXLwVdyX9tv5rJzVM9oUFLS9KJ/OV+bbQ3p9twQDNbHGbL7Khg01fvHr
         XlTXQbB1IrZs2pWzsTjF9lyinDxQwx6Aa1FF0EfHeqdaYIIn0tN9W9eawdAIVVLpGuaO
         GKdiju8DkPlRBGFthcDEHDIOuLI8xfGuJypMEJ5ykV/fidiqk4MT3/UYz7TQx/29ul2C
         fJ6gV59jbFTspNoPuXsk8WcmoadQl1sAVFT9ApE3GYkcIyc4XJl5V52QBc41DqKzmPbt
         5j6A==
X-Gm-Message-State: APjAAAVmlXFsrhaJEhGgpNd90Qx/UfG/SJchrhdo3dfKSQLmkPzRqrSn
        SPwMWpMHb39iyGB163QA7Yw=
X-Google-Smtp-Source: APXvYqx6xYIzEoOym13TYiVcywksrEkb0xzv62HopusBo9W5RA6+aQulpyPOg3IgZAi/6oNVnlfx7A==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr39349594wrm.124.1554166217026;
        Mon, 01 Apr 2019 17:50:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j9sm16868098wrr.93.2019.04.01.17.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 17:50:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam Lee <skynare@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reverting a range of commits with conflict
References: <CACrt3pyZ7XNHLfFM46qymLYft4+jXSU_HBD2Wk+cL6MSzryFhA@mail.gmail.com>
Date:   Tue, 02 Apr 2019 09:50:16 +0900
In-Reply-To: <CACrt3pyZ7XNHLfFM46qymLYft4+jXSU_HBD2Wk+cL6MSzryFhA@mail.gmail.com>
        (Sam Lee's message of "Mon, 1 Apr 2019 13:25:54 -0400")
Message-ID: <xmqq36n1ut6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam Lee <skynare@gmail.com> writes:

> It brings up EDITOR twice and I end up with two commits.
> I can squash them. But, I don't know if this is a desired behavior.

It is my understanding that the users who do want a single revert of
multiple commits are expected to squash them (by choosing which ones
to squash into one), so if you really want to make them into one,
you can squash them and that is your desired behaviour.  The point
is that you do not have to.

If you think a bit about it, it does not make much sense to leave
outstanding changes in limbo with --no-commit when you are picking
or reverting multiple commits.  The first one may replay cleanly or
may not and needs manual resolution, but after that, the work you
did will only be in your working tree, and the difference between
that and the HEAD and the index is not recorded anywhere else.  What
happens when the replaying (either cherry-picking or reverting) of
the second one had conflict?  The effect of picking or reverting the
first one is now intermingled with the effect of the conflicted
picking or reverting of the second---with --no-commit, the workflow
is making the messy conflicted state needlessly larger.

