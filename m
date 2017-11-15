Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC10201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759742AbdKOVkt (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 16:40:49 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44299 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759569AbdKOVi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 16:38:27 -0500
Received: by mail-oi0-f43.google.com with SMTP id a75so11423324oib.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=091Dstou/osroT7mcKqNtguWo2AhLIUBde+yCdX9mDI=;
        b=B60zoYP3WTb/Ul5RSF0qMQJxTs6XHMCMDGU1tnJRNm7/lx96dhxI0XTilojqS16Uy0
         WLdfNW+O2iq30gsvtKAJRMIbbV1vxrMpGyiG2b8EhLydu3nHXE9MyjHtnvqkUxn2hS6a
         tukCUBAwX69JrxUQbKho52KLFWiDx2NR+cHZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=091Dstou/osroT7mcKqNtguWo2AhLIUBde+yCdX9mDI=;
        b=kPfUyVEV9rEF3wXE//6kJzBWmnGW+vYEoJ3A2YDd54ZctgMSH9mqv3bqfOc9u7EuBL
         HcbdaqOQ7kit4zGxaN1UzwKeQt9dlak836bFrtUJd1CKZBDuxSBNKtBX1TPMJ3YzmbE3
         /lPD8RXG56hK7Jz47pMoN+//omd+LOGUM0yGarBSwblZyW2V6/vuVMvRHNsu2DE/X221
         dUQZPDWU5Kda+um+OoHld8NaQ4NoBrZbWcgXoHVeKoY5PiDZo7U/z/LPrNofPOkULyAR
         kVc7IpMS4YvhapJNoVPEV2m8QRh7lu3C1Lw6lPFY7iIFXltC+Hp50FJZvHpRBADvobm8
         M+LA==
X-Gm-Message-State: AJaThX5j1JVHbuoAWDxnl1TRp5/MAodGfr1UC5+WfqbszrgIP3gHczMx
        zbkdXkh0T+gmXTD0JsQBZdnfFkinZZuoFta6izr6IQ==
X-Google-Smtp-Source: AGs4zMZwpgkdPOf9dIffp4m7aMzJZphT8K1L9KVxLQ2czELGaPalKi14JZ3csvPY5sWvvmMD4Q1TRQPYYmvir5jucQ4=
X-Received: by 10.202.63.214 with SMTP id m205mr10564933oia.137.1510781907018;
 Wed, 15 Nov 2017 13:38:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.236 with HTTP; Wed, 15 Nov 2017 13:38:26 -0800 (PST)
In-Reply-To: <CAGZ79kZrZckX=xTgTH4cMper6BPAQ-_LT_x721SBEBB+Ks06jw@mail.gmail.com>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
 <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com> <CAGZ79kZrZckX=xTgTH4cMper6BPAQ-_LT_x721SBEBB+Ks06jw@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 15 Nov 2017 21:38:26 +0000
Message-ID: <CAE5ih79TojvBv4OZnHejm3Huypg=6KVmDqJURGN+uk+izkH0xw@mail.gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Jeff King

On 13 November 2017 at 22:15, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Nov 13, 2017 at 2:03 PM, Luke Diamand <luke@diamand.org> wrote:
>> On 13 November 2017 at 19:51, Luke Diamand <luke@diamand.org> wrote:
>>> Hi!
>>>
>>> I think there may be a regression caused by this change which means
>>> that "git fetch origin" doesn't work:
>>>
>>> commit d0c39a49ccb5dfe7feba4325c3374d99ab123c59 (refs/bisect/bad)
>>> Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>> Date:   Wed Aug 23 19:36:59 2017 +0700
>>>
>>>     revision.c: --all adds HEAD from all worktrees
>>>
>>> $ git fetch origin
>>> fatal: bad object HEAD
>>> error: ssh://my_remote_host/reponame did not send all necessary objects
>>>
>>> I used git bisect to find the problem, and it seems pretty consistent.
>>> "git fetch" with the previous revision works fine.
>>>
>>> FWIW, I've got a lot of git worktrees associated with this repo, so
>>> that may be why it's failing. The remote repo is actually a git-p4
>>> clone, so HEAD there actually ends up pointing at
>>> refs/remote/p4/master.
>>>
>>> Thanks,
>>> Luke
>>
>> Quite a few of the worktrees have expired - their head revision has
>> been GC'd and no longer points to anything sensible
>> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
>> bails out if there's an error, which I think is the problem. I wonder
>> if it should instead just report something and then keep going.
>
> Also see
> https://public-inbox.org/git/CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nve=
eBrihiw@mail.gmail.com/

So is this a bug or user error on my part?

Surely at the very least "git fetch" shouldn't give a cryptic error
message just because one of my git worktrees has expired!
