Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEF11F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 08:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJJQHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:07:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJJQHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:07:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so4742994wrt.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p/jDBIRU/O7xSXizD2yC0kUTrYJbIc2EB3/Zs74zEzA=;
        b=AMKFJdWiCKt7xZKl6HMotLF3/nh5lHZrT6E3WNPifozIPNWuil3bo9t0SoxerkxZUE
         tR6hMJFTZGl1CNp4EcBOHh3V5LqDAPM851KJXw1ZoB1VEbNDmRUArRAdG4zUHHfOhvCu
         EfRv9r6bnsFHgTApwTyX+U1RYphXZKelSFpEl3LXPO7i6A+X0O19PNkcAyNDUv9hs8B7
         9mdcXz70kSJkGYPxPs+8O4wD4ReoWE7WaEBnf6xhjVTE6B0oqTq1tUdOEbpbaFEkG6aN
         6EskAENuxmJe7IIBvSB3bOVP1WEepaj/JSi1gynR3MYhOplg9ZX/+n6V9kIJNhiyTDgh
         k8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p/jDBIRU/O7xSXizD2yC0kUTrYJbIc2EB3/Zs74zEzA=;
        b=dbyW8XdF8TUBXf9FiyXqG4TgGgDpBNSPfIZObfrtMtPLsAw52GF3Gquok3rFWxHSX9
         mo7I192nO3ruDS4Xr+xtHCJWOHw5RNWwV77rK/S3nu5fzhOsi0tXJIyb7PpextcA3YU1
         4B9hRs0504QC/xhcRxzIbSy3bxpbznqxg9L8MATInSgyFXxykwhkxKP8AUPVzlsfmI7O
         nN/nP/YPGdIRpOsjvk/y+FOez1wttnK/bM7PkSjRlbsneceHMZeztQJQLgxmB5dB3U2o
         f4KeCToBNxpvV0empePrZeFq8j9bluqEJd/QB6Bnke3LPZwEqSgVGxNmPl3ntXHMD4vh
         wJXw==
X-Gm-Message-State: ABuFfogKM7SRd57YdAXndkqiB0sOgWHJ14VM6FRQUkvKPy0rq+3ZxhsU
        yvw48WwlwrnYqKOsgvsLxz8=
X-Google-Smtp-Source: ACcGV60bsTd7dyKC6ZyLidlBeur9JDhTg/W2iN68QNGb3Az381Gcu5RpXCn5kIjTV8chgGcO0BcSow==
X-Received: by 2002:adf:fc0b:: with SMTP id i11-v6mr24383080wrr.9.1539161201037;
        Wed, 10 Oct 2018 01:46:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r131-v6sm12740094wmb.32.2018.10.10.01.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 01:46:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h in header files
References: <20181008170505.GA13134@manohar-ssh>
        <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
        <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810100856570.2034@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Oct 2018 17:46:38 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810100856570.2034@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Oct 2018 10:06:50 +0200
        (DST)")
Message-ID: <xmqq4ldumbo1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Personally, I find the "whoever is picking it up should do the thinking"
> much too harsh for a first-time contributor who specifically came through
> the Outreachy program, i.e. expected to have a gentle introduction into
> the project, and into the ways we work.

Oh, absolutely I agree.

Any random discussion participant can say "left over bits" in any
random message with an idea that is left on the table.  Looking for
it may narrow the set messages to be examined, but the query result
will inevitably be still full of chaff.  It is not a very good match
for "gentle introduction" material for GSoC/Outreachy microprojects.

List of reasonable low-hanging fruits is hard to maintain, as the
cost of building and maintaining such a list would easily outweigh
the cost (and fun) of picking these low-hanging fruits yourself X-<.

I do not think of a good solution to help newcomers offhand.

Thanks, as always, for trying to be helpful to newcomers.

