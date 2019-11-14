Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2112B1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 09:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNJqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 04:46:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51632 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfKNJqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 04:46:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so4935749wme.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rinpas9FA4Z8oMJ2szH8TvsEmd+PZycSzC5ENKg5Fw=;
        b=BrWmAyoidkAWkKKmVQtU9pZ2K0nWElmvoNpsDdNd/EeVGC16RW2WyMMp0zBGpX4MMg
         68KoQ9p4UqJg7WhqyjHz60SMYBK6M55EZVY2aZRGSRWUgrikIWwIO6k2Yorc2l7rvKFW
         GMuvnlORYUmb9t1VcOApQcl2XO0DTg+sHhI6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rinpas9FA4Z8oMJ2szH8TvsEmd+PZycSzC5ENKg5Fw=;
        b=NKff76xwlGY8ezYjiK6anXUL+wj58EMRHvqPWq5G2Y8/8T8dM77cZxT42YFfrOQS8j
         Pz0gX4Z7JcCrpsqjAkdLgiyPVWTmUAns2CMWYWKzqEMj216bac2MoAY27OTdvoEhbugF
         U0XmImS2VcLjSurKcm/hcDT6kccLdccXaTdr1CeLekLCIbfWSkGy8n8Wn04QyK9tS+w3
         v+n5pGDBnypfET1KEvyY3TC/jmiVVW4g7zhOmVr1lF23OAbwHTAreCYJSoS29YRrnaGm
         MTO8QKNtn29QZyP4T4vkmFDB9Po6C0k7s92bSnJ6L2MKY3lSZrANCSPwmHvf2Sns+5za
         vEuQ==
X-Gm-Message-State: APjAAAUw7iZcaEehxQIzxi4Pp0rZ/nfEq1yAK2YHzTUGa/13bfrVZTUJ
        SPYu7f7ZQG9eeSEhEZcwItTsjyk5cjNGVKasuQI+Tg==
X-Google-Smtp-Source: APXvYqxhbK2RkKoW3gfQzC+yyPcW91wXeJni3c+PgDc4EhqUrradJn1dhvj3V5TeEBpoT7nTTof8Z7dD0Ya5ktQgtFo=
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr6730144wmg.11.1573724789189;
 Thu, 14 Nov 2019 01:46:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.463.git.1573679258.gitgitgadget@gmail.com> <xmqqa78z9ou7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa78z9ou7.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 14 Nov 2019 09:46:41 +0000
Message-ID: <CAE5ih7_KXJ-4r=hOWdhhWdz9MdZHLrVisZTctGjMYYQQh6Om3Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] git-p4.py: Cast byte strings to unicode strings in python3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Nov 2019 at 02:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > commit: git-p4.py: Cast byte strings to unicode strings in python3
>
> Luke, this patch [*1*] came in my way, but I am hardly an expert on
> Py2to3 and know nothing about P4.  Could you take a look at them,
> please?
>
> Thanks.
>
>
> [References]
>
> <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573679258.git.gitgitgadget@gmail.com>

I just quickly tried it, and with git-p4 switched to using python3,
the unit tests fail.

$ make -C t T=t98*

But it looks like a reasonable approach, and with the demise of
Python2 fast approaching it would be good to get this fully working!

Luke
