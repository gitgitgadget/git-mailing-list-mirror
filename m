Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D2A1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeB1AhG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:37:06 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54050 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB1AhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:37:06 -0500
Received: by mail-wm0-f41.google.com with SMTP id t74so1841228wme.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r6OaqeSsyXSr49P58SdNKu6yg4Dhe9XwjUm/lt311Cw=;
        b=Dm9W3J7m7Cb2k606UE5POLlJy2bHko59JyaU+90LRXLpI1zvrKFi1jxA4Z58tR3wkk
         6ESI9dozFF8Yw/WRb0zTpqDLFa6CMAeWVhVkPLLl8V97HBB7lC5UbZkG88GicLuAkjUx
         sxQk+TFIu+jBuUSgMEm2oLmE55ajj2vWuqJ8yYyddwSklTZXLpD9ENhHQCmcY31hVwaS
         kskeM+O6vnXTHoD8+L3sH8G4x1nlvbHfdpFXCFqb9yAOjyatP7rfAmw3V9rAtNnywZCF
         Mwv6dmF6utscsseZxwoSTMhZUOAIhX4tvu/07lnBEzxC7YYFKmLYDvLSDXRcTdqT7cgL
         F+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r6OaqeSsyXSr49P58SdNKu6yg4Dhe9XwjUm/lt311Cw=;
        b=J4F5oa0NF8HZXbqsvUsai3kxY1bL4HWJlTnn6YzsAmjuI9vR58AM/dJnq5oRiaXHhP
         +/P9mjH2cKSIBDyazG5IjpJct62zVW2/P7UfAOFM/+7Bbl3xIxGxrzNS10gJt+vv9hGy
         xPFg5iV+rY0XVDwiS+ejcre7SUgMNj/sDwHzoM/kV51DpUNmaY3ow/ayYMd7MpQmjzzW
         LIWLr3e0Ly6Y3m+fig5FQcI1adNYXQsufFYtcfoSlB7dlSZysyzetIwCy2O0gdMvYjcs
         l/Kf91+mu/GmfL0/koJnG4cu1G1YvYmhNbPA4EAs9yofXgvlaObtpRvt3p2YRPNd5TRr
         AARw==
X-Gm-Message-State: APf1xPA50N9WUdfRdg2W4BZ+fDeLvT1/3Y6vDdnpRpPMToYpccC9Gv1S
        ca+YRmRVIY0qSLepBXTjPYMFIpOpijDodB3X+Bs=
X-Google-Smtp-Source: AG47ELsC4a8c/LodcZCOr+rwJeq7siiMa5pRG6tnvBDv7NMuXT6ZeGyM859uWKXStlP6hRCiZORAz1nuop14Vm8hQUw=
X-Received: by 10.80.232.69 with SMTP id k5mr15097562edn.133.1519778224874;
 Tue, 27 Feb 2018 16:37:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Tue, 27 Feb 2018 16:36:44 -0800 (PST)
In-Reply-To: <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Feb 2018 16:36:44 -0800
Message-ID: <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 3:40 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> On 27/02/2018 20:59, Igor Djordjevic wrote:
>>
>> (3) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>        |             \          |
>>        |              M         |
>>        |             /          |
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>>
>
> Meh, I hope I`m rushing it now, but for example, if we had decided to
> drop commit A2 during an interactive rebase (so losing A2' from
> diagram above), wouldn`t U2' still introduce those changes back, once
> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>
> p.s. Looks like Johannes already elaborated on this in the meantime,
> let`s see... (goes reading that other e-mail[1])
>
> [1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/


In that case, the method won't work well at all, so I think we need a
different approach.

Thanks,
Jake
