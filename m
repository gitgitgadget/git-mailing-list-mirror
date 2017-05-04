Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967B3207B3
	for <e@80x24.org>; Thu,  4 May 2017 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdEDLxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 07:53:51 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38249 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdEDLxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 07:53:49 -0400
Received: by mail-it0-f45.google.com with SMTP id e65so7638592ita.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hez5tduTOqOm7dB4dUrY+1u1IZ3p12YasyDoiuONfAo=;
        b=NYirjYmtGTZ8H/OMnv8a8AaUrl90Ber/GVNThvo6cHZFZXvKfPnG04VzJtQa0yJXu3
         dhGi97u95pPfVkz5LBzqRQACBrxWN5Qw3O3hD4xdCXIsETPpe/LkWOdJMmpAr742qG48
         4bzRveI7J+7nr+tMylu3Q/MoMpymfsWJbmkmCP7ztQTbtdL7Xczqoj5/WXTrSuPHBH6Y
         RzgNIKxxEYcMW93Jbc9pyYO76WxxJLQ6YNqwEp6quoDft8cjQKl1TIk1TqDTsW6OG0NN
         Nl11UsaBoClImUAPST6+jiW9Vh7frHC/Bv1SemZ9PglMVHxeLbWHjrrkZhR8cIYWXUWN
         FT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hez5tduTOqOm7dB4dUrY+1u1IZ3p12YasyDoiuONfAo=;
        b=gt7d2IY9hiAs6S45q4RhujLMesoqbkXfgsiC/9Wp/fhccfrxWW/kqScdNwj5xiAJYx
         993ok1d1MVrphc654jXOy691hqlHtQ7tO2eWPtb4/DqO7D8l6I6Yuph7Ezi6979BLNub
         8XEMgoE7OjFJKNv8JQdKia6+rRURg2tO6JjvgV5Lr1PkQwwECsiGjCrBS+k1zjNV0YBu
         xIriCnPPKc6jBtejm5BHXcE1/i6M9Qa7i6lS3SFffzuo9sF3M433RuSs/cMbniJLOKJj
         uLXr8Nmw5hld6EWlZJ1lLlq5g9kVnKFV3liOC2rdjmuG6447bQlrS+q/7MumO4RwYwL/
         Vnqg==
X-Gm-Message-State: AN3rC/4EfDb10s4bV7jbVQzWX+6O96VhODtUihsSkehmSMal0h7A59SV
        znph6o6c5xg9eeiZtxJd7xBArI/gyQ==
X-Received: by 10.36.124.129 with SMTP id a123mr1415948itd.66.1493898828657;
 Thu, 04 May 2017 04:53:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 04:53:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 13:53:27 +0200
Message-ID: <CACBZZX7DKOvcCRCHgkxiCOVx4XH=B1C+0=Q_ykjm3Odk-aWEWw@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 1:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Thu, 4 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> So I think if your criteria for working on integrating v2 is users
>> noticing it elsewhere and asking you for it you'll likely never switch
>> to it.
>
> Speaking for myself, my biggest problem with your patch series is to find
> the time to work on packaging PCRE v2 as an MSYS2 package.
>
> If you force me to make that time *now*, by forcing the switch to v2 in
> `pu`, you will disimprove my mood. That's all.
>
> If, however, you are gently with people like me, offering this as an
> opt-in, so that I can play with it when I find some time to build PCRE v2
> in MSYS2's context, I will be pretty happy, and of course will ship Git
> for Windows with the faster PCRE support as soon as I am satisfied that i=
t
> works correctly.
>
> That should make you happy, too, as you will get quite a bit of testers
> that way. Gently.

Sure, all makes sense. As noted I'll keep it from being the default for now=
.

The only reason I even replied & kept this thread going now was
because I noticed "make" not enabling it, REG_STARTEND making \0
searches work in practice (even if not specified by the NetBSD
extension) etc.

All stuff I would surely forget by the time we have the discussion
again down the road, so I wanted to get that E-Mail out now for future
reference.
