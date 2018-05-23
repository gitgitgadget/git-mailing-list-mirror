Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724C81F42D
	for <e@80x24.org>; Wed, 23 May 2018 07:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbeEWHDt (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 03:03:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37209 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754042AbeEWHDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 03:03:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id q13-v6so26771197qtp.4
        for <git@vger.kernel.org>; Wed, 23 May 2018 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kTkoEiEIHEhZxdRwsYiAFBdh8dAT+bypzS06Z2zusKw=;
        b=Eb3170XKaOurwsFw+0ZImRaSevoyeC31BriX9cceaT/BV83Si4fPXOucYunPp7tTyf
         EnyBdNBuxnXiufH7af1J8WtCP2Dg+pOk7FeRka3pB7yt9gYZ5V236apNhFoEv9Uxgr+y
         iRUjtNxjVkpRpXHAdPJk8ZvykJGEaQw5WvcqRSq96bYrAmNIGeKSIpTdcEiCnCCDM8Gq
         myDa4z8j23GXTLMz7tcKd40Ra8G6sWSRSvBEToBxyHe5w/65yVsF+r9HgHAKF4vYrAZf
         c9wPH1/0Z9daSvAtaGgZ+2ZyWuNyhXgeiDclH+sSi/q2lvAW+Xz3ztaf7ljmF+KIiWuE
         FvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kTkoEiEIHEhZxdRwsYiAFBdh8dAT+bypzS06Z2zusKw=;
        b=pbiFu80tCiWINM/uVffWmCqUj1wPb3A4bwXQG4ia9mhlhcXGld9SNKks9s4A7F9ITm
         ey9EvzxcMpNKJlTMn8A7T/JhNF6p7qhnSV712dqFs2INzS0Jot7/L/RvNwLQnF8JERrU
         eDEDTAqBPBzkH5siZWObPXCYJi4bzXyGo9WvhFOr07OKNvDBd4khRaHvk48XA2Mlj6n9
         8wpcDEnSnAEhJaiiiI3y+TgUIo99DtOxYeyeQwkmoOnOC9Y9P+kkz/B2EAm+PLfAKzBV
         2pitMk+GJKtaZ5GP1loK3ZH0ZoCqPszjrEB58MlAs5DADVa8uSKIYcEwlRQqUEV6CX40
         mZHA==
X-Gm-Message-State: ALKqPwfupvQKDgyUukEtAO20DiAlCFhHUplg/1nTIadfZ4E4NJgX9TjU
        1lQFNkHC198fDDNq+sMdhSOyLt4+HaxouIVwKBY=
X-Google-Smtp-Source: AB8JxZp+lq5Ua9a1KjR50FmULxU+vNm7vOz01rdoh/dV09/kGO6/CuV8MqCtT444NLXsR7Xycb2TDZQNQsPf6Dp4nlE=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr1508851qti.35.1527059028083;
 Wed, 23 May 2018 00:03:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 23 May 2018 00:03:47
 -0700 (PDT)
In-Reply-To: <e71b2abd7298de0123a6222186a8faa3fadf50c0.1526812503.git.martin.agren@gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com>
 <cover.1526812503.git.martin.agren@gmail.com> <e71b2abd7298de0123a6222186a8faa3fadf50c0.1526812503.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 May 2018 03:03:47 -0400
X-Google-Sender-Auth: QzMdD2pxdcy6QZ7TlOGmt3MkYWg
Message-ID: <CAPig+cSsbHXsVAzhSeah9cPsOha5dUGkxwwAYqku+K3d4p1ttQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] config: let `config_store_data_clear()` handle `key`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 6:42 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> Instead of remembering to free `key` in each code path, let
> `config_store_data_clear()` handle that.
>
> We still need to free it before replacing it, though. Move that freeing
> closer to the replacing to be safe. Note that in that same part of the
> code, we can no longer set `key` to the original pointer, but need to
> `xstrdup()` it.

That casting away of 'const' was an oddball case anyhow, so it's nice
to see it go away (even at the expense of an extra xstrdup()).

Overall, this change makes it quite a bit easier to reason about the
cleanup of 'store.key'.

Thanks.

> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
