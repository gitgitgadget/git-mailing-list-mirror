Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA1A20954
	for <e@80x24.org>; Sat, 25 Nov 2017 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdKYWhb (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 17:37:31 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33832 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdKYWha (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 17:37:30 -0500
Received: by mail-vk0-f54.google.com with SMTP id t14so2940725vkc.1
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EGEMZK/6WYRVc+0v1XqgbCPUQE24ZHtKGKbMPngxgpQ=;
        b=tg5l/lk/0nJy0X4tBre/knBguDKcPX65VRRTe2QyOms+vDIuH3Xm6fT0bHK2bRJGQA
         NOm+EUpe71mMWv41oa1p2mBY3J89h9D7M2ghLBU6VjdcznOf29k48yr97S8Id6cvZyQy
         CI5BelVfz8YH3xE6Frt3mR0eGiwhR7L6h6JjGvpU1Lb+YbPSWYiJrtjJTUipIlAx4eW+
         pl6xcGQmV4OvZgOAuaxDiDNsZOdzIRxxfFltfwcjXUC6NGJg3NaS9ySdwLVYZyQwPfWH
         24B+1y986GiFImsHr6aDECuVdH98uoYhCz73RhH1wHBJot8Q2EPA5S/dkmoPnJ/ubdtU
         DH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EGEMZK/6WYRVc+0v1XqgbCPUQE24ZHtKGKbMPngxgpQ=;
        b=Uo7/wp4cDAN3TRY7pZm2wNqKA4Wk8pTYDjXeNZeEJR31SJ3rocdLdrYW2MHWlMu+A3
         XLwbjtKQAf3yy6NsCwDufxszDByUWI0kuAvSyCKUI7r9/g7iTJ/542QOjr9AdVeiE+UB
         1es1jbebTphlw8iFuIPJRF50m3RJuQYDgxWHPjMyU7sugo+tPtRQM8nZyV/eWpQwGip2
         9TFsEfR3QUZPiOVXgr5K1aHt6+o8RKeEmBVuKzYNcHn437DnsEcsNjICOUqquCKWk3YA
         ePXBP3g5Ad7beMSB6Lgd78Tdf7n6cptR3C73v3rggMLHXnH4NFsYJToOzYcBpPaUE6qH
         ZnmQ==
X-Gm-Message-State: AJaThX6m5wC4UToOz7TMd6c09u3Uu+aqj4m0bM8CkEWEO+5kLf+fAiQ1
        kCiCnCBuwOJo3S3tce+Tf35+vKU4qppFZIWB5IU=
X-Google-Smtp-Source: AGs4zMZ8w+MuEGJx4/OGlvaPaGTyf3GgD2iGqMZqa90Feke6UmJhbFCy9KoOpa5Ch2b40T+R23mubji8zM4azwT8pgg=
X-Received: by 10.31.96.65 with SMTP id u62mr25531230vkb.68.1511649449495;
 Sat, 25 Nov 2017 14:37:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Sat, 25 Nov 2017 14:37:29 -0800 (PST)
In-Reply-To: <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com> <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Nov 2017 14:37:29 -0800
Message-ID: <CABPp-BFdJr8AL3hJSSLiqwPJMt6LZcLOEcTtxz1vohEuw==wKg@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 9:13 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 14, 2017 at 10:13 AM, Stefan Beller <sbeller@google.com> wrote:

>> But this line of though might be distracting from your original point,
>> which was that we have so much to keep in mind when doing tree
>> operations (flags, D/F conflicts, now submodules too). I wonder how
>> a sensible refactoring would look like to detangle all these aspects,
>> but still keeping Git fast and not overengineered.
>
> I think given how complex a lot of these code paths are, that an
> attempt to refactor it a bit to detangle some of the mess would be
> well worth the time. I'd suspect it might make handling the more
> complex task of actually resolving conflicts to be easier, so the
> effort to clean up the code here should be worth it.

I think changing from a 4-way merge to a 3-way merge would make things
much better, as Junio outlined here:

https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/

I don't know of any way to detangle the other aspects, yet.
