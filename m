Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE97C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 17:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeH1VK3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 17:10:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43060 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1VK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 17:10:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so993178pfi.10
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tz1+Z6bIrFpY+wovBntvhQ/yZT/hNeivSEAWJIJYxTU=;
        b=eEO4m9Y7Fgd630MDCU9fS1ziNNwvznH7aBhr2l/ZoNS1yUOfgUaaSTcoMhUCHtnAVw
         IeZMcngEYTMgZB+Nn9sY/i86/R+pzVpHphBqHK49pHOD8pcSyUDVE3ViknjHU2CW/zAz
         E7RNl8lg/EDqoRyt1gZ5edBSKKX4XovA0yGuRBjJVC5/HnRNd/EUOKt2TVuxgKQMrtm0
         gUUxmVdYimGysFn/KD74O2Xj5LOoZGE+j5mbytQ3LOIPGO5/oQYjZIRNLnewDENSd6dL
         d5tZer5zBdZ+bPD3w8huDKpsFNYlI8BgSxL4GwjcKiDk9bEJU77NRpTB3vWXWX2nUZTr
         dZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tz1+Z6bIrFpY+wovBntvhQ/yZT/hNeivSEAWJIJYxTU=;
        b=N8J76ci7ZaMmvIwyJjEepgmGr4MMm9zepHu2igQM316B435aNQ4F4QGi/X6G3HhpSO
         yKlvn1O+iPmrJekOKVOABDQ3NsA1z4SSJ5+EycnkniodAzGHjuchNvb60oBwy/YMrbt4
         SLZBoSaUS1yjylvCeEqbVYqA26BexiI9KNNrpGhZXq3hQcbuRj5znGFG9DG80bZFNDKJ
         CsNigmMmkttNWp16u/jvCKuTKXqWU+kMoZK7Al/AR5vhyxkjKlQ6gHOZcKpnry5Jyj2Q
         ZltD73oHH5C5rxXpFMiYeTWt8j/TNNWSxd5xIILU+LUf+apAT1hv98mGDf83vBf+1DK9
         K5Fg==
X-Gm-Message-State: APzg51CoBtjh3ZtSmkaHkRcktOf+6m+7bOuJzDYxCKTYD/5/g25EJkq4
        YVCrovnxxFzc3nh6m5bruLY=
X-Google-Smtp-Source: ANB0VdYpkfEWRJwFobHor1oheDwmcJZMNfYxauxJYlDDWMTW4tRhCmGOykf1Rw1PYnIe2ZuBAmfsPQ==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr2462676pgn.0.1535476670911;
        Tue, 28 Aug 2018 10:17:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d2-v6sm2563478pfg.172.2018.08.28.10.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:17:50 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:17:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin
 interactive rebase
Message-ID: <20180828171748.GC23314@aiede.svl.corp.google.com>
References: <pull.23.git.gitgitgadget@gmail.com>
 <20180823024856.GH92374@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet>
 <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Mon, 27 Aug 2018, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> Jonathan Nieder wrote:

>>>> Please include this information in the commit message.  It's super
>>>> helpful to find this kind of information about why a patch does what
>>>> it does when encountering a patch later "in the wild" (in git log -S
>>>> output).
[...]
>> I think what Jonathan finds helpful is the other half of the story
>
> I will await Jonathan's clarification.

Junio's understanding is correct.

More generally, I greatly appreciate the kind of motivation and
backstory that you write in cover letters, and I wish that more of
that would find its way into the commit messages instead.  Really I
wish (and don't take this the wrong way --- I am not asking you to
write it unless it's your own itch) that GitGitGadget would put the
cover letter in single-patch series after the "---" line in the
individual patches, since that would make it easier for reviewers to
point out what content from the cover letter would be useful to add to
the commit message.

That said, this is minor and not a reason to reroll this patch.  It was
more that I wanted to give the hint for later patches.

Thanks much and hope that helps,
Jonathan
