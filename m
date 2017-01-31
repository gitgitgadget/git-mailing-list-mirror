Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1828F20D07
	for <e@80x24.org>; Tue, 31 Jan 2017 03:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdAaDMA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 22:12:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34165 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdAaDL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 22:11:59 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so25361266pfb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 19:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tL3SJehY9ea4+A0DZf5Tmjh31ktFFdwb3TufhYX6/wg=;
        b=ctpkPhwU9m56kbIpyjKUk2e7rR1Hf0wmGV4MeAqE/Z0xGCUNgQ1uV5MVrAYwZ5nMJI
         E9TXt1bP90Zz2jf5Tz2bHX7EIrFR0Cq+qS09Q0heOEpkVVFyt4/XSoqiqZmvbPZEolhH
         qqSjoCguIXPknQUStur/J8/81ZxIL0TcHx+ebY3qjHje1aJydWmZqGS31xQdOIvpWFZn
         PMiqLOi99k6elTXYTKtW2HFqz+47J4Col3fUNoiA7cFAtSzoHPJf/oJxZeH1Nh1F3w3I
         uXIWoEIi+aPjRRaYKECVbNUUXdFHj6mALHT7ElOoLX0NB8OlvDnyDKVf85OBh6SnQsKQ
         YpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tL3SJehY9ea4+A0DZf5Tmjh31ktFFdwb3TufhYX6/wg=;
        b=SbX5rbMOvD2nN0A79XLqdJoGuplXH1to4jC4ddFiiGPNwYNSCVFJ+TvOObaW81ytrn
         TqB02X7ybsjt2GNQKb2jLfWtYn82fZzHys//QjNV+unZqk0Tyshy6dG80Mpv9mLuBKnv
         vKBSsSJs0Pf/XwGRZ9BJgZv5cgNyNv0b7VRSccOe72US8SJP418MtX2YzasvC59JwTBZ
         ghquGrnR6aOzRJYaBB9uzBDxpszXBt6JG2n4xPEaVgp3qokSbzj0SV2n3CDdl/h6eZ0o
         ncUiQvRabQ2w4mUFJ08JmiHXrZpZEuQs8vk1PcwbOIbapZ1XrS56zaalbC/O3J87QeeW
         3xbg==
X-Gm-Message-State: AIkVDXKNg8srVNYe2v/9sDjsk8WPmpJabkgpijH2G5ve/eUtV220cuZ/uq5YWiv1CVb96g==
X-Received: by 10.99.143.18 with SMTP id n18mr27311004pgd.133.1485832305258;
        Mon, 30 Jan 2017 19:11:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id m136sm36193831pga.22.2017.01.30.19.11.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 19:11:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
        <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
        <xmqqr33krtww.fsf@gitster.mtv.corp.google.com>
        <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de>
Date:   Mon, 30 Jan 2017 19:11:43 -0800
In-Reply-To: <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de> (Benjamin
        Fuchs's message of "Tue, 31 Jan 2017 01:10:15 +0100")
Message-ID: <xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benjamin Fuchs <email@benjaminfuchs.de> writes:

> In [2/4] I got rid of the loop by feedback of Gábor.
> Sorry if my patch wasn't well formed.

While it might be the way other development communities work, in the
Git development community, we do not work that way when presenting
your second and subsequent attempt to the community.

Having the initial draft from the original developers that records
the bugs and misdesigns in an earlier parts of a series and separate
patches that record how the problems were fixed to arrive at the
final shape of the codebase might be interesting to the original
developers, and they may even find such a history valuable, but in
the context of the history that will be recorded in the official
tree of the project for eternity, that just adds useless noise.

Instead of keeping the original, in which problems were pointed out,
and adding later commits to correct them incrementally, a patch is
"rerolled".  That is, you are expected to learn from the review
comments and pretend as if you did the work from scratch and you
already possessed the wisdom lent by the reviewers when you started
your work.  In the "rerolled" patches you send, you pretend as if
you worked without making mistakes you made in the earlier rounds at
all, producing (more) perfect patches from the beginning.  

In reality, you may locally be using Git tools like rebase,
cherry-pick and "add -p" while preparing these "rerolled" rounds of
patches, but the name of the game is to hide that effort from the
public and pretend to be a perfect human, recording the result of
exercising your best ability in the official history ;-).

So this is OK:

    0/3: I want to improve X, and for that I identified that I need
    A, B and C done.  A or B alone is already an improvement, but A
    and B together makes it even more useful, and implementation of
    C requires patches to do A and B.

    1/3: do A
    2/3: do B
    3/3: do C, building on A and B

This is not:

    0/3: I want to improve X, and for that I need to do C.
    1/3: I couldn't do C, and I did A instead.
    2/3: A was totally useless. I fix it to do B.
    3/3: B is not very useful, either. I fix it to do C.

