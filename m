Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985CA1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 05:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbeHSIMD (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 04:12:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43657 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeHSIMD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 04:12:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so5507376plv.10
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKx1yxb+9wWdgSJ5LSAZx0/AM1UKsw++ecuUhLD9Gx8=;
        b=bQA9pfAuBe9ec9mtSu1Dy9DZUazcYLnbUmMOp7k7sIeVYCspDkDyG4QBfVwTKZfJ4f
         q25hIoW5PxlAp+KpDk6RYfoVvI2D3GspunRq8ERlrtcpWfDDyXkWMUpAJSad1MQ+YtWf
         LMCzzWnwWbqLMGMB+1VyIqUY2NKIehKYGzvKEeOg90uKUy4f5y8NfanvSNOE8OxYywEy
         ou+A/ODO2S6RemcjX19XRxgxSNhjZKhq7TKjV7gCpRM7XMHge3ZgIVwBsml1xze+/2pE
         PfhRHThXRjJuvasHPGP+DfzYNBtqo4VkWlm9AsEO31J4SxMCEnubZFXq/QquRwYjo3aF
         ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKx1yxb+9wWdgSJ5LSAZx0/AM1UKsw++ecuUhLD9Gx8=;
        b=uTZAdTZHYOMOo2uVFlf8GmAigEYxkrASLTDRbqfDskeF2NL7qRKBMVjmZNiq7PI+PA
         +LtGtN2msFObF8cTHvrW9jy5TElYM4UIyED4qhZ46exoM+b5kj/aVMkcCswyH9vw/GSQ
         Y8iEyFejlBLHVTlbwXGaCvklKwS0S2mugrDwO9jEwho5DQHuM8MnHrrCvwBAy8EL0oI5
         YK22tdoVX1/tMOFIe8VFHEbwpph71eqHbRiNznk7ZHpmzfcaCUHbpN0mVa08uZVMmSFJ
         gn4Aj96L4pfx5qkI+YndIvK8yAxRjuw3cOiCsWyyRj1xgqATZrDoT7M1qx1YefbmYtj1
         m3qQ==
X-Gm-Message-State: AOUpUlFbw9kLmH4rIb8skkDKuAJW1sJRVu9NUlXnfjiNoAoeAXpCvhtw
        swPH6r5BH12AkD+aHDEp508=
X-Google-Smtp-Source: AA+uWPwx6scvOutxf3cozTzM2ZBHe1zteEdmNnCySomoufiyWsRnpuFUlxvpZvE0lClXowHEzPXAAQ==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12-v6mr3828058plo.94.1534654910881;
        Sat, 18 Aug 2018 22:01:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d132-v6sm10493287pgc.93.2018.08.18.22.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 22:01:50 -0700 (PDT)
Date:   Sat, 18 Aug 2018 22:01:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>,
        git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Matthias Beyer <mail@beyermatthias.de>,
        Julian Ganz <neither@nut.email>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180819050147.GA207351@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <xmqq6007abmu.fsf@gitster-ct.c.googlers.com>
 <20180819012748.GA175033@aiede.svl.corp.google.com>
 <87y3d3m2e4.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3d3m2e4.fsf@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+ git-dit authors)
Kyle Meyer wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I believe you're thinking of TicGit[1].
>>
>> Some other related work is listed at [2].  Most of these projects have
>> gone quiet:
>>
>> - ditz[3]
>> - git-issues[4]
>> - cil[5]
>> - Bugs Everywhere[6]
>> - milli by Steve Kemp, which I haven't found a copy of
>> - simple defects[7]
>> - kipling[8]
>
> To add to that list: There's also BuGit [1,2], though it too seems to
> have gone quiet.

I just found a good list on a non Git-specific wiki[3] that is more
helpful (more up to date and has more discussion) than the list on the
Git wiki.

It might be a good place to coordinate and compare notes.  git-dit[4]
in particular seems to have very similar goals and a similar data
model.  In my ideal world there may be a path forward that involves
working more closely together.

Thanks,
Jonathan

> [1]: https://gitlab.com/monnier/bugit
> [2]: https://public-inbox.org/git/jwva8psr6vr.fsf-monnier+gmane.comp.version-control.git@gnu.org/
[3] https://dist-bugs.branchable.com/software/
[4] https://github.com/neithernut/git-dit
