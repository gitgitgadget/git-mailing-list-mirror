Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2989220248
	for <e@80x24.org>; Thu, 14 Mar 2019 04:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCNE5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 00:57:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37982 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfCNE5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 00:57:44 -0400
Received: by mail-it1-f195.google.com with SMTP id k193so2563377ita.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 21:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfGb0DTIfW1xHkEsTslbaY1QAGPOzQ6VEH4wMvE6UHQ=;
        b=QyOtn1s6utpHeNHNRD+5AakatdOeLeJ2NEnDrRrdQAbnd3MPG2Iz86YGbJ/bamxY6Y
         VSR+DJ98zQqQbXC7lVGdM28JWOaur1hJwu2jjWZoGVSm0Wn1Y52PBlWF/sW6G9WAX9qa
         W6OA7iK8RXgryn6nwb2l9rxd2+mUZ/gd1ui95aCKyKCjZfUNgbCWm4H9+XqKlWA3hQRq
         ATZmr0G64giEs2hEtTu7Rnt/C/Tllf2KRBjfTPWPlZgWU65J745sfLAjYaoCkc93FWIA
         /73+hVn1XdjpOjLekMuQYkJyhzFl0Uysw3s2BhPikKv6Ci9axHXzUNRuZeeEI8Ntvwpu
         zdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfGb0DTIfW1xHkEsTslbaY1QAGPOzQ6VEH4wMvE6UHQ=;
        b=bv0ZT3UveSKdy2Bqi+/n2ZQLfegpMSZf8pjEj8SZaX4BHEnHbGjgPokfgsy7intfoQ
         U3TmQTEtp20rCx/mwi56J56T3LEaPn2TBATwPxxKaeSEHCPCz0LxwW4ex1DPKwIEfC1y
         Pkb8DgON6B8KBtndm49HF6kvvgj779syaXN6nx6JGb8qEL5IVeILbKVwd/d0fHqrMzqG
         KhSJmxRHKZ154/wNF5quw8Hum3kps/OgKqxzhkp+mD23eO7aaA1BN5BrCXqD+NIun3rP
         SJX2P1TG9XtnSlan/5qWqxKXH13tqdGgGwL+T8SQ6AlIlSKnxiSAFWCvhczQJhpVC19x
         Eadw==
X-Gm-Message-State: APjAAAXtPbKP33cHPIipxV8Kp5x4XYk+dlj4c2uTkxS4R2DkXo3DiXEl
        FhrcyY9/GWzav8TELpaXartkNYi65m9isyZbdLfxPQ==
X-Google-Smtp-Source: APXvYqwl2DcMf4osRcD1EMab9MnWd2dmxdnHZdIIN40Ps3XTU2mE6MDZnfCq035/NtKkkM9ZYsx9NyWgtniGGJoAAvA=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr831929ita.10.1552539463325;
 Wed, 13 Mar 2019 21:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-10-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1903131005180.41@tvgsbejvaqbjf.bet> <CACsJy8Ce3Sn7sWDOqGPeOk7JiXg+3KSaox4PFZxfh90B6E81_Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1903132316220.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903132316220.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 11:57:17 +0700
Message-ID: <CACsJy8CbGBFr0jknuWrkrS19OJhpPaUDwHa8-+j1Ak=DQkmpdw@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 5:17 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Wed, 13 Mar 2019, Duy Nguyen wrote:
>
> > On Wed, Mar 13, 2019 at 4:13 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > Duy, have you thought about making use of the CI builds? You could catch
> > > those bugs before they hit the Git mailing list...
> >
> > Using Azure? No.
>
> This hostility is totally unnecessary. Especially since we still have
> Travis builds that you could also use to catch your bugs early, so that I
> would not have to catch them.

Thanks. I'll check back on github in a couple years. Adding CI to
gitlab is on my todo list but it's very low.
-- 
Duy
