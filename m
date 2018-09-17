Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEB11F42B
	for <e@80x24.org>; Mon, 17 Sep 2018 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeIRBEs (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:04:48 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39166 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRBEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:04:48 -0400
Received: by mail-wm1-f46.google.com with SMTP id q8-v6so11015014wmq.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lkm76LiF5aSYY8yHcv8Y05rj/5vTPqsON/KrkiL+LwM=;
        b=tHYBrVqbhVAolz6bcXDwP2GEeHvsfEpCjURD9ldG+g8UwAUfp/hJU8Mv6rHOm9zhbL
         1AE/ffj4o1IfLbnn7w2qrPf5VIv0cxsxRlt66obWoxPeu8FoP01N5nekqZYfobMLt/KZ
         S0wCUagdtpbKaV2Tu2FwWyE9RzHMw7c90+OER9u3P1RMnx0k0fW0aov+uZSbGOUCTupj
         Z0GIQS0uCOqQ4Un0fMTqJeKcn+AIEsB7FPLEjFDmEsYC4knK4nwM8afIqvwrRw+dYrGN
         fT26zWJHUEj9ZNNENKlaqPKF0DhkqNzSbtLlIEl8K8SpjT9UrL+N5UXY0hxzFVo8zOEz
         7Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lkm76LiF5aSYY8yHcv8Y05rj/5vTPqsON/KrkiL+LwM=;
        b=RNMJo1YPqMGmNack3GDQe0w3t6FIsa1QSE6s03JImjiCM67PmNnZNaypCmPR1NoswK
         tQa7rZs40s9YCTfLAVGV/uZEfSyUXbNuJG0FnyFnp068LI6hxC8cbSlC60XV3rQYaQ+P
         Gg6mRdluE2nr+4g3UwAx1FVwlmxFu8tHYIyfn+wJdp5UUkf35ntCepiMsmRqLbKNWSdw
         tjqKiYNbpEd3RNIGN1RwfcpZaJnqdG+BKSFOvaMpdPLavZcY7zA3Ydgehv18TSesHwyC
         05Z0r6on9pt/OxJkpDArc0lC3uBnq/J08dgBMy7+AmvkVuILrgj4UCJ8XOQ4fNwl5/kk
         t09Q==
X-Gm-Message-State: APzg51B45ott5JLbwEdqYULfr1/4/dwEmb+pxBeGUzG7byPFZ6Liu9bP
        pObr01AoDtOAMef7W64PWYM=
X-Google-Smtp-Source: ANB0VdaMBhOG/YXCdY1+kyQFzTZei0gH4Yp9ITeK1oRGeEjAGV8PG8nG/dnd/3qmuPZAnkZrG412jg==
X-Received: by 2002:a1c:3a08:: with SMTP id h8-v6mr11992921wma.126.1537212962215;
        Mon, 17 Sep 2018 12:36:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm14572849wro.24.2018.09.17.12.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:36:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary files on "make clean"
References: <20180830195546.GA22407@sigill.intra.peff.net>
        <20180831063318.33373-1-sunshine@sunshineco.com>
        <20180831063318.33373-4-sunshine@sunshineco.com>
        <20180917183258.GC140909@aiede.svl.corp.google.com>
Date:   Mon, 17 Sep 2018 12:36:01 -0700
In-Reply-To: <20180917183258.GC140909@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 17 Sep 2018 11:32:58 -0700")
Message-ID: <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	'$(SHELL_PATH_SQ)' ./doc-diff --clean
>
> This means I need a copy of git in order to run "make clean".  That
> was never required before.  It makes bootstrapping difficult --- do we
> really need it?

Gahh, you are absolutely right.  Also "doc-diff --clean", if I am
reading the code correctly, requires us to be in a Git repository,
not a tarball extract.

Having to have Git installed, or be in a repository, in order to be
able to run an optional "doc-diff" tool is fine.  Requiring either
in order to run "make clean" is a different story.

Thanks for spotting.  We can just prefix the line with '-'?  Or does
the script badly misbehave (due to lack of CEILING_DIRECTORY) when
run in a tarball extract inside somebody else's repository?
