Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574FF1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdEIOqv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 10:46:51 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37674 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEIOqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 10:46:50 -0400
Received: by mail-it0-f47.google.com with SMTP id g126so2930544ith.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e2bDFNO9ugOkCDHLfsXpg/L/aVpQrq+gcDRJg0e5rd8=;
        b=T3c7OR8mQGvO7TWxVliRgheO7mfkTi4rHFXI9BmjWffesSFJHv5+oFx3en2wM/OS0p
         fv1SzSnERa/JVk8jc6oZeOELJiuCfs4tQ2+GztK+bQDDt/V3D8SJjPmKhLJvbZzqp9et
         XrB4+90Rm1oVm5z6cfoEFUDUg0oUuW2EzIZIdHa9IqwR1VZjRODD4f/fp/3ejDpChXc2
         Adz77o03LrzJ2eN1zoQMu/8Q2PT60bVUuLU8fTsl5W+AL6MTsCrCaWKVvQ3HWhWV9VJ1
         uxpWcEvunpN/Iskb1hwW7lpl3fLqPp79juhce2qFnPc4rds4C32+ApnjAHoriwPDIniN
         l3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e2bDFNO9ugOkCDHLfsXpg/L/aVpQrq+gcDRJg0e5rd8=;
        b=HhgFn+ytSrI0ILHen/g/FH3aZtzYe5itZvjRdFSTqmjMTj06d/D8MNCH79bEp330I6
         SdnhK0DP7KK2cdba6X9m4SIb32DVj+vrYXzia+Gxuf9cKPb5kSUr8OYJ9s9irjiHcp3+
         zyAFQRmNKRf3xyd96zXvYxUYffpR5Oo3K2orvuP07BZPMhAz2Epr9PIk93z3RRuMsVe8
         hOnk4TcaIRYN/l+TjigqI8Dl2kIOaTBBLaCSCprKOoEBHNMLf5YaOpIDbfkKNIq+c3wp
         efxDwmszL7Ikjsibyk1D7pysaGbc+NF1CosvhpsihKTqwsE35a+zHE7Zh46FJTlhVhqJ
         /ioQ==
X-Gm-Message-State: AODbwcAP0nDKc/cvViZdvvvVA40javSglJhK2x3j2GcVIvm6NuIgVEXY
        hdYHx+gZy/aeen/9+PURwUBs6gEtIA==
X-Received: by 10.36.89.207 with SMTP id p198mr1509510itb.71.1494341209643;
 Tue, 09 May 2017 07:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 07:46:28 -0700 (PDT)
In-Reply-To: <CANgJU+Vc2EC6o9CQ8O_Q52u0Q=3rkQDWafYWs9DzsFACBzX3Lw@mail.gmail.com>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com> <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
 <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
 <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
 <CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=Sf9tdkOt52M9j1Q@mail.gmail.com> <CANgJU+Vc2EC6o9CQ8O_Q52u0Q=3rkQDWafYWs9DzsFACBzX3Lw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 16:46:28 +0200
Message-ID: <CACBZZX6svPkny9Cy14fdPQNaTV_d0tEUWLvO49fdbwuH=_e9tg@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     demerphq <demerphq@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 4:22 PM, demerphq <demerphq@gmail.com> wrote:
> On 9 May 2017 at 13:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com> wrote:
>> On Tue, May 9, 2017 at 2:37 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> * gitweb is vulnerable to CPU DoS now in its default configuration.
>> It's easy to provide an ERE that ends up slurping up 100% CPU for
>> several seconds on any non-trivial sized repo, do that in parallel &
>> you have a DoS vector.
>
> Does one need an ERE? Can't one do that now to many parts of git just
> with a glob?

in practice I don't think so because:

1) I'm now aware of any place where we expose globbing over the wire.

2) AFAICT for the issue detailed in [1] to trigger you also need a
pathological filename in the repo, e.g. I can't get git-ls-files to go
quadratic on either git.git or linux.git, whereas it's pretty easy to
come up with a really expensive regex since there's more content to
choose from when matching file content than filenames.

1. https://public-inbox.org/git/20170424211249.28553-1-avarab@gmail.com/
