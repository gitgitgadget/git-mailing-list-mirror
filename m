Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8BD1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 11:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeIMQgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 12:36:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34342 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeIMQgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 12:36:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so4349798eds.1
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5C376MGtCLVSddQnkwsnmSTMlhxYIW53n+d9i8/oulI=;
        b=O+uQvJs0ORZcwQz0eaPpnNgabtCqIhhqKjguVMHlsizacwVIqD6maS4bwldG75P2KU
         wBpvTdpY3RHjLM+xMnjYYzQ9oBtnFiSZNJN4m2rdMPohjNFgKrmcBkAMi2vsPhDmGlTQ
         eR0bHqO4jnqYI2LEXiAy9iqh8+UNjIQyZc8S0VoQnqGxyQCY6zAk0h/wul0dGuZCRDi1
         ryh0ouL/0jjoH+EqzJTV5TlCYQLk3mepFRNSGMERJZG3sgLGKZjK+S6vEKgx2sufBa1a
         uvQaORAGdr2Qw78voP0gMqgWkkNubfMgb2AksXAj8qVHEFjn2kmK58Ekv6aPLSoCKvk2
         EmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5C376MGtCLVSddQnkwsnmSTMlhxYIW53n+d9i8/oulI=;
        b=g+vCTBpX1GmWj+Xy37pkAOMb+7/iD21bMWpfkqkb9xh88AOEN1aMj4EM/LXj6qYoWT
         69NbotFrgkosF3BwSNxWFrK8AuvWuR1yQqPrAYkP4im3+OQnpFVNuT0ERC5ZOuriA1oR
         eiD+DNoUbJq6XYWr06x9Zz1cwGQNiGH1o8dr5dmGRzNwVK1GFzF5Qj0MzWRHvU34FKft
         BATQZ0O26QXATcN0L/sasteG8WhZrMf5Q1hv0EGZqoptjjQcLqei5DM22XKSTGj9izyj
         0I7zqwzbRSXVIgdf0nzNILijTFixp4iY3hslWjPngAfY6JKPPy+4A3kgsPvFTAQiSVY9
         X5jA==
X-Gm-Message-State: APzg51BDT0UkKaYAhtasHpPlSYeun0BHPcobwXp1IJi+Ar7K7kOveiW+
        14L0fOu5TMI+0yNOOL9cqGTY0Do8qsU=
X-Google-Smtp-Source: ANB0VdYtRZcQqZcZM3nB/WrdACW/c/4az1i52C86lPtpvpxoPagyMBKyJXn8WVPxtooR0h3N7nfRsA==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr10427904ede.273.1536838036834;
        Thu, 13 Sep 2018 04:27:16 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id o22-v6sm4540382edc.90.2018.09.13.04.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 04:27:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: with git 1.8.3.1 get only merged tags
References: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
Date:   Thu, 13 Sep 2018 13:27:15 +0200
Message-ID: <87lg85ljsc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 11 2018, Michal Novotny wrote:

> I need to emulate git tag --merged with very old git 1.8.3.1. Is that
> somehow possible?
> I am looking for a bash function that would take what git 1.8.3.1
> offers and return only the tags accessible from the current branch

Jeff answer the question you had, but I just have one of my own: Is
RedHat stuck on 1.8-era git in some release it's still maintaining, does
this mean that e.g. you're still backporting security fixes to this
2012-era release?
