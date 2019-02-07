Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47F81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBGRiC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 12:38:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37198 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGRiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 12:38:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so752269wmd.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZTpfxBdPLlqBMygCQiKE+WAqvDINBktfnWKVtyx+dz4=;
        b=gfwx4r8ueeJ8V+ocqutMkkH5/ldufckmsFg6k+5CD4ZwhSeLDFvZlqRYSrdngPwm4O
         05htp7SGALCbdIuK+hJSNfxkRlMAx7rIWGAuJW02uoVkyCXEPVSpHWzNtEpXP/TFPG2L
         od2trwgwAY8GeLubqfXGNX7MlDmD0XfujnWqdlTL2O+2CEAae7dJZs61XLw41Qc8HMQX
         d6STbFMWWRh//Fx7oMC3PPY/eJmXOO/FSXUtFNdbjAsGQL25qSAxxHBJtvsrBwR65aMw
         NzxYUAD47LwHoZKlFMdd4pLRfMbPATy88QkinCvOFMXg6ndeb1YZJCU57j3pct4Brk7R
         EDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZTpfxBdPLlqBMygCQiKE+WAqvDINBktfnWKVtyx+dz4=;
        b=O60StQ6ql6lwLZWFwQiuTwInP9GboLs3Q8aXa+KtvzI8C6MleHAM9csakOA3caC+I1
         sYq6m1zytbqJQzaCF9pdH/U7xsM4po3nqnLn4flQJeCT83+SPqAPgNS4KxSv4oBXiG2I
         DnFK4Cm1nC+0CtR43ojRYKvi2z9uHvCz0tYRG7/oRy7WWQ6Ytm90I2JG1QUHk0JHVhda
         kTgFd3NN01Swp8KBI7+1rZACccD1nhIfdHCcWqxt/nDSZdrCNhG7+YlkU9jQ6kmv5WTA
         h1EbNGKp/hXlNQxXS+X3bndB7Vz4SFxnqz1PoxN8fU2LoBleJv9T8G173oRiR9pUyPON
         c8AA==
X-Gm-Message-State: AHQUAuYriRiWNMtd7cqC6Mz8B3kS9XmJbVXFvB7En12+RKzxUT6Jkenn
        QlWS1yLIMdOj9LWT/VgTmzQ=
X-Google-Smtp-Source: AHgI3IbkoMjrJpEEuNO+QxyponiTV04SDg8KAKLlcODt43UipuPCIlxFWTREVe1nTGNcZ5uQ1gC/FA==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr7909577wme.116.1549561079996;
        Thu, 07 Feb 2019 09:37:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i185sm3326462wma.28.2019.02.07.09.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:37:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
References: <20190203230152.GA25608@sigill.intra.peff.net>
        <20190204205037.32143-1-martin.agren@gmail.com>
        <20190204233444.GC2366@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
        <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
        <20190206185520.GD10231@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Feb 2019 09:37:58 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Feb 2019 16:41:57 +0100 (STD)")
Message-ID: <xmqqy36rpki1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Even when there are even only as much as 12 merge bases to test (which is
> the current number of merge bases between `next` and `pu`),...
> ...
> And I sadly have to report that that's not the end of it. Back when I
> implemented the automatic bisect after failed builds (for details, see
> https://github.com/git-for-windows/build-extra/commit/c7e01e82c), I had to
> turn it off real quickly because the dumb bisect between `next` and `pu`
> regularly ran into the 4h timeout.

Would it make it easier for you if you substituted all the mention
of 'next' in your message with 'pu^{/^### match next}'?  

That mid-point between 'master' and 'pu' is designed to contain
exactly the same set of non-merge commits 'next' has, with the tree
that is identical to that of 'next', and from there to the tip of
'pu' forms a single strand of merges of tips of topic branches that
are not yet merged to 'next' (by definition, it itself is the merge
base of it and 'pu').

Bisecting along the first-parent chain from there to the tip of 'pu'
would let us identify which merge is faulty as the first-and-quick
pass and currently there are about 20 merges in that range on the
first-parent chain.

