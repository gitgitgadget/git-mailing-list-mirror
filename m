Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629FB1F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 19:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHKTJI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 15:09:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44172 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHKTJI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 15:09:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so101317385otl.11
        for <git@vger.kernel.org>; Sun, 11 Aug 2019 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LtmLxEZG8UYKy7d9UwKMkKnYey4h7TTiNvWSUW9S9O4=;
        b=pG0Jg/XgApIS9i9yHYG/+ld7N0vNVDq04DxT6nkB8VgIV0xvEYxJebz99GSVSn1CGM
         99bKQ1G7nYxXUk3tlugw6D67a3THl+DDyBB8UWnoYEixwXq22KjAvaoTSl8WVL0VBozL
         HebZWDrIj+N/QUwKXNBJW5iLEE4juXLggyir40IDpTNjEIQd0vbB7PEqhEKq19VTlBVC
         GOhBSiBhNTEqly/bODtxRrE95jFjVJFeZOelnBSZs4jRO8GcrxfuLcnsuAHbM66UlUc9
         y7qpHP6Abn464d+wkWS2XvCAmuELr91uELNG44cQfbphxuKRTGXP/09r1Y+plkvkd3qj
         /D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LtmLxEZG8UYKy7d9UwKMkKnYey4h7TTiNvWSUW9S9O4=;
        b=PHC2UFnNLXxUQ63cdF95lexPLqatwYYtBpYkM8YeyfzcOXpMRP9uUKZwl05uD5Czvu
         DyVr3bXRAaQUxMWepdsCpIjPHu2eQtwW/oD0zhm/MkU1jsaBy3MKIOyzdiPh1giyW14x
         7g4MAU9nt0i6qiI/T0QK0yjOuU+m9wvUEGGaBNjNMsxZsPJPu/No8Eop0bOOenFm8ZYl
         3yxuDAc3KFYc4vW59CCjXDeZE92PeUce3s1EpS3wCnxts4oSPKrIWnaywQHe0HU/WmXq
         FbObjHwv6k/iQYXjNsh1Ek0mHHD3En37ZEKio0lU0BZrv2TKgs8x+oGgBCCO+cHdyJp+
         egig==
X-Gm-Message-State: APjAAAXMqZjwZOQmk2/5i57KJM0iCN8MoUxZpLBN3GMIBMohvCParPMj
        ME0RTCRXpj0NoTyeObZ94EZw815TsBgD2Gq3TPs=
X-Google-Smtp-Source: APXvYqyaXG/YnHYW06KYRpSFA2HpO8iVDWxQih+KtV88TWl594XCocUvmSg0FLqZ1CkkWHMggekQ0uDkkH4gh9ZXaHc=
X-Received: by 2002:a02:662f:: with SMTP id k47mr34142779jac.4.1565550546991;
 Sun, 11 Aug 2019 12:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190810220251.3684-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 11 Aug 2019 12:08:53 -0700
Message-ID: <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 11, 2019 at 4:20 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 10 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > cURL is very strict about its allocator being thread safe and so that m=
ight
> > be an issue to look for.
>
> Looks good to me.

it is not ready yet for using though, at minimum I have to fix the #ifdef
so there is no risky of breaking someone's build because they happen
to still be using and old enough cURL (ex: 7.10)

there is also the risk that xmalloc might not be sufficiently thread
safe (ex: when it triggers unuse_one_window() through the use of a
try_to_free_routine in packfile.c but we could mitigate the risk for
now by doing it only first #ifdef NED (I promise to take it out before
it even gets to next, assuming Junio would trust me enough after the
last blow up to even get it into pu)

alternatively, getting some feedback from people that know that code
better like Shawn, since I have to admit I haven't read it enough to
be fully confident it is safe (although I believe it was enough, or I
wouldn't had sent it for feedback otherwise)

> Please note that this did not cause problems in Git for Windows.
> Probably because we leave it to cURL to deallocate whatever it
> allocated.

unlike PCRE2 there is no layering violation to trigger

> Still, it is a good idea to ask libcurl to use the same allocator as Git.

and it should have a positive performance impact, which should be nice
to look for.

Carlo
