Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE2E1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 23:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfASXS7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 18:18:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41690 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbfASXS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 18:18:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so14563123ljc.8
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 15:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIDue5ahGQpm7qxP6ROCGpgUpmhaBVcimkajtceH8e8=;
        b=rh57AHTHYNoQqiISz7pYHM+r2do+qliA1wDJy6W4J7WwaRkGaIjiIgLzGh2aNf8Yw/
         9LeWUayFc/NOntlOgprR4EnMXNL8hJvccCjs6/mAwL/BAuC7mvFVZYJovcCzTrIynhn/
         UGGAHUoS+ae+n1hlAzDpJ6Tu7AqjrX014BVPkJqvAvdZeJPASoItYfFfWvlhDvYJNdUG
         VXk8cBjF6R2cUqrd1ZUX0t34+DFvZvnBo5YGeU0IkItn9XUwe+KdmidCha3BHk4iOfZw
         xTUOxx19v9pbyPLXB48emfPjB7mJNz6eK6sd6MQ1DLp6yOXH/xYCVVwTOTRykPASnmN6
         Hw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIDue5ahGQpm7qxP6ROCGpgUpmhaBVcimkajtceH8e8=;
        b=ChVW6UdfF2HScVIWac/BI5v9pafkxT90DuvsmYIBU+5S1fh/sXqzOOJsWAhY6Abypq
         l+yxw7Fc1i0f/WY29qNyM28CH1vNlz14GdQzlp+vMUPls2FIYd8qXlWJOzyVpySci60I
         x6DemQ64XwwqzN3sYAkpFLFe7SrmVpET3DgukLl483FMP+1gkndpWwkgyV0B1AD5OCeO
         XC0DULk5+Xp5pKGlnJoXs0ohOKwvPXTWrrOcjbVD6lyn2dRx9fCpm9L1pLSRvm8i3VWn
         rbnsTAxO+jhObQ5YbBRWUFm/rgd3/y1fBRCKLSXizcysaGTw1nInJxOsQURguUxQl6Pi
         CphQ==
X-Gm-Message-State: AJcUukfVAapx/TX/1JGaVKCGJqlx+JAx7ojK8IlVErNDTR7lp2DquuSN
        RccvYgDsQHXs4bFnDc853szSLxhwFF6Rn2L2Rkc=
X-Google-Smtp-Source: ALg8bN5fuTpvf3fyyI3hU+baVHwY/XV3N3OcHT3CuKvBEE1ww/WXPfbU8UAn1M4Hh1RKEEyKSdxmrXOxs+zqMRHfgfQ=
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr14414768lja.46.1547939937448;
 Sat, 19 Jan 2019 15:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20190119033530.4241-1-brandon1024.br@gmail.com>
 <20190119154552.12189-1-martin.agren@gmail.com> <CAETBDP5Ve=85Jtkb55=htPO1eiZQmqG7deUX_BF6ih259gY-XQ@mail.gmail.com>
 <CAN0heSo7CmuAYJGK5RjRkT9TX+RUyNDk-Rp_n-OCN8q1O6xNzA@mail.gmail.com>
In-Reply-To: <CAN0heSo7CmuAYJGK5RjRkT9TX+RUyNDk-Rp_n-OCN8q1O6xNzA@mail.gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Sat, 19 Jan 2019 19:18:46 -0400
Message-ID: <CAETBDP5xgPwu9ejg3j0oZGpwN0T1Me0n0CiaaCtrK37pZrJgZw@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: add missing --gpg-sign flag
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Sat, 19 Jan 2019 at 17:19, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
> > > Or, a bit simpler:
> > >
> > >   oid=3D$(echo 10 | git commit-tree -S HEAD^{tree}) &&
> > >   git tag tenth-signed "$oid"
> >
> > Just noticed your latest email. Do you prefer it this way?
>
> I think so, yeah. (But who knows what others might prefer? ;-) )
>

I'm personally a fan of your initial patch, I found it to be quite elegant.
I think I'll submit your first version, and if people prefer another way
we will go in that direction.

> I think the cleanest would be to submit a two-patch series, v4.

For simplicity, I'll do that :-)

Brandon
