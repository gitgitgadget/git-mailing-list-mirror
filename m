Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80EE1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 20:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbeKNGYc (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 01:24:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32917 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 01:24:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so8714299eda.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4kkiBO61ePQ7HwbOXw1tzy/oRcH5SmXSf3r73c3hQy4=;
        b=cIIYuwGYyQo6HYGA/OVmvFGRitqKFACY5aMmeuQmQ/EKsYWAZa++Vi/Q/Zo9A/ExXK
         EdT+BkbNJ4Wx5mMBGoyr6D9t7pKDIAHZK43Xq4Cbl508/Ykka45fz4IAAhFyrwRDXYnt
         AkTDUAoAM32QZmjf34av3zGsDTZPvMie8JrsnhTwAVyNSLowzZ9GW+nHBO/+c++FWHQR
         q+4TUkbFMbEtv3ryghOqSnRzdhtHnJAUREr8+MWK0yTXQvL5RrJbhqzVE5SUMbhwo5KJ
         olMg3PXiJSzjpxl7Fqr1O+157USfHPKUXxafyA4SKT5vWT86xq7HgYRPGplSMi902m7f
         rjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=4kkiBO61ePQ7HwbOXw1tzy/oRcH5SmXSf3r73c3hQy4=;
        b=noDFIbVnHyr+FFgfLjvGB44wnwe6SB1NW/WPR3rftHOKPrHapmugxEPcTBY9nuRLEO
         hqQtBJRX2inFAMhttWOwdw5u4YMaQPYOezCUf5Uz3DlVru5pGtpJbqI1Q4LWjQtuqEhl
         SRXl+u5ynIYgWE63de/JhZj4f1XWsIZQVKx4sLbCecTUtMWdTZmBGfm5Z41XOZh1c03Y
         VFLqeaJbkboA1hO0lZwOLebeZCOTBGoi+sb7WJTFZF5CT0mb05hJJcWcG7HhsvjNeAaw
         fkksJQaoaYiCWEBYAllMQjSA7cjMoKoEJUET2Ssxyymwci/4o8FZ6DayJW2FrWNvji3a
         JZ7w==
X-Gm-Message-State: AGRZ1gLDPGDrkmrr0cMnHF5t6KyudOt17cBkqu5sy2Ij2mICj95lS7WG
        h9C6KxazidrhZgoGJMZOIGmymWXYYD03CLSJgFBgLVUmI15nZDP+
X-Google-Smtp-Source: AJdET5dVD7VgWynWt10KdJA5JKFKj6HTf/wjH6nBt+9SWD8UNcGN4fdjtDyCyBNti+mNUzcoR0/3f2kdoDfDZlFtW7M=
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr5683457eds.91.1542140683955;
 Tue, 13 Nov 2018 12:24:43 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
In-Reply-To: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 13 Nov 2018 21:24:15 +0100
Message-ID: <CABUeae8pVeK+t2z1e5cvu65Ek7oEuo49M2tnovYvDEx7ruGt5Q@mail.gmail.com>
Subject: Re: Migration to Git LFS inflates repository multiple times
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Nov 2018 at 00:47, Mateusz Loskot <mateusz@loskot.net> wrote:
>
> Hi,
>
> I'm posting here for the first time and I hope it's the right place to as=
k
> questions about Git LFS.
>
> TL;TR: Is this normal a repository migrated to Git LFS inflates multiple =
times
> and how to deal with it?

FYI, answers to my questions have been completed via GitHub
https://github.com/git-lfs/git-lfs/issues/3374

I'd like to thank Jeff and =C3=86var here for help too.

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
