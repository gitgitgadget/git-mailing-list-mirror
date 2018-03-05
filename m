Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7761C1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 12:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeCEMQe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 07:16:34 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35568 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbeCEMQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 07:16:33 -0500
Received: by mail-oi0-f67.google.com with SMTP id x10so11843739oig.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 04:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vBtK70qpNbyjEKeefQQmLcy+OGj0+J9Ou8VRuo78kmE=;
        b=liSanPN5o0X2imnZjazdM9RTcS7eOHm0P9dijAH6bl8rjVUqxbxAdfRj3dH2e2LMgw
         /XTGcWMh8zuWMgcZ1/7A4eTQf+MPBLknPdDg/WfsEw0rRJorsk1eoUAIoNR96/e+Avpy
         v9qM0UhnSWW2AEAV1qDRJb/xboDQyG9HGgF7RC/h4RJiAPXQmNElKWW2W5lo7s/HMwtv
         19nPdhLvn1QEya4FBnodl1eWATb/fc3JyVxrCABlOd3Gc3yvLVucBWy+7sE12nsp8M4D
         j5zo1kDKhLGVelQrkrNskSnu3UyH6EloIC/S9eWcTTVY+6tzQ/slvw2dQCqdejGjOBmL
         pKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vBtK70qpNbyjEKeefQQmLcy+OGj0+J9Ou8VRuo78kmE=;
        b=fNwNbYi6Qvd5w1ZWQp6Uj4uVj2R7w313hUtgL/gj/oevVbYDb4zgua+Z6o+vmTnHaR
         byHsBmhx5lGL5vBLIP9HEnLjW4122NaqjmbmBHJFT/ntm2WLt2vE5pFJqz4BH3mnJsiN
         XOt7CtOvhH2EaodUyRawRgDpiLuChyQCWbFVaWvsM6nukyR02pZX0jeNOFgA25VHfnCi
         xNgrUr0fxuvvfr4HIngYw+wKGjNKCZ5n0lPmKE7+nIDz+seUZCUYQ0jV5tERFVyuK1am
         HyR52mjndEvQsV3oxzmvg1e3KOy4k1JtrMWLxxCvetbVw/ZvlklgpVYF1t3sJJRzPMRt
         zFvQ==
X-Gm-Message-State: AElRT7GmcuSaf50fCgmm8hVkN7gTFIdWpefCObYBZaEdXbpdEPs7bhlu
        CDDhRh76n+4s7ya1nKgBFtusnYUNYSG7K0IslRk=
X-Google-Smtp-Source: AG47ELtaI3fRFW+f73Il7yosMSje3GnJE9I84kKMGtXK2GIGt6wDTaU5z5SRtzycGU767JuNQ4knxnnqEfqx7+rSxFU=
X-Received: by 10.202.212.147 with SMTP id l141mr9885378oig.32.1520252192453;
 Mon, 05 Mar 2018 04:16:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 5 Mar 2018 04:16:02 -0800 (PST)
In-Reply-To: <002601d3b2fa$ff6df240$fe49d6c0$@nexbridge.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <002601d3b2fa$ff6df240$fe49d6c0$@nexbridge.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Mar 2018 19:16:02 +0700
Message-ID: <CACsJy8BvJPpR9hNcBoTze2fDhgWJ4Ya3u9YG5uNY8nu4_qRsVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] git worktree prune improvements
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 9:21 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On March 2, 2018 10:39 PM, Nguy?n Th=C3=A1i Ng?c Duy wrote:
>> This is something we could do to improve the situation when a user manua=
lly
>> moves a worktree and not follow the update process (we have had the firs=
t
>> reported case [1]). Plus a bit cleanup in gc.
>>
>> I think this is something we should do until we somehow make the user
>> aware that the worktree is broken as soon as they move a worktree
>> manually. But there's some more work to get there.
>>
>> [1] http://public-inbox.org/git/%3Caa98f187-4b1a-176d-2a1b-
>> 826c995776cd@aegee.org%3E
>
> I wonder whether the OT thread discussion about branch annotation may hav=
e some value here. For some repositories I manage, I have received question=
s about whether there was some way to know that a branch in the clone was a=
ssociated with a worktree "at any point in the past", which, once the workt=
ree has been pruned, is not derivable in a formal computational sense - the=
re may be specific conditions where it is. Perhaps, if that line of develop=
ment moves forward, that we should considering annotating the worktree-crea=
ted branch to help with our pruning process and to identify where the branc=
h originated.
>

I think for pruning, we already have that information. If a branch is
associated to a worktree, its HEAD must say so and we must not prune
anything reachable from _any_ HEAD. I made that mistake actually.
Still in process of fixing it (and fsck).
--=20
Duy
