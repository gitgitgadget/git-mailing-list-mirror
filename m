Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738AE1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdHVWK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:10:58 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35178 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdHVWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:10:57 -0400
Received: by mail-oi0-f43.google.com with SMTP id r200so516839oie.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C9AjXP0Dx3iwoF6FSXHOvb+eCFy0TNItgzWgT+3XKRo=;
        b=PtJr1DqEZufrVLHhiOtJu7xpeZCTb+Ni3ABocmVD0y+6wjvfbnDTYpQXgIx8wvWHU4
         m0AVFVN961vyzfKIwDfWjoJWUAbHLvY94itUDDWq0FXG7271al2OnaFMTL4Otv5f0vM1
         0QT7pUAkpNqe//jheFSrYJkAJJByDN1xiUnlWERe+UwnfkhGcJs8lD88fajqQhC8+Toj
         DdlH0CkD7e6+neaE9yTWbonQxN/DztG2lJyFNb0lcKU5qHwSyRY39zXguNJcuY78RbnA
         sI3JbcBSneo6MiuT0YsCbhiUFBitQYF+YnUPYiAuMxrRw9S9WWyH8+57UhFy9eht94DM
         24Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=C9AjXP0Dx3iwoF6FSXHOvb+eCFy0TNItgzWgT+3XKRo=;
        b=jeZ3BTtb23HihMkDKbtV3La+raxCz43M3kZXLF8GDlS6M3HGaeklUqpLMWEfElcwLG
         EFY3htEnJXAMG/eDB05/RQgsz+fbo8bdbJ+oC4jbtppgB9J6DxEmr/UGNBwdRogq5tWV
         ZnOpwR7Y1QwGGaqjARy1be7amQKtoM67sufJYtSNDv2GPZq+7Yb3ECflAOPjzuDxY1PL
         /P6BeW454rrRQxb1sBmCsknsIRCnr371QeT+D5Jug+AKh0SpahmZyv/ECVV2PC6kgnwR
         YRDYax2yshNeMR8VQWN91GDISDaTHxeWMSF8yIWtWgB9/rekX59HC6LONkb2iv/t6Ggm
         rrgA==
X-Gm-Message-State: AHYfb5g30hKURV26MCkcDyvhK6LZfE3pJ7msjYk/T4VSo+ViKuKPnAEp
        FXrt83miCdmZaK8vqyq5PWiHtXgQJWo3grs=
X-Received: by 10.202.63.85 with SMTP id m82mr887540oia.113.1503439856819;
 Tue, 22 Aug 2017 15:10:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Tue, 22 Aug 2017 15:10:56 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
 <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com> <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 22 Aug 2017 18:10:56 -0400
Message-ID: <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
Subject: Re: How to force a push to succeed?
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 6:03 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> On Tue, Aug 22, 2017 at 5:57 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Aug 22, 2017 at 2:55 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>>> I tested some changes that lead to a dead end. The changes need to be
>>> removed. The changes were added in 7 commits.
>>>
>>> I went back in time to the point before the changes:
>>>
>>>     $ git reset --hard HEAD~7
>>>     HEAD is now at 559fc3b Fix benchmark selection code (GH #464)
>>>
>>> When I attempted to push:
>>>
>>>     $ git push
>>>     Username for 'https://github.com': noloader
>>>     To https://github.com/noloader/cryptopp.git
>>>      ! [rejected]        master -> master (non-fast-forward)
>>>
>>> I tried to commit, but Git claims there's nothing to add:
>>>
>>>     $ git commit
>>>     On branch master
>>>     Your branch is behind 'origin/master' by 7 commits, and can be
>>> fast-forwarded.
>>>
>>> Commit seems to be the wrong command as Git appears to be trying to do
>>> something I don't want.
>>>
>>> How do I force the push to succeed?
>>>
>>> Thanks in advance.
>>
>> Checkout the --force[-with-lease] argument.

Thanks again Stefan,

From another testing machine, it looks like the changes have not been
backed out. The previous operation un-did the ADX gear because it was
an evolutionary dead-end.

via$ git pull
From https://github.com/noloader/cryptopp
 + 66654dd...559fc3b master     -> origin/master  (forced update)
Already up-to-date.
via:$ cat integer.cpp | grep ADX
#if defined(CRYPTOPP_ADX_AVAILABLE)
# define CRYPTOPP_INTEGER_ADX 1
#if CRYPTOPP_INTEGER_SSE2 || CRYPTOPP_INTEGER_ADX
#if CRYPTOPP_INTEGER_ADX
extern int CRYPTOPP_FASTCALL ADX_Add(size_t N, word *C, const word *A,
const word *B);
#if CRYPTOPP_INTEGER_ADX
        if (HasADX())
                s_pAdd = &ADX_Add;
#if CRYPTOPP_INTEGER_SSE2 || CRYPTOPP_INTEGER_ADX

Above, there should be no references to ADX. Looking at the GitHub the
changes have been applied.

Any ideas?

Jeff
