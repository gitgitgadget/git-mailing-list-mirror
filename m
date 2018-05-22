Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A7B1F51C
	for <e@80x24.org>; Tue, 22 May 2018 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeEVPNi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 11:13:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36037 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVPNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 11:13:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id v2-v6so16525001oif.3
        for <git@vger.kernel.org>; Tue, 22 May 2018 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k25qXE2PGhOelOTFOKdg2amrBRJQSdIub3fhaFoN3aM=;
        b=kf+EkrvNPilhIf+7ByhpQAwwluq/mQr6j7UbeYZ00MXJk+vCHVhF3aVuuAB7Ej6gGG
         o83/038sCRVjC2OABGo1JAy6p4StIvhafMSDGpWDoZMloJFe16KAgGxglIswuuQaTwiC
         upaW7xMxz1eWCeJJV6nSMrVRJ7NniVU4/I658VSxLdxaGhN1BNDCrNEs3CRPy1PB41kf
         nBqffwUfttlEM9KfCxmt+1ZzuZWQVq3pOCSgH0C3ezJ2ENP2BBaq0qdv+8Bf//680Ghp
         t0TUetfQvnA+9mPtNLNm7eopt00J3tulE4i9DeF1zmd3NfYUJ6ILCSFUOGJvLvmJ8zIy
         UqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k25qXE2PGhOelOTFOKdg2amrBRJQSdIub3fhaFoN3aM=;
        b=Ych3fWJ4/7oxzfB6g6z1HPLLPPiVI+hTHv/ZNU0yD+A0PmI5eUcuQVEy/fz3j96tMe
         sBrc1mDsa99l/9vzHlkWpSEtlydbrHw00AiXSnIwtGQW8Zc3A6bA0P2c61fQuBuAZCZZ
         Mutl7+hH5rY8aVXDFUJh1R76sLeix0PAzwvV2zjy7HS4Jr38To6nCBzlOgXjnZjYZ/2B
         1hLVB6KqB6QeUDhwVY8R6BTLuVHR+J8AUhlDSSoIKbNgqvv9uK+uPt61sLw6qdJYtzye
         YVmAA3+Kx7621QstXc468JRpk4Rr/2lLDdPu+7SgUdgRlSYpkUcIDWa1dHszegqqB7Ae
         vYiA==
X-Gm-Message-State: ALKqPwfoPEzgMTODbGJOdeip/XHuDlVCJHilNT8NfBJslw+d07P8KFrW
        RAuOnZZajLJRd+5pe6vUO6zY+CimuuatLlECYNw=
X-Google-Smtp-Source: AB8JxZrqt3709FtEZJTSO0RTzBV9FRwG5iMKjIz7LHlzMJVt4xgEmFlDtgstnLExIDMfaY3S6z5kodtH24+nI3VzBYw=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr14880700oir.56.1527002017178;
 Tue, 22 May 2018 08:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 22 May 2018 08:13:06 -0700 (PDT)
In-Reply-To: <CAGZ79kZ0TBzDMqpim1Wtr9QtF2OtskE=nRPx2Nj+rwyT8HMqTw@mail.gmail.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-3-sbeller@google.com>
 <20180519063729.GA14755@duynguyen.home> <CAGZ79kbxptYvDoTqsVRe3KOA_--ja8UZir=MkMXw8_LxVXG_-Q@mail.gmail.com>
 <20180521185040.GA125693@google.com> <CAGZ79kZ0TBzDMqpim1Wtr9QtF2OtskE=nRPx2Nj+rwyT8HMqTw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 May 2018 17:13:06 +0200
Message-ID: <CACsJy8DfF+Bn94dQH2cSFfHpXqHa07vstAKrJeRhd-5EP8avWA@mail.gmail.com>
Subject: Re: [PATCH 02/11] repository: introduce repo_read_index_or_die
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Antonio Ospite <ao2@ao2.it>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 9:27 PM, Stefan Beller <sbeller@google.com> wrote:
> Hi Brandon,
>
>>> One of the reviewers of the series questioned the overall goal of the
>>> series as we want to move away from _die() in top level code but this
>>> series moves more towards it.
>>
>> I've heard every once in a while that we want to move toward this but I
>> don't believe there is an actual effort along those lines just yet.  For
>> that to be the case we would need a clearly defined error handling
>> methodology (aside from the existing "die"ing behavior), which we don't
>> currently have.
>
> We have the example in the refs code, which I would want to
> imitate. :)
>
> /*
>  * Return 0 if a reference named refname could be created without
>  * conflicting with the name of an existing reference. Otherwise,
>  * return a negative value and write an explanation to err. [...]
>  */
>
> int refs_verify_refname_available(struct ref_store *refs, ...
>     struct strbuf *err);
>
> extern int refs_init_db(struct strbuf *err);

apply.c and sequencer.c too are libified and try hard to avoid die()
if I remember correctly.

> But it is true that there is no active effort currently being pushed.

Yeah. It took a lot of work to put refs code in the current shape
today. I think we just be careful about adding die(). If a function
has no way to return an error, then die() is unavoidable. If it's a
really fatal error, then die() might still be the right choice. But if
not we should try to return an error instead.

Speaking of avoiding die() (and going off-topic again), maybe we
should introduce NO_DIE_PLEASE macro in the same spirit as
NO_THE_INDEX_COMPATIBILITY_MACROS. If the macro is defined, die() and
friends are not declared (which will result in compile errors at least
on DEVELOPER=1 builds). This helps draw boundary between die-able code
and un-die-able code (not perfect, but good enough)
-- 
Duy
