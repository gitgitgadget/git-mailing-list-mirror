Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97DF3201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 19:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbdBUTkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 14:40:22 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32927 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753498AbdBUTkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 14:40:21 -0500
Received: by mail-wm0-f51.google.com with SMTP id t18so31194379wmt.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 11:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8Jes/uYEqcw2cTys109madfGifVvsm9XQJlyhMdm8jk=;
        b=P34t3r/w7wGtzWGtiCazrPT/WJbk1pm9bTf2G9RZyFiLmxPncNM05vZokSc0lR222J
         HOnKo228CUeDVIY+lLW+pZ17F/pL8ckI12FT575zNMOwmlf+CF3G0V9s9Wi/ls2PkgVS
         hjqlgVmScYvdFW+nWikytwm0CWb003hrYJqSf83X3Sz8QYTy/AjaZ7c8jGsIa8hbVVu/
         XkBotznbRBCOQyWQu1NfUh8vtyWjhuyXAl9NytZfxTVdce+J1kiP2e7/1j/gc5suRM4A
         DZ4CPym0SmGNPZi8BeULNpbd3j1bSXkfd0qZwFWM6YT+Y/TUnTfrbQO6A6GhurgRgpQM
         WQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8Jes/uYEqcw2cTys109madfGifVvsm9XQJlyhMdm8jk=;
        b=WPGR6X4vc9nG0PC1dtCYMGBWjTjuYpjxO0s0evytb5RQsDVoLOp1qXKb9d5332XgQK
         2CHf+fhNUciHdkTH7l3KSeyiGMce+t+RU8jwVJUbsHN972jiQLcQnsgQbxrPk1CtO2MT
         W1NvwSd7soqUv1sqnr5vnZvKWQTy6+g809UKQQWQH1zuGpR/CiALe5XH17TBkcAAf8fm
         q/trpwxp4zhv1L4CfUX+1zmZg8kBXoKNkh1qHfPWrtWX6O8Rls/EKMEI8750A62+Oqx/
         vLlbSySmZnFwXClwA0lru8Fc4NSDCXyYO+8fZyAk0wPvGKfxEnL3MTByaHXXWeAshGtl
         YCbA==
X-Gm-Message-State: AMke39nnLg7Iaa08pmG0gQzhINcKaRHtGoQR+UZ4SwpcVQ7LhQLQIpwWz7A5BfRf79V3G4GPdNxAEnGTw6AVqA==
X-Received: by 10.28.207.7 with SMTP id f7mr27192248wmg.112.1487706019801;
 Tue, 21 Feb 2017 11:40:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Tue, 21 Feb 2017 11:40:19 -0800 (PST)
X-Originating-IP: [77.176.34.158]
In-Reply-To: <4C20E99781EC4D6D82D48FBF9D9472A1@PhilipOakley>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
 <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com> <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
 <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com>
 <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com> <4C20E99781EC4D6D82D48FBF9D9472A1@PhilipOakley>
From:   Alex Hoffman <spec@gal.ro>
Date:   Tue, 21 Feb 2017 20:40:19 +0100
X-Google-Sender-Auth: e6MQioQCsB6JImB4STWArclrSC8
Message-ID: <CAMX8fZUR4h0T3hBmh6Z_0=f5LHFJetOi-vO_JJgnYPB7KjU_bg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Oleg Taranenko <olegtaranenko@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> isn't that spelt `--ancestry-path` ?
> (--ancestry-path has it's own issues such as needing an --first-parent-show
> option, but that's possibly a by the by)

Indeed it is spelled `--ancestry-path`. And interestingly enough you
may use it multiple times with the wanted effect in our case (e.g when
the user has multiple good commit and a single bad commit before
running the bisect itself). Also it is `--first-parent` (not
`--first-parent-show`), but I do not understand why do we need this
option? What kind of issues does `--ancestry-path` have?

Best regards,
VG
