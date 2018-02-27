Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EA21F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeB0UiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:38:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55109 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB0UiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:38:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id z81so1013708wmb.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sibUNoRlpsTCCDVkVtiKvm+4LwAoYgTgic9ZjuHhhlw=;
        b=oKbnqznuHs3u6g7VSI8JvhzO2esu2tDH7EoolyQGob294Ufkdf1X00DzCsLWc3T7YO
         +FRH9k563ST/vUSsjc8trJkYE9uTgjRuHx0q6DWx4ndMmh6we7x+pNMzf2oz3/uqDS4R
         aAdqSjTYHdoj0WtYuBShQByzGF9LUzUzUwKtqrafzVhSrjiZCAPjPL+sDpAeCuw6zd4s
         BO6d68NwAULnEh2J7OfiQeshu0oc/yFHbHe8mk49KNylYc1RkKrtdilC3znync32kUPL
         JPwL4Ix/Vr0Cs0YLLBkjaBxsNtS3Jg5UfbL87aB+kguBvgb1dalhShW1Y5Y4Wrka7flY
         PICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sibUNoRlpsTCCDVkVtiKvm+4LwAoYgTgic9ZjuHhhlw=;
        b=Xdb0AXqX0ea6zglwRcERMpSio3mQKcNDJSsBNSpD1QKuCwjg8btLDmloAOzyEvmXBY
         AoPLaD4j03EAFnlWAypS3CdJWUo0HUC52kGINEmrgM0HKjLG5WQqMmPrXGMAi1O/YrtS
         90w1eQF+UyI8M4wfZjAllhH4P0JMUg+O+ZTv/ldUeOXqRED/MxblmGZqwZprcCjlptHj
         +h2QReB7q5a04sxf4Gbb3wJVSDzJ8eshwdgGPSBIrZ9LFSO0oI6Xm8kqpaOrZYoYb5tA
         WoYKjJzC4QWXYJSQlU2exAxZXKkWf2RCn14U6lo8S36Ln8bKxEU3ynqNdLDNaRUBG0rX
         ORbg==
X-Gm-Message-State: APf1xPAqViXI3z78OOZ9BZfWpv7fx1bDtD4wsnqSJQUzLg6i11sf04+B
        7E4TLzRlt/hgM29Yboj7JGY=
X-Google-Smtp-Source: AG47ELt0m7FaV7kp6okBoQmWaCvPKkyaqkkA3lFBA84bnaTjNF6bhCegb4jcBD6BV58bffCt8SHP5A==
X-Received: by 10.28.66.65 with SMTP id p62mr6689918wma.8.1519763896323;
        Tue, 27 Feb 2018 12:38:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m15sm10283wrb.58.2018.02.27.12.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:38:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1802231310120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqwoz3ttod.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1802270022120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Feb 2018 12:38:14 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1802270022120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Feb 2018 00:23:45 +0100
        (STD)")
Message-ID: <xmqqy3jep3rd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Not quite. I have two more changes lined up. Let me send v4.
>> 
>> Picked up and started looking at it.  Thanks.
>
> FWIW v4's patches are identical to v5, but the interdiff as well as the
> pushed tags are completely broken in v4 (culprit: an error in my script
> that I recently converted from Bash to node.js, where it would not stop on
> `git rebase` returning with a non-zero exit status, fixed since).

Thanks for letting me know, but I didn't even notice those
screw-ups, as I mostly go strictly by patches and consult other
material only when I have trouble with.  And in this case the
changes between the versions were clear enough ;-)


