Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23971F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeBFUFN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:05:13 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34580 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBFUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:05:10 -0500
Received: by mail-pf0-f181.google.com with SMTP id g17so1101981pfh.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zX5Hw8odo+xqgnxVg8vwO/lOYV0xmb/3fI1C+ibCrts=;
        b=IDO3xes6c3JZldvakz2kxyC76FZWcKlslJcQq2R5VfJHnxgpr6oYoIbUlbgKuQwgZB
         0I3ZRIV0R2v4jtX95HDqZcp5lW5ZI51nfEoWjNiQ1bNjPnUD2EF1Ai98f7RDNpoZLKXW
         xQAl9yxNwpYMVZLcTbNbm2O1KcxracOQreQ5ruE09R+0zFJMzDfLLiFmB00GT1srzhLE
         zIdud6QCkt6SUq0ZJCk/oUnzqc0A1iGt7qu64Dwhlfp0vV7o7hlm/BYeel56RXFWcU8c
         dvZjk95/FYHEbD9KsZKCZKBTCviw4QqZSwWoIH1BKDkSpkva08lKwSnBetra5baf5wnn
         Cz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zX5Hw8odo+xqgnxVg8vwO/lOYV0xmb/3fI1C+ibCrts=;
        b=WbDKNFclJaxyOW9+Vw/1VvATwLcyVJneFM2FrfYBJsB7JE5CsMZ0anrhS3cB5TLnKj
         pAOvCYEgcMjCm2dFyQ5yCqpGsCfmGTguEwHyMGTT+f5pKzjLD+m87HLlLXBHpY3wc7vi
         Vrp7vrbNQ3DllKwMHfM/preEBlKgzJOPGr2rseoEUvoCs85RfETND6aAkURKXBx8Cush
         Ox5/CgDu3lQvICU07CDdaaxbhUrIQOvelNS39ADbyumtfbGHpPtsRx062mj1fNSznDvq
         cDTBOXBoX+7a7RN1IcDsTJtAExF+7cI5qGNfv3w2Lk8QnpApf96++EvLZ6JzKxGvR8dn
         ra/g==
X-Gm-Message-State: APf1xPDrLI5V4DwU4O6EJjxinQP6OeNNxqC4y0LmtNIFPUCRpbB3SBnH
        ivGJEER1pwdIQDmeKy/shQ2As6QADkmTJ6F1hT4=
X-Google-Smtp-Source: AH8x2259yKSKI5nBhYBqRXfYuya2Ccuk0b7v38paz/dL8xLxDuLaYe1fi00ROgGE6htF/9Tq/gjwl2X5w0LlVxERcXI=
X-Received: by 10.98.150.14 with SMTP id c14mr1644230pfe.210.1517947509451;
 Tue, 06 Feb 2018 12:05:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.163.48 with HTTP; Tue, 6 Feb 2018 12:05:08 -0800 (PST)
In-Reply-To: <20180206021313.GA26323@sigill.intra.peff.net>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com> <20180206021313.GA26323@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 6 Feb 2018 21:05:08 +0100
Message-ID: <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 February 2018 at 03:13, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 05, 2018 at 08:28:10PM +0700, Duy Nguyen wrote:
>> I learned SANITIZE=3Dleak today! It not only catches this but also "dst"=
.
>>
>> Jeff is there any ongoing effort to make the test suite pass with
>> SANITIZE=3Dleak? My t2038 passed, so I went ahead with the full test
>> suite and saw so many failures. I did see in your original mails that
>> you focused on t0000 and t0001 only..
>
> Yeah, I did those two scripts to try to prove to myself that the
> approach was good. But I haven't really pushed it any further.
>
> Martin =C3=85gren (cc'd) did some follow-up work, but I think we still ha=
ve a
> long way to go.

Agreed. :-)

> My hope is that people who are interested in
> leak-checking their new code can run some specific script they're
> interested in, and maybe fix up one or two nearby bits while they're
> there (either by fixing a leak, or just annotating via UNLEAK). Then we
> can slowly converge on correctness. :)

Yeah. My experience is that it's easy -- or was for me, anyway -- to
get carried away trying to fix all "related" leaks to the one you
started with, since there are so many dimensions to search in. Two
obvious aspects are "leaks nearby" and "leaks using the same API". This
is not to suggest that the situation is horrible. It's just that if you
pick a leak at random and there is a fair number of "clusters" of
leaks, chances are good you'll find yourself in such a cluster.

Addressing a leak without worrying too much about how it generalizes
would still help. ;-)

Martin
