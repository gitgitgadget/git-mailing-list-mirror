Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0691F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfAGTnz (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:43:55 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46107 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfAGTnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:43:55 -0500
Received: by mail-wr1-f45.google.com with SMTP id l9so1651151wrt.13
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=By7QLRiuk10S/RYQC4UzpCELYL7vCIDPTmKTUI6FCDQ=;
        b=d2DdWu03vkptFhkLwFNSnzOj+k+N/cV3rEqqZaaD+YV2U+7iLlbgy7ClRqirnOmu3z
         pZxaRKDxp0ZDwxiNhH/MrDsuqYh4UDl7MrBnGf1/yAxaqQiN7tq0HLKlOXZ8Uz40Gms/
         ZfLzEQVxWJUnT+q63BKIqbRLq4wO6GhRjBiQb9piV0Am5JF65TtH3K8rVSgEn7dNhjEz
         35a+KATZvkIFVwPI+nMWgvSbPvla/v9JEf05JJXgjtFc2oz+T3rmNuSyQTkYaswiX0oQ
         T+LrfWufcjGhFdAj4AIabnrFIt0UC4KgkdbZlwU0AOgdiExxdcCcq4n2L28UYbrNR+j2
         s/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=By7QLRiuk10S/RYQC4UzpCELYL7vCIDPTmKTUI6FCDQ=;
        b=YoJUuyQfj7oM5MC2kg99tYdHk6pOomVWz3q7XbOHKGtxPrCeegj2OigjZXvM2XOoAk
         UNHYX93c37r9eLWqfVcIfQ2zfPWgIKFKUnMh7Av+j0SCCiDug7O3vDeX0kS5LDPkfmP5
         VFyQpt7Cu5+1Ncf38G/cdHVN1SV9QoBfAv7ct74UoCGTFAWaGgzw8uwVhVh5/JNYTABD
         nV9gWX3H4c1IoEqFNTACJ+QTDlNX9n+snKuS54oPDv1Aoy1JhxUpYrxV+sw1waYKU9ir
         OSTdGXs+DFajDO2HKLe7hwyOEkpawp5wasb7xhEMJqa6HvNrqXyip+8s/5QLvTZ/xShD
         DKQA==
X-Gm-Message-State: AJcUukfsZNOnM7slm1VCtZjjD9PhjZbhUNPxwn/G9bwCB1prYVrtRlqb
        cCfu09KT73ENwcgn/y8pIehaHA3b
X-Google-Smtp-Source: ALg8bN5M+gd8IJHBSkstOV3hWhJTlVNhb8c4i3KLXKbEXZ6iE6cI7Lnp1JBwI3Gro38Z9wzROcLFSw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr54964593wrh.267.1546890232713;
        Mon, 07 Jan 2019 11:43:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f66sm8525045wmd.28.2019.01.07.11.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:43:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org
Subject: Re: Recovering from a "detached from" HEAD
References: <20190107161748.pyhgpewymdgjmgoh@x220>
Date:   Mon, 07 Jan 2019 11:43:51 -0800
In-Reply-To: <20190107161748.pyhgpewymdgjmgoh@x220> (Alyssa Ross's message of
        "Mon, 7 Jan 2019 16:17:48 +0000")
Message-ID: <xmqq8szw8d8o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

> If I detach my head, then use `git subtree add` to generate a commit,
> the output from `git status` changes from "detached at SHA" to
> "detached from SHA". The sha doesn't change, but HEAD has updated.

This is expected, and there is nothing to "recover from".  Use of
"git subtree add" should be irrelevant (iow, you should get the same
behaviour no matter _how_ you build new commits on the unnamed
branch).

    $ git checkout --detach
    $ git status -uno
    HEAD detached at 9745ede235
    $ git commit --allow-empty -m empty
    [detached HEAD bc9a31f2df] empty
    $ git status -uno
    HEAD detached from 9745ede235

The commit the message shows is meant to indicate where your unnamed
branch diverged at named branches.  Immediately after moving to the
unnamed branch by detaching the HEAD, the message says "at"; the
HEAD is pointing directly at the tip of the then-current branch and
that is where the tip of the unnamed branch is.  You can tell from
that message that you will not lose any commit if you were to check
out a named branch from that state.

After you make a commit on the unnamed branch, you have something to
lose if you were to check out a named branch from that state, as the
detached HEAD is the _only_ thing these new commits you built on top
of the fork point.  Upon seeing "HEAD detached from 9745ede235", you
could do "git log 9745ede235.." and see what you would end up losing
if you were to switch to another branch without saving them first to
a named branch.

> So my question is, what's going on here? Is this intentional behaviour,
> or a bug? How should I get my working tree back to a normal state?

There is nothing abnormal in this state while you are working on an
unnamed branch.
