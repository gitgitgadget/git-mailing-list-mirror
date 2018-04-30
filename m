Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56E4215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeD3WY5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:24:57 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36908 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeD3WY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:24:57 -0400
Received: by mail-lf0-f47.google.com with SMTP id b23-v6so14239060lfg.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wFRhXuNjzZb8It2+EJ9L8zwKbIw+bcXsNk9npNJ3+Zk=;
        b=Krp6laoa8mqOuzTw8F6+0VAHaMBUABflmWjB23gEIC3syvhQ5TejkdivPxDe3NTOqx
         jxk0++vkcpHVe4qxiFn4oxxRHXYMol8YLuMLfWNlczAW51XywEl9PdOTl0yPwM4UaTTV
         fmnlqcAthe4ZM+ZvkfpWK6KULyYabJVIKG2E4Gg5NJ5Oxaz2F/pSOBX+tLHDFqlKRAAs
         rnlIFFaMSp8afGDoF/Q5y7hqN7/cmW+dmXKqhMPcHEXT2AEokUQ/QDbShm5lwIKwqr/S
         P0aAYddxrqbBA/a5Wp40TUrXbRWb6fhjff7E4xR8APfxFpADk6FLHjPtNpm8v8yg5idI
         vojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFRhXuNjzZb8It2+EJ9L8zwKbIw+bcXsNk9npNJ3+Zk=;
        b=fff2PdF57wLBw7IgytCc1TzNgIQhnmyThV4nQ3VSULWKQ7iu8+pkxnLmMYzQAWGDsa
         F2WzWRLLzcQpsIX/m5EOqFn/PIgDaRCmxGjH7NrgRInLOlv4UrqE5jaRFpe7d+DIKshK
         o4dAlEpLiek1zuGXCQdVMv/hB7jqwYUo2Ro5OsoQcxB6JaJI093eFxg+oJRrFdqez2Yq
         iyZBg5mSuUuRs2h1JU3jo4+Rfy6MD9OySXXHkI/Lmz6R7kPb/xl4m37v4ti6uFTrqm0y
         OZLL7rPc2n3oGXELjCnhhnrRxghKTTx/EJS5qjTrpDVpUjtEcOoyvvqtO6L5xrIWqXqO
         L9cw==
X-Gm-Message-State: ALQs6tBqvQ4e25NUQCcoCG4swoTtJRRfviaAR/WlK/0M6JcWXCqZ00A8
        Jn6E7nsBfsS+5a5LcbyY84ttnIc8OhqOYYfCADM=
X-Google-Smtp-Source: AB8JxZqS4cenna/r+UTTvGCWdMGS2DWhvONN0+KK3FxSb8d1YeuJrl+xIELiOb91o1B0wN5gzJCNHypyRkdD6vrK4IQ=
X-Received: by 2002:a2e:1082:: with SMTP id 2-v6mr8987689ljq.9.1525127095604;
 Mon, 30 Apr 2018 15:24:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.146.199 with HTTP; Mon, 30 Apr 2018 15:24:35 -0700 (PDT)
In-Reply-To: <87d0ygz66w.fsf@evledraar.gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com> <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
 <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com>
 <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com> <87d0ygz66w.fsf@evledraar.gmail.com>
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Mon, 30 Apr 2018 18:24:35 -0400
Message-ID: <CAHqTa-37QHYyhDrvP+vrQw_xdGLhMoXfGsMobnXNk7b-Zs=dUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 6:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Pretty clear it's garbage data, unless we're to believe that the
> relative interest of submodules in the US, Germany and Sweden is 51, 64
> & 84, but 75, 100 and 0 for subtree.

Oh yeah, Swedish people hate git-subtree.  Nobody knows why.

Avery
