Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CE2201A7
	for <e@80x24.org>; Sun, 14 May 2017 07:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdENHCl (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 03:02:41 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34098 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdENHCk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 03:02:40 -0400
Received: by mail-io0-f171.google.com with SMTP id k91so58924964ioi.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zq/Cmwua4Ko8PrhJbDVI38BBFM4t2b0wotcgyJYTGEQ=;
        b=tbCraUo+xlNxr3NTlccASzwnlGyTBnymVT0jGaSpPHKnec31CH2EEq3PvPwpsk+PaB
         jlgXPLjmWVq3ufLrcjcVQAY+O4YruAn6bdEMw8cJoevSd+1OP6OEvdcSSdyooM8hcOcx
         uBi5vkYoZcG1U9QdhToAruQPJxy9Ov2UYL8kGCCifTU4O/oDyQbmCzLBULnqGXhDkq4i
         KB+HScd7VOAQZdIT1ky0qLMnVrRO1F56cvJjKUQDex7MwBI2n6saI/1d7J6QizZ4oWVq
         L4bDaNlV4ypaCc0mi7B/zEgbY0i49S7Jc3TqneUTCulDwWXO35dhZ0vNJ6aOmXemUuwS
         tNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zq/Cmwua4Ko8PrhJbDVI38BBFM4t2b0wotcgyJYTGEQ=;
        b=jI7InMasCrN+Te2KJ5DflImhkRf+iZ406Rp0c7UAllhDL9uZCMeNUMin3hkz638fdT
         RJ2lOS4SJnffCqTEU2eiNSQ5A5tlVg8Wos3MpB1NZ5ELGfb+xNd+RiCN75rEz4rVnXjh
         smg8Q2WUknxAFMMxGWnrl2N/fRnpCmwCcAt1+xLBnp/stFq2QMQrgMo9c295SuTkrGU4
         94mTOUwDt0AtgHMjUM3vXMe4i9MALxFZQCOVomidgNBqDy+ASN8ytuECV2WFae6n+Ir6
         Oql2YXmIxLQwW/p8AIJuoaQSQWsD2vISGBCjxe1xWeGhKOHtXwHb38RVxTe3fFzy0hX4
         3ZQA==
X-Gm-Message-State: AODbwcDRYvU2EyCxjXwkEhMw//wSc+ijxsZKuczhsY/kMS8KFAi5sQVY
        WQu/CFW32Z0tJsTxxipNg71QltZ1gg==
X-Received: by 10.107.178.12 with SMTP id b12mr210069iof.50.1494745359962;
 Sun, 14 May 2017 00:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 14 May 2017 00:02:19 -0700 (PDT)
In-Reply-To: <20170514033923.12870-2-bmalehorn@gmail.com>
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
 <20170514033923.12870-1-bmalehorn@gmail.com> <20170514033923.12870-2-bmalehorn@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 14 May 2017 09:02:19 +0200
Message-ID: <CACBZZX6hjbiTUzK9CCR1_taE8hzoDm9vH8tGTk-_DW_36Wia+A@mail.gmail.com>
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2017 at 5:39 AM, Brian Malehorn <bmalehorn@gmail.com> wrote:
> If a commit message is being editted as "verbose", it will contain a

Typo, should be "edited": https://en.wiktionary.org/wiki/editted
