Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B121F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeHSBRf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:17:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37394 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeHSBRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:17:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id c6-v6so437694pls.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VxoC8AJZ7LLXfSbfS/nqB7rBNldX6oRqQ6PCJanAC94=;
        b=rv1YIotwbYBsui5BBNcFSLdW6U2R80G2D6GRQ5P5OPm2Z7NhcdOcdgCnBg+69MroWF
         BgYd6O5jrDAIQqa9pIbfoz8JnNKkziGRm2e9bA8ZeCoPDj65zXwWQktUyRObIljA+7g/
         eNsi+OT03S36mQS+NRK8CaQLRnEO7/dk3ZcLaWs1trSTLmlyR2OqnerQ4wB7bbXg9p/U
         AEzhBJrHyBnrf2ilC/bawyHlNPkkA8PUCMYBbW9xCNCatP3OXVrIMJi6XABaqGwkP/Ha
         kuiRWF/cVeZL8qKfXMU7bZjOSlySVMqd0waSTUO6A29ouADMvd39cu+QbtC3VeJqw++T
         M2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VxoC8AJZ7LLXfSbfS/nqB7rBNldX6oRqQ6PCJanAC94=;
        b=o3vPhTa6WGXWmkMHBSNjbHYaqzuwlb2sHe8n++WIjQht69fZFC9ByCYkY7RaJzin2u
         STqTwbpKTsV2mUYdlma4y2APC9NQb37vBX9vIeMKlUEqlXUaINi0DPuCZ2VJAQfQ+IBG
         ZOsOQSOdno2xqwUzNT4Yfpjw0FLF2iKhACqFgN2oEh6bj23pYcIZ29DLKmTN0bzfi251
         xkPbUqQ01Q9wPsawcRTharA42C4y61Xyeui00xxbWYWX+30gbUIBvyUVQEE7SaZfOUkK
         vHFiLeme4+xBM7/8r+ensbDZ4/NqDvaXigNTfgmYuuNV3Ac7YtsullX/rF1SrUPoZoAX
         s57A==
X-Gm-Message-State: AOUpUlGthfz1WYLOrPb7AjdUaeXGtVaooaUy0mrbY0k2YFV25UUJ4pp1
        YRdKrOOX30aNPC5AC+fISVk=
X-Google-Smtp-Source: AA+uWPztrRGUYqP6MkgjpobxAQ7Pww03ceTKGq5Eyt/AdvvWfznaPl91asIzvko8e41iHyJrxYu78Q==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10-v6mr533319plb.160.1534630104000;
        Sat, 18 Aug 2018 15:08:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c4-v6sm9898002pfb.71.2018.08.18.15.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:08:23 -0700 (PDT)
Date:   Sat, 18 Aug 2018 15:08:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180818220821.GC144170@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818054300.GB241538@aiede.svl.corp.google.com>
 <874lfrrhfp.fsf@evledraar.gmail.com>
 <20180818204243.GA136983@aiede.svl.corp.google.com>
 <8736vbqr2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736vbqr2p.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> The reason I can drop a "git-whatever" in my $PATH and invoke it as "git
> whatever" is just a historical accident of how git was implemented.

No.  This is a very deliberate design decision, to allow people to
prototype new Git commands (and to create the kind of ecosystem that
allows commands to be implemented outside Git.

[...]
> So we don't get to say "you never asked us about git-annex, we're using
> that name now" without considering how widely used it is. It's us who
> decided to expose the API of seamlessly integrating 3rd party tools.

I think we're talking past each other.  I haven't proposed any blanket
policy.  I'm saying that "git bug" is a bad name for this tool:

 - it's hard to find with search engines
 - it conflicts with some likely good future changes to Git
 - it assumes that no one else will have some other refinement of the
   Git bugtracker concept, that it is the only "git bug" tool

It's a namespace grab.  There's nothing stopping someone from naming a
command "bug", either, but that doesn't make it a good idea.  (I'm not
saying that was the intent --- that's just the effect.)

Meanwhile it looks like a neat tool, and I'm very supportive of the
idea.  But you certainly still have not convinced me that the name is
a good idea, or that I shouldn't be bringing this up.

I'm not sure *what* you're trying to convince me of, actually.

Jonathan
