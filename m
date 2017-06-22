Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8AD1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdFVTmi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:42:38 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33458 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFVTmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:42:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id e7so13215231pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dnhxc6r0XsRZvDNfWGHaefz3Q7QsqS+6nogkrla2t50=;
        b=qtVeqDYx5KYPQ41uXK62XoYlFo48cnZz9mDEswrNbyIcQm7fbMpM/3uxQ/ZKCLQo/S
         e7sRVJsGBw42cySk5NB9PEmrvfSb3461/YBl9xb0vOnMk3y//vsVlQHsn3XAAs7OPQlc
         fAg9vMTFldwKg22h3d0Q+SAyBupeztYmwE83U37t/DqTQQjdhhUoZ2YOVDgj2GZIaotG
         C3QkqH+ofv/vlJabwCCiHab1YaNIWTcD1OsFbPVJbbBV8ndM0z9/AYGpjzvCDHDRRMjb
         waYuHzrtqCu75PFPBj7FWxiz/tZf39lCWYyllF8u96fPMLmRfOB5Cl3sAMF7nwPXJ9dz
         f44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dnhxc6r0XsRZvDNfWGHaefz3Q7QsqS+6nogkrla2t50=;
        b=PaBCdXqeYUmJIfiQ+RNjt6h90JhVeMQFcGvPDphqS/8UlRotp3KNATSOqDJxeSHEef
         PmTk/kC6Fqkb8CGFLbpxSOb+0ChAyFeRRUv+yRxjYsLYArmzjfSIQ4Kq/+DidIBkkgaO
         c8xQ7LTVGgTYBDHfaZK5RkQ6xSHOfcmhtnAm4DGdNkhYrsEIQSgHNziHM2328xcXDEYp
         ri7wxbxVa+wbW2mJ/kTbz51d/1xMBehAP/ffrzExzt6pEDv7b1Vy7t6x1oTyMnXvc/LD
         tobykcPar8r1YmVOgDX0dwEZTKZl3Tjmy7IHXdtmfq2WEaERe99gMJfvJYin/0k5ItQ2
         4bYQ==
X-Gm-Message-State: AKS2vOyKHCFh75JUm+0+aViuoh5ezEnHvHnZFuMYdfEH7pJLgrg+QFiv
        icWXfmyhwalEXssCniN5A5bhgPapIOVc
X-Received: by 10.98.69.76 with SMTP id s73mr4272883pfa.94.1498160556552; Thu,
 22 Jun 2017 12:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 12:42:36 -0700 (PDT)
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com> <20170622184348.56497-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 12:42:36 -0700
Message-ID: <CAGZ79kbrnCx2xxZHyZN+pwgUDY+sEuXAaYKDjKYLcbemsfM5Tg@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 11:43 AM, Brandon Williams <bmwill@google.com> wrote:
> As before you can find this series at:
> https://github.com/bmwill/git/tree/repository-object
>
> Changes in v4:
>
> * Patch 11 is slightly different and turns off all path relocation when a
>   worktree is provided instead of just for the index file (Thanks for the help
>   Jonathan Nieder).
> * 'repo_init()' has a tighter API and now requires that the provided gitdir is
>   a path to the gitdir instead of either a path to the gitdir or path to the
>   worktree (which has a .git file or directory) (Thanks Jonathan Tan).
> * Minor comment and commit message chagnes
>
> Note: Like v3 this series is dependent on on 'bw/config-h' and
>       'bw/ls-files-sans-the-index'

I read the whole series and I consider it
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
