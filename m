Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBA620357
	for <e@80x24.org>; Mon, 17 Jul 2017 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdGQWJr (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 18:09:47 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35116 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdGQWJq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 18:09:46 -0400
Received: by mail-pg0-f52.google.com with SMTP id v190so1484400pgv.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SWDoMaQIhZdth1fEjb1oN3fidOO3qTjR90549XNYP8w=;
        b=rmrIJATeIV6jOX3ctHDHg8UnnYYZQhmZmIs0+YIGSBzCduQVyQPGT/+yrA6E3Frne3
         DysBeQsTOiocJp3cxV/i5PSNqe3H0UENHipZcusS+Whb7ICj+tK0ijZ2VFk5q061Ljxq
         4W7diStnZ2lPaGOf29K3S4YSf4CzR698/p/c7JEmlCtOsXMABYIgZJWs3UoEbVx1NUpd
         F8ghh67vWopk+Vdod1HtsrecOQW+McDj+hojjgde4Bfc6ZI7BYVwcmAq6QOfm5zxZ4LG
         xkZhzYNJ7PfvqALwsFdHqUS4TANoIimwUu7dFPGDm7S6mac1dgIVpxRD5vXpiIDY2+DV
         V6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SWDoMaQIhZdth1fEjb1oN3fidOO3qTjR90549XNYP8w=;
        b=PV3VvRWWArNuTjO8zigpqQPy5tfpQw56yRLfEbi4o8v+5nxHRevFfGhU/w6JvNHN/Z
         hl501rI/wTLiPN9odVNd8gBHLDYg8thGZ2h2dhb1Mc8GtYjEVtUxq9WRQTJqklwWN3Xc
         KJ2DHRoCLJFTXOBAUYBq4s0jNHACr8VlX5OYK8h49mFdTSMkJCwcvGMa32JKWcdFdKSN
         gGZoGFYM+k/+tSLHUaafBOj2+eh6DHGfaKUTwbHWWPHt5Id/Vo4mEI7KzGbRkGLD623T
         9Ev3GuTA6jIUVvZ/n8vQb189fCHbxW5qRterTgU2CJ6i5YSQUGVm5iPAF4boptEuoNPR
         VGBg==
X-Gm-Message-State: AIVw111AvPFrTiY8RZklgD8SWdwvx1hKhixR2mv70yiFXpQD6GSqcXea
        4uiUoZGkfF2emw==
X-Received: by 10.98.35.214 with SMTP id q83mr21690132pfj.101.1500329386214;
        Mon, 17 Jul 2017 15:09:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id a29sm450042pfg.30.2017.07.17.15.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 15:09:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
        <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
        <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
        <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
        <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
Date:   Mon, 17 Jul 2017 15:09:44 -0700
In-Reply-To: <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain> (Santiago
        Torres's message of "Mon, 17 Jul 2017 17:42:41 -0400")
Message-ID: <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> Other projects such as notmuch opted for a solution that's simlar to
> what I had suggested[1], but I wonder if it's even necessary to do.
> There is already a fix on the master branch of gnupg[2], which I imagine
> will show up to the next version of gpg2.
>
> I don't think it would make sense to fix anything on our side, unless we
> want to be extra sure the test suite is not leaking agents for all gpg
> versions (including these minor versions). 

I am not sure if it is merely "if it's even necessary"; if there are
two tests running in parallel, with their own separate
$TRASH_DIRECTORY, and one of them say "kill the agent" at the
beginning, would it affect the other test, depending on the timing?

I would imagine that the sockets are kept per GNUPGHOME and they are
not going to interfere, so if that is the case, I do not think we
mind helping folks with a buggy versions of GnuPG by having a "let's
be cautious and kill a leftover agent before starting to test"
patch, as long as the reason why we do so is clearly understood and
documented.

Thanks for digging it to the root cause.

