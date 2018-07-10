Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4E21F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 22:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeGJWWm (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 18:22:42 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:35989 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJWWm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 18:22:42 -0400
Received: by mail-pl0-f45.google.com with SMTP id a7-v6so8225282plp.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRElxDMVQjTcJA59EETi0WJxgjZy4RzglnDFTG4Opvo=;
        b=C8TrysIvKgIRAJMi7bQOr9PFG+M3yIistX7X/AdehqKWasqaVxtEsGgJpnS0a849qi
         9gQ7sRlM7Yav/2gDg1c3jBViyqgjfndVkryT0mawnLjBH3E/dp3QslvVOSvnsPJRGjAg
         o/NlzGWUI5EvwGkdWlz+baOyDRulbX1EmfQSCitWjMpvsWKvNpvCE1j9Tq7IgWvRi/7U
         HfDgkWi6TyzZ6fTkZ7sdqK+FyzON+tEKCFxTgZSi7VIzUPo7xWIC6Y4ZB9CCRZReunXl
         dH9rScpPQavEROrlG5+j+vqefsbrgTy0oV10V5fltOjnPduNqIymybZCPg0r0HvlLz04
         aS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRElxDMVQjTcJA59EETi0WJxgjZy4RzglnDFTG4Opvo=;
        b=AMFk9EP696G3Bwgwe/jNCO9e4v8U55YZ75FZSUlYNoay400vyDdRK9IIMiGc3m2RdD
         5v8VyhJy0vASgHuJbe49nPN2OfzOMmsJb4JOBSolR+x09J0D4wfk+xXCLu6KLMDYGrXa
         DaB4PLlexygF0WkldG4x/sLjehMj5IryPilo1llmBBt7JPMfRTZpcyDeripQuiCzwukr
         MT0jxKlzJkv0bUdElnmTP73TAPtJeHToeCddExNzjz/CmZrn+0dSe6nWVtkH7vZFF6Eu
         JwMtmPYEnUGyZZlk7jYlxcsf/J4KZkp2qra7RIzwj1C+yT3rGbXgs59I9dA3z0NAHR5g
         MFUA==
X-Gm-Message-State: APt69E1i3FLK69h0yNh80npq8S8m18VQYcutTOpH05B0N9RL/Fp55IgH
        aOPAuy9bPTDQp6yYlHUz2zI=
X-Google-Smtp-Source: AAOMgpetndeb1m6C4oksz2UweR9yRdgycTYjv1erWx/BE3NCWxIyoPXZ7zVB5+JAlMuNDbFwETxeWA==
X-Received: by 2002:a17:902:d807:: with SMTP id a7-v6mr26029289plz.214.1531261293663;
        Tue, 10 Jul 2018 15:21:33 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p66-v6sm11013720pfd.65.2018.07.10.15.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 15:21:33 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:21:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Perry Hutchison <perryh@pluto.rain.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180710222131.GQ14196@aiede.svl.corp.google.com>
References: <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net>
 <20180710222005.GP14196@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222005.GP14196@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick correction:

Jonathan Nieder wrote:

>              Similarly, various features of other tools (like bash's
> support for <(echo hi)) also rely on /proc.

That relies on /dev/fd, not /proc, but same idea.

Tools like "ps" rely on /proc.

Sorry for the noise,
Jonathan
