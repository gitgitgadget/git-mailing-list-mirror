Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BAA1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbfBSOZ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:25:28 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:53392 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfBSOZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:25:27 -0500
Received: by mail-it1-f170.google.com with SMTP id x131so6375332itc.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpSW16ekzL9rDDNc1wLZL77vbD2pBqHkct48+lO9tqM=;
        b=noDv97b1jxtvIwrUi4P4B1GaEvyON3RQpPsxYLAMdaXJm28EXXwN9NnkWscfIP22Bc
         MyRuLc8fn9kdFLT3CiFA972+BI5FzEz3+4oOhJDQJyeXSweNEpKGn2ZVX2jikD21qFVa
         KDGcRSvLT4G5QYkvAnvuhLbJeupR4f36KciBH95sfeWasudY6+NwAzV7JNutBNNc7adZ
         ld8/RGLok7FFat7FmQoSsOkatFJSjX7zCd4HTh4kdRLfPZgno9+BsUeS9Gf/R1ClCPNu
         Pzbl82ZJdp7kiSS//Tj3KvpQmkkZ7104zb2abkFo2XACzEZZ6XwMAJDG1oUgUXQCezbw
         Xafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpSW16ekzL9rDDNc1wLZL77vbD2pBqHkct48+lO9tqM=;
        b=OisP7EIO4HLf3Zy/T1XFXO0AM2zF5eKtDHKo8qVwVZfaEa7YX+4cbtmcxXcnmsNO87
         eejKLyqxeJsmqELeUL+0J/0JfrpLP5RJT2ILy+NGF6mlgjck0Qxh/hRev5ScTe3Fodt6
         wizGXm77xl23vkLRnNWDrGkcMwu2rsjHO1gLItCqLhfSo9KubKwPe6yA+C1dwXP4obnh
         HE2v3a7vH9agwVybZWcNjNKAIcA5qD3Sph6G99tBXPKE0VN/2f4y+zhd2QZWlCHKg2Yl
         SmqoAAxACA8AUW04BKDudQK5Vm6kNpUyOSVhE1Mg5/I6tjoJ3cC5qVhw8zvtzF9qktiI
         kCvQ==
X-Gm-Message-State: AHQUAuY3kbovlWNOg6R1MqHF6af/K87uRF+osQdNiNBzZ0z17nSzFb1Z
        WOgdcEB/V3iysemEM06tTTaOtvQ0X7soBR1X5s0=
X-Google-Smtp-Source: AHgI3IbMcUKpMPEFFGO5x6dURN/qJjBQf+VZrMt9DpNTdBETBVLZaWyd/v/5g0A3IUPmp/Jq1aphS573YT218dO4lZ4=
X-Received: by 2002:a24:f443:: with SMTP id u3mr2120734iti.165.1550586326992;
 Tue, 19 Feb 2019 06:25:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
 <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net> <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
 <CACsJy8Crn3mnXkwj_CQ1capeAXT=Jvn5S-HdnKsTLJZvdH=ObQ@mail.gmail.com>
In-Reply-To: <CACsJy8Crn3mnXkwj_CQ1capeAXT=Jvn5S-HdnKsTLJZvdH=ObQ@mail.gmail.com>
From:   =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Date:   Tue, 19 Feb 2019 11:25:15 -0300
Message-ID: <CAJPSwc3-=ByzxTQirg9==6G4tUcR+0Bzc0cfknOWNCmb6e8hCw@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, it's not a typo. I just checked again.

That's the file that results when I start the rebase from tig (the Nix
version), which results in the error for rebase --continue.

When I start the rebase manually or from tig (the Homebrew version)
it has the quote.

        GIT_AUTHOR_NAME=3D'Sebasti=C3=A1n Mancilla'
        GIT_AUTHOR_EMAIL=3D'smancill@jlab.org'
        GIT_AUTHOR_DATE=3D'@1550530007 -0300'


Regards

El mar., 19 de feb. de 2019 a la(s) 11:15, Duy Nguyen
(pclouds@gmail.com) escribi=C3=B3:
>
> On Tue, Feb 19, 2019 at 9:04 PM Sebasti=C3=A1n Mancilla <smancill.m@gmail=
.com> wrote:
> > And the content of .git/rebase-merge/author-script is always the same:
> >
> >         GIT_AUTHOR_NAME=3D'Sebasti=C3=A1n Mancilla'
> >         GIT_AUTHOR_EMAIL=3D'smancill@jlab.org'
> >         GIT_AUTHOR_DATE=3D'@1550530007 -0300
> >
>
> Just to be clear, the lack of closing quote on the last line is not a
> typo right?
> --
> Duy



--=20
Sebastian Mancilla
