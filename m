Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8821F42D
	for <e@80x24.org>; Wed, 23 May 2018 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbeEWTMr (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 15:12:47 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35738 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbeEWTMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 15:12:47 -0400
Received: by mail-ot0-f196.google.com with SMTP id h8-v6so26522778otb.2
        for <git@vger.kernel.org>; Wed, 23 May 2018 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W3Lz+Ezy0+h/KLFjdIr8sYer+NMs5p9GBB/4YMIdi7Y=;
        b=f0a2hTpta8zRnCS9rI3OlSReCNOCjVU7o6lTjoRRjIioBqSyiknkA0/drRsG7B5dPk
         NWfajGoBc23sicu/Wdwj2m6lbI79vKZau3WanRoa6hZ7lodpUY1ie9pxGvIC0BdaEGu7
         LO8vSPVP1OO2kM/FnVZ+JaA89bnojfonwj+Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W3Lz+Ezy0+h/KLFjdIr8sYer+NMs5p9GBB/4YMIdi7Y=;
        b=Q6hnwn1dLVrRtXTNIhcU3Q6CPi6nnkZ31Jwu46L617ThbIJ9Ix0lSLhsFmfQ6BRi3k
         CmWpnETCrfPiO9xtUavZ5fNnfNMQ3mk+O6zIWIF4qtBrnYv/uJ3WRgkzshS2VDK+51/b
         h0fGKSPtykbxFG5zX0Zw4M3vrZEs0Xd56T2n45x/6aENmQSR65U4AJLcGlD1rNFsygQe
         2ainikmwgOPemg9qDPWbek2F/CwKD3VkSX2VPG+5uWWUzgwEcOXrI3DB8dwz5+jhuifm
         ubADSx8cwKwN4FJVb3NyS7FmLxnW3gUSCTgPfD5kRhxAY5BNdU3xScK3oKv9Tlt+HnLS
         7Wuw==
X-Gm-Message-State: ALKqPweRRzuogPzrUSUF0GORphw2gZWqR1hS2aU7XsejI25T/0MpShgG
        bNZhynCuUbq4/BTl9fPBRFGKCWJhe/9CmqZKLcrZZg==
X-Google-Smtp-Source: AB8JxZqYm3O5XFQXrQ2Q/OPzed+2wEq60BTZ13f5ConfSKUqhcFvbrA6/bhyu5gQi1fZzxfKerP9j+Wz5eq7qtoUk4w=
X-Received: by 2002:a9d:7259:: with SMTP id a25-v6mr2698190otk.267.1527102766542;
 Wed, 23 May 2018 12:12:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Wed, 23 May 2018 12:12:45
 -0700 (PDT)
In-Reply-To: <BYAPR08MB38451D101964D3B4D10436EBDA6B0@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <20180522084109.29787-1-luke@diamand.org> <20180522084109.29787-2-luke@diamand.org>
 <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
 <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>
 <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com> <BYAPR08MB38451D101964D3B4D10436EBDA6B0@BYAPR08MB3845.namprd08.prod.outlook.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 23 May 2018 20:12:45 +0100
Message-ID: <CAE5ih79RoyA87gsb8PTOz9n1niTU5tDM_WkzbpFADS1d00h8eQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of rev==none
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 May 2018 at 17:41, Mazo, Andrey <amazo@checkvideo.com> wrote:
>> The last one (i.e. "even if it is verbose, if fileSize is not
>> reported, do not write the verbose output") does not look like it is
>> limited to the unshelve feature, so it might, even though it is a
>> one-liner, deserve to be a separate preparatory patch if you want.
>> But I do not feel strongly about either way.
>
> This was actually discussed in a separate thread [1] some time ago with patches proposed by Thandesha and me.
> I haven't yet got time to cook a final patch, which addresses both Thandesha's and mine use-cases though,
> so this wasn't submitted to Junio yet.
> In the meantime, I guess, one of the patches [2] from that thread can be taken as is.
>
> [1] "[BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key"
>       https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com/t/#mee2ec50a40242089741f808f06214a44278055b3
> [2] "[PATCH 1/1] git-p4: fix `sync --verbose` traceback due to 'fileSize'"
>       https://public-inbox.org/git/2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com/

Should I re-roll my patch without this change then?

Luke
