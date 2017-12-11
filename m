Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08AF1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdLKTrN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:47:13 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:34535 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbdLKTrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:47:08 -0500
Received: by mail-it0-f47.google.com with SMTP id m11so14130824iti.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tuwnp8AQYSYI+Uf7WFoZHGUdGZHRlpi9ym9YmPUT69E=;
        b=cUkkxkUSqw2X0DzG9n+zsgoSqVS4AA2WArZttoNqPyZXr8qMzvMLl6I3WpoLLWNxzS
         cQTuIpv8nDQ0H/NUYk45Vym9jDj+ZduZ3YEfKJltWpcCZitIFNBA3JgDNF1B4qryQhOi
         jZgT6u3hBSIBB8VSsAJGSxd2KSKWYBrvr20FYPhoapQgvNFGyYEcKU5CWYJAFrkKkmi4
         cE+DwZKCL6WMuQDwQ365pdORCAk3WsI/kWiFtIOkpE5vNpaodOHDLoeY3d2+T+snIfkG
         URVz0KiKN94AX/XP8WjbLLKO4qn3FTzIpneGPiNypuCAEHhunfp7TzgS0wCLVfcPm/D9
         38rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tuwnp8AQYSYI+Uf7WFoZHGUdGZHRlpi9ym9YmPUT69E=;
        b=OK4x/Dp0fKklsg4fzLBnQjcX1yzsD/ixW6lpZtiakJQE6RyccPIN2b75GLnOttftWh
         5s1Dm+hG7fgCuC6GVf/DIRZ7Q5ukGEMl/AIGHpjoqFltmZfzM5MuzTSrfyaZGP66Nbah
         VNrNcL3swTW7Zkv+1twLsOyal5jclgZwgEA9PS3fETRBf+e7b11Mzb4mejw8lIabFbJf
         5JZaN15cnGPl7CTuShRUQTOUjew03rJGfdbCVb0633GWXD+dDJqtSmfnVNUzaawdTIWp
         wSypy5UbnO7WzO1cy6K7rosmD/XCYBvR5yRj9oriJ/h+4a3aKIJf5W3dcG7Xpf3YkUq5
         tHvQ==
X-Gm-Message-State: AKGB3mLaMeHu4sv2/PH7uD9Vdkip7+QJs7iMR2R5vxP2HS76XNj/HEXf
        I1pfO0HIVbUwGuEu2JPUZfqKx3vTR6Da0VDcbCE=
X-Google-Smtp-Source: ACJfBouxv3VUOYwIxiSIvY+v0UcWVgnbPwd5KE6kYQ0swHPQwPp4Iy4Ml8aXyduIGoECmktkDXixtxBnYakX9AKzejc=
X-Received: by 10.36.39.8 with SMTP id g8mr2808793ita.42.1513021627673; Mon,
 11 Dec 2017 11:47:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Mon, 11 Dec 2017 11:46:46 -0800 (PST)
In-Reply-To: <20171211172615.jfsjthkvs4itjpcn@laptop>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
 <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop>
 <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com> <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 11 Dec 2017 20:46:46 +0100
Message-ID: <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     Thomas Adam <thomas@xteddy.org>
Cc:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 6:26 PM, Thomas Adam <thomas@xteddy.org> wrote:
> On Mon, Dec 11, 2017 at 05:13:53PM +0000, Alex Benn=C3=A9e wrote:
>> So have we come to a consensus about the best solution here?
>>
>> I'm perfectly happy to send a reversion patch because to be honest
>> hacking on a bunch of perl to handle special mail cases is not my idea
>> of fun spare time hacking ;-)
>>
>> I guess the full solution is to make Mail::Address a hard dependency?
>
> This is what I was suggesting, and then as a follow-up, addressing the po=
int
> that there's a bunch of require() hacks to also get around needing
> hard-dependencies.

I don't know what the right move is here, but just saying that this
could also be built on top of my "Git::Error" wrapper which I added in
"Makefile: replace perl/Makefile.PL with simple make rules" which is
currently cooking.

I.e. we'd just ship a copy of Email::Valid and Mail::Address in
perl/Git/FromCPAN/, use a wrapper to load them, and then we wouldn't
need to if/else this at the code level, just always use the module,
and it would work even on core perl.
