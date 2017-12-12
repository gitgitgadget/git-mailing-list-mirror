Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426251F406
	for <e@80x24.org>; Tue, 12 Dec 2017 16:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdLLQkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 11:40:13 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43644 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLLQkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 11:40:12 -0500
Received: by mail-wr0-f181.google.com with SMTP id z34so21761389wrz.10
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wyJvRRotFiIVjTTSoad0uiS62UqZUBQ+UX1IojJFL9U=;
        b=f7r0fL8nDc+lLUoiKDE70mhimj8PFXxFf63zs/SRmPmE+Yx1kQZuQ13ICbRLflV8t4
         v5k56UIBF3ghYlpSqYGiN9nkB0u5dwnLWJT2ue7dR9EWKip1q/+TZYjmGV/fNdfbQJI7
         a0jgh5ePunqYogiYxZSkjc3/LGd0E4ggWaCEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wyJvRRotFiIVjTTSoad0uiS62UqZUBQ+UX1IojJFL9U=;
        b=YNFijIjBr949R2C99MlBqcEazitAS9hfCUUC4C9kiwX0H7VULsffiDaO5g98ePniwz
         EjWC2sdQOIaGCcp37zq33UX0xz9afA1sMuLPY74EfOcpySOCOuCykE5Pe3QK5opqOmS4
         VFjI9ob/9ruKN93T96jx1WYuvc2S/F/76062vMzg7T342Lm1HI5LoVx1rYmTl5u6Thwq
         xalNJvJ4zAPdT4Qqq77BrYmgdidViNFcogXZqEdohfBJHiHHGkr3wL/Dig+DEJy1cuUh
         0u6DSNSX/FIt21kIhkOV3QQUcSB8p6TxemNR5rQMqsM6cAacjygfCn2E9a1Lt9KXt922
         pacg==
X-Gm-Message-State: AKGB3mLVdrtS3OQW9jQKrp9EIIOTJ8zYTRk79wJRD3JQS4ExnamaFIyQ
        zRE6ROLphQex4oKLhs4k59P/Rf0WAg4=
X-Google-Smtp-Source: ACJfBouZkX0/RLwznxDrpnDWGruNVdaNQ0+DikRqfLfbf0cBIYaHkWTgjZiP2BxMNrX3pqJ9dDLU+A==
X-Received: by 10.223.148.69 with SMTP id 63mr4651698wrq.89.1513096810927;
        Tue, 12 Dec 2017 08:40:10 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id b16sm22201319wrd.69.2017.12.12.08.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 08:40:09 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 7AEE93E009E;
        Tue, 12 Dec 2017 16:40:09 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com> <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop> <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com> <20171212103040.jbgkyet5rapqxi44@laptop>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <20171212103040.jbgkyet5rapqxi44@laptop>
Date:   Tue, 12 Dec 2017 16:40:09 +0000
Message-ID: <87indb99xy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thomas Adam <thomas@xteddy.org> writes:

> Hi,
>
> On Mon, Dec 11, 2017 at 08:46:46PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> I.e. we'd just ship a copy of Email::Valid and Mail::Address in
>> perl/Git/FromCPAN/, use a wrapper to load them, and then we wouldn't
>> need to if/else this at the code level, just always use the module,
>> and it would work even on core perl.
>
> I disagree with the premise of this, =C3=86var.  As soon as you go down t=
his route,
> it increases maintenance to ensure we keep up to date with what's on CPAN=
 for
> a tiny edge-case which I don't believe exists.
>
> You may as well just use App::FatPacker.
>
> We're talking about package maintenance here -- and as I said before, the=
re's
> plenty of it around.  For those distributions which ship Git (and hence a=
lso
> package git-send-email), the dependencies are already there, too.  I just
> cannot see this being a problem in relying on non-core perl modules.  Eve=
ry
> perl program does this, and they don't go down this route of having copie=
s of
> various CPAN modules just in case.  So why should we?  We're not a special
> snowflake.

I less bothered my the potentially shipping a git specific copy than
ensuring the packagers pick up the dependency when they do their builds.
Do we already have a mechanism for testing for non-core perl modules
during the "configure" phase of git?

--
Alex Benn=C3=A9e
