Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C3E1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 18:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755317AbdDFSsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 14:48:39 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36058 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdDFSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 14:48:37 -0400
Received: by mail-pg0-f48.google.com with SMTP id g2so42999265pge.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xeBNqtt8fjc3y/TuCXT42YH5VDzkwOK4vC2HM/itL8c=;
        b=Gmqns9Gea6QQap5C9+0tHO849sNthQJfhYl6FrZleAKl6ljoqzahQMxsZp5IytVaEY
         G5aarYPsMK8rb++R89Xp70s57TwyIgG6cj5Y06CI79J+QwsmlytQHYZj5w9cBqMc2Gx2
         /cndFdqYF4i48LLSLznFFA5TQKv0q2RZ+1cl030c4L5LSiKycdXKvBFSaCp8/cpL3zJy
         6ZFS2bIVmM9TcEBEC91sCsRLg8354NB3yRgbsnnja/U92DcqqDvarKtXVJHY3hXfJ4It
         1iEE+lvlr0mG3qY5ce0f6Hix/0PTloBdiygrXofRMhEM7CkQaUWYh7VklTLfxh6Jheyy
         KYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xeBNqtt8fjc3y/TuCXT42YH5VDzkwOK4vC2HM/itL8c=;
        b=l5/x7303UFDi4AAaILjZ8Nbj6Ju+IWz54tEJCUnNBEiT36cuBBnoGMbGK3B1j3TUde
         moNTlYXvmaOssiUVNJfigcK1Ph0Scyaug2ygcjU5Jc5L1OWfKyDHkrseE+BrXPIvcT5L
         LLVNVPTxHa/veGbbU206wnPZJUZehVTgDPI+DOZ27zxDpIPBUMM3u+yK8dsYGg7irFbW
         XNVjIjANBM3prxnL1denzjebhXHTnKYgKDXWifNxTvQj2MXl9baB6s5q8fRAgH0S3HSC
         H5zJvRVlDbIg+lY46ltGpR3AwMtiwmgoJiXpX37C6rXLZuJcNuaFZUH2P1gQqlMzLINd
         cQFA==
X-Gm-Message-State: AFeK/H0o5u1gdWA2W1AQEk9FNhwUuT61pLqX1gOwKPRaF7tIp0BJxHGsj7pYbW1kY3lxfheRN0t4n0InEbbECW9C
X-Received: by 10.99.137.66 with SMTP id v63mr37745244pgd.183.1491504516377;
 Thu, 06 Apr 2017 11:48:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 6 Apr 2017 11:48:35 -0700 (PDT)
In-Reply-To: <CACBZZX7xA92e5n=E8fdGHiBHaqzRjP_MVWsaE2v=DcVmCO2r0w@mail.gmail.com>
References: <955c152a-b278-ecfd-8bc7-671c3aa81dc6@ricozome.net> <CACBZZX7xA92e5n=E8fdGHiBHaqzRjP_MVWsaE2v=DcVmCO2r0w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Apr 2017 11:48:35 -0700
Message-ID: <CAGZ79kYByeaX0qhRhy0RDq5hvuyEhhDcgWS7GABi6Nr+k-Ekdw@mail.gmail.com>
Subject: Re: how-to get commit content with pre-receive hook ?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Belhomme <rico-ml@ricozome.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>
>> But I don't know how to get the *content* of the file being submitted to run
>> my syntax check rules against it !
>>

>     git log -p <old>..<new>
>     git diff <old>..<new>

or in case of the tool requiring a full worktree

    mkdir /tmp/test
    GIT_WORKTREE=/tmp/test git checkout -f <new>
    and then perform the check on that full tree?
