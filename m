Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D202820248
	for <e@80x24.org>; Wed, 17 Apr 2019 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbfDQU4H (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 16:56:07 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45995 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbfDQU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 16:56:05 -0400
Received: by mail-ed1-f52.google.com with SMTP id k92so4042112edc.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E/4OWPZ/diaxxuO2dns9E8g2f94z3JMAfi9u/01TwOs=;
        b=SVjKvHtNjpL4tRHJlrfRd8LldQiGe4CWnMHzEop1jLLFCUtYDc2UyxT1cPCjB/yEjq
         saTghEipH0/PRyUwoP9cPioyLTn11F8k2AlmudzRo4r5lWtnZjlfSfGR5e8r/q1A3CnP
         QX2ZzBCNhdRRrxK2gm6J4AFF/2zuVxEF9/wegHmJz4OSe1RBRFzPvGSUK5JH2QIFheCE
         OT6BFryjAgZkLQdREGToRcCNtvNr+o27RCbyTk07m5nHl7VAyfTR6USVM2GwahJmS3aJ
         yGaXCA8L+xiz/yrxT1LLJpD5+D5buZElN1g41Kfb0c6T9DO/IgfvOH8U6OJa8ox2ree0
         cAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=E/4OWPZ/diaxxuO2dns9E8g2f94z3JMAfi9u/01TwOs=;
        b=aYopH0i8G7qn4Z0Cw/l7iE9FxACeq63u4/gEhQJD+9reFwtaRjwdqyvQ5n2NIKVZGQ
         TQM9hh3UnVurS57Pf9eiekm+QXHNayEuQXkbgV14P2ln6d0dHvmRu4kg5JQBTr01FKOJ
         e8RxsOUgiqfVpGiNtrOXI7vwfJqt9d940tPcbzLo6AUdqn7CKgBz6VcMB5p3j7KibsjM
         7ZKpbHYSg12Cmmsi80V6FZoy2vJocI6h5VX600xkqABOxl4UUzh33rHIIFJll0FHAfFO
         Rgznemq4PhGcoNO3TsqYwmGFbAtH7Yghoatq/IQAKK8j8ZSH0ATe7djdX38iHKVPn41P
         lOuQ==
X-Gm-Message-State: APjAAAUYhnMCoK9T0ouC6c8qPlh77VXnok+3tx2X/EVhTnSAa9t2Qavh
        upqGMrHUmwHysxOzp5NsoZgFW4Ls20s=
X-Google-Smtp-Source: APXvYqy0IlM30347saW5BLmyz3s6/fQL6PQhY7jU4mLVzg9fDnxBKe/j/S6YgRuYIlpTN+5ZAVzkuQ==
X-Received: by 2002:a50:e844:: with SMTP id k4mr56473399edn.249.1555534563920;
        Wed, 17 Apr 2019 13:56:03 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p12sm2059890edj.46.2019.04.17.13.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:56:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
Date:   Wed, 17 Apr 2019 22:56:01 +0200
Message-ID: <878sw8bbby.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 17 2019, Giuseppe Crin=C3=B2 wrote:

> The feature I'm asking is to add an extra-step during rebasing,
> checking whether there's a reference to a commit that's not going to
> be included in history and asks the user whether the heuristics is
> correct and if she wants to update those references.
>
> Scenario: it can happen for a commit message to contain the ID of an
> ancestor commit. A typical example is a commit with the message
> "revert 01a9fe8". If 01a9fe8 and the commit that reverts it are
> involved in a rebase the message "revert 01a9fe8" is no longer valid
> -- the old 01a9fe8 has now a different hash. This will most likely be
> ignored by the person who's rebasing but will let the other people
> reading history confused.

This would be useful. Done properly we'd need some machinery/command to
extract the commit id parts from the free-text of the commit
message. That would be useful for other parts of git, e.g. as discussed
here:
https://public-inbox.org/git/xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com/
