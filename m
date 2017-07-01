Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD8F20209
	for <e@80x24.org>; Sat,  1 Jul 2017 20:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdGAUbl (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 16:31:41 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34073 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGAUbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 16:31:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so18923454pge.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X4fJHI2/6ns9pk5PyOpoJflsMGBnE5QhQjR3W7AXniw=;
        b=k1vE37dI4/8Y7b1DbJwMKnqIbNBTf2v0wu9r5EW8lTe6X18lgTCnckBZFMK11F4Q4E
         UoQzjB4lIzG+8KbfuJaV+UnJpUvxasxM1mOsh8TmEzE+iY3HxHA6fPRDXMbVc6Tk5lVh
         4ADJ9HkKxxpQ3dfJxYin7OauLFH5vmrN2CgO/iKvkkHb8C6cOO5IdiWHP2bRDsM5Q8Il
         7ewIWogbLqOpiNrgdd+BjKv+ov4p0Re41AqCmhEsikkQfZYUmyh7/V7bZFf77K8TPmVU
         66K7dib25wU1cW5sDF8aPhdfuofu9MJRAT49goDmEdgS6z9k6Lp4yhSJjMwq251FuVhj
         MOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X4fJHI2/6ns9pk5PyOpoJflsMGBnE5QhQjR3W7AXniw=;
        b=EJJvXmTNSs4rGE5TYc8L+9/kZ+RBnzua3y0SOhtYrPBp7EYXrp1/HMmLX8isFsDVeT
         A1mrF5VsArCkQUp4Rpuo+WN/YRBWAJvG7f5X17MDlWs0+wAPebrX8FcMPqIGxN0R/+kt
         +Qm9AQOMKRJS+1KHfe16tItK7HVpRSyCweZYjLLy8FTCFNr43beCCg9klhyA9IaiBoCT
         kQk9HWzWMLYkpPBrBpbbUu27kiC4bHbBy9cJNZOhQbmbUnSO6lda6UtW3rjhLjzvUHAF
         /K5B0znKTRX9g0lbIsvseZUZ78o8sAiw/6SfjHUcIGyom8dt2azGmDUc4soDOYvhbW7H
         wPlw==
X-Gm-Message-State: AIVw110slvV5eBIVp5r9XQmAfvUOME6A/R2xtct8DsInx9Ym/kUFrKGT
        8n77atNBROeclQ==
X-Received: by 10.99.186.71 with SMTP id l7mr2290686pgu.272.1498941099462;
        Sat, 01 Jul 2017 13:31:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id n71sm25700427pfi.95.2017.07.01.13.31.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 13:31:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
        <1498918546.4321.1.camel@gmail.com>
        <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
        <1498935127.11617.1.camel@gmail.com>
Date:   Sat, 01 Jul 2017 13:31:37 -0700
In-Reply-To: <1498935127.11617.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 02 Jul 2017 00:22:07 +0530")
Message-ID: <xmqqy3s7nbkm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Sat, 2017-07-01 at 10:36 -0700, Junio C Hamano wrote:
>> Actually I was wondering if it is a good idea to remove it, as it
>> seems to have outlived its usefulness.
> It does seem  to be a good idea but it would leave the 'prepare-commit-
> msg' hook with no scripts that could be used by just activating it.
> That's why I thought of adding a script that removes the "Please enter
> your.." message from the comments if it exists.

That sounds like a sample that is there not because it would be
useful, but because we couldn't think of any useful example.

IOW, I view it just as useful as a sample that does

	#!/bin/sh
	echo "# useless cruft" >>"$1"

whose sole value is to demonstrate that you could affect what you
see in the editor by modifying "$1".
