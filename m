Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC791F453
	for <e@80x24.org>; Fri,  8 Feb 2019 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBHIqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 03:46:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53841 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHIqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 03:46:55 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so7033542ita.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 00:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/PxWmzrfWtl0cMYBhoOhLu/8JFbeLDpnCCMmPLWSp0=;
        b=ZoEejpF7vrNcSTl71lnMOCWdfINQZF9bxWNi7hhYEag6InoKJmc5GQkserkK9krCvj
         onBLALsRJSV6LywWYqQa9b330TtJg7InKXAvXu8MsCwVBAHDQfVcNApAQrJcMvxM84v4
         iIDIy2tkZ1HV9sKt7/l1EKuQtXaxNKDhZUJQA1ldCRGc7xlVzN/3yplg435ImDo9vRQr
         /tgjH3tb9myU8LyME+wOV3y5oeH0JvSm/g4G5d+Pc0w8Yy0wTADlvH3Ekoa/wP/0FZKh
         KAwgCl72GBMNaZhSTQnYemZkm5ff7EMpr9j1W1bF/dWel4i/hbUmSpZfZJW/vUDNUbOo
         d9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/PxWmzrfWtl0cMYBhoOhLu/8JFbeLDpnCCMmPLWSp0=;
        b=UvKr4VL6aifZ3RU5pdMBV4v4sk6fpYm2Cc+Fio4m0rloR6+H0p3G0KKGQ6j6fNHxaX
         PEYcRInuEs4ypdwsT/QPgeuLcuvuowuRxY5ZxHX7CYlriF3Obe/8rimgEfnCRptThX1n
         HflPxRYBr8RK8y7y+VKKiUKx2pCk7cLNm/130U2geSgPjzWsV6zsnIAIrjo2FGwMR2yS
         nL42Y1Qb9rK5LpS3ogkF5uPWwKxAJjGMIvlG98lMst9byqaZo6QyEr7AIB+AEevHCBzG
         B+8oeGFM5/y3YeiEGyZFHfJ1QsoypfqmNYLcEYVyz26Yc4BzHvS73tKY0Q846jMBxUsi
         yTiw==
X-Gm-Message-State: AHQUAubyNgsTeghKMzsJLyCrK6+99amn3jM1xF3HSk9B7otFqXQa+GGG
        9AVuw4SxnwkLYgld7U/s+QHdTEKhmGuZfKhWIaE=
X-Google-Smtp-Source: AHgI3Ib+J9jXkqONlwKPJixpLjdY25bom2jYZUQzUCsUgK4obb1lC/KBLQEyDA5jBRt/+FDTlsYwNS4KXByKKWQvL0g=
X-Received: by 2002:a02:bb81:: with SMTP id g1mr5499401jan.130.1549615614244;
 Fri, 08 Feb 2019 00:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <20190131130953.GJ13764@szeder.dev>
In-Reply-To: <20190131130953.GJ13764@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 8 Feb 2019 15:46:27 +0700
Message-ID: <CACsJy8D-vL88JaJYqhXnkJ5Cxvou_=haSFLpwELuX-E9cj_9aQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 8:09 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Jan 30, 2019 at 04:48:20PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.tx=
t
> > new file mode 100644
> > index 0000000000..953c9747b2
>
> > +--orphan <new_branch>::
> > +     Create a new 'orphan' branch, named <new_branch>, started from
> > +     <start_point> and switch to it. See explanation of the same
> > +     option in linkgit:git-checkout[1] for details.
>
> Copy-paste error?  An orphan branch, by definition, doesn't have a
> starting point.

It does not have any parents, true. The "started from <start-point>"
is not super clear on this, but git-checkout.txt describes more and
says that it's essentially "git checkout <start_point>" then make an
orphan branch based on HEAD^{tree}.
--=20
Duy
