Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD221F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeC1Uyn (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:54:43 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:46065 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeC1Uym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:54:42 -0400
Received: by mail-yw0-f178.google.com with SMTP id r29so1257348ywa.12
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YzD8uqc/ivBsPISM9eYTgrAPYBR/xTCctPRNLyunB6Q=;
        b=UGYzDZmG3SytSI6lgxdN3Ree0hCCixNjpAw6LHb4fecBWffGoi5JBx0SS6xOO7byuJ
         J/Dm1SrNdv03pu1FlVOkFHEhIaRWA+HAedIZ8Vsxg/HFwUYZ1odhj9yVQEtErl3354JN
         sDFdQ32OG/g60tt8pjOc3oXalCoYtP/0w7lrjULwDbvbUsjsTQaVZj2CP9HgtGNmjSG2
         d2mPcSA094QDJbVnBzSKDcywM1hp1mnx4cnynknkTIngYy3zzKKOxUE6xUG7MEG0I/4n
         Kmq9RgGOPt+56npJ0FQeEd4OheGp48UWQ/cmpJbZxm2gu/uKK5RlKkfGh4KZwfjJbebq
         ixmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YzD8uqc/ivBsPISM9eYTgrAPYBR/xTCctPRNLyunB6Q=;
        b=Svr8MTynvYDB99C6eGNSF7478OByHdrTaBAu/TXODBc2RLKIAUzUi5dULzAM3Mlrqh
         dZ5KhIvKIDhvgHTUhcjZxv70uAuCXebDKWDgQhWNFVqyzD8b/q77i3xnJrcG4updSH/W
         FlzNZ4AWxVOMYdgq+u+7ylWm7i6ud/zSRoLwP3NlxL8s0yJefTDr3NbjNCR4US2vp3nn
         c68K68zYSk9u5hIDw1F3lxD7ad5DJzNgigmUhVkI385EPC6ncU0DmLbJWnPsmRJBsMLS
         Wutn1qxoQ02v3/MKrbbS8XPIsggZoPPkkL4Qz7CIJbGf8AMYNFZJ7XDkJdHNF+Kb9hHb
         kx8Q==
X-Gm-Message-State: AElRT7EVa9js50Pd3tOh6dULkb0Z9JHquh2l62suFg1WVTtm69AdwE6Q
        hPCu3b+nnFs2/cN7mhhSBCuQF1/I7242eqA60aRhiA==
X-Google-Smtp-Source: AIpwx48CZzLUllQTzb2lCmqV1ZMSf+A1/AiTVJFdpwyQTEfhvQZEygRROTpcVD4P8PDgXnUIuKy9ecGDLMBjyV5qzIo=
X-Received: by 10.129.232.5 with SMTP id a5mr3389227ywm.421.1522270481784;
 Wed, 28 Mar 2018 13:54:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 13:54:41
 -0700 (PDT)
In-Reply-To: <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de> <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
 <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com> <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 13:54:41 -0700
Message-ID: <CAGZ79kYs1YFQav8ux0nHcdDoaXcrBrnLM7K5=+9+4sYjHR4yJA@mail.gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 1:21 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> Or, even simpler:
>
>     mv addtest2/repo addtest2/repo.bak &&
>     test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
>     git -C addtest2 submodule status >actual &&
>     grep -e "^-" -e repo actual

I like this!
Time permitting I'll update the patch (I'll first have to take
care of some other series, so feel free to make it into a patch)

Thanks,
Stefan
