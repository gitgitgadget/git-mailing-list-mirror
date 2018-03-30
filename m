Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8EE1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeC3QIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:08:15 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39445 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeC3QIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:08:14 -0400
Received: by mail-wm0-f51.google.com with SMTP id f125so17404049wme.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SBUoLLBzvsXAst3KDp2suuq/5FOE/iwpeFa4mDU7NSg=;
        b=s/pi/KTAQDjaCpGuEBQBWMQSxp4bKV3H/fU53CGLqOWoiUyQVEAaAsVXFuX6FXnYM7
         ygCKCkKgW3ljMX4za843IrLbceIVFuOWwlIzmFpsxgWb+PmBTvHljFJMSDgY6PDugerk
         +ymISsOtIXuFKne0LaI++E7J1AIysJbCdEoDvdCeK8y57ktwEkqC/mT80MNslir4zo+i
         Re2ziN+vjz/J4fVy/wGC4qpW2pFJb3aZXZvUKeo6fyN4ns3cBtmHZqyD15CRGmoK2vKc
         JK9YYKNgY953/inwAg+CG/nH4SbVuXo1KgdIHRykgFzGh0Hi+rzb3R4PFn4AkCbYMlID
         4mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SBUoLLBzvsXAst3KDp2suuq/5FOE/iwpeFa4mDU7NSg=;
        b=CSeMRhxEN6LoBu0C/bPGsb3cxSChI7+91Ed/Ryrj8SLYMRQ2qztZaRoSE4aIRGP+aj
         dT5LKZdWR2EZHZaDvjnEELMe/2Cmd6ZWoLjbtoYInBp/7fGU+qoa+ZgeuE2T/pOE4M/f
         8c/h0bEh2W7YpLTyzyAYmLhiMko8byxttAtF0Bg0m7xni4AgVTvL4rR/pvvp9AbZ9UpL
         LfSSJSvegTX4fHUugFzj6NQAs6ORh8qH9qT8zedRU2EdKt1xYOytDl0DwqwnIm1x28Oc
         7QnitVeBMTyYYtbDCR7OmKPMEwcHpRpUezwf/lGXvJMxEtIkH/CJmWCSzbSJH9wd5C1f
         qzPw==
X-Gm-Message-State: AElRT7ECFsjRcNkzTOo7KVzMY2Vl6snrWFJsrgxpOY7+z06J09NsOzZI
        h9zR2mZIFV9v8/U2KpusuGyOrOBtDJRZV3V/DIU=
X-Google-Smtp-Source: AIpwx4++EWqfgIv2ihaEIb36X35wShzPJ509gXmb3xUSRN3qD2KWmhMnRWqtEPAL/n1F86fTBfKcuhnsQkm+OQPFwhw=
X-Received: by 10.80.162.231 with SMTP id 94mr3410027edm.84.1522426093407;
 Fri, 30 Mar 2018 09:08:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Fri, 30 Mar 2018 09:07:52 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803301059450.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com>
 <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com>
 <CAP8UFD0wWiivjzJ29-RPVyOxkmbFACXTwHLyPrMdsUsW__RsYQ@mail.gmail.com> <nycvar.QRO.7.76.6.1803301059450.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 30 Mar 2018 09:07:52 -0700
Message-ID: <CA+P7+xoEquzyFFtpsmHb4WDLJiaDb1r5fDTsHk=4qyj4sVXm0w@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 37
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 2:02 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 19 Mar 2018, Christian Couder wrote:
>
>> On Sun, Mar 18, 2018 at 11:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> >
>> > I don't have a good summary yet, but I think a section about the
>> > discussion regarding the new recreate-merges and rebasing merges
>> > that's been on going might be useful?
>>
>> Yeah sure, we would gladly accept a summary of this discussion.
>
> I would *love* a summary of that discussion, especially since it got
> pretty unwieldy (and partially out of hand, but that part probably does
> not need a lot of detail apart from the adjective "heated").
>
>> > a lot of that discussion occurred prior to git-merge (tho it's been
>> > ongoing since then?).
>>
>> If you want to take the latest discussions into account, the summary
>> could be either split into two parts, one for this edition and the
>> other one for the next edition. Or we could wait and have the whole
>> summary in the next edition.
>
> Jake, I do not know about your availability, but I would love it if you
> could take a stab, as I trust you to be unbiased. I would not trust myself
> to be unbiased because (as everybody saw who cared to read) I got a little
> bit too emotional and should have stayed more professional.
>
> Thanks,
> Dscho

I hope to be able to make a summary of the discussion as best I can.
It may take a bit as there is a lot of mails to read. I agree that a
good summary should come from someone outside the discussion to reduce
emotional bias.

Thanks,
Jake
