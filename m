Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FBE1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeCVQie (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:38:34 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:39294 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCVQie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:38:34 -0400
Received: by mail-wr0-f176.google.com with SMTP id c24so9360706wrc.6
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/JWZzWTots2x1wmD+8YJPvuxprM1W50BtFKwsjReDmY=;
        b=qjJJF4tqn2fuZ0QEy8rkxG94n8S43EYOO+gVOXzgCaH3do3AbJSHwIy26hw5Ardo5q
         tSaCYbLhnbGsV4CmheyjauZ8RPHRjZ0N6Q7T+NS43eSynjtCXozD+/G0MptAb4Hs3YmZ
         V/0aSZqxL2SbCW+yzpsOFEOZ6LJTnhnoUsVDH2CI/svWuamDJhtJK3uNQHrHIey/V1Dr
         cmW7rZup+lAx1VJS8TyWrNXDnQNVYPCXmQgmeSZpQl9MjpnLdpjzUogebHdiTxkBybh2
         jhWLMCCkeB60waktHOh8Sl3LrjTSJyWNbJTyB3HyVDBMilW2enDHMffOa+UxUIBX+VIr
         /VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/JWZzWTots2x1wmD+8YJPvuxprM1W50BtFKwsjReDmY=;
        b=N+PIyP1ov6ObqL1stRboT31QSZ/XRPJ3ow5sCOv4d3LN+sEmLGimiYjeBjgN83E1kH
         fvCnZ0LgOyntLxbTUoyQwcTZTId2OUOZ8jfFut9dbxDHK6fViFEBOPeIVdvRJ9Jdkw7B
         biOb/SuntJDLg6NbyYLeJzP4LOOYVf+1/bU9K1qIc7YTvhtUj2blAGF7jUIAjNqmHqdC
         kdg0JhjTVfL0SL5lRBGBPGVewUbQ48gPtOAsjGe2kgF3W+aOR8ripn1SiuTYshgG7CVf
         u8bqsyQZ971iAIRJ4NO9Xx/Tz7sKLVMgu1i3LnUSEC5BU5jIPSmfLkNLJiGoyRJMRYzO
         XWZA==
X-Gm-Message-State: AElRT7E+CXR/NevMvDOciMaPTra3S2NSjTZ2wGvqzXFOV6u6vtj5cmUi
        lWmDXZ+A+9xHX0WdPZxXDjA=
X-Google-Smtp-Source: AG47ELvf8YTsHH6lgs61yVS3vQb5vrVQTPPJ5LhQrTpVmYX64bbvga3IVp4DyaAIdqIygMkQBsYzVQ==
X-Received: by 10.223.128.40 with SMTP id 37mr21593227wrk.73.1521736712368;
        Thu, 22 Mar 2018 09:38:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y111sm7614006wrc.0.2018.03.22.09.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 09:38:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug With git rebase -p
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local>
        <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
        <nycvar.QRO.7.76.6.1803212332320.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 22 Mar 2018 09:38:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803212332320.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 21 Mar 2018 23:33:32 +0100
        (STD)")
Message-ID: <xmqqd0zwm5fd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 20 Mar 2018, Joseph Strauss wrote:
>
>> Perfect. Thank you.
>
> You are welcome.
>
> I am puzzled, though... does your message mean that you tested the Git for
> Windows v2.17.0-rc0 installer and it did fix your problem? Or do you
> simply assume that it does fix your problem because Junio & I expect it to
> fix your problem?

Thanks for asking, as I was curious about the same thing after
interpreting what Joseph said as "oh, perfect that there is a
packaged thing I can readily test" (implying "I'll get back to you
after seeing if it helps").
