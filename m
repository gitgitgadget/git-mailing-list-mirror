Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6301FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754972AbdEKJ3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:29:37 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38296 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbdEKJ3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:29:36 -0400
Received: by mail-it0-f43.google.com with SMTP id e65so16378349ita.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEePqZD9Mj/g32BKZaQa2hP/4t0vwuJguhJLAAdbYdA=;
        b=chGRqN6uU2tUCA7Jsda2nr9g+DBYlox46a9XND0fnD2bxrLoqnNlAihwijFIbbxGHA
         HB6AWSaSkm0PWdT0Rx1nl23KR+/j7z8Z2iMKnSEN4nymiBZdTDNyvxxlLTtXLBF+vLEe
         vtRHmsGJCNUzW0GbOyZJ4xnIkq5lN8guOtFNFUD3RAmMviCHWAHxQE6WkxthzQJVxcsv
         o8yKeiJxnHzu0bA/wVc8dUszjGN5XLbv11/FR7ra82B4nX/xhog6SIerX0zD7brbFsr9
         tFWWhmcNWiMA/z4ChnMIZcLzHExZRIhrucGzXL6yMqhNsYsVpl60wZYA5c61wORGrcsc
         LeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEePqZD9Mj/g32BKZaQa2hP/4t0vwuJguhJLAAdbYdA=;
        b=aR8lgc19zN/f4/x+faWv1RAVcwD11l2SMq78TEJ9+N/1CyHi4VbvL5iY6tPO1mScP5
         EtCV76Y0hk2sFMkEhfDKTRDN1NAFmW6bUC5byI8MfBKsn8pi4nAJB752rWxrmeW7VtwU
         hkAL5mLr2++uuS/LzGiXbHcrvCxbbesDIazhk4Wy4McVC5fhNUnKXCmry0IrqzkenvPJ
         R9H9BmoD19px6gNVmu8K3pofaTBAQ+glJtQTjH2/oEDQf88OoClEK4pMYUqi++FQLWXV
         mKzGFks06hvoQl8umH66hcX5Xdmkri6U6dosoD9AAnNwOc+UgcWTPzCHdxC6E6d24bzY
         nEUQ==
X-Gm-Message-State: AODbwcCCaDqwr1i5jh5bCBxdDR1/fjMQDlz32ryw3P8fbzTnyTRmo6dL
        sEHSD52cPOW9yWIWyg35pAOChYLqkA==
X-Received: by 10.36.166.4 with SMTP id q4mr56915ite.66.1494494976091; Thu, 11
 May 2017 02:29:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 02:29:15 -0700 (PDT)
In-Reply-To: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com> <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net> <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
 <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net> <CACBZZX6hpL0=Zw0kvB-Ww95uGvuJ8129MTwkmv7DOEE1i66a_Q@mail.gmail.com>
 <20170511075437.yjxs6oit7ibe7rkq@sigill.intra.peff.net> <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 11:29:15 +0200
Message-ID: <CACBZZX4BEOO+DeO-OzJzHT88Y2k7_ZmFRPJKJ9e6HMb9eMonZA@mail.gmail.com>
Subject: Re: [PATCH 0/4] doc improvements for config includes
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 11:09 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2017 at 03:54:37AM -0400, Jeff King wrote:
>
>> On Thu, May 11, 2017 at 09:49:09AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > > I don't like this because it copies the rules for _one_ property to =
the
>> > > conditional section. What happens when you're looking for some other
>> > > property of include.path?
>> >
>> > Yeah, as I said once I wrote it up I found it wasn't really any
>> > better, but just wanted to send an explanation for why I didn't find
>> > it while I remembered, as a sort of case study.
>> > [...]
>> > > I suspect that whole paragraph under Includes could be reworded to m=
ake
>> > > it clear that anything it is saying applies equally to include.$key =
and
>> > > includeIf.*.$key, and then that would future-proof us for other
>> > > modifications.
>>
>> What about this:
>
> I think this is the right path, but I actually ended up with an
> introductory paragraph about the two sections. I hope it makes the same
> point but is a bit less clunky.
>
> Here's a series that I think covers all the bits discussed here, and a
> few others.
>
>   [1/4]: docs/config: clarify include/includeIf relationship
>   [2/4]: docs/config: give a relative includeIf example
>   [3/4]: docs/config: avoid the term "expand" for includes
>   [4/4]: docs/config: consistify include.path examples

This whole thing looks great to me. Thanks!

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

>  Documentation/config.txt | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> -Peff
